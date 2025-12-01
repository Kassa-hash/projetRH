package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.HeureSuppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.ressourcesHumaine.rh.entities.Employe;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/heures-supp")
public class HeureSuppController {

    @Autowired
    private HeureSuppService heureSuppService;

    @Autowired
    private EmployeService employeeService;

    @GetMapping
    public String heuresSuppPage(Model model) {
        List<HeureSupp> heureSupps = heureSuppService.getAllHeuresSupp();
        List<Employe> employes = employeeService.getAllEmployes();
        model.addAttribute("heuressupps", heureSupps);

        // Calcul du total des heures du mois courant
        double totalHeuresMois = heureSupps.stream()
                .filter(heure -> {
                    // Filtrer pour le mois courant (vous pouvez adapter cette logique)
                    java.util.Date now = new java.util.Date();
                    java.util.Calendar cal = java.util.Calendar.getInstance();
                    cal.setTime(now);
                    int moisCourant = cal.get(java.util.Calendar.MONTH);
                    int anneeCourante = cal.get(java.util.Calendar.YEAR);

                    cal.setTime(heure.getDate());
                    int moisHeure = cal.get(java.util.Calendar.MONTH);
                    int anneeHeure = cal.get(java.util.Calendar.YEAR);

                    return moisHeure == moisCourant && anneeHeure == anneeCourante;
                })
                .mapToDouble(heure -> heure.getDuree().doubleValue())
                .sum();

        model.addAttribute("totalHeuresMois", totalHeuresMois);
        model.addAttribute("employes", employes);

        return "HeureSupp";
    }

    @PostMapping("/save")
    public String saveHeureSupp(@RequestParam String date, @RequestParam String duree, @RequestParam Long employeId) {

        try {
            HeureSupp heureSupp = new HeureSupp();
            heureSupp.setDate(java.sql.Date.valueOf(date));
            heureSupp.setDuree(new java.math.BigDecimal(duree));
            Optional<Employe> employe = employeeService.getEmployeById(employeId);
            heureSupp.setEmploye(employe.get());
            heureSuppService.saveHeureSupp(heureSupp);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/heures-supp";
    }
}