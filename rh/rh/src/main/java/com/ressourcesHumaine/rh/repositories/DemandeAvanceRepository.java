package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.DemandeConge;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DemandeAvanceRepository extends JpaRepository<DemandeAvance, Long> {

    @Query("SELECT dc FROM DemandeAvance dc WHERE dc.status = 'en attente'")
    List<DemandeAvance> demandeAttente();

    @Query("SELECT COUNT(dc) FROM DemandeAvance dc WHERE dc.status = 'validee'")
    int nbAvanceValid();

    @Query("SELECT COUNT(d) FROM DemandeAvance d WHERE d.employe = :employe AND d.mois = :mois")
    int countByEmployeAndMois(@Param("employe") Employe employe, @Param("mois") Mois mois);

    List<DemandeAvance> findByEmployeAndMois(Employe employe, Mois mois);

    // Use case-insensitive partial match to tolerate variations like 'Validee',
    // 'validée', etc.
    @Query("SELECT d FROM DemandeAvance d WHERE d.employe = :employe AND d.mois = :mois AND LOWER(d.status) LIKE '%valid%'")
    List<DemandeAvance> findAvanceValideeByEmployeAndMois(@Param("employe") Employe employe, @Param("mois") Mois mois);

    // Match by mois id (id_mois) and year extracted from date_ column
    @Query("SELECT d FROM DemandeAvance d WHERE d.employe = :employe AND d.mois.idMois = :idMois AND FUNCTION('YEAR', d.date) = :annee AND LOWER(d.status) LIKE '%valid%'")
    List<DemandeAvance> findAvanceValideeByEmployeAndMoisIdAndYear(@Param("employe") Employe employe,
            @Param("idMois") Long idMois, @Param("annee") Integer annee);

}