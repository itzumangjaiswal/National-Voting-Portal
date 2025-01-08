package com.votingSystem.controller;

import com.votingSystem.entity.Image;
import com.votingSystem.entity.User;
import com.votingSystem.service.*;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class UserController {


    private final UserService userService;
    private final ImageService imageService;
    private final CloudinaryService cloudinaryService;
    private final JwtService jwtService;


    public UserController(UserService userService, ImageService imageService, CloudinaryService cloudinaryService, JwtService jwtService) {
        this.userService = userService;
        this.imageService = imageService;
        this.cloudinaryService = cloudinaryService;
        this.jwtService = jwtService;
    }


    @PostMapping("/voter-registration")
    public String voterRegistration(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("aadharNumber") String aadharNumber,
            @RequestParam("profilePic") MultipartFile profilePic,
            @RequestParam("password") String password,
            Model model
    ){

        System.out.println("/user/voter-registration called");
        String imagePublicUrlId;
        int role = 3;

        email = email.toLowerCase();

        //Upload image to Cloudinary
		imagePublicUrlId ="xgljencrmvtpxnncov1y";
//        try {
//            imagePublicUrlId = cloudinaryService.uploadImage(profilePic);
//        }catch (IOException e){
//            model.addAttribute("error", "Image upload failed. Try again.");
//            return "redirect:/user/registration-form";
//        }

        // Save image publicId to image table
        Image image = imageService.saveImage(new Image(imagePublicUrlId));

        //Encrypt Password
        String encryptedPassword = userService.encryptPassword(password);
        System.out.println("Encrypted password: " + encryptedPassword);

        User user = new User(name, email, image.getImageId(), aadharNumber, role, encryptedPassword, false);

        boolean signUpStatus = userService.signUp(user);

        String successMessage = "Registration Successful! Your data will be reviewed and approved soon.";
        String failureMessage = "A user with email " + user.getEmail() + " already exists.";

        if (signUpStatus) {
            model.addAttribute("success", successMessage);
        }
        else{
            model.addAttribute("error", failureMessage);
        }

        return "index";
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpServletResponse response,
                        Model model,
                        HttpSession session) {

        System.out.println("/user/login called");

        email = email.toLowerCase();

        Optional<User> userOptional = userService.findUserByEmail(email);

        if(userOptional.isEmpty()) {
            model.addAttribute("error", "No user exists with given email.");
            return "index";
        }

        User user = userOptional.get();

        if(user.getRole() == 3 && !user.isApproved()){
            model.addAttribute("error", "Your account has not been approved yet.");
            return "index";
        }

        if(user.getRole() == 2 && user.isAuthorityRevoked()){
            model.addAttribute("error", "Your authority has been revoked.");
            return "index";
        }

        if(!userService.verifyPassword(password, user.getPassword())) {
            model.addAttribute("error", "Wrong password.");
            return "index";
        }

        String token = jwtService.generateJwtToken(user);

        // Create a cookie
        Cookie cookie = new Cookie("token", token);
        cookie.setHttpOnly(true); // Helps prevent XSS attacks
        cookie.setPath("/"); // Accessible to the entire application
        cookie.setMaxAge(60 * 60); // Set cookie expiration (15 mins)

        // Add the cookie to the response
        response.addCookie(cookie);
        session.setAttribute("currentUser", user);

        if(user.getRole() == 1){
            return "redirect:/admin_dashboard.html";
        }
        else if(user.getRole() == 2){
            return "redirect:/s_subAdmin_dashboard.html";
        }
        else{
            return "redirect:/u_voter_dashboard.html";
        }


    }

    @GetMapping("/profile")
    public String getUserProfile(@CookieValue(value = "token", defaultValue = "NA") String token, Model model) {


        if (token.equals("NA") || jwtService.isTokenExpired(token)) {
            System.out.println("Expired token");
            // Pass a flag to the front-end to trigger the JS-based redirection
            model.addAttribute("tokenExpired", "EXP");
            return "index";  // This loads a profile page containing the redirect script
        }

        model.addAttribute("tokenExpired", "false");

        Map<String, String> userDetails = jwtService.extractUserDetails(token);

//        System.out.println("User details map" + userDetails.keySet());
//        System.out.println("User details map" + userDetails.values());

        int imageId = Integer.parseInt(userDetails.get("profilePicId"));
        int roleId = Integer.parseInt(userDetails.get("roleId"));


        String imagePublicId = imageService.getImage(imageId).getImageUrl();
        String role = getRoleName(roleId);

        userDetails.put("imagePublicId", imagePublicId);
        userDetails.put("role", role);

//        System.out.println("User details map" + userDetails.keySet());
//        System.out.println("User details map" + userDetails.values());

        model.addAttribute("userDetails",userDetails);

        return "profile";
    }

    private String getRoleName(int roleId){
        if(roleId == 1) return "ELECTION COMMISSIONER";

        if(roleId == 2) return "REGIONAL OFFICER";

        if(roleId == 3) return "VOTER";

        return null;
    }


}
