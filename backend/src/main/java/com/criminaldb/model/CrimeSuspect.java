package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "SuspectCrime")
@Getter @Setter @NoArgsConstructor
public class CrimeSuspect {

    @EmbeddedId
    private CrimeSuspectId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("crimeId")
    @JoinColumn(name = "CrimeId")
    private Crime crime;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("suspectId")
    @JoinColumn(name = "SuspectId")
    private Suspect suspect;
}
