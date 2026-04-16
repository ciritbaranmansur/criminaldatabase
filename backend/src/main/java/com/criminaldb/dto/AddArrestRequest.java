package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

/**
 * Request body for Query 4: Add a new arrest of a suspect.
 */
@Getter @Setter @NoArgsConstructor
public class AddArrestRequest {
    private Integer crimeId;
    private Integer suspectId;
    private Integer arrestingOfficerId;
    private LocalDate arrestDate;
    private String arrestLocation;
}
