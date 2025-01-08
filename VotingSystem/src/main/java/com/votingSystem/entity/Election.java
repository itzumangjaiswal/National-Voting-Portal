package com.votingSystem.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "elections")
public class Election {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int electionId;

    @Column(length = 60)
    private String electionName;

    @Column(length = 32)
    private String electionType;

    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private int assignedTo;
    private int createdBy;

    public Election() {
        super();
    }

    public Election(String electionName, String electionType, LocalDateTime startDate, LocalDateTime endDate, int assignedTo, int createdBy) {
        super();
        this.electionName = electionName;
        this.electionType = electionType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
    }

    public Election(int electionId, String electionName, String electionType, LocalDateTime startDate, LocalDateTime endDate, int assignedTo, int createdBy) {
        super();
        this.electionId = electionId;
        this.electionName = electionName;
        this.electionType = electionType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
    }

    public int getElectionId() {
        return electionId;
    }

    public String getElectionName() {
        return electionName;
    }

    public String getElectionType() {
        return electionType;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setElectionId(int electionId) {
        this.electionId = electionId;
    }

    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }

    public void setElectionType(String electionType) {
        this.electionType = electionType;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public void setAssignedTo(int assingedTo) {
        this.assignedTo = assingedTo;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "\nElection{" +
                "electionId=" + electionId +
                ", electionName='" + electionName + '\'' +
                ", electionType='" + electionType + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", assingedTo=" + assignedTo +
                ", createdBy=" + createdBy +
                '}';
    }
}
