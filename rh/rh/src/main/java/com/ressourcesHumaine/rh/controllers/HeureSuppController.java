package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import com.ressourcesHumaine.rh.services.HeureSuppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/heures-supp")
public class HeureSuppController {

    @Autowired
    private HeureSuppService heureSuppService;

    @PostMapping
    @ResponseBody
    public ResponseEntity<?> addHeureSupp(@RequestBody Map<String, Object> payload) {

        try {
            Long idEmploye = Long.valueOf(payload.get("idEmploye").toString());

            HeureSupp heureSupp = new HeureSupp();
            heureSupp.setDate(java.sql.Date.valueOf(payload.get("date").toString()));
            heureSupp.setDuree(new java.math.BigDecimal(payload.get("duree").toString()));

            HeureSupp saved = heureSuppService.createHeureSupp(heureSupp, idEmploye);

            return ResponseEntity.ok(saved);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur : " + e.getMessage());
        }
    }

    @GetMapping
    public String heuresSuppPage() {
        return "HeureSupp"; // HeureSupp.jsp dans /WEB-INF/views/
    }
}
