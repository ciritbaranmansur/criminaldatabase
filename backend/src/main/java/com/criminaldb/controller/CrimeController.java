package com.criminaldb.controller;

import com.criminaldb.dto.AddCrimeRequest;
import com.criminaldb.model.Crime;
import com.criminaldb.service.CrimeService;
import com.criminaldb.service.CrimeSuspectService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/crimes")
public class CrimeController {

    private final CrimeService crimeService;
    private final CrimeSuspectService crimeSuspectService;

    public CrimeController(CrimeService crimeService, CrimeSuspectService crimeSuspectService) {
        this.crimeService = crimeService;
        this.crimeSuspectService = crimeSuspectService;
    }

    @GetMapping
    public List<Crime> getAll(@RequestParam(required = false) String type,
                               @RequestParam(required = false) String status,
                               @RequestParam(required = false) String city) {
        return crimeService.filter(type, status, city);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Crime> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(crimeService.getById(id));
    }

    @GetMapping("/by-suspect/{suspectId}")
    public List<Crime> getBySuspect(@PathVariable Integer suspectId) {
        return crimeService.getBySuspect(suspectId);
    }

    @PostMapping
    public ResponseEntity<Crime> addCrime(@RequestBody AddCrimeRequest request) {
        return ResponseEntity.ok(crimeService.addCrime(request));
    }

    /**
     * Query 5: Remove a suspect from a crime (they did not do it).
     */
    @DeleteMapping("/{crimeId}/suspects/{suspectId}")
    public ResponseEntity<Map<String, Object>> removeSuspect(@PathVariable Integer crimeId,
                                                              @PathVariable Integer suspectId) {
        boolean removed = crimeSuspectService.removeSuspectFromCrime(crimeId, suspectId);
        if (removed) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Suspect " + suspectId + " removed from crime " + crimeId
            ));
        }
        return ResponseEntity.status(404).body(Map.of(
            "success", false,
            "message", "Link between crime " + crimeId + " and suspect " + suspectId + " not found"
        ));
    }
}
