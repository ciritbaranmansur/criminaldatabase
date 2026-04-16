package com.criminaldb.repository;

import com.criminaldb.model.Arrest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ArrestRepository extends JpaRepository<Arrest, Integer> {

    @Query("SELECT MAX(a.arrestId) FROM Arrest a")
    Integer findMaxArrestId();
}
