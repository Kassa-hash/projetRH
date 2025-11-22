package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.DemandeConge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DemandeCongeRepository extends JpaRepository<DemandeConge, Long> {

@Query("SELECT dc FROM DemandeConge dc WHERE dc.status = 'en attente'")
List<DemandeConge> demandeAttente();

@Query("SELECT COUNT(dc) FROM DemandeConge dc WHERE dc.status = 'validee'")
int nbCongeValid();

@Query("select dc from DemandeConge dc where dc.status='validee' and dc.employe.idEmploye= :idemp")
List<DemandeConge> demandesValidByEmp(@Param("idemp") Long idEmp);

@Query("select dc from DemandeConge dc where dc.employe.idEmploye= :idemp")
List<DemandeConge> demandesByEmp(@Param("idemp") Long idEmp);

}