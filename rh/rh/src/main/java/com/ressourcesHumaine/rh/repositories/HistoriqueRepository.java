package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Historique;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HistoriqueRepository extends JpaRepository<Historique, Long> {
    @Query("select h from Historique h order by idHistorique desc limit 5")
    List<Historique> recentHistorique();
}