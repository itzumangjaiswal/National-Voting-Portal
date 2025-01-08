package com.votingSystem.repository;


import com.votingSystem.entity.Vote;

import java.util.List;

public interface VoteRepository {

    int saveVote(Vote vote);

    Vote getVotingDetailsById(int voteId);

    List<Vote> getVotingDetailsByVoterId(int voterId);

    boolean hasVoted(int userId, int electionId);


}
