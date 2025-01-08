package com.votingSystem.service;

import com.votingSystem.entity.User;
import com.votingSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public Optional<User> findUserById(int userId) {
        return userRepository.findByUserId(userId);
    }

    public List<User> findSubAdmins() {
        return userRepository.findUserByRoleEquals(2);
    }

    public List<User> findVoters() {
        return userRepository.findUserByRoleEquals(3);
    }
    
    public List<User>findPendingVoters(){
    	return userRepository.findUserByRoleEqualsAndIsApprovedIsFalse(3);
    }

    public Optional<User> findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean emailExists(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public boolean updatePassword(String email, String newPassword){
        User user = findUserByEmail(email).get();
        user.setPassword(encryptPassword(newPassword));
        User savedUser = userRepository.save(user);
        return savedUser != null;
    }

    public boolean signUp(User user) {

        Optional<User> existingUser = findUserByEmail(user.getEmail());
        if (existingUser.isPresent()) {
            return false;
        }

        User newUser = userRepository.save(user);

        return true;
    }

    public String encryptPassword(String plainPassword) {
        String salt = BCrypt.gensalt();
        System.out.println("Salt: " + salt + " Len:" +salt.length());
        return BCrypt.hashpw(plainPassword, salt);
    }

    public boolean verifyPassword(String plainPassword, String encryptedPassword) {
        return BCrypt.checkpw(plainPassword, encryptedPassword);
    }





}
