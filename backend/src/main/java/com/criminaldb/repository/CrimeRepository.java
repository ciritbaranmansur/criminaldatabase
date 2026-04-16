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
            SELECT * FROM crime WHERE
            (:type   IS NULL OR crime_type   = :type)   AND
            (:status IS NULL OR crime_status = :status) AND
            (:city   IS NULL OR LOWER(city) LIKE LOWER(CONCAT('%', :city, '%')))
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
            SELECT c.* FROM crime c
            JOIN crime_suspect cs ON c.crime_id = cs.crime_id
            WHERE cs.suspect_id = :suspectId
            ORDER BY c.crime_date DESC
            """, nativeQuery = true)
    List<Crime> findBySuspectId(@Param("suspectId") Integer suspectId);
}
