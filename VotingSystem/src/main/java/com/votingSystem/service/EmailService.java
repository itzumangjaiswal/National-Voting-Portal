package com.votingSystem.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private Environment env;

    public void sendEmail(String to, String otp) throws MessagingException {

        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

        // Construct the HTML message with the OTP
        String htmlContent = "<h3>Your one-time password (OTP) is: <strong>" + otp + "</strong></h3>" +
                "<br><p>If you didn't request this, please ignore this email.</p>";

        // Fetching the sender email address from application.properties using Environment
        String fromEmail = env.getProperty("spring.mail.username");

        helper.setTo(to);
        helper.setSubject("OTP for password reset");
        helper.setFrom(fromEmail);
        helper.setText(htmlContent, true);

        mailSender.send(mimeMessage);

    }


}
