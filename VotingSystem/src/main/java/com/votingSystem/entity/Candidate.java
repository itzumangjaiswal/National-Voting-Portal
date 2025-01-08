package com.votingSystem.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "candidates")
public class Candidate {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int candidateId;

	@Column(length = 30)
	private String candidateName;

	@Column(length = 60)
	private String candidateDescription;

	@Column(length = 14)
	private String aadharNumber;

	private int profilePicId;

	@Column(length = 45)
	private String partyName;

	private int partyLogoId;
	private int voteCount;
	private boolean isCandidatureRevoked;
	private int createdBy;

	private LocalDateTime createdOn;

	@Transient
	private int electionId;

	public Candidate(int candidateId, String candidateName, String candidateDescription, String aadharNumber,
			int profilePicId, String partyName, int partyLogoId, int voteCount, boolean isCandidatureRevoked,
			int createdBy) {
		this.candidateId = candidateId;
		this.candidateName = candidateName;
		this.candidateDescription = candidateDescription;
		this.aadharNumber = aadharNumber;
		this.profilePicId = profilePicId;
		this.partyName = partyName;
		this.partyLogoId = partyLogoId;
		this.voteCount = voteCount;
		this.isCandidatureRevoked = isCandidatureRevoked;
		this.createdBy = createdBy;
	}

	public Candidate(String candidateName, String candidateDescription, String aadharNumber, int profilePicId,
			String partyName, int partyLogoId, int voteCount, boolean isCandidatureRevoked, int createdBy) {
		this.candidateName = candidateName;
		this.candidateDescription = candidateDescription;
		this.aadharNumber = aadharNumber;
		this.profilePicId = profilePicId;
		this.partyName = partyName;
		this.partyLogoId = partyLogoId;
		this.voteCount = voteCount;
		this.isCandidatureRevoked = isCandidatureRevoked;
		this.createdBy = createdBy;
	}

	public Candidate(String candidateName, String candidateDescription, String aadharNumber, int profilePicId,
			String partyName, int partyLogoId, int createdBy) {
		this.candidateName = candidateName;
		this.candidateDescription = candidateDescription;
		this.aadharNumber = aadharNumber;
		this.profilePicId = profilePicId;
		this.partyName = partyName;
		this.partyLogoId = partyLogoId;
		this.voteCount = 0;
		this.isCandidatureRevoked = false;
		this.createdBy = createdBy;
	}

	public Candidate() {
		super();
	}

	public Candidate(String aadharNumber, String partyName, int partyLogoId, int createdBy) {

		this.aadharNumber = aadharNumber;

		this.partyName = partyName;
		this.partyLogoId = partyLogoId;
		this.createdBy = createdBy;
	}

	@PrePersist
	private void onCreate() {
		this.createdOn = LocalDateTime.now();
	}

	public int getElectionId() {
		return electionId;
	}

	public void setElectionId(int electionId) {
		this.electionId = electionId;
	}

	public int getProfilePicId() {
		return profilePicId;
	}

	public void setProfilePicId(int profilePicId) {
		this.profilePicId = profilePicId;
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public int getCandidateId() {
		return candidateId;
	}

	public void setCandidateId(int candidateID) {
		this.candidateId = candidateID;
	}

	public String getCandidateName() {
		return candidateName;
	}

	public void setCandidateName(String candidateName) {
		this.candidateName = candidateName;
	}

	public String getCandidateDescription() {
		return candidateDescription;
	}

	public void setCandidateDescription(String candidateDescription) {
		this.candidateDescription = candidateDescription;
	}

	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public int getPartyLogoId() {
		return partyLogoId;
	}

	public void setPartyLogoId(int partyLogoId) {
		this.partyLogoId = partyLogoId;
	}

	public int getVoteCount() {
		return voteCount;
	}

	public void setVoteCount(int voteCount) {
		this.voteCount = voteCount;
	}

	public boolean isCandidatureRevoked() {
		return isCandidatureRevoked;
	}

	public void setCandidatureRevoked(boolean candidatureRevoked) {
		isCandidatureRevoked = candidatureRevoked;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int created_by) {
		this.createdBy = created_by;
	}

	@Override
	public String toString() {
		return "Candidate{" + "candidateId=" + candidateId + ", candidateName='" + candidateName + '\''
				+ ", candidateDescription='" + candidateDescription + '\'' + ", aadharNumber='" + aadharNumber + '\''
				+ ", profilePicId=" + profilePicId + ", partyName='" + partyName + '\'' + ", partyLogoId=" + partyLogoId
				+ ", voteCount=" + voteCount + ", isCandidatureRevoked=" + isCandidatureRevoked + ", created_by="
				+ createdBy + ", created_on=" + createdOn + ", electionId=" + electionId + '}';
	}
}
