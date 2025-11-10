package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.services.EmployeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employes")
public class EmployeController {

    @Autowired
    private EmployeService employeService;

    // Page principale - Liste des employés
    @GetMapping
    public String listeEmployes(Model model) {
        List<Employe> employes = employeService.getAllEmployes();
        model.addAttribute("employes", employes);
        model.addAttribute("employe", new Employe());
        return "Employe";
    }

    // Formulaire d'ajout
    @GetMapping("/ajouter")
    public String showAddForm(Model model) {
        model.addAttribute("employe", new Employe());
        return "employes/formulaire";
    }

    // Ajouter un employé
    @PostMapping("/ajouter")
    public String ajouterEmploye(@ModelAttribute Employe employe, Model model) {
        try {
            employeService.saveEmploye(employe);
            return "redirect:/employes?success=Employé ajouté avec succès";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("employe", employe);
            return "employes/formulaire";
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
}