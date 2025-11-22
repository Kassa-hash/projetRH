package com.ressourcesHumaine.rh.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GlobalController {

    @GetMapping
    public String showDemandeAvance(Model model) {
        return "Accueil";
    }
}
