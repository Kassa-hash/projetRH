package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Pointage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface PointageRepository extends JpaRepository<Pointage, Long> {
    List<Pointage> findByDatePointage(Date datePointage);

    @Query("SELECT p FROM Pointage p WHERE p.employe.idEmploye = :employeId")
    List<Pointage> findByEmployeId(@Param("employeId") Long employeId);

    @Query("SELECT p FROM Pointage p WHERE p.employe.idEmploye = :employeId AND p.datePointage = :date")
    java.util.Optional<Pointage> findByEmployeIdAndDate(@Param("employeId") Long employeId, @Param("date") Date date);
}
