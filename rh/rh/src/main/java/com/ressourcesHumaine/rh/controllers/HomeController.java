package com.ressourcesHumaine.rh.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ressourcesHumaine.rh.services.ContratEmployeService;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.HistoriqueService;
import com.ressourcesHumaine.rh.services.DemandeCongeService;
import com.ressourcesHumaine.rh.services.DemandeAvanceService;
import jakarta.servlet.http.HttpSession;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Historique;
import com.ressourcesHumaine.rh.entities.DemandeConge;
import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;
import org.springframework.ui.Model;
import java.util.Map;

@Controller
public class HomeController {

    @Autowired
    public EmployeService empService;

    @Autowired
    public ContratEmployeService contratService;

    @Autowired
    public DemandeCongeService demandeCongeService;

    @Autowired
    public DemandeAvanceService demandeAvanceService;

    @Autowired
    public HistoriqueService historiqueService;

    @GetMapping("/")
    public String home(Model model, HttpSession session) {

        //liste des employes actuels
        List<Employe> employesActuels = empService.employesActuels();
        model.addAttribute("employesActuels", employesActuels); 

        //en attente
        //liste des demandes de conge
        List<DemandeConge> demandesConge = demandeCongeService.demandeAttente();
        model.addAttribute("demandesConge",demandesConge);

        //liste des demandes avances
        List<DemandeAvance> demandesAvance=demandeAvanceService.demandeAttente();
        model.addAttribute("demandesAvance",demandesAvance);

        //liste des demandes avances
        List<DemandeAvance> demandeAvanceAll=demandeAvanceService.demandeAll();
        //liste des demandes conges
        List<DemandeConge> demandeCongeAll=demandeCongeService.demandeAll();

        //nb demandes totales
        int nbDemandes = demandeAvanceAll.size() + demandeCongeAll.size();
        model.addAttribute("totalDemande", nbDemandes);

        //liste des dernieres historiques
        List<Historique> historiques=historiqueService.recentHistorique();
        model.addAttribute("historiques",historiques);
        
        //age moyen des employes
        int ageMoyen=empService.getAgeMoyen();
        model.addAttribute("ageMoyen",ageMoyen);

        //anciennete moyenne
        double ancienne_moyenne=empService.getAncienneteMoyenne();
        model.addAttribute("ancienneteMoyenne",ancienne_moyenne);
        
        //nb de demandes valides
        int congeValid=demandeCongeService.nbCongeValid();
        int avanceValid=demandeAvanceService.nbAvanceValid();

        int nbDocValid=avanceValid+congeValid;
        model.addAttribute("docValid",nbDocValid);

        int effectifLastMonth = contratService.effectifLastMonth();
        int effectifNow = contratService.effectifNow();
        String variationPourcentage = contratService.getVariationPourcentage();
        String variationClasse = contratService.getVariationClasseCss();

        model.addAttribute("effectifLastMonth", effectifLastMonth);
        model.addAttribute("effectifNow", effectifNow);
        model.addAttribute("variationPourcentage", variationPourcentage);
        model.addAttribute("variationClasse", variationClasse);

        return "Accueil";
    }
}
