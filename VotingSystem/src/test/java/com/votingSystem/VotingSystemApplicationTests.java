package com.votingSystem;

import com.votingSystem.entity.User;
import com.votingSystem.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;

@SpringBootTest
class VotingSystemApplicationTests {

	@Autowired
	UserService userService;

	@Test
	void testFindUserById(){
		Optional<User> optionalUser = userService.findUserById(4);
		if(optionalUser.isPresent()){
			User user = optionalUser.get();
			System.out.println(user);
		}else{
			System.out.println("User Not Found");
		}
	}


}
