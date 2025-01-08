package com.votingSystem.repository;

import com.votingSystem.entity.Candidate;

import java.util.List;

public interface ElectionsParticipantsRepository {

    int insert(int election_id, int candidate_id);

    List<Candidate> getCandidatesByElectionId(int election_id);

}
