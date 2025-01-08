package com.votingSystem.repository;

import java.io.IOException;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialException;

import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {
	
	public int revokeAuthority(int subAdminId) throws SerialException, IOException, SQLException;

	public int isApproved(int voterId) throws SerialException, IOException, SQLException;

	public int insertRejectedVoters(int voterId,
									String voterName,
									String voterEmail,
									String voterAdhar,
									String reason,
									int rejectorId)throws SerialException, IOException, SQLException;

	public void deleteUserById(int voterId) throws SerialException, IOException, SQLException;

	public int revokeAuthorityCandidate(int candidateId) throws SerialException, IOException, SQLException;
	
}
