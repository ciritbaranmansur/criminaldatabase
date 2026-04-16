package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor
public class AddOfficerRequest {
    private String firstName;
    private String lastName;
    private String badgeNumber;
    private Integer rankId;
    private Integer unitId;
    private String phone;
    private String email;
}
