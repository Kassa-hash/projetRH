package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.CongeSolde;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface CongeSoldeRepository extends JpaRepository<CongeSolde, Long> {

    // Récupérer le solde de congé pour un employé pour une année donnée
    @Query("SELECT c FROM CongeSolde c WHERE c.annee = :annee AND c.employe.idEmploye = :idEmp")
    CongeSolde getCongeEmpByAnnee(@Param("annee") int annee, @Param("idEmp") Long idEmp);

    // Récupérer le total de jours de congé pour un employé pour une année donnée
    @Query("SELECT SUM(c.nbJour) FROM CongeSolde c WHERE c.employe.idEmploye = :idEmp AND c.annee = :annee")
    Integer soldeByEmploye(@Param("idEmp") Long idEmp, @Param("annee") int annee);

    // Méthode pratique pour récupérer le solde de l'année courante
    default Integer soldeByEmployeCetteAnnee(Long idEmp) {
        int anneeCourante = LocalDate.now().getYear();
        return soldeByEmploye(idEmp, anneeCourante);
    }
}
