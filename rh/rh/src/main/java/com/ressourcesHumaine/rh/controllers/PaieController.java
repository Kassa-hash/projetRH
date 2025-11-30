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
        List<Employe> employes = employeService.employesActuels();



        model.addAttribute("employes", employes);
        return "Paie"; // Retourne le nom de la JSP (Paie.jsp)
    }
}