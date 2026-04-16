package com.criminaldb.service;

import com.criminaldb.dto.DashboardStatsDTO;
import com.criminaldb.repository.*;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashboardService {

    private final CrimeRepository crimeRepository;
    private final SuspectRepository suspectRepository;
    private final OfficerRepository officerRepository;
    private final ArrestRepository arrestRepository;

    public DashboardService(CrimeRepository crimeRepository,
                            SuspectRepository suspectRepository,
                            OfficerRepository officerRepository,
                            ArrestRepository arrestRepository) {
        this.crimeRepository = crimeRepository;
        this.suspectRepository = suspectRepository;
        this.officerRepository = officerRepository;
        this.arrestRepository = arrestRepository;
    }

    public DashboardStatsDTO getStats() {
        DashboardStatsDTO dto = new DashboardStatsDTO();
        dto.setTotalCrimes(crimeRepository.count());
        dto.setTotalSuspects(suspectRepository.count());
        dto.setTotalOfficers(officerRepository.count());
        dto.setTotalArrests(arrestRepository.count());

        List<Map<String, Object>> byType = crimeRepository.countByType()
                .stream().map(row -> {
                    Map<String, Object> m = new HashMap<>();
                    m.put("type", row[0]);
                    m.put("count", row[1]);
                    return m;
                }).collect(Collectors.toList());
        dto.setCrimesByType(byType);

        List<Map<String, Object>> byStatus = crimeRepository.countByStatus()
                .stream().map(row -> {
                    Map<String, Object> m = new HashMap<>();
                    m.put("status", row[0]);
                    m.put("count", row[1]);
                    return m;
                }).collect(Collectors.toList());
        dto.setCrimesByStatus(byStatus);

        return dto;
    }
}
