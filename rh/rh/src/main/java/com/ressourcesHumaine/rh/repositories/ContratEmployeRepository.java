package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.ContratEmploye;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContratEmployeRepository extends JpaRepository<ContratEmploye, Long> {

    //avoir les contrats en cours
    @Query("select c from ContratEmploye c where c.dateDebut <= NOW() and c.dateFin is null")
    List<ContratEmploye> contratsActuels();

    // Récupère tous les contrats avec date de début et éventuellement date de fin
    @Query("SELECT c FROM ContratEmploye c WHERE c.dateDebut IS NOT NULL")
    List<ContratEmploye> findAllWithDates();

    // Optionnel : pour optimiser
    @Query("SELECT c.dateDebut, c.dateFin, c.employe.id FROM ContratEmploye c")
    List<Object[]> findAllStartAndEndDates();

    // Effectif actuel (aujourd'hui)
    @Query(value = """
        SELECT COUNT(DISTINCT ce.id_employe)
        FROM contrat_employe ce
        WHERE ce.date_ <= CURRENT_DATE
          AND (ce.Date_Fin IS NULL OR ce.Date_Fin >= CURRENT_DATE)
        """, nativeQuery = true)
    int getEffectifActuel();

    // Effectif du mois dernier (octobre si on est en novembre)
    @Query(value = """
        SELECT COUNT(DISTINCT ce.id_employe)
        FROM contrat_employe ce
        WHERE ce.date_ <= LAST_DAY(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
          AND (ce.Date_Fin IS NULL 
               OR ce.Date_Fin >= LAST_DAY(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)))
        """, nativeQuery = true)
    int getEffectifMoisDernier();
}
