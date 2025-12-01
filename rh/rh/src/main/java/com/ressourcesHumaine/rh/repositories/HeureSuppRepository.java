package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HeureSuppRepository extends JpaRepository<HeureSupp, Long> {
    // Méthode pour récupérer les heures supp d'un employé pour un mois et année spécifiques
    @Query("SELECT h FROM HeureSupp h WHERE h.employe.idEmploye = :employeId AND MONTH(h.date) = :month AND YEAR(h.date) = :year")
    List<HeureSupp> findHeuresSuppByEmployeAndMonth(@Param("employeId") Long employeId,
                                                    @Param("month") int month,
                                                    @Param("year") int year);
}
