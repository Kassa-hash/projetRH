package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.MoisRepository;
import com.ressourcesHumaine.rh.services.DemandeAvanceService;
import com.ressourcesHumaine.rh.services.EmployeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/avance")
public class DemandeAvanceController {

    @Autowired
    private DemandeAvanceService demandeAvanceService;

    @Autowired
    private EmployeService employeService;

    @Autowired
    private MoisRepository moisRepository;

    @GetMapping
    public String showDemandeAvance(Model model) {
        List<Employe> employes = employeService.getAllEmployes();
        model.addAttribute("employes", employes);
        return "Demande";
    }

    @PostMapping("/demanderAvance")
    public String DemanderAvance(
            @RequestParam("idEmploye") Long idEmploye,
            @RequestParam("dateAvance") String dateAvance,
            @RequestParam("moisId") Long moisId,
            @RequestParam("montant") BigDecimal montant,
            Model model
    ) {
        try {
            DemandeAvance da = new DemandeAvance();

            // Récupération de l'employé
            Employe employe = employeService.getEmployeById(idEmploye)
                    .orElseThrow(() -> new IllegalArgumentException("Employé non trouvé avec l'ID: " + idEmploye));
            da.setEmploye(employe);

            // Récupération du mois depuis le repository
            Mois mois = moisRepository.findById(moisId)
                    .orElseThrow(() -> new IllegalArgumentException("Mois non trouvé avec l'ID: " + moisId));
            da.setMois(mois);

            // Conversion de la date
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = formatter.parse(dateAvance);
            da.setDate(date);

            da.setMontant(montant);

            demandeAvanceService.demanderAvance(da);
           // model.addAttribute("message", "Demande envoyée avec succès !");

        } catch (ParseException e) {
            model.addAttribute("error", "Format de date invalide !");
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }

        return "Demande";
    }
}
