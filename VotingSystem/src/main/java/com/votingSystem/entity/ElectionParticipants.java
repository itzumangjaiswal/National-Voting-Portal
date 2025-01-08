package com.votingSystem.entity;

public class ElectionParticipants {

    private int electionId;
    private int candidateId;

    public ElectionParticipants(int electionId, int candidateId) {
        this.electionId = electionId;
        this.candidateId = candidateId;
    }

    public ElectionParticipants() {
        super();
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
}
