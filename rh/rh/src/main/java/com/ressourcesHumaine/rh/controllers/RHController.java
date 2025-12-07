package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.services.RHService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;

@Controller
@RequestMapping("/rh")
public class RHController {

    private final RHService service;

    public RHController(RHService service) {
        this.service = service;
    }

    @GetMapping("/presence")
    public String presenceDuJour(@RequestParam(required = false) Date date,
                                 Model model) {

        String reponseIA = service.demanderInfosPresence(date);
        model.addAttribute("reponseIA", reponseIA);

        return "Accueil";
    }
}
