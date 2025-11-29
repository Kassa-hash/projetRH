package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.HeureSupp;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.repositories.HeureSuppRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HeureSuppService {

    @Autowired
    private HeureSuppRepository heureSuppRepository;

    @Autowired
    private EmployeRepository employeRepository;

    public HeureSupp createHeureSupp(HeureSupp heureSupp, Long idEmploye) {
        Employe employe = employeRepository.findById(idEmploye)
                .orElseThrow(() -> new RuntimeException("Employé introuvable"));

        heureSupp.setEmploye(employe);
        return heureSuppRepository.save(heureSupp);
    }
}
