package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Poste")
public class Poste {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Poste")
    private Long idPoste;

    @Column(name = "libelle", length = 50)
    private String libelle;

    @Column(name = "salaireDeBase", precision = 15, scale = 2)
    private BigDecimal salaireDeBase;

    // Getters and Setters
    public Long getIdPoste() { return idPoste; }
    public void setIdPoste(Long idPoste) { this.idPoste = idPoste; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public BigDecimal getSalaireDeBase() { return salaireDeBase; }
    public void setSalaireDeBase(BigDecimal salaireDeBase) { this.salaireDeBase = salaireDeBase; }
}