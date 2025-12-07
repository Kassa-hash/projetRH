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


    @Query("SELECT d FROM DemandeAvance d WHERE d.employe = :employe AND d.mois = :mois AND d.status = 'validee'")
    List<DemandeAvance> findAvanceValideeByEmployeAndMois(@Param("employe") Employe employe, @Param("mois") Mois mois);

    @Query("SELECT d FROM DemandeAvance d WHERE d.employe = :employe AND d.mois.idMois = :idMois")
    List<DemandeAvance> findByEmployeAndMoisId(@Param("employe") Employe employe, @Param("idMois") Long idMois);

    @Query("SELECT d FROM DemandeAvance d WHERE d.employe = :employe " +
            "AND d.mois.idMois = :idMois AND d.status = 'validee'")
    List<DemandeAvance> findAvanceValideeByEmployeAndMoisId(
            @Param("employe") Employe employe,
            @Param("idMois") Long idMois);


}