package com.votingSystem.service;

import com.votingSystem.entity.Election;
import com.votingSystem.repository.ElectionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ElectionService {

    private final ElectionRepository electionRepository;

    public ElectionService(ElectionRepository electionRepository) {
        this.electionRepository = electionRepository;
    }

    public List<Election> getAllOngoingElections() {
        return electionRepository.findByEndDateAfter(LocalDateTime.now());
    }

    public List<Election> getAllPreviousElections() {
        return electionRepository.findByEndDateBefore(LocalDateTime.now());
    }

    public Election insertElection(Election election) {
        return electionRepository.save(election);
    }

    public Election findElectionById(int id) {
        return electionRepository.findById(id);
    }

    public List<Election> findSubAdminElections(int assignedTo) {
        return electionRepository.findByAssignedToEquals(assignedTo);
    }

    public List<Election> findSubAdminElectionsComp(int assignedTo) {
        return electionRepository.findByAssignedToEqualsComp(assignedTo);
    }

    public List<Election> getAllLokSabhaElections() {
        return electionRepository.findByElectionTypeEqualsAndEndDateAfter("Lok Sabha", LocalDateTime.now());
    }

    public List<Election> getAllRajyaSabhaElections() {
        return electionRepository.findByElectionTypeEqualsAndEndDateAfter("Rajya Sabha", LocalDateTime.now());
    }

    public List<Election> getAllMunicipalElections() {
        return electionRepository.findByElectionTypeEqualsAndEndDateAfter("Municipal Corporation",LocalDateTime.now());
    }
  

}
