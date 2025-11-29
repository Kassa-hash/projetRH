package com.ressourcesHumaine.rh.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ressourcesHumaine.rh.services.ContratEmployeService;
import com.ressourcesHumaine.rh.services.EmployeService;
import com.ressourcesHumaine.rh.services.PointageService;
import jakarta.servlet.http.HttpSession;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Pointage;
import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;
import org.springframework.ui.Model;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

@Controller
@RequestMapping("/pointages")
public class PointageController {

    @Autowired
    private PointageService pointageService;

    @GetMapping
    public String goPointage(Model model) {
        List<Pointage> all = pointageService.getAllPointages();
        model.addAttribute("pointages", all);
        return "Pointage";
    }

    @GetMapping("/all")
    @ResponseBody
    public List<Pointage> getAllPointages() {
        return pointageService.getAllPointages();
    }

    @GetMapping("/{id}")
    @ResponseBody
    public Pointage getPointage(@PathVariable Long id) {
        Optional<Pointage> p = pointageService.getPointageById(id);
        return p.orElse(null);
    }

    @PostMapping("/save")
    @ResponseBody
    public Pointage savePointage(@RequestBody Pointage pointage) {
        return pointageService.savePointage(pointage);
    }

    @PutMapping("/update/{id}")
    @ResponseBody
    public Pointage updatePointage(@PathVariable Long id, @RequestBody Pointage details) {
        return pointageService.updatePointage(id, details);
    }

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public String deletePointage(@PathVariable Long id) {
        pointageService.deletePointage(id);
        return "Supprimé";
    }

    @GetMapping("/byDate")
    @ResponseBody
    public List<Pointage> getByDate(@RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date date) {
        return pointageService.getPointagesByDate(date);
    }

    @PostMapping("/entry/{employeId}")
    @ResponseBody
    public Pointage markEntry(@PathVariable Long employeId,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date date) {
        return pointageService.markEntry(employeId, date);
    }

    @PostMapping("/exit/{employeId}")
    @ResponseBody
    public Pointage markExit(@PathVariable Long employeId,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date date) {
        return pointageService.markExit(employeId, date);
    }

}