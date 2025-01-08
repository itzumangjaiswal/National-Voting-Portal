package com.votingSystem.controller;

import com.votingSystem.entity.Election;
import com.votingSystem.entity.User;
import com.votingSystem.service.ElectionService;
import com.votingSystem.service.JwtService;
import com.votingSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/election")
public class ElectionController {

    @Autowired
    UserService userService;

    @Autowired
    JwtService jwtService;

    @Autowired
    private ElectionService electionService;

    @GetMapping("/registraion-form")
    public String registraionForm(Model model) {

        List<User> subAdmins = userService.findSubAdmins();
        User currentUser = jwtService.getCurrentUser();

        model.addAttribute("allSubAdmins", subAdmins);
        model.addAttribute("currentUser", currentUser);

        return "election/election_creation_form";
    }

    @PostMapping("/create")
    public String createElection(@RequestParam String name,
                                 @RequestParam("election_type") String electionType,
                                 @RequestParam("start_date") LocalDateTime startDate,
                                 @RequestParam("end_date") LocalDateTime endDate,
                                 @RequestParam int assignedTo,
                                 @RequestParam("created_by") int createdBy,
                                 Model model) throws Exception {

        List<User> subAdmins = userService.findSubAdmins();
        User currentUser = jwtService.getCurrentUser();

        model.addAttribute("allSubAdmins", subAdmins);
        model.addAttribute("currentUser", currentUser);

        System.out.println("Assigned by : "+ assignedTo);
        Election election = new Election(name, electionType, startDate, endDate, assignedTo, createdBy);

        Election savedElection = electionService.insertElection(election);

        if(savedElection != null) {
            model.addAttribute("success", "Election created successfully");
        }
        else {
            model.addAttribute("error", "Election creation failed");
        }

        return "election/election_creation_form";

    }

}
