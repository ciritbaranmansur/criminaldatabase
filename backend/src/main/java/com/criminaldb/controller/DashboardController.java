package com.criminaldb.controller;

import com.criminaldb.dto.DashboardStatsDTO;
import com.criminaldb.service.DashboardService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/stats")
    public DashboardStatsDTO getStats() {
        return dashboardService.getStats();
    }
}
