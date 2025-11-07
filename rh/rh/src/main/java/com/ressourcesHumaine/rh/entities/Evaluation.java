package com.ressourcesHumaine.rh.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "Evaluation")
public class Evaluation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id_Evaluation")
    private Long idEvaluation;

    @Column(name = "Date_")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "note", precision = 15, scale = 2)
    private BigDecimal note;

    @Column(name = "Commentaire", length = 50)
    private String commentaire;

    @ManyToOne
    @JoinColumn(name = "Id_Employe", nullable = false)
    private Employe employeEvalue;

    @ManyToOne
    @JoinColumn(name = "Id_Employe_1", nullable = false)
    private Employe evaluateur;

    // Getters and Setters
    public Long getIdEvaluation() { return idEvaluation; }
    public void setIdEvaluation(Long idEvaluation) { this.idEvaluation = idEvaluation; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public BigDecimal getNote() { return note; }
    public void setNote(BigDecimal note) { this.note = note; }
    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }
    public Employe getEmployeEvalue() { return employeEvalue; }
    public void setEmployeEvalue(Employe employeEvalue) { this.employeEvalue = employeEvalue; }
    public Employe getEvaluateur() { return evaluateur; }
    public void setEvaluateur(Employe evaluateur) { this.evaluateur = evaluateur; }
}