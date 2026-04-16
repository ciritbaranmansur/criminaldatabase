package com.criminaldb.service;

import com.criminaldb.dto.AddArrestRequest;
import com.criminaldb.model.Arrest;
import com.criminaldb.repository.ArrestRepository;
import com.criminaldb.repository.CrimeSuspectRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ArrestService {

    private final ArrestRepository arrestRepository;
    private final CrimeSuspectRepository crimeSuspectRepository;

    public ArrestService(ArrestRepository arrestRepository, CrimeSuspectRepository crimeSuspectRepository) {
        this.arrestRepository = arrestRepository;
        this.crimeSuspectRepository = crimeSuspectRepository;
    }

    public List<Arrest> getAll() {
        return arrestRepository.findAll();
    }

    /**
     * Query 4: Add a new arrest of a suspect.
     * Also ensures a crime_suspect link exists so the suspect appears on the crime detail page.
     */
    @Transactional
    public Arrest addArrest(AddArrestRequest req) {
        Integer maxId = arrestRepository.findMaxArrestId();
        int newId = (maxId != null ? maxId : 0) + 1;

        Arrest arrest = new Arrest();
        arrest.setArrestId(newId);
        arrest.setCrimeId(req.getCrimeId());
        arrest.setSuspectId(req.getSuspectId());
        arrest.setArrestingOfficerId(req.getArrestingOfficerId());
        arrest.setArrestDate(req.getArrestDate());
        arrest.setArrestLocation(req.getArrestLocation());

        arrestRepository.save(arrest);

        // Ensure the suspect is linked to the crime in crime_suspect
        crimeSuspectRepository.linkSuspectToCrime(req.getCrimeId(), req.getSuspectId());

        return arrest;
    }
}
