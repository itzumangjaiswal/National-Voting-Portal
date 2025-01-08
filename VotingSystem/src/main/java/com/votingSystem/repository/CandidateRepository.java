package com.votingSystem.repository;

import com.votingSystem.entity.Candidate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Optional;

@Repository
public interface CandidateRepository extends JpaRepository<Candidate, Integer> {

    Optional<Candidate> findById(int id);

    Candidate save(Candidate candidate);

    List<Candidate> findAll();

    
    List<Candidate> findByIsCandidatureRevokedFalse();

    @Modifying
    @Query("UPDATE Candidate c SET  c.voteCount = c.voteCount + 1 WHERE c.candidateId= :cId")
    int incrementVote(@Param("cId") int candidateId);

    @Modifying
    @Query("UPDATE Candidate c SET c.partyName = :cPartyName , c.partyLogoId = :clogo, c.createdBy=:created_by WHERE c.aadharNumber = :cAdhar")
    int UpdateParty(@Param("cAdhar") String cAdhar,
    		@Param("cPartyName") String cPartyName,
    		@Param("clogo") int clogo,
    		@Param("created_by") int created_by);
    
    @Modifying
    @Query(value = "DELETE FROM election_participants WHERE election_id = :electionId", nativeQuery = true)
    int deleteByElectionId(@Param("electionId") int electionId);

     
    @Modifying
    @Query(value = "INSERT INTO election_participants (election_id, candidate_id) VALUES (:electionId, :candidateId)", nativeQuery = true)
    int insertElectionParticipants(@Param("electionId") int electionId,
                                   @Param("candidateId") int candidateId);
    
//    @Modifying
//    @Query("SELECT c FROM Candidate c " +
//            "JOIN ElectionsParticipants ep ON c.candidateId = ep.candidateId " +
//            "WHERE ep.electionId = :electionId " +
//            "ORDER BY c.voteCount DESC")
//    List<Candidate> getCandidatesByElectionIdSorted(@Param("electionId") int electionId);



}
