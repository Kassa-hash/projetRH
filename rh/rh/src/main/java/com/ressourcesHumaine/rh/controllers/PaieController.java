package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.HeureSuppService;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller
@RequestMapping("/paies")
public class PaieController {

    private static final Logger logger = LoggerFactory.getLogger(PaieController.class);

    @Autowired
    private EmployeService employeService;

    @Autowired
    private HeureSuppService heureSuppService;

    @GetMapping
    public String showPaie(
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer year,
            Model model) {

        logger.info("=== DEBUT showPaie ===");

        try {
            // Utiliser le mois/année fourni ou le mois courant
            int mois = (month != null) ? month : Calendar.getInstance().get(Calendar.MONTH) + 1;
            int annee = (year != null) ? year : Calendar.getInstance().get(Calendar.YEAR);

            logger.info("Mois sélectionné: {}, Année: {}", mois, annee);

            // Récupérer tous les employés actuels
            List<Employe> employes = employeService.employesActuels();
            logger.info("Nombre d'employés récupérés: {}", employes != null ? employes.size() : 0);

            // Filtrer les employés valides
            if (employes != null) {
                employes = employes.stream()
                        .filter(employe -> employe.getIdEmploye() != null && employe.getIdEmploye() > 0)
                        .toList();
                logger.info("Nombre d'employés après filtrage: {}", employes.size());
            }

            model.addAttribute("employes", employes);
            model.addAttribute("moisActuel", mois);
            model.addAttribute("anneeActuelle", annee);

            // Calculer les heures supplémentaires pour chaque employé
            Map<Long, BigDecimal> heuresSuppTotals = new HashMap<>();

            if (employes != null && !employes.isEmpty()) {
                logger.info("=== Calcul des heures supp pour {} employés ===", employes.size());

                for (Employe e : employes) {
                    if (e != null && e.getIdEmploye() != null) {
                        logger.info("Traitement employé ID: {} - Nom: {}",
                                e.getIdEmploye(), e.getNom());

                        try {
                            BigDecimal total = heureSuppService.getTotalHeuresSuppByEmployeAndMonth(
                                    e.getIdEmploye(), mois, annee);

                            heuresSuppTotals.put(e.getIdEmploye(), total != null ? total : BigDecimal.ZERO);

                            logger.info("  -> Total heures supp pour employé {}: {}",
                                    e.getIdEmploye(), total);

                        } catch (Exception ex) {
                            logger.error("ERREUR pour employé {}: {}", e.getIdEmploye(), ex.getMessage(), ex);
                            heuresSuppTotals.put(e.getIdEmploye(), BigDecimal.ZERO);
                        }
                    }
                }

                logger.info("=== MAP finale heuresSuppTotals: {} ===", heuresSuppTotals);
            }

            model.addAttribute("heuresSuppTotals", heuresSuppTotals);

            logger.info("=== FIN showPaie - Redirection vers Paie.jsp ===");
            return "Paie";

        } catch (Exception e) {
            logger.error("ERREUR GLOBALE dans showPaie: {}", e.getMessage(), e);
            model.addAttribute("employes", java.util.Collections.emptyList());
            model.addAttribute("heuresSuppTotals", new HashMap<>());
            model.addAttribute("errorMessage", "Erreur lors du chargement des données: " + e.getMessage());
            return "Paie";
        }
    }
}