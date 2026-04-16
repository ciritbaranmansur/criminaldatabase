package com.criminaldb.controller;

import com.criminaldb.dto.AddArrestRequest;
import com.criminaldb.model.Arrest;
import com.criminaldb.service.ArrestService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/arrests")
public class ArrestController {

    private final ArrestService arrestService;

    public ArrestController(ArrestService arrestService) {
        this.arrestService = arrestService;
    }

    @GetMapping
    public List<Arrest> getAll() {
        return arrestService.getAll();
    }

    /**
     * Query 4: Add a new arrest of a suspect.
     */
    @PostMapping
    public ResponseEntity<Arrest> addArrest(@RequestBody AddArrestRequest request) {
        Arrest created = arrestService.addArrest(request);
        return ResponseEntity.ok(created);
    }
}
