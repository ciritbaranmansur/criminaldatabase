package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "sentence")
@Getter @Setter @NoArgsConstructor
public class Sentence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sentence_id")
    private Integer sentenceId;

    @Column(name = "court_case_no", unique = true)
    private Integer courtCaseNo;

    @Column(name = "crime_id")
    private Integer crimeId;

    @Column(name = "suspect_id")
    private Integer suspectId;

    @Column(name = "hearing_date")
    private LocalDate hearingDate;

    @Column(name = "verdict", length = 20)
    private String verdict;

    @Column(name = "sentence_type", length = 30)
    private String sentenceType;

    @Column(name = "prison_duration")
    private Integer prisonDuration;

    @Column(name = "fine_amount", precision = 10, scale = 2)
    private BigDecimal fineAmount;

    @Column(name = "community_service_hours")
    private Integer communityServiceHours;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
}
