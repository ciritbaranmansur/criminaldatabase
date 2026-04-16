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
public class CrimeSuspectId implements Serializable {

    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "suspect_id")
    private Integer suspectId;
}
