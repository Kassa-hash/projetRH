package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Conge")
public class Conge {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Conge")
    private Long idConge;

    @OneToOne
    @JoinColumn(name = "Id_DemandeConge", nullable = false, unique = true)
    private DemandeConge demandeConge;

    // Getters and Setters
    public Long getIdConge() { return idConge; }
    public void setIdConge(Long idConge) { this.idConge = idConge; }
    public DemandeConge getDemandeConge() { return demandeConge; }
    public void setDemandeConge(DemandeConge demandeConge) { this.demandeConge = demandeConge; }
}
