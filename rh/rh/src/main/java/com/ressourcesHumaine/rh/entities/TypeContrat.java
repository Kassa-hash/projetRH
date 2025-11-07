package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "TypeContrat")
public class TypeContrat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_TypeContrat")
    private Long idTypeContrat;

    @Column(name = "libelle", length = 50)
    private String libelle;

    @Column(name = "duree")
    private Integer duree;

    // Getters and Setters
    public Long getIdTypeContrat() { return idTypeContrat; }
    public void setIdTypeContrat(Long idTypeContrat) { this.idTypeContrat = idTypeContrat; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
}