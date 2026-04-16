package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;
import java.util.Map;

/**
 * DTO for dashboard statistics summary.
 */
@Getter @Setter @NoArgsConstructor
public class DashboardStatsDTO {
    private long totalCrimes;
    private long totalSuspects;
    private long totalOfficers;
    private long totalArrests;
    private List<Map<String, Object>> crimesByType;
    private List<Map<String, Object>> crimesByStatus;
}
