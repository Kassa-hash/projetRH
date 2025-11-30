package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Departement")
public class Departement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Departement")
    private Long idDepartement;

    @Column(name = "nom", length = 50)
    private String nom;


    // Getters and Setters
    public Long getIdDepartement() { return idDepartement; }
    public void setIdDepartement(Long idDepartement) { this.idDepartement = idDepartement; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

}