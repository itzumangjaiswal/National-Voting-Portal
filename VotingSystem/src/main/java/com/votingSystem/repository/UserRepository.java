package com.votingSystem.repository;

import com.votingSystem.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.sql.rowset.serial.SerialException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findByUserId(int userId);

    Optional<User> findByEmail(String email);

    User save(User user);

    List<User> findUserByRoleEquals(int role);
    
    List<User> findUserByRoleEqualsAndIsApprovedIsFalse(int role);

    
    

    //List<User> findUserByRoleEqualsAndIsApprovedIsFalse(int role);

//    @Query("UPDATE users SET is_authority_revoked = not is_authority_revoked where user_id = ?")
//    public int revokeAuthority(int subAdminId) throws SerialException, IOException, SQLException;

}

