package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "PosteEmploye")
public class PosteEmploye {
    @Id
    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    @Id
    @ManyToOne
    @JoinColumn(name = "Id_Poste", nullable = false)
    private Poste poste;

    @Column(name = "date_")
    @Temporal(TemporalType.DATE)
    private Date date;

    // Getters and Setters
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public Poste getPoste() { return poste; }
    public void setPoste(Poste poste) { this.poste = poste; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}