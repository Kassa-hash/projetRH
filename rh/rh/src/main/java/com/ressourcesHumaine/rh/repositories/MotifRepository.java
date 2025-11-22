package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Motif;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MotifRepository extends JpaRepository<Motif, Long> {
}