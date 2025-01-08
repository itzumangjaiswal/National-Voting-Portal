package com.votingSystem.controller;

import com.votingSystem.entity.Candidate;
import com.votingSystem.entity.Election;
import com.votingSystem.entity.Image;
import com.votingSystem.entity.User;
import com.votingSystem.repository.UserDaoImpl;
import com.votingSystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/subAdmin")
public class SubAdminController {

	@Autowired
	private UserService userService;

	@Autowired
	private ElectionService electionService;

	@Autowired
	private CandidateService candidateService;

	@Autowired
	private ImageService imageService;

	@Autowired
	private CloudinaryService cloudinaryService;

	@Autowired
	private JwtService jwtService;

	@Autowired
	UserDaoImpl u_UserImpl;

	@GetMapping("info")
	public String info(Model model) {

		User currentUser = jwtService.getCurrentUser();

		List<Election> allElections = electionService.findSubAdminElections(currentUser.getUserId());
		List<Candidate> allCandidates = candidateService.findAllCandidates();

		model.addAttribute("allElections", allElections);
		model.addAttribute("allCandidates", allCandidates);
		model.addAttribute("currentUser", currentUser);

		return "subAdmin/s_subAdmin_consolidated_info";
	}

	@GetMapping("/publishResult")
	public String publishResult(Model model) {

		User currentUser = jwtService.getCurrentUser();

		List<Election> allElections = electionService.findSubAdminElections(currentUser.getUserId());
		List<Election> completedElections = electionService.findSubAdminElectionsComp(currentUser.getUserId());

		System.out.println("->>>>>");
		System.out.println(allElections);
		System.out.println(completedElections);
		System.out.println("<<<<<<-");
		List<Candidate> allCandidates = candidateService.findAllCandidates();

		model.addAttribute("allElections", completedElections);
		model.addAttribute("allCandidates", allCandidates);
		model.addAttribute("currentUser", currentUser);

		return "subAdmin/result";
	}

	@GetMapping("/voter-info")
	public String showAdminConsolidatedInfo(Model model) {
		System.out.println("subAdmin/info Controller called");
		User currentUser = jwtService.getCurrentUser();

		List<User> allVoters = userService.findPendingVoters();

		model.addAttribute("currentUser", currentUser);
		model.addAttribute("allVoters", allVoters);

		return "subAdmin/u_pending_voters"; // Maps to /WEB-INF/views/voter/u_voter_consolidated_info.jsp
	}

	@GetMapping("/manageVoters")
	public String manageAuthority(@RequestParam int subAdminId, @RequestParam int voterId,
			RedirectAttributes attributes, Model model) throws IOException, SQLException {

		System.out.println("admin: " + subAdminId);
		System.out.println("subAdmin: " + voterId);

		int result = u_UserImpl.isApproved(voterId);

		List<User> allVoters = userService.findPendingVoters();

		model.addAttribute("allVoters", allVoters);

		attributes.addFlashAttribute("updateResult", result > 0 ? "Success" : "Failure");

		return "redirect:/s_subAdmin_dashboard.html";

	}

	@PostMapping("/addCandidates")
	public String AddCandidates(@RequestParam int electionId, @RequestParam List<Integer> candidateIds) {
		System.out.println("->>>>>>>>>>>>>>>>>");
		System.out.println(electionId);
		System.out.println(candidateIds);
		candidateService.resetElectionParticipants(electionId, candidateIds);
		return "redirect:/subAdmin/info";
	}

	@GetMapping("/subAdmin-form")
	public String registrationForm() {
		return "subAdmin/s_registration";
	}

	@PostMapping("/register")
	public String RegionalRegistration(@RequestParam String name, @RequestParam String email,
			@RequestParam MultipartFile profilePic, @RequestParam String aadharNumber, @RequestParam String password,
			Model model) {
		System.out.println("subAdmin/register called");

		String profilePicturePublicId;

		email = email.toLowerCase();

		// Upload image to Cloudinary

		// Upload image to Cloudinary
		profilePicturePublicId = "xgljencrmvtpxnncov1y";
//        try {
//            imagePublicUrlId = cloudinaryService.uploadImage(profilePic);
//        }catch (IOException e){
//            model.addAttribute("error", "Image upload failed. Try again.");
//            return "redirect:/user/registration-form";
//        }

		int profilePicId = imageService.saveImage(new Image(profilePicturePublicId)).getImageId();

		String encryptedPassword = userService.encryptPassword(password);
		System.out.println("Encrypted password: " + encryptedPassword);

		User user = new User(name, email, profilePicId, aadharNumber, 2, encryptedPassword, 0, true);
		System.out.println(user);

		User savedUser = userService.saveUser(user);

		if (savedUser != null) {
			model.addAttribute("success", "Regional Officer has been registered successfully");
		} else {
			model.addAttribute("error", "Unable to add Regional Officer");
		}

		return "subAdmin/s_registration";
	}

	@GetMapping("/manageAuthority")
	public String manageCandidates(@RequestParam int subAdminId, @RequestParam int candidateId, Model model)
			throws Exception {

		System.out.println("Candidate manage authority called");

		System.out.println("subAdmin: " + subAdminId);
		System.out.println("Candidate: " + candidateId);
		try {
			u_UserImpl.revokeAuthorityCandidate(candidateId);
			List<Candidate> allCandidates = candidateService.findAllCandidates();
			model.addAttribute("allCandidates", allCandidates);
			return "redirect:/s_subAdmin_dashboard.html";
		} catch (Exception e) {
			throw new Exception("Unable to manage authority");
		}
	}
//	@GetMapping("/result")
//	public String returnResult(@RequestParam int id, Model model) {
//		
//		System.out.println("<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>");
//		System.out.println(id);
//		
//		
//		return "";
//	}
	

	@PostMapping("/rejectVoterWithReason")
	public String rejectVoterWithReason(@RequestParam String voterId, @RequestParam String rejectorId,
			@RequestParam String reason, Model model) throws IOException, SQLException {

		System.out.println("Reject controller is called");
		System.out.println(voterId + " " + rejectorId + " " + reason);

		int voterIdInt;
		int rejectorIdInt;

		try {
			voterIdInt = Integer.parseInt(voterId);
			rejectorIdInt = Integer.parseInt(rejectorId);
		} catch (NumberFormatException e) {
			// Handle the error appropriately
			return "errorPage"; // Return an error page or an error response
		}

		System.out.println("Received Voter ID: " + voterIdInt);
		System.out.println("Received Rejector ID: " + rejectorIdInt);
		System.out.println("Received Reason: " + reason);

		// int voterid;
		String voterName, voterEmail, voterAdhar;

		Optional<User> voter = userService.findUserById(voterIdInt);

		if (voter.isPresent()) {
			User user = voter.get(); // Unwrapping the Optional
			// voterid = user.getUserId();
			voterName = user.getName(); // Using getter method
			voterEmail = user.getEmail();
			voterAdhar = user.getAadharNumber();
			int result = u_UserImpl.insertRejectedVoters(voterIdInt, voterName, voterEmail, voterAdhar, reason,
					rejectorIdInt);
			u_UserImpl.deleteUserById(voterIdInt);

		}

		List<User> allVoters = userService.findPendingVoters();

		model.addAttribute("allVoters", allVoters);

		return "subAdmin/u_pending_voters";

	}

}
