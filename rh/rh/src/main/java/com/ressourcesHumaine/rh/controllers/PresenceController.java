package com.ressourcesHumaine.rh.controllers;
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

@Controller
@RequestMapping("/presences")
public class PresenceController {
    
    @GetMapping
    public String goPresence() {
        return "Presence";
    }
}