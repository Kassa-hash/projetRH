package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Presence;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.PresenceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import java.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/presences")
public class PresenceController {

    @Autowired
    private PresenceService presenceService;

    @Autowired
    private EmployeService employeService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }

    // Page principale - liste des présences (optionnellement par date)
    @GetMapping
    public String listePresences(@RequestParam(required = false) String date, Model model) {
        // parse date (yyyy-MM-dd) or use today
        Date selectedDate;
        if (date == null || date.trim().isEmpty()) {
            selectedDate = new Date();
        } else {
            try {
                java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
                fmt.setLenient(false);
                selectedDate = fmt.parse(date);
            } catch (java.text.ParseException pe) {
                selectedDate = new Date();
            }
        }

        List<Presence> presences = presenceService.getPresencesByDate(selectedDate);
        model.addAttribute("presences", presences);
        model.addAttribute("presence", new Presence());
        // fournir la liste des employés pour le formulaire et l'affichage
        //List<Employe> employes = employeService.getAllEmployes();
        //liste des employes actuels
        List<Employe> employes = employeService.employesActuels();
        model.addAttribute("employes", employes);

        // calculer statistiques
        long presentCount = presences.stream().filter(p -> Boolean.TRUE.equals(p.getStatut())).count();
        int totalCount = employes.size();
        long absentCount = totalCount - presentCount;
        int taux = totalCount == 0 ? 0 : (int) Math.round((presentCount * 100.0) / totalCount);

        model.addAttribute("presentCount", presentCount);
        model.addAttribute("absentCount", absentCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("taux", taux);

        // formatted date for input value
        java.text.SimpleDateFormat outFmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("selectedDate", outFmt.format(selectedDate));

        return "Presence";
    }

    // JSON - récupérer toutes les présences
    @GetMapping("/all")
    @ResponseBody
    public List<Presence> listePresencesJson() {
        return presenceService.getAllPresences();
    }

    // Ajouter une présence
    @PostMapping("/ajouter")
    public String ajouterPresence(@ModelAttribute Presence presence, Model model) {
        try {
            presenceService.savePresence(presence);
            return "redirect:/presences?success=Présence ajoutée";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("presence", presence);
            return "Presence";
        }
    }

    // Formulaire de modification
    @GetMapping("/modifier/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Presence presence = presenceService.getPresenceById(id)
                    .orElseThrow(() -> new RuntimeException("Présence non trouvée"));
            model.addAttribute("presence", presence);
            return "Presence";
        } catch (RuntimeException e) {
            return "redirect:/presences?error=" + e.getMessage();
        }
    }

    // Modifier une présence
    @PostMapping("/modifier/{id}")
    public String modifierPresence(@PathVariable Long id, @ModelAttribute Presence presence, Model model) {
        try {
            presenceService.updatePresence(id, presence);
            return "redirect:/presences?success=Présence modifiée";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("presence", presence);
            return "Presence";
        }
    }

    // Supprimer une présence
    @GetMapping("/supprimer/{id}")
    public String supprimerPresence(@PathVariable Long id) {
        try {
            presenceService.deletePresence(id);
            return "redirect:/presences?success=Présence supprimée";
        } catch (RuntimeException e) {
            return "redirect:/presences?error=" + e.getMessage();
        }
    }

    // Marquer présence pour un employé à une date (ou créer si absent)
    @PostMapping("/mark/{employeId}")
    public String markPresence(@PathVariable Long employeId,
            @RequestParam(required = false) String date,
            @RequestParam(required = false) Boolean statut,
            HttpSession session) {
        try {
            final Date parsedDate;
            if (date == null || date.trim().isEmpty()) {
                parsedDate = new Date();
            } else {
                Date tmp;
                try {
                    java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
                    fmt.setLenient(false);
                    tmp = fmt.parse(date);
                } catch (java.text.ParseException pe) {
                    tmp = new Date();
                }
                parsedDate = tmp;
            }

            Presence p = presenceService.getPresenceByEmployeAndDate(employeId, parsedDate).orElseGet(() -> {
                Presence np = new Presence();
                Employe emp = employeService.getEmployeById(employeId).orElse(null);
                np.setEmploye(emp);
                np.setDatePresence(parsedDate);
                return np;
            });
            if (statut != null)
                p.setStatut(statut);
            else
                p.setStatut(true);
            presenceService.savePresence(p);
            return "redirect:/presences?success=Présence marquée";
        } catch (RuntimeException e) {
            return "redirect:/presences?error=" + e.getMessage();
        }
    }

}
