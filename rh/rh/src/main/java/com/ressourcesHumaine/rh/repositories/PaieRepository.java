package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Paie;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface PaieRepository extends JpaRepository<Paie, Long> {

    // Vérifier si une paie existe déjà pour un employé et un mois donné
    Optional<Paie> findByEmployeAndMois(Employe employe, Mois mois);

    // Vérifier l'existence
    boolean existsByEmployeAndMois(Employe employe, Mois mois);
}