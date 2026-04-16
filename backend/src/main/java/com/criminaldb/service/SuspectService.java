package com.criminaldb.service;

import com.criminaldb.dto.AddSuspectRequest;
import com.criminaldb.model.Suspect;
import com.criminaldb.repository.SuspectRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SuspectService {

    private final SuspectRepository suspectRepository;

    public SuspectService(SuspectRepository suspectRepository) {
        this.suspectRepository = suspectRepository;
    }

    public List<Suspect> getAll() {
        return suspectRepository.findAll();
    }

    public Suspect getById(Integer id) {
        return suspectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Suspect not found: " + id));
    }

    public List<Suspect> search(String query) {
        if (query == null || query.isBlank()) {
            return suspectRepository.findAll();
        }
        return suspectRepository.search(query.trim());
    }

    public List<Suspect> getByCrime(Integer crimeId) {
        return suspectRepository.findByCrimeId(crimeId);
    }

    public Suspect addSuspect(AddSuspectRequest req) {
        Integer maxId = suspectRepository.findMaxSuspectId();
        int newId = (maxId != null ? maxId : 0) + 1;

        Suspect s = new Suspect();
        s.setSuspectId(newId);
        s.setFirstName(req.getFirstName());
        s.setLastName(req.getLastName());
        s.setDateOfBirth(req.getDateOfBirth());
        s.setGender(req.getGender());
        s.setNationId(req.getNationId());
        s.setHeightCm(req.getHeightCm());
        s.setWeightKg(req.getWeightKg());
        s.setEyeColor(req.getEyeColor());
        s.setHairColor(req.getHairColor());
        s.setAddress(req.getAddress());
        s.setStatus(req.getStatus() != null ? req.getStatus() : "Active");
        return suspectRepository.save(s);
    }
}
