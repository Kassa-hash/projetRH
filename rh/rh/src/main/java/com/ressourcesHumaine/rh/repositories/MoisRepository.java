package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Mois;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MoisRepository extends JpaRepository<Mois, Long> {
}