package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Pointage;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.repositories.PointageRepository;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.services.HistoriqueService;
import com.ressourcesHumaine.rh.entities.Historique;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PointageService {

    @Autowired
    private PointageRepository pointageRepository;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private HistoriqueService historiqueService;

    public Pointage savePointage(Pointage pointage) {
        Pointage saved = pointageRepository.save(pointage);
        try {
            Historique h = new Historique();
            h.setDescription("Pointage créé");
            String details = "Pointage id=" + (saved.getIdPointage() != null ? saved.getIdPointage() : "?")
                    + ", employe=" + (saved.getEmploye() != null ? saved.getEmploye().getNom() : "-");
            h.setDetails(details);
            h.setIdEvenement(saved.getIdPointage() != null ? saved.getIdPointage().intValue() : 0);
            h.setClasse(Pointage.class);
            historiqueService.saveHistorique(h);
        } catch (Exception ignore) {
        }
        return saved;
    }

    public List<Pointage> getAllPointages() {
        return pointageRepository.findAll();
    }

    public Optional<Pointage> getPointageById(Long id) {
        return pointageRepository.findById(id);
    }

    public List<Pointage> getPointagesByDate(Date date) {
        return pointageRepository.findByDatePointage(date);
    }

    public Optional<Pointage> getPointageByEmployeAndDate(Long employeId, Date date) {
        return pointageRepository.findByEmployeIdAndDate(employeId, date);
    }

    public Pointage markEntry(Long employeId, Date date) {
        Optional<Pointage> existing = getPointageByEmployeAndDate(employeId, date);
        Pointage p;
        if (existing.isPresent()) {
            p = existing.get();
        } else {
            p = new Pointage();
            Employe emp = employeRepository.findById(employeId)
                    .orElseThrow(() -> new RuntimeException("Employé non trouvé: " + employeId));
            p.setEmploye(emp);
            p.setDatePointage(date);
        }
        Time now = Time.valueOf(LocalTime.now());
        p.setHeureEntree(now);
        Pointage saved = pointageRepository.save(p);
        try {
            Historique h = new Historique();
            h.setDescription("Pointage entrée");
            String details = "Pointage id=" + (saved.getIdPointage() != null ? saved.getIdPointage() : "?")
                    + ", employeId=" + (saved.getEmploye() != null ? saved.getEmploye().getIdEmploye() : "-");
            h.setDetails(details);
            h.setIdEvenement(saved.getIdPointage() != null ? saved.getIdPointage().intValue() : 0);
            h.setClasse(Pointage.class);
            historiqueService.saveHistorique(h);
        } catch (Exception ignore) {
        }
        return saved;
    }

    public Pointage markExit(Long employeId, Date date) {
        Optional<Pointage> existing = getPointageByEmployeAndDate(employeId, date);
        if (existing.isPresent()) {
            Pointage p = existing.get();
            Time now = Time.valueOf(LocalTime.now());
            p.setHeureSortie(now);
            Pointage saved = pointageRepository.save(p);
            try {
                Historique h = new Historique();
                h.setDescription("Pointage sortie");
                String details = "Pointage id=" + (saved.getIdPointage() != null ? saved.getIdPointage() : "?")
                        + ", employeId=" + (saved.getEmploye() != null ? saved.getEmploye().getIdEmploye() : "-");
                h.setDetails(details);
                h.setIdEvenement(saved.getIdPointage() != null ? saved.getIdPointage().intValue() : 0);
                h.setClasse(Pointage.class);
                historiqueService.saveHistorique(h);
            } catch (Exception ignore) {
            }
            return saved;
        } else {
            throw new RuntimeException(
                    "Aucun pointage d'entrée trouvé pour l'employé " + employeId + " à la date " + date);
        }
    }

    public List<Pointage> getPointagesByEmployeId(Long employeId) {
        return pointageRepository.findByEmployeId(employeId);
    }

    public Pointage updatePointage(Long id, Pointage details) {
        Optional<Pointage> optional = pointageRepository.findById(id);
        if (optional.isPresent()) {
            Pointage p = optional.get();
            p.setDatePointage(details.getDatePointage());
            p.setHeureEntree(details.getHeureEntree());
            p.setHeureSortie(details.getHeureSortie());
            p.setEmploye(details.getEmploye());
            Pointage saved = pointageRepository.save(p);
            try {
                Historique h = new Historique();
                h.setDescription("Pointage modifié");
                String det = "Pointage id=" + (saved.getIdPointage() != null ? saved.getIdPointage() : "?")
                        + ", employe=" + (saved.getEmploye() != null ? saved.getEmploye().getNom() : "-");
                h.setDetails(det);
                h.setIdEvenement(saved.getIdPointage() != null ? saved.getIdPointage().intValue() : 0);
                h.setClasse(Pointage.class);
                historiqueService.saveHistorique(h);
            } catch (Exception ignore) {
            }
            return saved;
        } else {
            throw new RuntimeException("Pointage non trouvé avec l'ID: " + id);
        }
    }

    public void deletePointage(Long id) {
        if (pointageRepository.existsById(id)) {
            Optional<Pointage> opt = pointageRepository.findById(id);
            pointageRepository.deleteById(id);
            try {
                Historique h = new Historique();
                h.setDescription("Pointage supprimé");
                String details = "Pointage id=" + id;
                if (opt.isPresent() && opt.get().getEmploye() != null) {
                    details += ", employe=" + opt.get().getEmploye().getNom();
                }
                h.setDetails(details);
                h.setIdEvenement(id != null ? id.intValue() : 0);
                h.setClasse(Pointage.class);
                historiqueService.saveHistorique(h);
            } catch (Exception ignore) {
            }
        } else {
            throw new RuntimeException("Pointage non trouvé avec l'ID: " + id);
        }
    }

    public boolean pointageExists(Long id) {
        return pointageRepository.existsById(id);
    }

}
