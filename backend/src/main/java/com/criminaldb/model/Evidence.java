package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "evidence")
@Getter @Setter @NoArgsConstructor
public class Evidence {

    @Id
    @Column(name = "evidence_id")
    private Integer evidenceId;

    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "evidence_type", length = 50)
    private String evidenceType;

    @Column(name = "evidence_description", columnDefinition = "TEXT")
    private String evidenceDescription;
}
