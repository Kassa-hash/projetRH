package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Presence;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class RHService {
    private final OpenAIService aiService;
    private final PresenceService presenceService;

    public RHService(OpenAIService aiService, PresenceService presenceService) {
        this.aiService = aiService;
        this.presenceService = presenceService;
    }

    public String demanderInfosPresence(Date date) {
        if (date == null) {
            date = new Date();
        }

        List<Presence> presences = presenceService.getPresencesByDate(date);

        StringBuilder data = new StringBuilder("Données RH du ");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        data.append(sdf.format(date)).append(" :\n\n");

        if (presences.isEmpty()) {
            data.append("Aucune présence enregistrée.\n");
        } else {
            data.append("Employés présents :\n");
            for (Presence p : presences) {
                data.append("- ").append(p.getEmploye().getNom())

                        .append("\n");
            }
        }

        String prompt = data + "\nQuestion : Combien de personnels sont présents aujourd'hui ?";

        return aiService.askAI(prompt);
    }

    public String repondreQuestionRH(String question) {
        // Vous pouvez enrichir cette méthode avec plus de contexte
        return aiService.askAI("Contexte : Tu es un assistant RH. Question : " + question);
    }
}