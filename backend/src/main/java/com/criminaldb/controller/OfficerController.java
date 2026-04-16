package com.criminaldb.controller;

import com.criminaldb.dto.AddOfficerRequest;
import com.criminaldb.dto.OfficerArrestStatsDTO;
import com.criminaldb.model.Officer;
import com.criminaldb.service.OfficerService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/officers")
public class OfficerController {

    private final OfficerService officerService;

    public OfficerController(OfficerService officerService) {
        this.officerService = officerService;
    }

    @GetMapping
    public List<Officer> getAll() {
        return officerService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Officer> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(officerService.getById(id));
    }

    @PostMapping
    public ResponseEntity<Officer> addOfficer(@RequestBody AddOfficerRequest request) {
        return ResponseEntity.ok(officerService.addOfficer(request));
    }

    /**
     * Query 2: Officers and how many suspects of each gender were arrested by each officer.
     */
    @GetMapping("/arrest-stats")
    public List<OfficerArrestStatsDTO> getArrestStats() {
        return officerService.getArrestStats();
    }
}
