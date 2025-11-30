package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.services.EmployeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/paies")
public class PaieController {

    @Autowired
    private EmployeService employeService;

    @GetMapping
    public String showPaie(Model model) {
        try {
            List<Employe> employes = employeService.employesActuels();
            // Filtrer les employés pour éviter ceux avec des relations problématiques
            if (employes != null) {
                employes = employes.stream()
                        .filter(employe -> employe.getIdEmploye() != null && employe.getIdEmploye() > 0)
                        .toList();
            }
            model.addAttribute("employes", employes);
            return "Paie";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("employes", java.util.Collections.emptyList());
            return "Paie";
        }
    }
}