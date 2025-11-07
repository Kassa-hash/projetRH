package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Genre")
public class Genre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Genre")
    private Long idGenre;

    @Column(name = "libelle", length = 50)
    private String libelle;

    // Getters and Setters
    public Long getIdGenre() { return idGenre; }
    public void setIdGenre(Long idGenre) { this.idGenre = idGenre; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}