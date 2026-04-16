package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "crime_officer")
@Getter @Setter @NoArgsConstructor
public class CrimeOfficer {

    @EmbeddedId
    private CrimeOfficerId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("crimeId")
    @JoinColumn(name = "crime_id")
    private Crime crime;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("officerId")
    @JoinColumn(name = "officer_id")
    private Officer officer;

    @Column(name = "role", length = 50)
    private String role;

    @Column(name = "assigned_date")
    private LocalDate assignedDate;
}
