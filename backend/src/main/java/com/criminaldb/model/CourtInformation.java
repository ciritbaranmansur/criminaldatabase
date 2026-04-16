package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "CourtInformation")
@Getter @Setter @NoArgsConstructor
public class CourtInformation {

    @Id
    @Column(name = "CourtCaseNo")
    private Integer courtCaseNo;

    @Column(name = "HearingDate")
    private LocalDate hearingDate;

    @Column(name = "Verdict")
    private String verdict;

    @Column(name = "SentenceLenght")
    private String sentenceLenght;

    @Column(name = "CrimeId")
    private Integer crimeId;

    @Column(name = "Fine")
    private Integer fine;
}
