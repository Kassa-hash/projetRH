package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Pointage;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.repositories.PointageRepository;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
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

    public Pointage savePointage(Pointage pointage) {
        return pointageRepository.save(pointage);
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
        return pointageRepository.save(p);
    }

    public Pointage markExit(Long employeId, Date date) {
        Optional<Pointage> existing = getPointageByEmployeAndDate(employeId, date);
        if (existing.isPresent()) {
            Pointage p = existing.get();
            Time now = Time.valueOf(LocalTime.now());
            p.setHeureSortie(now);
            return pointageRepository.save(p);
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
            return pointageRepository.save(p);
        } else {
            throw new RuntimeException("Pointage non trouvé avec l'ID: " + id);
        }
    }

    public void deletePointage(Long id) {
        if (pointageRepository.existsById(id)) {
            pointageRepository.deleteById(id);
        } else {
            throw new RuntimeException("Pointage non trouvé avec l'ID: " + id);
        }
    }

    public boolean pointageExists(Long id) {
        return pointageRepository.existsById(id);
    }

}
