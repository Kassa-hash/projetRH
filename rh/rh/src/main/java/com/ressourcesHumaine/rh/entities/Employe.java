package com.ressourcesHumaine.rh.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ressourcesHumaine.rh.services.HeureSuppService;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

@Entity
@Table(name = "Employe")
public class Employe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Employe")
    private Long idEmploye;

    @Column(name = "nom", length = 50)
    private String nom;

    @Column(name = "DateDeNaissance")
    @Temporal(TemporalType.DATE)
    private Date dateDeNaissance;

    @Column(name = "contact", length = 50)
    private String contact;

    @Column(name = "email", length = 50)
    private String email;

    @Column(name = "photo", length = 50)
    private String photo;

    @Column(name = "adresse", length = 50)
    private String adresse;

    @Column(name = "mdp")
    private String mdp;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Id_Role", nullable = true)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Role role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Id_Genre", nullable = false)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Genre genre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Id_Departement", nullable = true)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Departement departement;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Id_ContratEmploye")
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private ContratEmploye contratEmploye;

    // Getters et Setters
    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public ContratEmploye getContratEmploye() {
        return this.contratEmploye;
    }

    public void setContratEmploye(ContratEmploye co) {
        this.contratEmploye = co;
    }

    public Long getIdEmploye() {
        return idEmploye;
    }

    public void setIdEmploye(Long idEmploye) {
        this.idEmploye = idEmploye;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Date getDateDeNaissance() {
        return dateDeNaissance;
    }

    public void setDateDeNaissance(Date dateDeNaissance) {
        this.dateDeNaissance = dateDeNaissance;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public Departement getDepartement() {
        return departement;
    }

    public void setDepartement(Departement departement) {
        this.departement = departement;
    }

    public BigDecimal getCoutHeureSupp(int mois, int annee) {

        return BigDecimal.ZERO;
    }

    public BigDecimal getCoutHeureSupp(java.math.BigDecimal heuresSupp) {
        java.math.BigDecimal salaireBase = java.math.BigDecimal.ZERO;
        if (this.getContratEmploye() != null && this.getContratEmploye().getPoste() != null
                && this.getContratEmploye().getPoste().getSalaireDeBase() != null) {
            salaireBase = this.getContratEmploye().getPoste().getSalaireDeBase();
        }
        java.math.BigDecimal heuresMensuelles = new java.math.BigDecimal("173.33");
        java.math.BigDecimal tauxHoraire = java.math.BigDecimal.ZERO;
        if (salaireBase.compareTo(java.math.BigDecimal.ZERO) > 0) {
            tauxHoraire = salaireBase.divide(heuresMensuelles, 10, java.math.RoundingMode.HALF_UP);
        }
        if (heuresSupp == null) {
            heuresSupp = java.math.BigDecimal.ZERO;
        }
        return heuresSupp.multiply(tauxHoraire);
    }
}