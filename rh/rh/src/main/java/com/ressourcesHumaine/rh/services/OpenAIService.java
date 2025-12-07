package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Presence;
import org.springframework.stereotype.Service;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import java.util.*;
import java.util.regex.Pattern;

@Service
public class OpenAIService {

    private final RestTemplate restTemplate = new RestTemplate();
    private  final PresenceService presenceService;

    public OpenAIService(PresenceService presenceService) {
        this.presenceService = presenceService;
    }

    /**
     * Méthode principale - utilise une IA gratuite
     */
    public String askAI(String prompt) {
        System.out.println("💬 Question reçue : " + prompt);

        // Essayer l'API gratuite en premier
        String response = tryFreeAPI(prompt);

        // Si l'API échoue, utiliser le mode intelligent local
        if (response.startsWith("❌") || response.startsWith("⏳")) {
            System.out.println("🤖 Utilisation de l'assistant local intelligent");
            return analyzeLocally(prompt);
        }

        return response;
    }

    /**
     * Essaie plusieurs APIs gratuites
     */
    private String tryFreeAPI(String prompt) {
        // 1. Essayer Hugging Face (gratuit, sans clé)
        try {
            return callHuggingFaceAPI(prompt);
        } catch (Exception e) {
            System.out.println("⚠️ Hugging Face indisponible : " + e.getMessage());
        }

        // 2. Si échec, utiliser le mode local
        return analyzeLocally(prompt);
    }

    /**
     * API Hugging Face GRATUITE (sans clé requise)
     */
    private String callHuggingFaceAPI(String prompt) {
        try {
            String apiUrl = "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2";

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String formattedPrompt = String.format(
                    "[INST] Tu es un assistant RH professionnel. Réponds en français de manière concise et utile.\n\nQuestion: %s [/INST]",
                    prompt
            );

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("inputs", formattedPrompt);
            requestBody.put("parameters", Map.of(
                    "max_new_tokens", 250,
                    "temperature", 0.7,
                    "return_full_text", false
            ));

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            ResponseEntity<List> response = restTemplate.exchange(
                    apiUrl,
                    HttpMethod.POST,
                    request,
                    List.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                List<Map<String, Object>> body = response.getBody();
                if (!body.isEmpty()) {
                    String generatedText = (String) body.get(0).get("generated_text");
                    return "🤖 " + generatedText.trim();
                }
            }

            throw new Exception("Réponse invalide");

        } catch (org.springframework.web.client.HttpServerErrorException e) {
            return "⏳ Modèle en chargement (20-30 sec). Réessayez dans un instant...";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Analyseur local intelligent (fonctionne TOUJOURS, même sans internet)
     */
    private String analyzeLocally(String prompt) {
        String lower = prompt.toLowerCase();

        // Détection des salutations
        if (matches(lower, "bonjour", "salut", "hello", "hi", "coucou", "bonsoir")) {
            return "👋 Bonjour ! Je suis votre assistant RH.\n\n" +
                    "Je peux vous aider avec :\n" +
                    "• 📊 Statistiques de présence\n" +
                    "• 🏖️ Gestion des congés\n" +
                    "• 👥 Informations sur les employés\n" +
                    "• 💰 Gestion des paies\n" +
                    "• 📋 Génération de rapports\n\n" +
                    "Que puis-je faire pour vous ?";
        }

        // Questions sur les présences
        if (matches(lower, "présent", "présence", "absent", "aujourd'hui", "pointage")) {
            Date date= new Date();

            List<Presence> presencesAujourdhui = presenceService.getPresencesByDate(date);
            StringBuilder context = new StringBuilder();

            if (!presencesAujourdhui.isEmpty()) {
                context.append("Liste des présents :\n");
                for (Presence p : presencesAujourdhui) {
                    Employe emp = p.getEmploye();
                    context.append("  • ").append(emp.getNom()).append(" ")
                            .append(")\n");
                }
            }

            return context.toString();
        }

        // Questions sur les congés
        if (matches(lower, "congé", "vacances", "absence", "rtt", "repos")) {
            return "🏖️ **Gestion des congés :**\n\n" +
                    "**Demandes en attente :** Consultez la section 'Demandes'\n" +
                    "**Validation :** Cliquez sur une demande pour approuver/refuser\n\n" +
                    "**Types de congés :**\n" +
                    "• Congés payés annuels\n" +
                    "• RTT (Réduction du Temps de Travail)\n" +
                    "• Congés maladie\n" +
                    "• Congés exceptionnels\n\n" +
                    "💡 N'oubliez pas de traiter les demandes rapidement pour maintenir la satisfaction des employés !";
        }

        // Questions sur les employés
        if (matches(lower, "employé", "personnel", "staff", "équipe", "effectif", "recrutement")) {
            return "👥 **Gestion des employés :**\n\n" +
                    "Vous pouvez gérer vos employés depuis la section 'Employés'.\n\n" +
                    "**Fonctionnalités disponibles :**\n" +
                    "• Ajouter un nouvel employé\n" +
                    "• Modifier les informations\n" +
                    "• Consulter l'historique\n" +
                    "• Générer des statistiques (âge moyen, ancienneté)\n" +
                    "• Exporter la liste\n\n" +
                    "📈 **Stats actuelles visibles sur le dashboard :** effectif total, âge moyen, ancienneté moyenne.";
        }

        // Questions sur les contrats
        if (matches(lower, "contrat", "cdi", "cdd", "stage", "intérim")) {
            return "📋 **Gestion des contrats :**\n\n" +
                    "Accédez à la section 'Contrats' pour :\n" +
                    "• Créer de nouveaux contrats\n" +
                    "• Modifier les contrats existants\n" +
                    "• Suivre les échéances (fin de CDD, période d'essai)\n" +
                    "• Générer les documents PDF\n\n" +
                    "**Types de contrats :**\n" +
                    "• CDI (Contrat à Durée Indéterminée)\n" +
                    "• CDD (Contrat à Durée Déterminée)\n" +
                    "• Stage / Alternance\n" +
                    "• Intérim";
        }

        // Questions sur les paies
        if (matches(lower, "paie", "salaire", "bulletin", "paiement", "rémunération", "avance")) {
            return "💰 **Gestion de la paie :**\n\n" +
                    "Section 'Gestion de paiement' pour :\n" +
                    "• Calculer les salaires mensuels\n" +
                    "• Générer les bulletins de paie\n" +
                    "• Gérer les avances sur salaire\n" +
                    "• Suivre les primes et heures supplémentaires\n\n" +
                    "⚠️ **Demandes d'avances en attente :** Consultez le tableau de bord pour les traiter.\n\n" +
                    "💡 Les heures supplémentaires sont automatiquement calculées depuis la section 'Heures Supp'.";
        }

        // Questions sur les heures supplémentaires
        if (matches(lower, "heure", "supp", "supplémentaire", "overtime")) {
            return "⏱️ **Heures supplémentaires :**\n\n" +
                    "Accédez à la section 'Heures Supp' pour :\n" +
                    "• Enregistrer les heures supp\n" +
                    "• Calculer la rémunération majorée\n" +
                    "• Générer des rapports mensuels\n" +
                    "• Suivre les compteurs individuels\n\n" +
                    "📊 **Ce mois-ci :** Les statistiques sont visibles sur le tableau de bord.\n\n" +
                    "💡 Les heures supp sont automatiquement ajoutées aux bulletins de paie.";
        }

        // Questions sur les rapports/statistiques
        if (matches(lower, "rapport", "statistique", "analyse", "bilan", "export", "graphique")) {
            return "📊 **Rapports et Analyses :**\n\n" +
                    "Le tableau de bord affiche :\n" +
                    "• Évolution des effectifs (6 derniers mois)\n" +
                    "• Répartition présence/absence\n" +
                    "• Demandes en attente\n" +
                    "• Activités récentes\n\n" +
                    "**Exports disponibles :**\n" +
                    "• Liste des employés (Excel/CSV)\n" +
                    "• Rapports de présence mensuels\n" +
                    "• Historique des paies\n\n" +
                    "💡 Utilisez les graphiques interactifs pour analyser les tendances.";
        }

        // Questions sur les documents
        if (matches(lower, "document", "fichier", "pdf", "attestation", "certificat")) {
            return "📁 **Gestion des documents :**\n\n" +
                    "Section 'Gestion de document' pour :\n" +
                    "• Stocker les documents RH\n" +
                    "• Générer des attestations\n" +
                    "• Archiver les contrats\n" +
                    "• Partager avec les employés\n\n" +
                    "**Types de documents :**\n" +
                    "• Contrats de travail\n" +
                    "• Bulletins de paie\n" +
                    "• Attestations employeur\n" +
                    "• Certificats de travail";
        }

        // Questions d'aide
        if (matches(lower, "aide", "help", "comment", "utiliser", "fonction")) {
            return "❓ **Besoin d'aide ?**\n\n" +
                    "**Navigation :**\n" +
                    "Utilisez le menu latéral gauche pour accéder aux différentes sections.\n\n" +
                    "**Sections principales :**\n" +
                    "📊 Tableau de Bord - Vue d'ensemble\n" +
                    "👥 Employés - Gestion du personnel\n" +
                    "📋 Contrats - Gestion contractuelle\n" +
                    "✅ Présences - Suivi quotidien\n" +
                    "⏰ Pointages - Horaires de travail\n" +
                    "🏖️ Demandes - Congés et avances\n" +
                    "💰 Paies - Rémunération\n\n" +
                    "💡 Chaque section a ses propres fonctionnalités détaillées.";
        }

        // Merci
        if (matches(lower, "merci", "thanks", "thank")) {
            return "😊 Je vous en prie ! N'hésitez pas si vous avez d'autres questions.\n\n" +
                    "Je suis là pour faciliter votre gestion RH quotidienne ! 💼";
        }

        // Question non reconnue
        return "💬 **Je peux vous aider avec :**\n\n" +
                "• 📊 Statistiques et présences\n" +
                "• 🏖️ Gestion des congés\n" +
                "• 👥 Informations employés\n" +
                "• 💰 Paies et avances\n" +
                "• ⏱️ Heures supplémentaires\n" +
                "• 📋 Contrats et documents\n\n" +
                "**Exemples de questions :**\n" +
                "• \"Combien d'employés sont présents aujourd'hui ?\"\n" +
                "• \"Comment gérer les demandes de congés ?\"\n" +
                "• \"Comment calculer les heures supplémentaires ?\"\n\n" +
                "Reformulez votre question et je ferai de mon mieux pour vous aider ! 😊";
    }

    /**
     * Vérifie si le texte contient l'un des mots-clés
     */
    private boolean matches(String text, String... keywords) {
        for (String keyword : keywords) {
            if (text.contains(keyword)) {
                return true;
            }
        }
        return false;
    }
}