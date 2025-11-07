package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
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

    @ManyToOne
    @JoinColumn(name = "Id_Role", nullable = false)
    private Role role;

    @ManyToOne
    @JoinColumn(name = "Id_Genre", nullable = false)
    private Genre genre;

    // Getters and Setters
    public Long getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Long idEmploye) { this.idEmploye = idEmploye; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public Date getDateDeNaissance() { return dateDeNaissance; }
    public void setDateDeNaissance(Date dateDeNaissance) { this.dateDeNaissance = dateDeNaissance; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    public Genre getGenre() { return genre; }
    public void setGenre(Genre genre) { this.genre = genre; }
}