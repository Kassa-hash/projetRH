package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.TypeContrat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeContratRepository extends JpaRepository<TypeContrat, Long> {

}
