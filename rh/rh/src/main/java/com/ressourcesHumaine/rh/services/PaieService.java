package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Paie;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.PaieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.Optional;

@Service
public class PaieService {

    private static final Logger logger = LoggerFactory.getLogger(PaieService.class);

    @Autowired
    private PaieRepository paieRepository;

    /**
     * Enregistrer une nouvelle paie ou mettre à jour une existante
     */
    @Transactional
    public Paie savePaie(Paie paie) {
        logger.info("Enregistrement de la paie pour l'employé ID: {}",
                paie.getEmploye() != null ? paie.getEmploye().getIdEmploye() : "null");

        return paieRepository.save(paie);
    }

    /**
     * Créer ou mettre à jour une paie complète
     */
    @Transactional
    public Paie createOrUpdatePaie(
            Employe employe,
            Mois mois,
            BigDecimal salaireBase,
            BigDecimal salaireBrute,
            BigDecimal cnaps,
            BigDecimal ostie,
            BigDecimal revenuImposable,
            BigDecimal impotDu,
            BigDecimal netDuMois) {

        logger.info("Création/Mise à jour paie - Employé: {}, Mois: {}",
                employe.getIdEmploye(), mois.getLibelle());

        // Chercher si une paie existe déjà
        Optional<Paie> paieExistante = paieRepository.findByEmployeAndMois(employe, mois);

        Paie paie;
        if (paieExistante.isPresent()) {
            logger.info("Paie existante trouvée - ID: {}, mise à jour...",
                    paieExistante.get().getIdPaie());
            paie = paieExistante.get();
        } else {
            logger.info("Nouvelle paie à créer");
            paie = new Paie();
            paie.setEmploye(employe);
            paie.setMois(mois);
        }

        // Mettre à jour tous les champs
        paie.setSalaireBase(salaireBase);
        paie.setSalaireBrute(salaireBrute);
        paie.setCnaps(cnaps);
        paie.setOstie(ostie);
        paie.setRevenuImposable(revenuImposable);
        paie.setImpotDu(impotDu);
        paie.setNetDuMois(netDuMois);

        Paie saved = paieRepository.save(paie);
        logger.info("Paie enregistrée avec succès - ID: {}", saved.getIdPaie());

        return saved;
    }

    /**
     * Vérifier si une paie existe déjà
     */
    public boolean paieExists(Employe employe, Mois mois) {
        return paieRepository.existsByEmployeAndMois(employe, mois);
    }

    /**
     * Récupérer une paie existante
     */
    public Optional<Paie> findByEmployeAndMois(Employe employe, Mois mois) {
        return paieRepository.findByEmployeAndMois(employe, mois);
    }
}