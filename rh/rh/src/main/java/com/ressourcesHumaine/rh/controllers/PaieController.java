package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.entities.Paie;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.HeureSuppService;
import com.ressourcesHumaine.rh.services.MoisService;
import com.ressourcesHumaine.rh.services.PaieService;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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

    @Autowired
    private PaieService paieService;

    @Autowired
    private MoisService moisService;

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


    @GetMapping("/details")
    public String showPaieDetails(
            @RequestParam Long employeId,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer year,
            Model model) {

        logger.info("=== DEBUT showPaieDetails ===");
        logger.info("Employé ID: {}, Mois: {}, Année: {}", employeId, month, year);

        try {
            // Utiliser le mois/année fourni ou le mois courant
            int mois = (month != null) ? month : Calendar.getInstance().get(Calendar.MONTH) + 1;
            int annee = (year != null) ? year : Calendar.getInstance().get(Calendar.YEAR);

            // Récupérer l'employé
            Employe employe = employeService.findByIdWithContrat(employeId);
            if (employe == null) {
                model.addAttribute("errorMessage", "Employé non trouvé");
                return "erreur";
            }

            // Récupérer les informations nécessaires
            String nomEmploye = (employe.getNom() != null && !employe.getNom().trim().isEmpty())
                    ? employe.getNom()
                    : "Employé " + employe.getIdEmploye();

            String dateEmbauche = "N/A";
            String poste = "N/A";
            String departement = "N/A";
            BigDecimal salaireBase = BigDecimal.ZERO;

            if (employe.getContratEmploye() != null) {
                if (employe.getContratEmploye().getDate() != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    dateEmbauche = sdf.format(employe.getContratEmploye().getDate());
                }

                if (employe.getContratEmploye().getPoste() != null) {
                    poste = employe.getContratEmploye().getPoste().getLibelle();
                    if (employe.getContratEmploye().getPoste().getSalaireDeBase() != null) {
                        salaireBase = employe.getContratEmploye().getPoste().getSalaireDeBase();
                    }
                }
            }

            if (employe.getDepartement() != null && employe.getDepartement().getNom() != null) {
                departement = employe.getDepartement().getNom();
            }

            // Calculer les heures supplémentaires
            BigDecimal heuresSuppDecimal = heureSuppService.getTotalHeuresSuppByEmployeAndMonth(
                    employeId, mois, annee);
            int heuresSupp = heuresSuppDecimal != null ? heuresSuppDecimal.intValue() : 0;

            // CALCULS DE PAIE
            BigDecimal heuresParMois = new BigDecimal("173.33");
            BigDecimal tauxMajoration = new BigDecimal("1.5");
            BigDecimal tauxHoraireNormal = salaireBase.divide(heuresParMois, 2, RoundingMode.HALF_UP);
            BigDecimal tauxHoraireSupp = tauxHoraireNormal.multiply(tauxMajoration);
            BigDecimal majorationHeuresSupp = tauxHoraireSupp.multiply(heuresSuppDecimal != null ? heuresSuppDecimal : BigDecimal.ZERO);
            BigDecimal salaireBrut = salaireBase.add(majorationHeuresSupp);

            BigDecimal cnaps1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
            BigDecimal cnaps8 = salaireBrut.multiply(new BigDecimal("0.08")).setScale(0, RoundingMode.HALF_UP);
            BigDecimal ostie1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
            BigDecimal ostie5 = salaireBrut.multiply(new BigDecimal("0.05")).setScale(0, RoundingMode.HALF_UP);
            BigDecimal revenuImposable = salaireBrut.subtract(cnaps1).subtract(ostie1);

            // Calcul IRSA
            BigDecimal irsa = BigDecimal.ZERO;
            BigDecimal seuil1 = new BigDecimal("350000");
            BigDecimal seuil2 = new BigDecimal("650000");
            BigDecimal seuil3 = new BigDecimal("1000000");
            BigDecimal seuil4 = new BigDecimal("1500000");

            if (revenuImposable.compareTo(seuil1) > 0) {
                BigDecimal tranche1 = revenuImposable.subtract(seuil1);
                if (tranche1.compareTo(new BigDecimal("300000")) > 0) {
                    tranche1 = new BigDecimal("300000");
                }
                irsa = irsa.add(tranche1.multiply(new BigDecimal("0.05")));
            }

            if (revenuImposable.compareTo(seuil2) > 0) {
                BigDecimal tranche2 = revenuImposable.subtract(seuil2);
                if (tranche2.compareTo(new BigDecimal("350000")) > 0) {
                    tranche2 = new BigDecimal("350000");
                }
                irsa = irsa.add(tranche2.multiply(new BigDecimal("0.10")));
            }

            if (revenuImposable.compareTo(seuil3) > 0) {
                BigDecimal tranche3 = revenuImposable.subtract(seuil3);
                if (tranche3.compareTo(new BigDecimal("500000")) > 0) {
                    tranche3 = new BigDecimal("500000");
                }
                irsa = irsa.add(tranche3.multiply(new BigDecimal("0.15")));
            }

            if (revenuImposable.compareTo(seuil4) > 0) {
                BigDecimal tranche4 = revenuImposable.subtract(seuil4);
                irsa = irsa.add(tranche4.multiply(new BigDecimal("0.20")));
            }

            irsa = irsa.setScale(0, RoundingMode.HALF_UP);

            BigDecimal salaireNet = salaireBrut.subtract(cnaps1).subtract(ostie1).subtract(irsa);

            BigDecimal avance = BigDecimal.ZERO;
            if (salaireNet.compareTo(new BigDecimal("200000")) > 0) {
                avance = new BigDecimal("50000");
            }

            BigDecimal netAPayer = salaireNet.subtract(avance);

            // Ajouter les attributs au modèle
            model.addAttribute("employe", employe);
            model.addAttribute("nomEmploye", nomEmploye);
            model.addAttribute("dateEmbauche", dateEmbauche);
            model.addAttribute("poste", poste);
            model.addAttribute("departement", departement);
            model.addAttribute("salaireBase", salaireBase);
            model.addAttribute("heuresSupp", heuresSupp);
            model.addAttribute("salaireBrut", salaireBrut);
            model.addAttribute("majorationHeuresSupp", majorationHeuresSupp);
            model.addAttribute("cnaps1", cnaps1);
            model.addAttribute("cnaps8", cnaps8);
            model.addAttribute("ostie1", ostie1);
            model.addAttribute("ostie5", ostie5);
            model.addAttribute("revenuImposable", revenuImposable);
            model.addAttribute("irsa", irsa);
            model.addAttribute("salaireNet", salaireNet);
            model.addAttribute("avance", avance);
            model.addAttribute("netAPayer", netAPayer);
            model.addAttribute("tauxHoraireNormal", tauxHoraireNormal);
            model.addAttribute("tauxHoraireSupp", tauxHoraireSupp);
            model.addAttribute("mois", mois);
            model.addAttribute("annee", annee);
            model.addAttribute("moisNom", getNomMois(mois));

            logger.info("=== FIN showPaieDetails ===");
            return "DetailsPaie";

        } catch (Exception e) {
            logger.error("ERREUR dans showPaieDetails: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "Erreur lors du chargement des détails: " + e.getMessage());
            return "erreur";
        }
    }


    /**
     * NOUVELLE METHODE: Valider et enregistrer une paie
     */
    @PostMapping("/valider")
    public String validerPaie(
            @RequestParam Long employeId,
            @RequestParam Integer mois,
            @RequestParam Integer annee,
            @RequestParam BigDecimal salaireBase,
            @RequestParam BigDecimal salaireBrut,
            @RequestParam BigDecimal cnaps1,
            @RequestParam BigDecimal ostie1,
            @RequestParam BigDecimal revenuImposable,
            @RequestParam BigDecimal irsa,
            @RequestParam BigDecimal netAPayer,
            RedirectAttributes redirectAttributes) {

        logger.info("=== DEBUT validerPaie ===");
        logger.info("Validation paie - Employé: {}, Mois: {}/{}", employeId, mois, annee);

        try {
            // Récupérer l'employé
            Employe employe = employeService.findByIdWithContrat(employeId);
            if (employe == null) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Employé non trouvé (ID: " + employeId + ")");
                return "redirect:/paies?month=" + mois + "&year=" + annee;
            }

            // Créer ou récupérer le mois
            String libelleMois = moisService.construireLibelleMois(mois, annee);
            Mois moisEntity = moisService.getOrCreateMoisByLibelle(libelleMois);

            logger.info("Mois entity: ID={}, Libellé={}", moisEntity.getIdMois(), moisEntity.getLibelle());

            // Créer ou mettre à jour la paie
            Paie paie = paieService.createOrUpdatePaie(
                    employe,
                    moisEntity,
                    salaireBase,
                    salaireBrut,
                    cnaps1,        // Stockage cnaps1 (part employé)
                    ostie1,        // Stockage ostie1 (part employé)
                    revenuImposable,
                    irsa,
                    netAPayer
            );

            logger.info("Paie validée avec succès - ID: {}", paie.getIdPaie());

            redirectAttributes.addFlashAttribute("successMessage",
                    "Paie validée avec succès pour " + employe.getNom() + " (" + libelleMois + ")");

            return "redirect:/paies?month=" + mois + "&year=" + annee;

        } catch (Exception e) {
            logger.error("ERREUR lors de la validation de la paie: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Erreur lors de la validation: " + e.getMessage());
            return "redirect:/paies?month=" + mois + "&year=" + annee;
        }
    }

    private String getNomMois(int mois) {
        String[] nomsMois = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
        return mois >= 1 && mois <= 12 ? nomsMois[mois - 1] : "Mois inconnu";
    }
}