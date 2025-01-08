package com.votingSystem.repository;

import com.votingSystem.entity.Election;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ElectionRepository extends JpaRepository<Election, Integer> {

    Election save(Election election);

    Election findById(int electionId);

    List<Election> findByEndDateAfter(LocalDateTime endDate);

    List<Election> findByEndDateBefore(LocalDateTime startDate);

    List<Election> findByAssignedToEquals(int assignedTo);
    
    @Modifying
    @Query("SELECT e FROM Election e WHERE e.assignedTo = :assignedTo AND e.endDate < CURRENT_DATE")
    List<Election> findByAssignedToEqualsComp(@Param("assignedTo") int assignedTo);

    List<Election> findByElectionTypeEqualsAndEndDateAfter(String electionType, LocalDateTime endDate);

    List<Election> findAll();
    
    



}
