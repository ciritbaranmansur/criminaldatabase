package com.criminaldb.controller;

import com.criminaldb.dto.CourtHearingDTO;
import com.criminaldb.dto.UpdateHearingDateRequest;
import com.criminaldb.service.SentenceService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/sentences")
public class SentenceController {

    private final SentenceService sentenceService;

    public SentenceController(SentenceService sentenceService) {
        this.sentenceService = sentenceService;
    }

    /**
     * Query 1: All suspects and crime info appearing in court on a certain date.
     */
    @GetMapping("/by-date")
    public List<CourtHearingDTO> getByDate(@RequestParam String date) {
        return sentenceService.getByHearingDate(LocalDate.parse(date));
    }

    /**
     * Query 3: Change the hearing date for a particular court case.
     */
    @PutMapping("/{caseNo}/hearing-date")
    public ResponseEntity<Map<String, Object>> updateHearingDate(
            @PathVariable Integer caseNo,
            @RequestBody UpdateHearingDateRequest request) {
        boolean updated = sentenceService.updateHearingDate(caseNo, request.getHearingDate());
        if (updated) {
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Hearing date updated for case #" + caseNo,
                "newDate", request.getHearingDate().toString()
            ));
        }
        return ResponseEntity.status(404).body(Map.of(
            "success", false,
            "message", "Court case #" + caseNo + " not found"
        ));
    }
}
