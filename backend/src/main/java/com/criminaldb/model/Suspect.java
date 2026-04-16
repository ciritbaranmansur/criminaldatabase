package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "suspect")
@Getter @Setter @NoArgsConstructor
public class Suspect {

    @Id
    @Column(name = "suspect_id")
    private Integer suspectId;

    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(name = "gender", length = 1)
    private String gender;

    @Column(name = "nation_id", length = 20)
    private String nationId;

    @Column(name = "height_cm")
    private Integer heightCm;

    @Column(name = "weight_kg")
    private Integer weightKg;

    @Column(name = "eye_color", length = 20)
    private String eyeColor;

    @Column(name = "hair_color", length = 20)
    private String hairColor;

    @Column(name = "address", length = 200)
    private String address;

    @Column(name = "status", length = 20)
    private String status;
}
