package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "officer_rank")
@Getter @Setter @NoArgsConstructor
public class OfficerRank {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rank_id")
    private Integer rankId;

    @Column(name = "rank_name", nullable = false, length = 50)
    private String rankName;
}
