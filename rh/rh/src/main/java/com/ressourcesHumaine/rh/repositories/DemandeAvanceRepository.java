package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.Employe;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DemandeAvanceRepository extends JpaRepository<DemandeAvance, Long> {

}
