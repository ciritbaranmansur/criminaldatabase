package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "crime_suspect")
@Getter @Setter @NoArgsConstructor
public class CrimeSuspect {

    @EmbeddedId
    private CrimeSuspectId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("crimeId")
    @JoinColumn(name = "crime_id")
    private Crime crime;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("suspectId")
    @JoinColumn(name = "suspect_id")
    private Suspect suspect;

    @Column(name = "suspect_role", length = 50)
    private String suspectRole;
}
