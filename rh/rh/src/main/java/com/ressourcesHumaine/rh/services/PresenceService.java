package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Presence;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.repositories.PresenceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PresenceService {

    @Autowired
    private PresenceRepository presenceRepository;

    @Autowired
    private EmployeRepository employeRepository;

    public Presence savePresence(Presence presence) {
        if (presence.getEmploye() != null && presence.getEmploye().getIdEmploye() != null) {
            Employe emp = employeRepository.findById(presence.getEmploye().getIdEmploye())
                    .orElseThrow(
                            () -> new RuntimeException("Employé non trouvé: " + presence.getEmploye().getIdEmploye()));
            presence.setEmploye(emp);
        }
        return presenceRepository.save(presence);
    }

    public List<Presence> getAllPresences() {
        return presenceRepository.findAll();
    }

    public Optional<Presence> getPresenceById(Long id) {
        return presenceRepository.findById(id);
    }

    public List<Presence> getPresencesByDate(Date date) {
        return presenceRepository.findByDatePresence(date);
    }

    public Optional<Presence> getPresenceByEmployeAndDate(Long employeId, Date date) {
        return presenceRepository.findByEmployeIdAndDate(employeId, date);
    }

    public List<Presence> getPresencesByEmployeId(Long employeId) {
        return presenceRepository.findByEmployeId(employeId);
    }

    public Presence updatePresence(Long id, Presence details) {
        Optional<Presence> optional = presenceRepository.findById(id);
        if (optional.isPresent()) {
            Presence p = optional.get();
            p.setDatePresence(details.getDatePresence());
            p.setStatut(details.getStatut());
            p.setEmploye(details.getEmploye());
            return presenceRepository.save(p);
        } else {
            throw new RuntimeException("Présence non trouvée avec l'ID: " + id);
        }
    }

    public void deletePresence(Long id) {
        if (presenceRepository.existsById(id)) {
            presenceRepository.deleteById(id);
        } else {
            throw new RuntimeException("Présence non trouvée avec l'ID: " + id);
        }
    }

    public boolean presenceExists(Long id) {
        return presenceRepository.existsById(id);
    }

    public int countDistinctEmployesPresentToday(){
        return this.presenceRepository.countDistinctEmployesPresentToday();
    }

}
