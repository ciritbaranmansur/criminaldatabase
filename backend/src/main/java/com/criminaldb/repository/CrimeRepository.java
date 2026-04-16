package com.criminaldb.repository;

import com.criminaldb.model.Crime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CrimeRepository extends JpaRepository<Crime, Integer> {

    List<Crime> findByCrimeType(String crimeType);

    List<Crime> findByCrimeStatus(String crimeStatus);

    List<Crime> findByCity(String city);

    @Query(value = """
            SELECT * FROM Crime WHERE
            (:type   IS NULL OR CrimeType   = :type)   AND
            (:status IS NULL OR CrimeStatus = :status) AND
            (:city   IS NULL OR LOWER(City) LIKE LOWER(CONCAT('%', :city, '%')))
            """, nativeQuery = true)
    List<Crime> filter(@Param("type") String type,
                       @Param("status") String status,
                       @Param("city") String city);

    @Query("SELECT c.crimeType, COUNT(c) FROM Crime c GROUP BY c.crimeType ORDER BY COUNT(c) DESC")
    List<Object[]> countByType();

    @Query("SELECT c.crimeStatus, COUNT(c) FROM Crime c GROUP BY c.crimeStatus")
    List<Object[]> countByStatus();

    @Query("SELECT MAX(c.crimeId) FROM Crime c")
    Integer findMaxCrimeId();

    @Query(value = """
            SELECT c.* FROM Crime c
            JOIN SuspectCrime sc ON c.CrimeId = sc.CrimeId
            WHERE sc.SuspectId = :suspectId
            ORDER BY c.CrimeDate DESC
            """, nativeQuery = true)
    List<Crime> findBySuspectId(@Param("suspectId") Integer suspectId);
}
