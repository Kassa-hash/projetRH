package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.DemandeConge;

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
}