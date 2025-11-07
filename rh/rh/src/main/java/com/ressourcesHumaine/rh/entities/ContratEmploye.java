package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ContratEmploye")
public class ContratEmploye {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_ContratEmploye")
    private Long idContratEmploye;

    @Column(name = "Date_")
    @Temporal(TemporalType.DATE)
    private Date date;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    @ManyToOne
    @JoinColumn(name = "Id_TypeContrat", nullable = false)
    private TypeContrat typeContrat;

    // Getters and Setters
    public Long getIdContratEmploye() { return idContratEmploye; }
    public void setIdContratEmploye(Long idContratEmploye) { this.idContratEmploye = idContratEmploye; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public TypeContrat getTypeContrat() { return typeContrat; }
    public void setTypeContrat(TypeContrat typeContrat) { this.typeContrat = typeContrat; }
}