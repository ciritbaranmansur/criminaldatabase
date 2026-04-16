package com.criminaldb.controller;

import com.criminaldb.dto.AddSuspectRequest;
import com.criminaldb.model.Suspect;
import com.criminaldb.service.SuspectService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/suspects")
public class SuspectController {

    private final SuspectService suspectService;

    public SuspectController(SuspectService suspectService) {
        this.suspectService = suspectService;
    }

    @GetMapping
    public List<Suspect> getAll(@RequestParam(required = false) String search) {
        return suspectService.search(search);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Suspect> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(suspectService.getById(id));
    }

    @GetMapping("/by-crime/{crimeId}")
    public List<Suspect> getByCrime(@PathVariable Integer crimeId) {
        return suspectService.getByCrime(crimeId);
    }

    @PostMapping
    public ResponseEntity<Suspect> addSuspect(@RequestBody AddSuspectRequest request) {
        return ResponseEntity.ok(suspectService.addSuspect(request));
    }
}
