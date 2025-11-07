package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Mois")
public class Mois {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Mois")
    private Long idMois;

    @Column(name = "libelle", length = 50)
    private String libelle;

    // Getters and Setters
    public Long getIdMois() { return idMois; }
    public void setIdMois(Long idMois) { this.idMois = idMois; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}