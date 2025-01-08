package com.votingSystem.controller;

import com.votingSystem.entity.Election;
import com.votingSystem.entity.User;
import com.votingSystem.repository.UserDaoImpl;
import com.votingSystem.service.ElectionService;
import com.votingSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ElectionService electionService;

    @Autowired
    private UserService userService;

	@Autowired
	UserDaoImpl u_UserImpl;

    @GetMapping("/info")
    public String showAdminConsolidatedInfo(Model model) {
        System.out.println("admin/info Controller called");

        getAdminInfo(model);

        return "admin/admin_consolidated_info"; // Maps to /WEB-INF/views/admin_consolidated_info.jsp
    }


    @GetMapping("/manageAuthority")
    public String manageAuthority(@RequestParam int subAdmin, Model model)
            throws Exception {


        try{
            u_UserImpl.revokeAuthority(subAdmin);

            getAdminInfo(model);

            return "redirect:/admin_dashboard.html";

        }catch (Exception e){
            throw new Exception("Unable to manage authority");
        }

        
    }

    private void getAdminInfo(Model model) {
        List<Election> allOngoingElections = electionService.getAllOngoingElections();
        List<Election> allPreviousElections = electionService.getAllPreviousElections();
        List<User> allSubAdmins = userService.findSubAdmins();

        model.addAttribute("allOngoingElections", allOngoingElections);
        model.addAttribute("allPreviousElections", allPreviousElections);
        model.addAttribute("allSubAdmins", allSubAdmins);
    }
}
