package com.criminaldb.service;

import com.criminaldb.dto.AddOfficerRequest;
import com.criminaldb.dto.OfficerArrestStatsDTO;
import com.criminaldb.model.Officer;
import com.criminaldb.model.OfficerRank;
import com.criminaldb.model.Unit;
import com.criminaldb.repository.OfficerRankRepository;
import com.criminaldb.repository.OfficerRepository;
import com.criminaldb.repository.UnitRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OfficerService {

    private final OfficerRepository officerRepository;
    private final OfficerRankRepository rankRepository;
    private final UnitRepository unitRepository;

    public OfficerService(OfficerRepository officerRepository,
                          OfficerRankRepository rankRepository,
                          UnitRepository unitRepository) {
        this.officerRepository = officerRepository;
        this.rankRepository = rankRepository;
        this.unitRepository = unitRepository;
    }

    public List<Officer> getAll() {
        return officerRepository.findAll();
    }

    public Officer getById(Integer id) {
        return officerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Officer not found: " + id));
    }

    public List<OfficerRank> getAllRanks() {
        return rankRepository.findAll();
    }

    public List<Unit> getAllUnits() {
        return unitRepository.findAll();
    }

    public Officer addOfficer(AddOfficerRequest req) {
        Integer maxId = officerRepository.findMaxOfficerId();
        int newId = (maxId != null ? maxId : 0) + 1;

        OfficerRank rank = rankRepository.findById(req.getRankId())
                .orElseThrow(() -> new RuntimeException("Rank not found: " + req.getRankId()));
        Unit unit = unitRepository.findById(req.getUnitId())
                .orElseThrow(() -> new RuntimeException("Unit not found: " + req.getUnitId()));

        Officer o = new Officer();
        o.setOfficerId(newId);
        o.setFirstName(req.getFirstName());
        o.setLastName(req.getLastName());
        o.setBadgeNumber(req.getBadgeNumber());
        o.setRank(rank);
        o.setUnit(unit);
        o.setPhone(req.getPhone());
        o.setEmail(req.getEmail());
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
