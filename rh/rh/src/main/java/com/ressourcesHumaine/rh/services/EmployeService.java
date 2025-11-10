package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeService {

    @Autowired
    private EmployeRepository employeRepository;

    // CREATE - Ajouter un employé
    public Employe saveEmploye(Employe employe) {
        // Vérifier si l'email existe déjà
        Optional<Employe> existingEmploye = employeRepository.findByEmail(employe.getEmail());
        if (existingEmploye.isPresent()) {
            throw new RuntimeException("Un employé avec cet email existe déjà");
        }

        // Vérifier si le contact existe déjà
        Optional<Employe> existingContact = employeRepository.findByContact(employe.getContact());
        if (existingContact.isPresent()) {
            throw new RuntimeException("Un employé avec ce contact existe déjà");
        }

        return employeRepository.save(employe);
    }

    // READ - Récupérer tous les employés
    public List<Employe> getAllEmployes() {
        return employeRepository.findAll();
    }

    // READ - Récupérer un employé par ID
    public Optional<Employe> getEmployeById(Long id) {
        return employeRepository.findById(id);
    }

    // READ - Rechercher par nom
    public List<Employe> getEmployesByNom(String nom) {
        return employeRepository.findByNomContainingIgnoreCase(nom);
    }

    // READ - Récupérer par email
    public Optional<Employe> getEmployeByEmail(String email) {
        return employeRepository.findByEmail(email);
    }

    // READ - Récupérer par rôle
    public List<Employe> getEmployesByRole(Long roleId) {
        return employeRepository.findByRoleId(roleId);
    }

    // READ - Récupérer par genre
    public List<Employe> getEmployesByGenre(Long genreId) {
        return employeRepository.findByGenreId(genreId);
    }

    // UPDATE - Mettre à jour un employé
    public Employe updateEmploye(Long id, Employe employeDetails) {
        Optional<Employe> optionalEmploye = employeRepository.findById(id);

        if (optionalEmploye.isPresent()) {
            Employe employe = optionalEmploye.get();

            // Vérifier l'unicité de l'email (sauf pour l'employé actuel)
            Optional<Employe> existingEmail = employeRepository.findByEmail(employeDetails.getEmail());
            if (existingEmail.isPresent() && !existingEmail.get().getIdEmploye().equals(id)) {
                throw new RuntimeException("Un autre employé utilise déjà cet email");
            }

            // Vérifier l'unicité du contact (sauf pour l'employé actuel)
            Optional<Employe> existingContact = employeRepository.findByContact(employeDetails.getContact());
            if (existingContact.isPresent() && !existingContact.get().getIdEmploye().equals(id)) {
                throw new RuntimeException("Un autre employé utilise déjà ce contact");
            }

            // Mettre à jour les champs
            employe.setNom(employeDetails.getNom());
            employe.setDateDeNaissance(employeDetails.getDateDeNaissance());
            employe.setContact(employeDetails.getContact());
            employe.setEmail(employeDetails.getEmail());
            employe.setPhoto(employeDetails.getPhoto());
            employe.setAdresse(employeDetails.getAdresse());
            employe.setRole(employeDetails.getRole());
            employe.setGenre(employeDetails.getGenre());

            return employeRepository.save(employe);
        } else {
            throw new RuntimeException("Employé non trouvé avec l'ID: " + id);
        }
    }

    // DELETE - Supprimer un employé
    public void deleteEmploye(Long id) {
        Optional<Employe> employe = employeRepository.findById(id);
        if (employe.isPresent()) {
            employeRepository.deleteById(id);
        } else {
            throw new RuntimeException("Employé non trouvé avec l'ID: " + id);
        }
    }

    // Vérifier si un employé existe
    public boolean employeExists(Long id) {
        return employeRepository.existsById(id);
    }
}

