package com.votingSystem.utility;

import com.votingSystem.entity.Vote;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class VoteRowMapper implements RowMapper<Vote> {
    @Override
    public Vote mapRow(ResultSet rs, int rowNum) throws SQLException {

        int voteId = rs.getInt("vote_id");
        int voterId = rs.getInt("voter_id");
        int electionId = rs.getInt("election_id");
        int candidateId = rs.getInt("candidate_id");
        LocalDateTime votedAt = rs.getTimestamp("voted_at").toLocalDateTime();

        return new Vote(voteId, voterId, electionId, candidateId, votedAt);
    }
}
