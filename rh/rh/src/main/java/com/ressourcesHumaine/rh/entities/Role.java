package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Role")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Role")
    private Long idRole;

    @Column(name = "valeur")
    private Integer valeur;

    // Getters and Setters
    public Long getIdRole() { return idRole; }
    public void setIdRole(Long idRole) { this.idRole = idRole; }
    public Integer getValeur() { return valeur; }
    public void setValeur(Integer valeur) { this.valeur = valeur; }
}