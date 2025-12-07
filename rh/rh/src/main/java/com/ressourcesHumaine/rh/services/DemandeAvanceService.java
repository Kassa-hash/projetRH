package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.DemandeAvanceRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Collections;

@Service
public class DemandeAvanceService {

    @Autowired
    private DemandeAvanceRepository demandeAvanceRepository;

    public List<DemandeAvance> demandeAttente() {
        List<DemandeAvance> demandes = demandeAvanceRepository.demandeAttente();
        return demandes;
    }

    public DemandeAvance save(DemandeAvance demandeAvance) {
        return demandeAvanceRepository.save(demandeAvance);
    }

    public List<DemandeAvance> demandeAll() {
        return demandeAvanceRepository.findAll();
    }

    public int nbAvanceValid() {
        return demandeAvanceRepository.nbAvanceValid();
    }

    public boolean hasDejaDemandeAvanceCeMois(Employe employe, Mois mois) {
        return demandeAvanceRepository.countByEmployeAndMois(employe, mois) > 0;
    }

    public boolean isMontantValide(BigDecimal montant, BigDecimal salaireDeBase) {
        BigDecimal limite = salaireDeBase.multiply(new BigDecimal("0.8"));
        return montant.compareTo(limite) <= 0;
    }

    public DemandeAvance findById(int id) {
        return demandeAvanceRepository.findById((long) id)
                .orElse(null);
    }

    public List<DemandeAvance> getAvancesValideesByEmployeAndMoisId(Employe employe, Long idMois, int mois, int annee) {
        // Récupère toutes les avances avec cet id_mois
        List<DemandeAvance> allAvances = demandeAvanceRepository.findByEmployeAndMoisId(employe, idMois);

        // Filtre pour garder seulement celles du bon mois/année
        return allAvances.stream()
                .filter(avance -> avance.getMois() != null)
                .filter(avance -> {
                    // Vérifie si le mois correspond
                    Mois moisEntity = avance.getMois();
                    return moisEntity.getIdMois() == mois;
                })
                .filter(avance -> "validee".equals(avance.getStatus()))
                .collect(Collectors.toList());
    }

    public List<DemandeAvance> getAvancesValideesByEmployeAndMoisIdAndYear(Employe employe, Long idMois,
            Integer annee) {
        return demandeAvanceRepository.findAvanceValideeByEmployeAndMoisIdAndYear(employe, idMois, annee);
    }

    public List<DemandeAvance> getAvancesValideesByEmployeAndMois(Employe employe, Mois mois) {
        if (employe == null || mois == null) {
            return Collections.emptyList();
        }
        return demandeAvanceRepository.findAvanceValideeByEmployeAndMois(employe, mois);
    }
}