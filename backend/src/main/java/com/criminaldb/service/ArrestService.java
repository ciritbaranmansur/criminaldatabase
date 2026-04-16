package com.criminaldb.service;

import com.criminaldb.dto.AddArrestRequest;
import com.criminaldb.model.Arrest;
import com.criminaldb.repository.ArrestRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ArrestService {

    private final ArrestRepository arrestRepository;

    public ArrestService(ArrestRepository arrestRepository) {
        this.arrestRepository = arrestRepository;
    }

    public List<Arrest> getAll() {
        return arrestRepository.findAll();
    }

    /**
     * Query 4: Add a new arrest record.
     * Also links the officer and suspect via OfficerArrest / SuspectArrest junction tables.
     */
    @Transactional
    public Arrest addArrest(AddArrestRequest req) {
        Integer maxId = arrestRepository.findMaxArrestId();
        int newId = (maxId != null ? maxId : 0) + 1;

        Arrest arrest = new Arrest();
        arrest.setArrestId(newId);
        arrest.setCrimeId(req.getCrimeId());
        arrest.setArrestDate(req.getArrestDate());
        arrest.setArrestLocation(req.getArrestLocation());

        Arrest saved = arrestRepository.save(arrest);

        if (req.getOfficerId() != null) {
            arrestRepository.insertOfficerArrest(req.getOfficerId(), saved.getArrestId());
        }
        if (req.getSuspectId() != null) {
            arrestRepository.insertSuspectArrest(saved.getArrestId(), req.getSuspectId());
        }

        return saved;
    }
}
