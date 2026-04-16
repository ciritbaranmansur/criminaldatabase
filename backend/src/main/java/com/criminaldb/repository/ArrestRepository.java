package com.criminaldb.repository;

import com.criminaldb.model.Arrest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ArrestRepository extends JpaRepository<Arrest, Integer> {

    @Query("SELECT MAX(a.arrestId) FROM Arrest a")
    Integer findMaxArrestId();

    @Modifying
    @Query(value = "INSERT IGNORE INTO OfficerArrest (OfficerId, ArrestId) VALUES (:officerId, :arrestId)", nativeQuery = true)
    void insertOfficerArrest(@Param("officerId") Integer officerId, @Param("arrestId") Integer arrestId);

    @Modifying
    @Query(value = "INSERT IGNORE INTO SuspectArrest (ArrestId, SuspectId) VALUES (:arrestId, :suspectId)", nativeQuery = true)
    void insertSuspectArrest(@Param("arrestId") Integer arrestId, @Param("suspectId") Integer suspectId);

    @Modifying
    @Query(value = "INSERT IGNORE INTO SuspectCrime (SuspectId, CrimeId) VALUES (:suspectId, :crimeId)", nativeQuery = true)
    void insertSuspectCrime(@Param("suspectId") Integer suspectId, @Param("crimeId") Integer crimeId);
}
