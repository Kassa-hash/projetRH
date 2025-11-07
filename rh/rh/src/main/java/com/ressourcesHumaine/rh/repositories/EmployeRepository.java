package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Employe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Long> {
}