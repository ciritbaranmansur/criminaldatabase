package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "Crime")
@Getter @Setter @NoArgsConstructor
public class Crime {

    @Id
    @Column(name = "CrimeId")
    private Integer crimeId;

    @Column(name = "CrimeType")
    private String crimeType;

    @Column(name = "CrimeDate")
    private LocalDate crimeDate;

    @Column(name = "CrimeTime")
    private LocalTime crimeTime;

    @Column(name = "CrimeLocation")
    private String crimeLocation;

    @Column(name = "City")
    private String city;

    @Column(name = "District")
    private String district;

    @Column(name = "CrimeDescription", columnDefinition = "TEXT")
    private String crimeDescription;

    @Column(name = "CrimeStatus")
    private String crimeStatus;
}
