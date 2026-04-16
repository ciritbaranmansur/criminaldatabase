package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "officer")
@Getter @Setter @NoArgsConstructor
public class Officer {

    @Id
    @Column(name = "officer_id")
    private Integer officerId;

    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @Column(name = "badge_number", unique = true, length = 20)
    private String badgeNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "rank_id")
    private OfficerRank rank;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "unit_id")
    private Unit unit;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "email", length = 100)
    private String email;
}
