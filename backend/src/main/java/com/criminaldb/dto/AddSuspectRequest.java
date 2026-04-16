package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Getter @Setter @NoArgsConstructor
public class AddSuspectRequest {
    private String firstName;
    private String lastName;
    private LocalDate dateOfBirth;
    private String gender;
    private String nationId;
    private Integer heightCm;
    private Integer weightKg;
    private String eyeColor;
    private String hairColor;
    private String address;
    private String status;
}
