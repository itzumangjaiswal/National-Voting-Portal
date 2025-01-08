package com.votingSystem.controller;

import com.votingSystem.entity.User;
import com.votingSystem.service.EmailService;
import com.votingSystem.service.UserService;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/")
public class PublicController {

    private String localOtp = null;
    private String localEmail = null;

    @Autowired
    UserService userService;

    @Autowired
    EmailService emailService;

    public String indexPage() {
        return "index";
    }

    @GetMapping("/voter-registration-form")
    public String registrationForm() {
        return "redirect:/voter_form.html";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword(Model model) {
        model.addAttribute("emailExists", false);
        model.addAttribute("isOtpValid", false);
        return "forgotPassword";
    }

    @PostMapping("/password-reset")
    public String passwordReset(
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "otp", required = false) String otp,
            @RequestParam(value = "newPassword", required = false) String newPassword,
            @RequestParam(value = "confirmPassword", required = false) String confirmPassword,
            Model model
    ) {

        System.out.println(email);
        System.out.println(otp);
        System.out.println(newPassword);
        System.out.println(confirmPassword);
        System.out.println("L:" + localOtp);
        System.out.println("E:" + localEmail);

        if (email != null && otp == null && newPassword == null) {
            if (userService.emailExists(email)) {
                this.localEmail = email;
                model.addAttribute("emailExists", true);
                localOtp = sendEmail(email);
                model.addAttribute("success", "OTP sent to your email");
            } else {
                model.addAttribute("error", "Email does not exist");
                model.addAttribute("emailExists", false);
            }
            model.addAttribute("isOtpValid", false);
        }


        if (otp != null && newPassword == null) {
            if (otp.equals(localOtp)) {
                model.addAttribute("isOtpValid", true);
                model.addAttribute("success", "OTP verified");
            } else {
                model.addAttribute("error", "OTP does not match");
                model.addAttribute("isOtpValid", false);
            }
            model.addAttribute("emailExists", true);
        }

        if (confirmPassword != null && newPassword != null) {

            if (!confirmPassword.equals(newPassword)) {

                model.addAttribute("error", "Passwords do not match, enter OTP again");
                model.addAttribute("emailExists", true);
                model.addAttribute("isOtpValid", false);
            } else {

                boolean updated = userService.updatePassword(localEmail, newPassword);

                if (updated) {
                    model.addAttribute("success", "Password updated");
                } else {
                    model.addAttribute("error", "Unable to update password");
                }

                return "index";
            }

        }


        model.addAttribute("email", localEmail);


        return "forgotPassword";

    }

    private String sendEmail(String to) {

        String otp = String.valueOf((int) ((Math.random() * 900000) + 100000));
        System.out.println("OTP: " + otp);

        try {
            emailService.sendEmail(to, otp);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        return otp;
    }

}
