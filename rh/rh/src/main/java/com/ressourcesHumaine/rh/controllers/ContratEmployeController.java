package com.ressourcesHumaine.rh.controllers;

import com.ressourcesHumaine.rh.entities.ContratEmploye;
import com.ressourcesHumaine.rh.services.ContratEmployeService;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.repositories.TypeContratRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.text.SimpleDateFormat;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import java.util.Date;

import java.util.List;

@Controller
@RequestMapping("/contrats")
public class ContratEmployeController {

    @Autowired
    private ContratEmployeService contratService;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private TypeContratRepository typeContratRepository;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }

    @GetMapping
    public String listeContrats(Model model) {
        List<ContratEmploye> contrats = contratService.getAllContrats();
        model.addAttribute("contrats", contrats);
        model.addAttribute("contrat", new ContratEmploye());
        model.addAttribute("employes", employeRepository.findAll());
        model.addAttribute("typeContrats", typeContratRepository.findAll());
        return "SuiviContrat";
    }

    @GetMapping("/all")
    @ResponseBody
    public List<ContratEmploye> listeContratsJson() {
        return contratService.getAllContrats();
    }

    @PostMapping("/ajouter")
    public String ajouterContrat(@ModelAttribute ContratEmploye contrat, Model model) {
        try {
            // Résoudre les relations employe/typeContrat avant sauvegarde
            if (contrat.getEmploye() != null && contrat.getEmploye().getIdEmploye() != null) {
                contrat.setEmploye(employeRepository.findById(contrat.getEmploye().getIdEmploye()).orElse(null));
            }
            if (contrat.getTypeContrat() != null && contrat.getTypeContrat().getIdTypeContrat() != null) {
                contrat.setTypeContrat(
                        typeContratRepository.findById(contrat.getTypeContrat().getIdTypeContrat()).orElse(null));
            }

            contratService.saveContrat(contrat);
            return "redirect:/contrats?success=Contrat ajouté";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("contrat", contrat);
            // repopuler les listes pour ne pas perdre l'affichage
            model.addAttribute("contrats", contratService.getAllContrats());
            model.addAttribute("employes", employeRepository.findAll());
            model.addAttribute("typeContrats", typeContratRepository.findAll());
            return "SuiviContrat";
        }
    }

    @GetMapping("/modifier/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            ContratEmploye contrat = contratService.getContratById(id)
                    .orElseThrow(() -> new RuntimeException("Contrat non trouvé"));
            model.addAttribute("contrat", contrat);
            // fournir aussi la liste complète afin que le tableau reste affiché
            model.addAttribute("contrats", contratService.getAllContrats());
            model.addAttribute("employes", employeRepository.findAll());
            model.addAttribute("typeContrats", typeContratRepository.findAll());
            return "SuiviContrat";
        } catch (RuntimeException e) {
            return "redirect:/contrats?error=" + e.getMessage();
        }
    }

    @PostMapping("/modifier/{id}")
    public String modifierContrat(@PathVariable Long id, @ModelAttribute ContratEmploye contrat, Model model) {
        try {
            // Résoudre relations avant mise à jour
            if (contrat.getEmploye() != null && contrat.getEmploye().getIdEmploye() != null) {
                contrat.setEmploye(employeRepository.findById(contrat.getEmploye().getIdEmploye()).orElse(null));
            }
            if (contrat.getTypeContrat() != null && contrat.getTypeContrat().getIdTypeContrat() != null) {
                contrat.setTypeContrat(
                        typeContratRepository.findById(contrat.getTypeContrat().getIdTypeContrat()).orElse(null));
            }

            contratService.updateContrat(id, contrat);
            return "redirect:/contrats?success=Contrat modifié";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("contrat", contrat);
            model.addAttribute("contrats", contratService.getAllContrats());
            model.addAttribute("employes", employeRepository.findAll());
            model.addAttribute("typeContrats", typeContratRepository.findAll());
            return "SuiviContrat";
        }
    }

    @GetMapping("/supprimer/{id}")
    public String supprimerContrat(@PathVariable Long id) {
        try {
            contratService.deleteContrat(id);
            return "redirect:/contrats?success=Contrat supprimé";
        } catch (RuntimeException e) {
            return "redirect:/contrats?error=" + e.getMessage();
        }
    }

}
