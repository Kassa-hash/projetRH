package com.ressourcesHumaine.rh.controllers;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.ressourcesHumaine.rh.services.ContratEmployeService;
import com.ressourcesHumaine.rh.services.EmployeService;

import jakarta.servlet.http.HttpSession;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.DemandeConge;
import com.ressourcesHumaine.rh.entities.CongeSolde;
import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;

import org.springframework.ui.Model;

import com.ressourcesHumaine.rh.entities.Historique;
import com.ressourcesHumaine.rh.services.DemandeCongeService;
import com.ressourcesHumaine.rh.services.DemandeAvanceService;
import com.ressourcesHumaine.rh.services.HistoriqueService;
import com.ressourcesHumaine.rh.services.CongeSoldeService;
import com.ressourcesHumaine.rh.services.MotifService;

@Controller
@RequestMapping("/demandes")
public class DemandeController {
    
    @Autowired 
    DemandeCongeService demandeCongeService;

    @Autowired
    DemandeAvanceService demandeAvanceService;
    
    @Autowired
    HistoriqueService historiqueService;

    @Autowired
    CongeSoldeService congeSoldeService;

    @Autowired
    MotifService motifService;

    @Autowired 
    EmployeController employeController;

    public static boolean estAuMoins15JoursAvant(LocalDate dateDemande, LocalDate dateDebut) {
        if (dateDemande == null || dateDebut == null) {
            return false;
        }
        long joursEntre = ChronoUnit.DAYS.between(dateDemande, dateDebut);
        return joursEntre >= 15;
    }

    public static int joursEntre(LocalDate date1, LocalDate date2) {
        return (int)ChronoUnit.DAYS.between(date1, date2);
    }

    @GetMapping
    public String goDemande(Model model) {
        List<DemandeConge> demandesConge=demandeCongeService.demandeAll();
        model.addAttribute("demandesConge",demandesConge);

        List<DemandeAvance> demandesAvance=demandeAvanceService.demandeAll();
        model.addAttribute("demandesAvance",demandesAvance);
        return "Demande";
    }

    //refuser une demande de conge
    @GetMapping("/refuserConge")
    public String refuserConge(@RequestParam("id") Integer id,Model model)
    {
        DemandeConge demande=demandeCongeService.findById(id);
        demande.setStatus("refusee");
        demande=demandeCongeService.save(demande);
        String message="Conge refuse";
        model.addAttribute("messageConge",message);
        model.addAttribute("typeConge","succes");

        //creer l'historique qui correspond
        Historique historique=new Historique();
        historique.setDescription("Conge refuse");

        //details
        Employe emp=demande.getEmploye();
        Date debut=demande.getDateDebut();
        Date fin=demande.getDateFin();

        long diffMillis = fin.getTime() - debut.getTime();
        long diffJours = diffMillis / (1000 * 60 * 60 * 24);

        System.out.println("Différence en jours : " + diffJours);

        String details=emp.getNom()+" - " +diffJours+" jours";
        historique.setDetails(details);
        historique.setClasse(demande.getClass());
        historique.setIdEvenement(Math.toIntExact(demande.getIdDemandeConge()));

        //save
        historiqueService.saveHistorique(historique);
        
        return this.goDemande(model);
    }

    //accepter demande de conge
    @GetMapping("/accepterConge")
    public String accepterConge(@RequestParam("id") Integer id,Model model,HttpSession session)
    {
        DemandeConge demande=demandeCongeService.findById(id);
        demande.setStatus("validee");
        demande=demandeCongeService.save(demande);
        String message="Conge accepte";
        model.addAttribute("messageConge",message);
        model.addAttribute("typeConge","succes");

        //creer l'historique qui correspond
        Historique historique=new Historique();
        historique.setDescription("Conge valide");

        //details
        Employe emp=demande.getEmploye();
        Date debut=demande.getDateDebut();
        Date fin=demande.getDateFin();

        long diffMillis = fin.getTime() - debut.getTime();
        long diffJours = diffMillis / (1000 * 60 * 60 * 24);

        System.out.println("Différence en jours : " + diffJours);

        String details=emp.getNom()+" - " +diffJours+" jours";
        historique.setDetails(details);
        historique.setClasse(demande.getClass());
        historique.setIdEvenement(Math.toIntExact(demande.getIdDemandeConge()));

        //save
        historiqueService.saveHistorique(historique);

        //update le solde de conge
        CongeSolde soldeConge=congeSoldeService.getCongeEmpByAnnee(2025,emp.getIdEmploye());
        int newSolde=(int)soldeConge.getNbJour()-(int)diffJours;

        soldeConge.setNbJour(newSolde);
        congeSoldeService.save(soldeConge);

        return this.goDemande(model);
    }

    @PostMapping("/conge")
    public String demanderConge(
        @RequestParam("dateDebut") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date debut,
        @RequestParam("dateFin") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date fin,
        @RequestParam("dateDemande") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date dateDemande,
        @RequestParam("motifId") int motifId,
        HttpSession session, Model model) {
    {
        Employe emp=(Employe) session.getAttribute("utilisateur");
        LocalDate localDemande = dateDemande.toInstant()
                                 .atZone(ZoneId.systemDefault())
                                 .toLocalDate();

        LocalDate localDebut = debut.toInstant()
                                 .atZone(ZoneId.systemDefault())
                                 .toLocalDate();
        
        LocalDate localFin = fin.toInstant()
                                 .atZone(ZoneId.systemDefault())
                                 .toLocalDate();

        boolean isUp15=this.estAuMoins15JoursAvant(localDemande,localDebut);
        int daysBetween=this.joursEntre(localDebut,localFin)+1;
        CongeSolde soldeConge=congeSoldeService.getCongeEmpByAnnee(2025,emp.getIdEmploye());

        String message="";

        if(isUp15 == true && soldeConge.getNbJour()>=daysBetween){
            DemandeConge demande = new DemandeConge();
            demande.setEmploye(emp);
            demande.setDateDebut(debut);
            demande.setDateFin(fin);
            demande.setDateDemande(dateDemande);
            demande.setMotif(motifService.findById(motifId)); 
            demande.setStatus("en attente");

            demandeCongeService.save(demande);
            message="Votre demande a ete enregistree , en attente d'une reponse";
        }
        else
        {
            if(isUp15 == false){
                message+=" Demande a effectuer 15j au minimum a l'avance";
            }
            if(soldeConge.getNbJour()<daysBetween)
            {
                message+=" Solde de conge insuffisant";
            }
        }

        model.addAttribute("message",message);
        return employeController.login(emp.getNom(),emp.getMdp(),model,session);
    }
}
}