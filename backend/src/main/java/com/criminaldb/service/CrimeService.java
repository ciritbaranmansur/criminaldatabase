package com.criminaldb.service;

import com.criminaldb.dto.AddCrimeRequest;
import com.criminaldb.model.Crime;
import com.criminaldb.repository.CrimeRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CrimeService {

    private final CrimeRepository crimeRepository;

    public CrimeService(CrimeRepository crimeRepository) {
        this.crimeRepository = crimeRepository;
    }

    public List<Crime> getAll() {
        return crimeRepository.findAll();
    }

    public Crime getById(Integer id) {
        return crimeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Crime not found: " + id));
    }

    public List<Crime> filter(String type, String status, String city) {
        String t = (type   != null && !type.isBlank())   ? type   : null;
        String s = (status != null && !status.isBlank()) ? status : null;
        String c = (city   != null && !city.isBlank())   ? city   : null;
        return crimeRepository.filter(t, s, c);
    }

    public List<Object[]> countByType()   { return crimeRepository.countByType(); }
    public List<Object[]> countByStatus() { return crimeRepository.countByStatus(); }

    public List<Crime> getBySuspect(Integer suspectId) {
        return crimeRepository.findBySuspectId(suspectId);
    }

    public Crime addCrime(AddCrimeRequest req) {
        Integer maxId = crimeRepository.findMaxCrimeId();
        int newId = (maxId != null ? maxId : 0) + 1;

        Crime c = new Crime();
        c.setCrimeId(newId);
        c.setCrimeType(req.getCrimeType());
        c.setCrimeDate(req.getCrimeDate());
        c.setCrimeTime(req.getCrimeTime());
        c.setCrimeLocation(req.getCrimeLocation());
        c.setCity(req.getCity());
        c.setDistrict(req.getDistrict());
        c.setDescription(req.getDescription());
        c.setCrimeStatus(req.getCrimeStatus() != null ? req.getCrimeStatus() : "Open");
        return crimeRepository.save(c);
    }
}
