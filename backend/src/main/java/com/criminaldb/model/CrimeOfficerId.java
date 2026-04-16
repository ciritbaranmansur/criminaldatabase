package com.criminaldb.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.io.Serializable;

@Embeddable
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode
public class CrimeOfficerId implements Serializable {

    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "officer_id")
    private Integer officerId;
}
