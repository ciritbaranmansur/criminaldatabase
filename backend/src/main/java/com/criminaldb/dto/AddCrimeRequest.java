package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;
import java.time.LocalTime;

@Getter @Setter @NoArgsConstructor
public class AddCrimeRequest {
    private String crimeType;
    private LocalDate crimeDate;
    private LocalTime crimeTime;
    private String crimeLocation;
    private String city;
    private String district;
    private String crimeDescription;
    private String crimeStatus;
}
