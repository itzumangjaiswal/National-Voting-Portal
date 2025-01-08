package com.votingSystem.service;

import com.votingSystem.entity.Candidate;
import com.votingSystem.utility.CandidateRowMapper;
import com.votingSystem.repository.ElectionsParticipantsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ElectionParticipantsService implements ElectionsParticipantsRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;


    @Override
    public int insert(int election_id, int candidate_id) {
        String sql = "insert into election_participants values(?,?)";
        return jdbcTemplate.update(sql, election_id, candidate_id);
    }

    @Override
    public List<Candidate> getCandidatesByElectionId(int election_id) {
        String sql = "select * from candidates  natural join election_participants where election_id = ? and is_candidature_revoked = false";
        return jdbcTemplate.query(sql, new CandidateRowMapper(), election_id);
    }
}
