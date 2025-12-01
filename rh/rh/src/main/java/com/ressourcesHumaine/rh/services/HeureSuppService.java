package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import com.ressourcesHumaine.rh.repositories.HeureSuppRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List;

@Service
public class HeureSuppService {

    private static final Logger logger = LoggerFactory.getLogger(HeureSuppService.class);

    @Autowired
    private HeureSuppRepository heureSuppRepository;

    public List<HeureSupp> getAllHeuresSupp() {
        return heureSuppRepository.findAll();
    }

    public List<HeureSupp> getHeuresSuppByEmployeAndMonth(Long employeId, int month, int year) {
        logger.info("Recherche heures supp pour employeId={}, month={}, year={}", employeId, month, year);
        List<HeureSupp> heures = heureSuppRepository.findHeuresSuppByEmployeAndMonth(employeId, month, year);
        logger.info("Nombre d'heures trouvées: {}", heures != null ? heures.size() : 0);

        if (heures != null && !heures.isEmpty()) {
            for (HeureSupp h : heures) {
                logger.info("HeureSupp: id={}, date={}, duree={}",
                        h.getIdHeureSupp(), h.getDate(), h.getDuree());
            }
        }

        return heures;
    }

    public BigDecimal getTotalHeuresSuppByEmployeAndMonth(Long employeId, int month, int year) {
        List<HeureSupp> heures = getHeuresSuppByEmployeAndMonth(employeId, month, year);
        BigDecimal total = heures.stream()
                .map(h -> h.getDuree() == null ? BigDecimal.ZERO : h.getDuree())
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        logger.info("Total heures supp pour employeId={}: {}", employeId, total);
        return total;
    }
}