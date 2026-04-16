package com.criminaldb.repository;

import com.criminaldb.model.CourtInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface CourtInformationRepository extends JpaRepository<CourtInformation, Integer> {

    Optional<CourtInformation> findByCourtCaseNo(Integer courtCaseNo);

    /**
     * Query 1: All suspects and crime info appearing in court on a certain date.
     */
    @Query(value = """
        SELECT
            ci.CourtCaseNo,
            ci.HearingDate,
            s.SuspectId,
            s.FirstName,
            s.LastName,
            s.Gender,
            c.CrimeId,
            c.CrimeType,
            c.CrimeDate,
            c.City,
            c.CrimeDescription,
            ci.Verdict,
            ci.SentenceLenght
        FROM CourtInformation ci
        JOIN Crime c ON ci.CrimeId = c.CrimeId
        JOIN SuspectCrime sc ON c.CrimeId = sc.CrimeId
        JOIN Suspect s ON sc.SuspectId = s.SuspectId
        WHERE ci.HearingDate = :date
        ORDER BY ci.CourtCaseNo
        """, nativeQuery = true)
    List<Object[]> findByHearingDate(@Param("date") String date);

    /**
     * Query 3: Update hearing date for a particular court case.
     */
    @Modifying
    @Query("UPDATE CourtInformation ci SET ci.hearingDate = :date WHERE ci.courtCaseNo = :caseNo")
    int updateHearingDate(@Param("caseNo") Integer caseNo, @Param("date") LocalDate date);
}
