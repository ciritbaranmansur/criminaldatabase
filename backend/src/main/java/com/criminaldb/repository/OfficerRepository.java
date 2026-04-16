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
     * Returns rows: [officer_id, officer_name, rank_name, male_arrests, female_arrests, total_arrests]
     */
    @Query(value = """
        SELECT
            o.officer_id,
            CONCAT(o.first_name, ' ', o.last_name) AS officer_name,
            r.rank_name,
            SUM(CASE WHEN s.gender = 'M' THEN 1 ELSE 0 END) AS male_arrests,
            SUM(CASE WHEN s.gender = 'F' THEN 1 ELSE 0 END) AS female_arrests,
            COUNT(*) AS total_arrests
        FROM arrest a
        JOIN officer o      ON a.arresting_officer_id = o.officer_id
        JOIN suspect s      ON a.suspect_id = s.suspect_id
        JOIN officer_rank r ON o.rank_id = r.rank_id
        GROUP BY o.officer_id, o.first_name, o.last_name, r.rank_name
        ORDER BY total_arrests DESC
        """, nativeQuery = true)
    List<Object[]> getArrestStatsByGender();

    @Query("SELECT MAX(o.officerId) FROM Officer o")
    Integer findMaxOfficerId();
}
