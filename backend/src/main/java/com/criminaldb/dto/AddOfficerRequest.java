package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor
public class AddOfficerRequest {
    private Integer officerId;
    private String officerRank;
    private String officerName;
    private String officerUnit;
}
