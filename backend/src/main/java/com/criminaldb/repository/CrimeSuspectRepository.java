package com.criminaldb.repository;

import com.criminaldb.model.CrimeSuspect;
import com.criminaldb.model.CrimeSuspectId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CrimeSuspectRepository extends JpaRepository<CrimeSuspect, CrimeSuspectId> {

    /**
     * Query 5: Remove a suspect from a crime (they did not do it).
     */
    @Modifying
    @Query("DELETE FROM CrimeSuspect cs WHERE cs.id.crimeId = :crimeId AND cs.id.suspectId = :suspectId")
    int removeSuspectFromCrime(@Param("crimeId") Integer crimeId, @Param("suspectId") Integer suspectId);

    @Modifying
    @Query(value = "INSERT IGNORE INTO crime_suspect (crime_id, suspect_id) VALUES (:crimeId, :suspectId)", nativeQuery = true)
    void linkSuspectToCrime(@Param("crimeId") Integer crimeId, @Param("suspectId") Integer suspectId);
}
