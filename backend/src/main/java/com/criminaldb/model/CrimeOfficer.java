package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Crime_Officer")
@Getter @Setter @NoArgsConstructor
public class CrimeOfficer {

    @EmbeddedId
    private CrimeOfficerId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("crimeId")
    @JoinColumn(name = "CrimeId")
    private Crime crime;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("officerId")
    @JoinColumn(name = "OfficerId")
    private Officer officer;
}
