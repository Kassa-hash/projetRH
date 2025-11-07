package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "DemandeAvance")
public class DemandeAvance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_DemandeAvance")
    private Long idDemandeAvance;

    @Column(name = "Date_")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "Montant", precision = 15, scale = 2)
    private BigDecimal montant;

    @ManyToOne
    @JoinColumn(name = "Id_Mois", nullable = false)
    private Mois mois;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdDemandeAvance() { return idDemandeAvance; }
    public void setIdDemandeAvance(Long idDemandeAvance) { this.idDemandeAvance = idDemandeAvance; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }
    public Mois getMois() { return mois; }
    public void setMois(Mois mois) { this.mois = mois; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
}