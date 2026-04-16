package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "crime")
@Getter @Setter @NoArgsConstructor
public class Crime {

    @Id
    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "crime_type", length = 50)
    private String crimeType;

    @Column(name = "crime_date")
    private LocalDate crimeDate;

    @Column(name = "crime_time")
    private LocalTime crimeTime;

    @Column(name = "crime_location", length = 200)
    private String crimeLocation;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "district", length = 100)
    private String district;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "crime_status", length = 30)
    private String crimeStatus;
}
