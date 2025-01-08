package com.votingSystem.service;

import com.votingSystem.entity.Vote;
import com.votingSystem.repository.VoteRepository;
import com.votingSystem.utility.VoteRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public class VoteService implements VoteRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    @Override
    public int saveVote(Vote vote) {

        String sql = "INSERT INTO vote (voter_id, election_id, candidate_id, voted_at) values (?, ?, ?, ?)";

        return jdbcTemplate.update(sql, vote.getVoterId(), vote.getElectionId(), vote.getCandidateId(), LocalDateTime.now());
    }

    @Override
    public Vote getVotingDetailsById(int voteId) {

        String sql = "SELECT * FROM vote WHERE vote_id = ?";

        return jdbcTemplate.queryForObject(sql, new VoteRowMapper(), voteId);
    }

    @Override
    public List<Vote> getVotingDetailsByVoterId(int voterId) {

        String sql = "SELECT * FROM vote WHERE voter_id = ?";

        return jdbcTemplate.query(sql, new VoteRowMapper(), voterId);
    }


    @Override
    public boolean hasVoted(int userId, int electionId) {

        String sql = "SELECT COUNT(*) FROM vote WHERE voter_id = ? and election_id = ?";

//        System.out.println("hasVoted");
//        System.out.println(userId);
//        System.out.println(electionId);

        // Execute the query and get the count
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, electionId);

        // Check if the count is not null and greater than 0
        return count != null && count > 0;
    }


}
