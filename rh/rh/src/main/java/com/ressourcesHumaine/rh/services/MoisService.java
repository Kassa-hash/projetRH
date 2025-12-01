package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.MoisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;

@Service
public class MoisService {

    private static final Logger logger = LoggerFactory.getLogger(MoisService.class);

    @Autowired
    private MoisRepository moisRepository;

    /**
     * Récupérer ou créer un mois par son libellé
     * Format attendu: "Janvier 2024", "Février 2024", etc.
     */
    @Transactional
    public Mois getOrCreateMoisByLibelle(String libelle) {
        logger.info("Recherche du mois avec libellé: {}", libelle);

        Optional<Mois> moisOpt = moisRepository.findByLibelle(libelle);

        if (moisOpt.isPresent()) {
            logger.info("Mois trouvé: ID={}", moisOpt.get().getIdMois());
            return moisOpt.get();
        } else {
            // Créer un nouveau mois si inexistant
            Mois nouveauMois = new Mois();
            nouveauMois.setLibelle(libelle);
            Mois savedMois = moisRepository.save(nouveauMois);
            logger.info("Nouveau mois créé: ID={}, Libellé={}", savedMois.getIdMois(), libelle);
            return savedMois;
        }
    }

    /**
     * Construire le libellé du mois à partir du numéro et de l'année
     */
    public String construireLibelleMois(int numeroMois, int annee) {
        String[] nomsMois = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};

        if (numeroMois >= 1 && numeroMois <= 12) {
            return nomsMois[numeroMois - 1] + " " + annee;
        }

        return "Mois inconnu " + annee;
    }

    public Optional<Mois> findById(Long moisId)
    {
        return moisRepository.findById(moisId);
    }

    public List<Mois> MoisAll()
    {
        return  moisRepository.findAll();
    }
}