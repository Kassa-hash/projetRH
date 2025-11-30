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

  @Column(name = "Date")
  @Temporal(TemporalType.DATE)
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date dateDebut;

  @Column(name = "Date_Fin")
  @Temporal(TemporalType.DATE)
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date dateFin;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "Id_Poste")
  private Poste poste;

  // L'employé qui possède ce contrat
  @ManyToOne
  @JoinColumn(name = "Id_Employe", insertable = false, updatable = false)
  private Employe employe;

  @Column(name = "Duree")
  private Integer duree;

  @ManyToOne
  @JoinColumn(name = "Id_TypeContrat", nullable = false)
  private TypeContrat typeContrat;

  // Getters et setters
  public Long getIdContratEmploye() { return idContratEmploye; }
  public void setIdContratEmploye(Long idContratEmploye) { this.idContratEmploye = idContratEmploye; }
  public Date getDate() { return dateDebut; }
  public void setDate(Date date) { this.dateDebut = date; }
  public void setDateFin(Date date) { this.dateFin = date; }
  public Date getDateFin() { return this.dateFin; }
  public TypeContrat getTypeContrat() { return typeContrat; }
  public void setTypeContrat(TypeContrat typeContrat) { this.typeContrat = typeContrat; }
  public Integer getDuree() { return duree; }
  public void setDuree(Integer duree) { this.duree = duree; }
  public Poste getPoste() { return this.poste; }
  public void setPoste(Poste p) { this.poste = p; }
  public void setEmploye(Employe e) { this.employe = e; }
  public Employe getEmploye() { return this.employe; }
}
