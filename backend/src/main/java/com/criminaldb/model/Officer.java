package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Officer")
@Getter @Setter @NoArgsConstructor
public class Officer {

    @Id
    @Column(name = "OfficerId")
    private Integer officerId;

    @Column(name = "OfficerRank")
    private String officerRank;

    @Column(name = "OfficerName")
    private String officerName;

    @Column(name = "OfficerUnit")
    private String officerUnit;
}
