package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "Arrest")
@Getter @Setter @NoArgsConstructor
public class Arrest {

    @Id
    @Column(name = "ArrestId")
    private Integer arrestId;

    @Column(name = "ArrestDate")
    private LocalDate arrestDate;

    @Column(name = "ArrestLocation")
    private String arrestLocation;

    @Column(name = "CrimeId")
    private Integer crimeId;
}
