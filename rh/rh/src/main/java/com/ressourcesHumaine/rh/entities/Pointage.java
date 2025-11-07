package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.sql.Time;
import java.util.Date;

@Entity
@Table(name = "Pointage")
public class Pointage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Pointage")
    private Long idPointage;

    @Column(name = "DatePointage")
    @Temporal(TemporalType.DATE)
    private Date datePointage;

    @Column(name = "HeureEntree")
    private Time heureEntree;

    @Column(name = "HeureSortie")
    private Time heureSortie;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdPointage() { return idPointage; }
    public void setIdPointage(Long idPointage) { this.idPointage = idPointage; }
    public Date getDatePointage() { return datePointage; }
    public void setDatePointage(Date datePointage) { this.datePointage = datePointage; }
    public Time getHeureEntree() { return heureEntree; }
    public void setHeureEntree(Time heureEntree) { this.heureEntree = heureEntree; }
    public Time getHeureSortie() { return heureSortie; }
    public void setHeureSortie(Time heureSortie) { this.heureSortie = heureSortie; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
}