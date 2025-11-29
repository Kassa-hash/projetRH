package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Presence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface PresenceRepository extends JpaRepository<Presence, Long> {
    List<Presence> findByDatePresence(Date datePresence);

    @Query("SELECT p FROM Presence p WHERE p.employe.idEmploye = :employeId")
    List<Presence> findByEmployeId(@Param("employeId") Long employeId);

    @Query("SELECT p FROM Presence p WHERE p.employe.idEmploye = :employeId AND p.datePresence = :date")
    Optional<Presence> findByEmployeIdAndDate(@Param("employeId") Long employeId, @Param("date") Date date);

    @Query("SELECT COUNT(DISTINCT p.employe.idEmploye) FROM Presence p WHERE p.datePresence = CURRENT_DATE()")
    int countDistinctEmployesPresentToday();
}
