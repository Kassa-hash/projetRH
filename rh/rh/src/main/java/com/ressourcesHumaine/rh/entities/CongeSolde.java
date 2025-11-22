package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "CongeSolde")
public class CongeSolde {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_CongeSolde")
    private Long idCongeSolde;

    public Long getIdCongeSolde() {
        return idCongeSolde;
    }

    public void setIdCongeSolde(Long idCongeSolde) {
        this.idCongeSolde = idCongeSolde;
    }

    @ManyToOne
    @JoinColumn(name="Id_Employe")
    Employe employe;

    public Employe getEmp() {
        return employe;
    }

    public void setEmp(Employe emp) {
        this.employe = emp;
    }

    @Column(name="annee")
    int annee;

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    @Column(name="nb_jour")
    int nbJour;

    public int getNbJour() {
        return nbJour;
    }

    public void setNbJour(int nbJour) {
        this.nbJour = nbJour;
    }
}