package com.votingSystem.entity;


import jakarta.persistence.*;

import java.time.LocalDateTime;

/* Role 1=Admin, 2=SubAdmin, 3=Voter
* */
/**
 * @author Anand Raj
 * @version 1.0
 *
 * This class is used to represent a table `user` in the database
 * It will automatically create a table if not exists
 *
 * */



@Entity
@Table(name = "users")
public class User {

    /**
     * The user's unique identifier.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    /**
     * The user's full name.
     */
    private String name;

    /**
     * The user's email, also used as of a user identifier.
     */
    @Column(unique=true)
    private String email;

    /**
     * The user's profile picture Id which is to identify its iamge url in image database table.
     */
    private int profilePictureId;

    /**
     * The user's unique Aadhar Number to verify whether the user is Indian Citizen.
     */
    @Column(unique=true)
    private String aadharNumber;

    /**
     * The user's role identifier which is used to get the type of user.
     */
    private int role;

    /**
     * The user's password used for user authentication and protection.
     */
    private String password;

    /**
     * The user's isAuthorityRevoked used to track the authority of the user.
     */
    private boolean isAuthorityRevoked;

    /**
     * The user's createdBy references to self table to track who created a particular user.
     */
    @Column(nullable = true)
    private int createdBy;

    /**
     * The user's isApproved to track whether a voter's information is verified.
     */
    private boolean isApproved;



    private LocalDateTime createdOn;

    /**
     * The user's default constructor
     */
    public User(){
        super();
    }

    /**
     * The user's parameterised constructor without userId and createdBy intended for Voter Registration
     */
    public User(String name, String email, int profilePictureId,String aadharNumber, int role, String password, boolean isApproved) {
        super();
        this.name = name;
        this.email = email;
        this.profilePictureId = profilePictureId;
        this.aadharNumber = aadharNumber;
        this.role = role;
        this.password = password;
        this.isAuthorityRevoked = false;
        this.isApproved = isApproved;
    }

    /**
     * The user's parameterised constructor without userId intended for Election Commissioner and Regional Officer
     */
    public User(String name, String email, int profilePictureId,String aadharNumber, int role, String password, int createdBy, boolean isApproved) {
        super();
        this.name = name;
        this.email = email;
        this.profilePictureId = profilePictureId;
        this.aadharNumber = aadharNumber;
        this.role = role;
        this.password = password;
        this.createdBy = createdBy;
        this.isAuthorityRevoked = false;
        this.isApproved = isApproved;
    }

    /**
     * The user's parameterised constructor with all User Fields intended for Modification for any field
     */
    public User(int userId,String name, String email, int profilePictureId, String aadharNumber, int role, String password, int createdBy, boolean isApproved) {
        super();
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.profilePictureId = profilePictureId;
        this.aadharNumber = aadharNumber;
        this.role = role;
        this.password = password;
        this.createdBy = createdBy;
        this.isApproved = isApproved;
    }


    //this much info will be available to frontend after login
    public User(int userId,String name, String email, int profilePictureId, String aadharNumber, int role) {
        super();
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.profilePictureId = profilePictureId;
        this.aadharNumber = aadharNumber;
        this.role = role;
    }

    @PrePersist
    private void onCreate() {
        this.createdOn = LocalDateTime.now();
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the user's isApproved.
     *
     * @return the user's isApproved
     */
    public boolean isApproved() {
        return isApproved;
    }

    /**
     * Sets the user's isApproved.
     *
     * @param approved the user's isApproved to set
     */
    public void setApproved(boolean approved) {
        isApproved = approved;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getProfilePictureId() {
        return profilePictureId;
    }

    public void setProfilePictureId(int profilePictureId) {
        this.profilePictureId = profilePictureId;
    }

    public String getAadharNumber() {
        return aadharNumber;
    }

    public void setAadharNumber(String aadharNumber) {
        this.aadharNumber = aadharNumber;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isAuthorityRevoked() {
        return isAuthorityRevoked;
    }

    public void setAuthorityRevoked(boolean authorityRevoked) {
        isAuthorityRevoked = authorityRevoked;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", profilePictureId=" + profilePictureId +
                ", aadharNumber='" + aadharNumber + '\'' +
                ", role=" + role +
                ", password='" + password + '\'' +
                ", isAuthorityRevoked=" + isAuthorityRevoked +
                ", createdBy=" + createdBy +
                ", isApproved=" + isApproved +
                ", createdOn=" + createdOn +
                '}';
    }
}
