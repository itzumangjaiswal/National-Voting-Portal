package com.votingSystem.repository;

import java.io.IOException;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int revokeAuthority(int subAdminId) throws SerialException, IOException, SQLException  {
		
		
		String query = "UPDATE users " +
	               "SET is_authority_revoked = CASE " +
	               "WHEN is_authority_revoked = 0 THEN 1 " +
	               "ELSE 0 " +
	               "END " +
	               "WHERE user_id = ?";
	   int result =	jdbcTemplate.update(query,subAdminId);


		return result;
	}
	@Override
	public int isApproved(int voterId) throws SerialException, IOException, SQLException  {
		
		
		String query = "UPDATE users " +
	               "SET is_approved = CASE " +
	               "WHEN is_approved = 0 THEN 1 " +
	               "ELSE 0 " +
	               "END " +
	               "WHERE user_id = ?";
	   int result =	jdbcTemplate.update(query,voterId);

	   return result;
	}

	@Override
	public int revokeAuthorityCandidate(int candidateId) throws SerialException, IOException, SQLException {

		String query = "UPDATE candidates " + "SET is_candidature_revoked = CASE " + "WHEN is_candidature_revoked = 0 THEN 1 "
				+ "ELSE 0 " + "END " + "WHERE candidate_id = ?";
		int result = jdbcTemplate.update(query, candidateId);

		return result;
	}

	@Override
	public int insertRejectedVoters(int voterId, String voterName, String voterEmail, String voterAdhar, String reason,
									int rejectorId) throws SerialException, IOException, SQLException {
		String query = "INSERT INTO rejected_voters (id,name, email, aadhar_number, rejection_reason,rejection_date, rejector_id) "
				+ "VALUES (?, ?, ?, ?, ?,NOW(), ?)";

		int result = jdbcTemplate.update(query, voterId, voterName, voterEmail, voterAdhar, reason, rejectorId);

		return result;
	}

	@Override
	public void deleteUserById(int userId) throws SerialException, IOException, SQLException {
		String query = "DELETE FROM users WHERE user_id = ?";
		int result = jdbcTemplate.update(query, userId);
	}

}
