package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Document")
public class Document {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Document")
    private Long idDocument;

    @Column(name = "NomFichier", length = 50)
    private String nomFichier;

    @ManyToOne
    @JoinColumn(name = "Id_TypeDocument", nullable = false)
    private TypeDocument typeDocument;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdDocument() { return idDocument; }
    public void setIdDocument(Long idDocument) { this.idDocument = idDocument; }
    public String getNomFichier() { return nomFichier; }
    public void setNomFichier(String nomFichier) { this.nomFichier = nomFichier; }
    public TypeDocument getTypeDocument() { return typeDocument; }
    public void setTypeDocument(TypeDocument typeDocument) { this.typeDocument = typeDocument; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
}