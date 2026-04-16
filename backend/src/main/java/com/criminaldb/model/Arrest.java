package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "arrest")
@Getter @Setter @NoArgsConstructor
public class Arrest {

    @Id
    @Column(name = "arrest_id")
    private Integer arrestId;

    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "suspect_id")
    private Integer suspectId;

    @Column(name = "arresting_officer_id")
    private Integer arrestingOfficerId;

    @Column(name = "arrest_date")
    private LocalDate arrestDate;

    @Column(name = "arrest_location", length = 200)
    private String arrestLocation;
}
