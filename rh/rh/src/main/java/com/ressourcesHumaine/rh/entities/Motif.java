package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Motif")
public class Motif {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Motif")
    private Long idMotif;

    @Column(name = "libelle", length = 50)
    private String libelle;

    // Getters and Setters
    public Long getIdMotif() { return idMotif; }
    public void setIdMotif(Long idMotif) { this.idMotif = idMotif; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}