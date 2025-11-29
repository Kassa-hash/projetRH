package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "ContratEmploye")
public class ContratEmploye {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "Id_ContratEmploye")
  private Long idContratEmploye;

  @Column(name = "Date_")
  @Temporal(TemporalType.DATE)
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date dateDebut;

  @Column(name = "Date_Fin")
  @Temporal(TemporalType.DATE)
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date dateFin;

  @ManyToOne
  @JoinColumn(name = "Id_Poste")
  private Poste poste;

  @ManyToOne
  @JoinColumn(name = "Id_Employe")
  private Employe employe;

  public void setEmploye(Employe e) {
    this.employe = e;
  }

  public Employe getEmploye() {
    return this.employe;
  }

  public Poste getPoste() {
    return this.poste;
  }

  public void setPoste(Poste p) {
    this.poste = p;
  }

  @Column(name = "Duree")
  private Integer duree;

  public Integer getDuree() {
    return duree;
  }

  public void setDuree(Integer duree) {
    this.duree = duree;
  }

  @ManyToOne
  @JoinColumn(name = "Id_TypeContrat", nullable = false)
  private TypeContrat typeContrat;

  // Getters and Setters
  public Long getIdContratEmploye() {
    return idContratEmploye;
  }

  public void setIdContratEmploye(Long idContratEmploye) {
    this.idContratEmploye = idContratEmploye;
  }

  public Date getDate() {
    return dateDebut;
  }

  public void setDate(Date date) {
    this.dateDebut = date;
  }

  public void setDateFin(Date date) {
    this.dateFin = date;
  }

  public Date getDateFin() {
    return this.dateFin;
  }

  public TypeContrat getTypeContrat() {
    return typeContrat;
  }

  public void setTypeContrat(TypeContrat typeContrat) {
    this.typeContrat = typeContrat;
  }
}