package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "HeureSupp")
public class HeureSupp {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_heure_supp")
    private Long idHeureSupp;

    @Column(name = "date_")  // Correspond exactement au nom dans votre table
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "duree", precision = 15, scale = 2)
    private BigDecimal duree;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdHeureSupp() {
        return idHeureSupp;
    }

    public void setIdHeureSupp(Long idHeureSupp) {
        this.idHeureSupp = idHeureSupp;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public BigDecimal getDuree() {
        return duree;
    }

    public void setDuree(BigDecimal duree) {
        this.duree = duree;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }


}