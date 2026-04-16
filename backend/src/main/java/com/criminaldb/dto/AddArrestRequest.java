package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Getter @Setter @NoArgsConstructor
public class AddArrestRequest {
    private Integer crimeId;
    private Integer officerId;
    private Integer suspectId;
    private LocalDate arrestDate;
    private String arrestLocation;
}
