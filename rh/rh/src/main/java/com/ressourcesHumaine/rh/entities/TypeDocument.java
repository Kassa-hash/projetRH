package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "TypeDocument")
public class TypeDocument {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_TypeDocument")
    private Long idTypeDocument;

    @Column(name = "libelle", length = 50)
    private String libelle;

    // Getters and Setters
    public Long getIdTypeDocument() { return idTypeDocument; }
    public void setIdTypeDocument(Long idTypeDocument) { this.idTypeDocument = idTypeDocument; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}