package com.votingSystem.service;

import com.votingSystem.entity.Candidate;
import com.votingSystem.repository.CandidateRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CandidateService {

    private final CandidateRepository candidateRepository;

    public CandidateService(CandidateRepository candidateRepository) {
        this.candidateRepository = candidateRepository;
    }

    public Candidate findCandidateById(int id) {
        return candidateRepository.findById(id).orElseThrow(()-> new RuntimeException("Could not find candidate with id: " + id));
    }

    public List<Candidate> findAllCandidates() {
        return candidateRepository.findAll();
    }

    public List<Candidate> findAllActiveCandidates() {
        return candidateRepository.findByIsCandidatureRevokedFalse();
    }

    public Candidate saveCandidate(Candidate candidate) {
        return candidateRepository.save(candidate);
    }
    
    @Transactional
    public int updateCandidate(Candidate candidate) {
    	
        return candidateRepository.UpdateParty(candidate.getAadharNumber(),candidate.getPartyName(),candidate.getPartyLogoId(),candidate.getCreatedBy());
    }

    public Candidate updateCandidateVoteCount(int id, int voteCount) {
        Candidate candidate = findCandidateById(id);
        candidate.setVoteCount(voteCount);
        return candidateRepository.save(candidate);
    }

    public Candidate updateCandidateCandidature(int id, boolean status) {
        Candidate candidate = findCandidateById(id);
        candidate.setCandidatureRevoked(status);
        return candidateRepository.save(candidate);
    }

    @Transactional
    public int incrementVoteCount(int candidateId) {
        return candidateRepository.incrementVote(candidateId);
    }
    
    
    @Transactional
    public void deleteParticipantsByElectionId(int electionId) {
    	candidateRepository.deleteByElectionId(electionId);
    }

    
    @Transactional
    public void insertParticipant(int electionId, int candidateId) {
    	candidateRepository.insertElectionParticipants(electionId, candidateId);
    }

//    @Transactional
//    public List<Candidate> findAllActiveCandidatesSorted(int electionId) {
//        return candidateRepository.getCandidatesByElectionIdSorted(electionId);
//    }
    
    @Transactional
    public void resetElectionParticipants(int electionId, List<Integer> candidateIds) {
        deleteParticipantsByElectionId(electionId);

        for (Integer candidateId : candidateIds) {
            insertParticipant(electionId, candidateId);
        }
    }

}
