package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Presence;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.repositories.PresenceRepository;
import com.ressourcesHumaine.rh.services.HistoriqueService;
import com.ressourcesHumaine.rh.entities.Historique;
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

    @Autowired
    private HistoriqueService historiqueService;

    public Presence savePresence(Presence presence) {
        if (presence.getEmploye() != null && presence.getEmploye().getIdEmploye() != null) {
            Employe emp = employeRepository.findById(presence.getEmploye().getIdEmploye())
                    .orElseThrow(
                            () -> new RuntimeException("Employé non trouvé: " + presence.getEmploye().getIdEmploye()));
            presence.setEmploye(emp);
        }
        Presence saved = presenceRepository.save(presence);
        try {
            Historique h = new Historique();
            h.setDescription("Presence créée");
            String details = "Presence id=" + (saved.getIdPresence() != null ? saved.getIdPresence() : "?")
                    + ", employe=" + (saved.getEmploye() != null ? saved.getEmploye().getNom() : "-");
            h.setDetails(details);
            h.setIdEvenement(saved.getIdPresence() != null ? saved.getIdPresence().intValue() : 0);
            h.setClasse(Presence.class);
            historiqueService.saveHistorique(h);
        } catch (Exception ignore) {
        }
        return saved;
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
            Presence saved = presenceRepository.save(p);
            try {
                Historique h = new Historique();
                h.setDescription("Presence modifiée");
                String det = "Presence id=" + (saved.getIdPresence() != null ? saved.getIdPresence() : "?")
                        + ", employe=" + (saved.getEmploye() != null ? saved.getEmploye().getNom() : "-");
                h.setDetails(det);
                h.setIdEvenement(saved.getIdPresence() != null ? saved.getIdPresence().intValue() : 0);
                h.setClasse(Presence.class);
                historiqueService.saveHistorique(h);
            } catch (Exception ignore) {
            }
            return saved;
        } else {
            throw new RuntimeException("Présence non trouvée avec l'ID: " + id);
        }
    }

    public void deletePresence(Long id) {
        if (presenceRepository.existsById(id)) {
            Optional<Presence> opt = presenceRepository.findById(id);
            presenceRepository.deleteById(id);
            try {
                Historique h = new Historique();
                h.setDescription("Presence supprimée");
                String details = "Presence id=" + id;
                if (opt.isPresent() && opt.get().getEmploye() != null) {
                    details += ", employe=" + opt.get().getEmploye().getNom();
                }
                h.setDetails(details);
                h.setIdEvenement(id != null ? id.intValue() : 0);
                h.setClasse(Presence.class);
                historiqueService.saveHistorique(h);
            } catch (Exception ignore) {
            }
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
