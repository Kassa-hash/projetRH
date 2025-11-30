package com.ressourcesHumaine.rh.controllers;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

import com.ressourcesHumaine.rh.entities.*;
import com.ressourcesHumaine.rh.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;

import org.springframework.ui.Model;

@Controller
@RequestMapping("/demandes")
public class DemandeController {
    
    @Autowired 
    DemandeCongeService demandeCongeService;

    @Autowired
   MoisService moisService;

    @Autowired
    DemandeAvanceService demandeAvanceService;
    
    @Autowired
    HistoriqueService historiqueService;

    @Autowired
    CongeSoldeService congeSoldeService;

    @Autowired
    EmployeService employeService;


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

    @PostMapping("/avance")
    public String demanderAvance(
            @RequestParam("montant") BigDecimal montant,
            @RequestParam("moisId") Long moisId,
            HttpSession session,
            Model model) {
        Employe empSession = (Employe) session.getAttribute("utilisateur");
        Employe emp = employeService.findByIdWithContrat(empSession.getIdEmploye());
        String message = "";

        try {
            System.out.println("=== DEBUT DEMANDE AVANCE ===");
            System.out.println("Employé: " + emp.getNom());
            System.out.println("Montant: " + montant);
            System.out.println("Mois ID: " + moisId);

            // Vérifications de base
            if (emp == null) {
                throw new DemandeAvanceException("Employé non connecté");
            }

            if (montant == null || montant.compareTo(BigDecimal.ZERO) <= 0) {
                throw new DemandeAvanceException("Montant invalide");
            }

            Mois mois = moisService.findById(moisId);
            System.out.println("Mois trouvé: " + (mois != null ? mois.getLibelle() : "null"));

            if (mois == null) {
                throw new DemandeAvanceException("Mois invalide");
            }

            // Vérifier le contrat et le poste
            if (emp.getContratEmploye() == null) {
                throw new DemandeAvanceException("Aucun contrat trouvé pour cet employé");
            }

            if (emp.getContratEmploye().getPoste() == null) {
                throw new DemandeAvanceException("Aucun poste défini pour cet employé");
            }

            BigDecimal salaireDeBase = emp.getContratEmploye().getPoste().getSalaireDeBase();
            System.out.println("Salaire de base: " + salaireDeBase);

            if (salaireDeBase == null) {
                throw new DemandeAvanceException("Salaire de base non défini");
            }

            // Vérifier si une avance existe déjà pour ce mois
            boolean dejaDemande = demandeAvanceService.hasDejaDemandeAvanceCeMois(emp, mois);
            System.out.println("Déjà une demande ce mois: " + dejaDemande);

            if (dejaDemande) {
                throw new DemandeAvanceException("Vous avez déjà une demande d'avance pour ce mois");
            }

            // Vérifier le montant (80% du salaire)
            BigDecimal limite = salaireDeBase.multiply(new BigDecimal("0.8"));
            System.out.println("Limite autorisée: " + limite);

            if (montant.compareTo(limite) > 0) {
                throw new DemandeAvanceException(
                        String.format("Le montant demandé (%,.0f Ar) dépasse la limite autorisée (%,.0f Ar)",
                                montant, limite)
                );
            }

            // Créer la demande
            DemandeAvance demande = new DemandeAvance();
            demande.setEmploye(emp);
            demande.setMontant(montant);
            demande.setMois(mois);
            demande.setDate(new Date());
            demande.setStatus("en attente");

            DemandeAvance savedDemande = demandeAvanceService.save(demande);
            System.out.println("Demande sauvegardée avec ID: " + savedDemande.getIdDemandeAvance());

            message = "Votre demande d'avance a été enregistrée avec succès";
            model.addAttribute("message", message);

        } catch (DemandeAvanceException e) {
            System.out.println("Erreur métier: " + e.getMessage());
            message = "Erreur : " + e.getMessage();
            model.addAttribute("message", message);
        } catch (Exception e) {
            System.out.println("Erreur technique: " + e.getMessage());
            e.printStackTrace();
            message = "Une erreur technique est survenue: " + e.getMessage();
            model.addAttribute("message", message);
        }

        return employeController.login(emp.getNom(), emp.getMdp(), model, session);
    }


    @GetMapping("/approuverAvance")
    public String approuverAvance(@RequestParam("id") Integer id,Model model,HttpSession session)
    {
        DemandeAvance demande=demandeAvanceService.findById(id);
        demande.setStatus("validee");
        demande=demandeAvanceService.save(demande);
        String message="Conge accepte";
        model.addAttribute("messageConge",message);
        model.addAttribute("typeConge","succes");

        //creer l'historique qui correspond
        Historique historique=new Historique();
        historique.setDescription("Avance valide");

        //details
        Employe emp=demande.getEmploye();

        return this.goDemande(model);
    }

}