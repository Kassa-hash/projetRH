package com.ressourcesHumaine.rh.restcontrollers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ressourcesHumaine.rh.services.ContratEmployeService;
import com.ressourcesHumaine.rh.services.EmployeService;
import jakarta.servlet.http.HttpSession;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;
import org.springframework.ui.Model;
import java.util.Map;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/effectif")
public class ApiController {

    @Autowired
    private ContratEmployeService effectifService;

    @GetMapping("/evolution")
    public List<Map<String, Object>> getEvolution() {
        return effectifService.getEvolutionEffectif("6mois");
    }
}
