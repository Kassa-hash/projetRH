package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Paie")
public class Paie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Paie")
    private Long idPaie;

    @Column(name = "SalaireBase", precision = 15, scale = 2)
    private BigDecimal salaireBase;

    @Column(name = "SalaireBrute", precision = 15, scale = 2)
    private BigDecimal salaireBrute;

    @Column(name = "cnaps", precision = 15, scale = 2)
    private BigDecimal cnaps;

    @Column(name = "revenuimposable", precision = 15, scale = 2)
    private BigDecimal revenuImposable;

    @Column(name = "impotDu", precision = 15, scale = 2)
    private BigDecimal impotDu;

    @Column(name = "NetDuMois", precision = 15, scale = 2)
    private BigDecimal netDuMois;

    @Column(name = "ostie", precision = 15, scale = 2)
    private BigDecimal ostie;

    @ManyToOne
    @JoinColumn(name = "Id_Mois", nullable = false)
    private Mois mois;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employe;

    // Getters and Setters
    public Long getIdPaie() { return idPaie; }
    public void setIdPaie(Long idPaie) { this.idPaie = idPaie; }
    public BigDecimal getSalaireBase() { return salaireBase; }
    public void setSalaireBase(BigDecimal salaireBase) { this.salaireBase = salaireBase; }
    public BigDecimal getSalaireBrute() { return salaireBrute; }
    public void setSalaireBrute(BigDecimal salaireBrute) { this.salaireBrute = salaireBrute; }
    public BigDecimal getCnaps() { return cnaps; }
    public void setCnaps(BigDecimal cnaps) { this.cnaps = cnaps; }
    public BigDecimal getRevenuImposable() { return revenuImposable; }
    public void setRevenuImposable(BigDecimal revenuImposable) { this.revenuImposable = revenuImposable; }
    public BigDecimal getImpotDu() { return impotDu; }
    public void setImpotDu(BigDecimal impotDu) { this.impotDu = impotDu; }
    public BigDecimal getNetDuMois() { return netDuMois; }
    public void setNetDuMois(BigDecimal netDuMois) { this.netDuMois = netDuMois; }
    public BigDecimal getOstie() { return ostie; }
    public void setOstie(BigDecimal ostie) { this.ostie = ostie; }
    public Mois getMois() { return mois; }
    public void setMois(Mois mois) { this.mois = mois; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
}