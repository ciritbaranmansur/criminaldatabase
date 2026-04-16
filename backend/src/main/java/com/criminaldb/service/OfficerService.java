package com.criminaldb.service;

import com.criminaldb.dto.AddOfficerRequest;
import com.criminaldb.dto.OfficerArrestStatsDTO;
import com.criminaldb.model.Officer;
import com.criminaldb.repository.OfficerRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OfficerService {

    private final OfficerRepository officerRepository;

    public OfficerService(OfficerRepository officerRepository) {
        this.officerRepository = officerRepository;
    }

    public List<Officer> getAll() {
        return officerRepository.findAll();
    }

    public Officer getById(Integer id) {
        return officerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Officer not found: " + id));
    }

    public Officer addOfficer(AddOfficerRequest req) {
        Integer maxId = officerRepository.findMaxOfficerId();
        int newId = req.getOfficerId() != null ? req.getOfficerId() : (maxId != null ? maxId : 0) + 1;

        Officer o = new Officer();
        o.setOfficerId(newId);
        o.setOfficerRank(req.getOfficerRank());
        o.setOfficerName(req.getOfficerName());
        o.setOfficerUnit(req.getOfficerUnit());
        return officerRepository.save(o);
    }

    /**
     * Query 2: Officers and how many suspects of each gender were arrested by each officer.
     */
    public List<OfficerArrestStatsDTO> getArrestStats() {
        return officerRepository.getArrestStatsByGender()
                .stream()
                .map(OfficerArrestStatsDTO::fromRow)
                .collect(Collectors.toList());
    }
}
