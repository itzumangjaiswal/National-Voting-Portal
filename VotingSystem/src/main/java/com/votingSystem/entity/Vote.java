package com.votingSystem.entity;


import jakarta.persistence.PrePersist;

import java.time.LocalDateTime;

public class Vote {

    private int voteId;

    private int voterId;
    private int electionId;
    private int candidateId;
    private LocalDateTime votedAt;


    public Vote() {
    }

    public Vote(int voteId, int voterId, int electionId, int candidateId, LocalDateTime votedAt) {
        this.voteId = voteId;
        this.voterId = voterId;
        this.electionId = electionId;
        this.candidateId = candidateId;
        this.votedAt = votedAt;
    }

    public Vote(int voteId, int voterId, int electionId, int candidateId) {
        this.voteId = voteId;
        this.voterId = voterId;
        this.electionId = electionId;
        this.candidateId = candidateId;
    }

    public Vote(int voterId, int electionId, int candidateId) {
        this.voterId = voterId;
        this.electionId = electionId;
        this.candidateId = candidateId;
    }


    public LocalDateTime getVotedAt() {
        return votedAt;
    }

    public void setVotedAt(LocalDateTime votedAt) {
        this.votedAt = votedAt;
    }

    public int getVoteId() {
        return voteId;
    }

    public void setVoteId(int voteId) {
        this.voteId = voteId;
    }

    public int getVoterId() {
        return voterId;
    }

    public void setVoterId(int voterId) {
        this.voterId = voterId;
    }

    public int getElectionId() {
        return electionId;
    }

    public void setElectionId(int electionId) {
        this.electionId = electionId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

	@Override
	public String toString() {
		return "Vote [voteId=" + voteId + ", voterId=" + voterId + ", electionId=" + electionId + ", candidateId="
				+ candidateId + ", votedAt=" + votedAt + "]";
	}
    
    
}
