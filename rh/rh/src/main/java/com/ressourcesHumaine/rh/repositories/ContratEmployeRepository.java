package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.ContratEmploye;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContratEmployeRepository extends JpaRepository<ContratEmploye, Long> {

  // Contrats considérés comme "actuels" (dateDebut passée et pas de dateFin ou
  // dateFin après aujourd'hui)
  @Query("SELECT c FROM ContratEmploye c WHERE c.dateDebut <= CURRENT_DATE AND (c.dateFin IS NULL OR c.dateFin >= CURRENT_DATE)")
  List<ContratEmploye> contratsActuels();

  // Récupère tous les contrats avec une date de début renseignée
  @Query("SELECT c FROM ContratEmploye c WHERE c.dateDebut IS NOT NULL")
  List<ContratEmploye> findAllWithDates();

  // Effectif actuel (aujourd'hui)
  @Query(value = """
      SELECT COUNT(DISTINCT ce.id_employe)
      FROM contrat_employe ce
      WHERE ce.date_ <= CURRENT_DATE
        AND (ce.Date_Fin IS NULL OR ce.Date_Fin >= CURRENT_DATE)
      """, nativeQuery = true)
  int getEffectifActuel();

  // Effectif du mois dernier
  @Query(value = """
      SELECT COUNT(DISTINCT ce.id_employe)
      FROM contrat_employe ce
      WHERE ce.date_ <= LAST_DAY(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
        AND (ce.Date_Fin IS NULL
             OR ce.Date_Fin >= LAST_DAY(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)))
      """, nativeQuery = true)
  int getEffectifMoisDernier();

}
