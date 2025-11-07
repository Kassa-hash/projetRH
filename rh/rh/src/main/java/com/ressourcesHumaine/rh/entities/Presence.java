package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Presence")
public class Presence {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Presence")
    private Long idPresence;

    @Column(name = "statut")
    private Boolean statut;

    @Column(name = "DatePresence")
    @Temporal(TemporalType.DATE)
    private Date datePresence;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdPresence() { return idPresence; }
    public void setIdPresence(Long idPresence) { this.idPresence = idPresence; }
    public Boolean getStatut() { return statut; }
    public void setStatut(Boolean statut) { this.statut = statut; }
    public Date getDatePresence() { return datePresence; }
    public void setDatePresence(Date datePresence) { this.datePresence = datePresence; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
}