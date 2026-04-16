package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Evidence")
@Getter @Setter @NoArgsConstructor
public class Evidence {

    @Id
    @Column(name = "EvidenceId")
    private Integer evidenceId;

    @Column(name = "CrimeId")
    private Integer crimeId;

    @Column(name = "EvidenceType")
    private String evidenceType;

    @Column(name = "EvidenceDescription", columnDefinition = "TEXT")
    private String evidenceDescription;
}
