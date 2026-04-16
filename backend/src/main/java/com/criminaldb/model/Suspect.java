package com.criminaldb.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "Suspect")
@Getter @Setter @NoArgsConstructor
public class Suspect {

    @Id
    @Column(name = "SuspectId")
    private Integer suspectId;

    @Column(name = "FirstName")
    private String firstName;

    @Column(name = "LastName")
    private String lastName;

    @Column(name = "DateOfBirth")
    private LocalDate dateOfBirth;

    @Column(name = "Gender", length = 1)
    private String gender;

    @Column(name = "NationId")
    private String nationId;

    @Column(name = "HeightInCm")
    private Double heightInCm;

    @Column(name = "WeightInKg")
    private Double weightInKg;

    @Column(name = "EyeColor")
    private String eyeColor;

    @Column(name = "HairColor")
    private String hairColor;

    @Column(name = "Adress")
    private String adress;

    @Column(name = "Phone")
    private String phone;
}
