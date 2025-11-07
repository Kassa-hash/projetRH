package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "Parametre")
public class Parametre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Parametre")
    private Long idParametre;

    @Column(name = "libelle", length = 50)
    private String libelle;

    @Column(name = "taux", precision = 15, scale = 2)
    private BigDecimal taux;

    @Column(name = "description", length = 50)
    private String description;

    @Column(name = "dateDebut")
    @Temporal(TemporalType.DATE)
    private Date dateDebut;

    // Getters and Setters
    public Long getIdParametre() { return idParametre; }
    public void setIdParametre(Long idParametre) { this.idParametre = idParametre; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public BigDecimal getTaux() { return taux; }
    public void setTaux(BigDecimal taux) { this.taux = taux; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }
}