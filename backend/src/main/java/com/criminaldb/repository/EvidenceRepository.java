package com.criminaldb.repository;

import com.criminaldb.model.Evidence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EvidenceRepository extends JpaRepository<Evidence, Integer> {
    List<Evidence> findByCrimeId(Integer crimeId);
}
