package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.repositories.AvanceRepository;
import com.ressourcesHumaine.rh.repositories.DemandeAvanceRepository;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service

public class DemandeAvanceService {

    @Autowired
    private DemandeAvanceRepository demandeAvanceRepository;

    public DemandeAvance demanderAvance(DemandeAvance demandeAvance)
    {
        return demandeAvanceRepository.save(demandeAvance);
    }

}
