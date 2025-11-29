package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HeureSuppRepository extends JpaRepository<HeureSupp, Long> {
}
