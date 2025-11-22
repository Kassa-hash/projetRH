package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;  // Utilise LocalDateTime au lieu de Date/Datetime
@Entity
@Table(name = "Historique")
public class Historique {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Historique")
    private Long idHistorique;

    public Long getIdHistorique() {
        return idHistorique;
    }

    public void setIdHistorique(Long idHistorique) {
        this.idHistorique = idHistorique;
    }

    @Column(name="description")
    String description;

    public void setDescription(String descri){this.description=descri;}
    public String getDescription(){return this.description;}

    @Column(name="details")
    String details;
    public String getDetails(){return this.details;}
    public void setDetails(String det){this.details=det;}
    
    @Column(name="Id_Evenement")
    int Id_Evenement;
    public void setIdEvenement(int id){this.Id_Evenement=id;}
    public int getIdEvenement(){return this.Id_Evenement;}

    @Column(name = "moment_action", nullable = false, updatable = false)
    @CreationTimestamp
    private LocalDateTime momentAction;
    public LocalDateTime getMomentAction() { return momentAction; }

    @Column(name="classe")
    Class classe;
    public void setClasse(Class c){this.classe=c;}
    public Class getClasse(){return this.classe;}
    
}