package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.services.RHService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/ai")
public class AIController {

    private final RHService rhService;

    public AIController(RHService rhService) {
        this.rhService = rhService;
    }

    @GetMapping
    @ResponseBody
    public ResponseEntity<String> ask(@RequestParam String prompt) {
        try {
            if (prompt == null || prompt.trim().isEmpty()) {
                return ResponseEntity.badRequest().body("❌ La question ne peut pas être vide");
            }

            String response = rhService.repondreQuestionRH(prompt);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500)
                    .body("❌ Erreur serveur : " + e.getMessage());
        }
    }
}