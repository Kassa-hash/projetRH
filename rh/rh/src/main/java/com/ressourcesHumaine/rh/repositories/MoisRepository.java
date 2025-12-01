package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Mois;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface MoisRepository extends JpaRepository<Mois, Long> {

    // Trouver un mois par son libellé (ex: "Janvier 2024")
    Optional<Mois> findByLibelle(String libelle);
}