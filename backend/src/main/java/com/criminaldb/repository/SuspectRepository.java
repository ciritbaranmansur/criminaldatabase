package com.criminaldb.repository;

import com.criminaldb.model.Suspect;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SuspectRepository extends JpaRepository<Suspect, Integer> {

    @Query("SELECT s FROM Suspect s WHERE " +
           "LOWER(s.firstName) LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(s.lastName)  LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(s.nationId)  LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(s.status)    LIKE LOWER(CONCAT('%', :q, '%'))")
    List<Suspect> search(@Param("q") String query);

    @Query("SELECT MAX(s.suspectId) FROM Suspect s")
    Integer findMaxSuspectId();

    @Query(value = """
            SELECT s.* FROM suspect s
            JOIN crime_suspect cs ON s.suspect_id = cs.suspect_id
            WHERE cs.crime_id = :crimeId
            """, nativeQuery = true)
    List<Suspect> findByCrimeId(@Param("crimeId") Integer crimeId);
}
