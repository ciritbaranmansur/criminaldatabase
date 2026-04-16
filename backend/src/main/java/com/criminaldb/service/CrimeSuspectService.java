package com.criminaldb.service;

import com.criminaldb.repository.CrimeSuspectRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

@Service
public class CrimeSuspectService {

    private final CrimeSuspectRepository crimeSuspectRepository;

    public CrimeSuspectService(CrimeSuspectRepository crimeSuspectRepository) {
        this.crimeSuspectRepository = crimeSuspectRepository;
    }

    /**
     * Query 5: Remove a suspect from a crime (they did not do it).
     */
    @Transactional
    public boolean removeSuspectFromCrime(Integer crimeId, Integer suspectId) {
        int deleted = crimeSuspectRepository.removeSuspectFromCrime(crimeId, suspectId);
        return deleted > 0;
    }
}
