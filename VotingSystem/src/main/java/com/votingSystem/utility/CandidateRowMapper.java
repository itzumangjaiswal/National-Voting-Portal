package com.votingSystem.utility;

import com.votingSystem.entity.Candidate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CandidateRowMapper implements RowMapper<Candidate> {


    @Override
    public Candidate mapRow(ResultSet rs, int rowNum) throws SQLException {

        int candidateId = rs.getInt("candidate_id");
        String name = rs.getString("candidate_name");
        String description = rs.getString("candidate_description");
        String aadhaarNumber = rs.getString("aadhar_number");
        int profilePicId = rs.getInt("profile_pic_id");
        String partyName = rs.getString("party_name");
        int partyLogoId = rs.getInt("party_logo_id");
        int voteCount = rs.getInt("vote_count");
        boolean isCandidatureRevoked = rs.getBoolean("is_candidature_revoked");
        int createdBy = rs.getInt("created_by");

        int electionId = rs.getInt("election_id");

        Candidate candidate = new Candidate(candidateId, name, description, aadhaarNumber, profilePicId, partyName, partyLogoId, voteCount, isCandidatureRevoked,createdBy);

        candidate.setElectionId(electionId);

        return candidate;
    }
}
