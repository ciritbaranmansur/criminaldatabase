package com.criminaldb.repository;

import com.criminaldb.model.OfficerRank;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OfficerRankRepository extends JpaRepository<OfficerRank, Integer> {}
