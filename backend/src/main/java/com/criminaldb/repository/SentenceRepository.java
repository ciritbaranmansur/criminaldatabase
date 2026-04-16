package com.criminaldb.repository;

import com.criminaldb.model.Sentence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface SentenceRepository extends JpaRepository<Sentence, Integer> {

    Optional<Sentence> findByCourtCaseNo(Integer courtCaseNo);

    /**
     * Query 1: All suspects and crime info appearing in court on a certain date.
     * Returns rows: [court_case_no, hearing_date, suspect_id, first_name, last_name,
     *               gender, crime_id, crime_type, crime_date, city, description, verdict, sentence_type]
     */
    @Query(value = """
        SELECT
            sn.court_case_no,
            sn.hearing_date,
            s.suspect_id,
            s.first_name,
            s.last_name,
            s.gender,
            c.crime_id,
            c.crime_type,
            c.crime_date,
            c.city,
            c.description,
            sn.verdict,
            sn.sentence_type
        FROM sentence sn
        JOIN crime c   ON sn.crime_id   = c.crime_id
        JOIN suspect s ON sn.suspect_id = s.suspect_id
        WHERE sn.hearing_date = :date
        ORDER BY sn.court_case_no
        """, nativeQuery = true)
    List<Object[]> findByHearingDate(@Param("date") LocalDate date);

    /**
     * Query 3: Update hearing date for a particular court case.
     */
    @Modifying
    @Query("UPDATE Sentence s SET s.hearingDate = :date WHERE s.courtCaseNo = :caseNo")
    int updateHearingDate(@Param("caseNo") Integer caseNo, @Param("date") LocalDate date);
}
