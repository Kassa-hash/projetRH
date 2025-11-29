package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.*;
import com.ressourcesHumaine.rh.services.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/employes")
public class EmployeController {

    @Autowired
    private EmployeService employeService;

    @Autowired
    private DemandeCongeService demandeCongeService;

    @Autowired
    private MotifService motifService;

    @Autowired
    private MoisService moisService;

    @Autowired
    private CongeSoldeService congeSoldeService;

    @Autowired
    private GenreService genreService;

    // Page principale - Liste des employés
    @GetMapping
    public String listeEmployes(Model model) {
        List<Employe> employes = employeService.employesActuels();
        model.addAttribute("employes", employes);
        model.addAttribute("employe", new Employe());
        return "Employe";
    }

    @GetMapping("/api")
    @ResponseBody
    public List<Employe> getEmployesApi() {
        return employeService.getAllEmployes();
    }


    // JSON - récupérer tous les employés (pour usage AJAX)
    @GetMapping("/all")
    @ResponseBody
    public List<Employe> listeEmployesJson() {
        return employeService.getAllEmployes();
    }

    // Formulaire d'ajout
    @GetMapping("/ajouter")
    public String showAddForm(Model model) {
        model.addAttribute("employe", new Employe());
        model.addAttribute("genres", genreService.getAllGenres());
        return "FormulaireEmploye";
    }


    // Ajouter un employé
    @PostMapping("/ajouter")
    public String ajouterEmploye(@RequestParam String nom,
                                 @RequestParam String dateDeNaissance,
                                 @RequestParam String contact,
                                 @RequestParam String email,
                                 @RequestParam String adresse,
                                 @RequestParam Long idGenre,
                                 @RequestParam(required = false) String mdp,
                                 @RequestParam(required = false) MultipartFile photo,
                                 Model model) {
        try {
            Employe employe = new Employe();
            employe.setNom(nom);
            employe.setContact(contact);
            employe.setEmail(email);
            employe.setAdresse(adresse);


            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date dateNaissance = sdf.parse(dateDeNaissance);
                employe.setDateDeNaissance(dateNaissance);
            } catch (ParseException e) {
                model.addAttribute("error", "Format de date invalide");
                return showAddForm(model);
            }



            // Gérer le mot de passe
            if (mdp != null && !mdp.trim().isEmpty()) {
                employe.setMdp(mdp);
            }

            // Créer les objets Genre
            Genre genre = new Genre();
            genre.setIdGenre(idGenre);
            employe.setGenre(genre);


            employeService.saveEmploye(employe);
            return "redirect:/employes?success=Employé ajouté avec succès";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return showAddForm(model);
        }
    }

    // Formulaire de modification
    @GetMapping("/modifier/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Employe employe = employeService.getEmployeById(id)
                    .orElseThrow(() -> new RuntimeException("Employé non trouvé"));
            model.addAttribute("employe", employe);
            return "employes/formulaire";
        } catch (RuntimeException e) {
            return "redirect:/employes?error=" + e.getMessage();
        }
    }

    // Modifier un employé
    @PostMapping("/modifier/{id}")
    public String modifierEmploye(@PathVariable Long id, @ModelAttribute Employe employe, Model model) {
        try {
            employeService.updateEmploye(id, employe);
            return "redirect:/employes?success=Employé modifié avec succès";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("employe", employe);
            return "employes/formulaire";
        }
    }

    // Supprimer un employé
    @GetMapping("/supprimer/{id}")
    public String supprimerEmploye(@PathVariable Long id) {
        try {
            employeService.deleteEmploye(id);
            return "redirect:/employes?success=Employé supprimé avec succès";
        } catch (RuntimeException e) {
            return "redirect:/employes?error=" + e.getMessage();
        }
    }

    // aller au login
    @GetMapping("/goLogin")
    public String goLogin() {
        return "Utilisateur";
    }

    // aller a l'utilisateur accueil
    @GetMapping("/goAccueil")
    public String goAccueilUtilisateur() {
        return "UtilisateurAccueil";
    }

    // login
    @PostMapping("/login")
    public String login(@RequestParam String nom,
            @RequestParam String mdp,
            Model model,
            HttpSession session) {

        try {
            Employe emp = employeService.login(nom, mdp);

            if (emp == null) {
                model.addAttribute("error", "Nom ou mot de passe incorrect");
                return "Utilisateur";
            }

            //liste des demandes validees
            List<DemandeConge> demandesValid=demandeCongeService.demandesValidByEmp(emp.getIdEmploye());
            //liste des demandes de l'employe
            List<DemandeConge> demandesByEmp=demandeCongeService.demandesByEmp(emp.getIdEmploye());
            //liste des motifs 
            List<Motif> motifs=motifService.motifsAll();
            //liste des mois
            List<Mois> mois=moisService.MoisAll();
            //nb de jours de conge total
            int nbJoursConge=congeSoldeService.getSoldeByEmp(emp.getIdEmploye());
            model.addAttribute("demandesConge",demandesByEmp);
            session.setAttribute("motifs",motifs);
            session.setAttribute("congesValides",demandesValid);
            session.setAttribute("utilisateur", emp);
            session.setAttribute("mois",mois);
            session.setAttribute("soldeConge",nbJoursConge);
            return "UtilisateurAccueil";

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "Utilisateur";
        }
    }

}
