package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "DemandeConge")
public class DemandeConge {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_DemandeConge")
    private Long idDemandeConge;

    @Column(name = "DateDebut")
    @Temporal(TemporalType.DATE)
    private Date dateDebut;

    @Column(name = "DateFin")
    @Temporal(TemporalType.DATE)
    private Date dateFin;

    @Column(name = "DateDemande")
    @Temporal(TemporalType.DATE)
    private Date dateDemande;

    @Column(name="status")
    private String status;

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    @ManyToOne
    @JoinColumn(name = "Id_Motif", nullable = false)
    private Motif motif;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdDemandeConge() { return idDemandeConge; }
    public void setIdDemandeConge(Long idDemandeConge) { this.idDemandeConge = idDemandeConge; }
    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }
    public Date getDateFin() { return dateFin; }
    public void setDateFin(Date dateFin) { this.dateFin = dateFin; }
    public Motif getMotif() { return motif; }
    public void setMotif(Motif motif) { this.motif = motif; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public void setDateDemande(Date dt){this.dateDemande=dt;}
    public Date getDateDemande(){return this.dateDemande;}
    
}