package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Avance")
public class Avance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Avance")
    private Long idAvance;

    @OneToOne
    @JoinColumn(name = "Id_DemandeAvance", nullable = false, unique = true)
    private DemandeAvance demandeAvance;

    // Getters and Setters
    public Long getIdAvance() { return idAvance; }
    public void setIdAvance(Long idAvance) { this.idAvance = idAvance; }
    public DemandeAvance getDemandeAvance() { return demandeAvance; }
    public void setDemandeAvance(DemandeAvance demandeAvance) { this.demandeAvance = demandeAvance; }
}