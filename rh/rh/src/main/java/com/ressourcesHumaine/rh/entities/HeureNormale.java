package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.sql.Time;

@Entity
@Table(name = "HeureNormale")
public class HeureNormale {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_HeureNormale")
    private Long idHeureNormale;

    @Column(name = "HeureEntree")
    private Time heureEntree;

    @Column(name = "HeureSortie")
    private Time heureSortie;

    // Getters and Setters
    public Long getIdHeureNormale() { return idHeureNormale; }
    public void setIdHeureNormale(Long idHeureNormale) { this.idHeureNormale = idHeureNormale; }
    public Time getHeureEntree() { return heureEntree; }
    public void setHeureEntree(Time heureEntree) { this.heureEntree = heureEntree; }
    public Time getHeureSortie() { return heureSortie; }
    public void setHeureSortie(Time heureSortie) { this.heureSortie = heureSortie; }
}