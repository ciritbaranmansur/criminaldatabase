package com.criminaldb.repository;

import com.criminaldb.model.Officer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface OfficerRepository extends JpaRepository<Officer, Integer> {

    /**
     * Query 2: Officers and how many suspects of each gender were arrested by each officer.
     * Returns rows: [OfficerId, officer_name, rank_name, male_arrests, female_arrests, total_arrests]
     */
    @Query(value = """
        SELECT
            o.OfficerId,
            o.OfficerName AS officer_name,
            o.OfficerRank AS rank_name,
            SUM(CASE WHEN s.Gender = 'M' THEN 1 ELSE 0 END) AS male_arrests,
            SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) AS female_arrests,
            COUNT(*) AS total_arrests
        FROM OfficerArrest oa
        JOIN Officer o ON oa.OfficerId = o.OfficerId
        JOIN Arrest a ON oa.ArrestId = a.ArrestId
        JOIN SuspectArrest sa ON a.ArrestId = sa.ArrestId
        JOIN Suspect s ON sa.SuspectId = s.SuspectId
        GROUP BY o.OfficerId, o.OfficerName, o.OfficerRank
        ORDER BY total_arrests DESC
        """, nativeQuery = true)
    List<Object[]> getArrestStatsByGender();

    @Query("SELECT MAX(o.officerId) FROM Officer o")
    Integer findMaxOfficerId();
}
