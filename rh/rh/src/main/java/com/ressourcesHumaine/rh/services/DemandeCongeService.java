package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.DemandeConge;
import com.ressourcesHumaine.rh.repositories.DemandeCongeRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.*;
import java.util.TreeMap;

@Service
public class DemandeCongeService {

    @Autowired
    private DemandeCongeRepository demandeCongeRepository;

    public List<DemandeConge> demandeAttente(){
        List<DemandeConge> demandes=demandeCongeRepository.demandeAttente();
        return demandes;
    }

    public List<DemandeConge> demandeAll(){
        return demandeCongeRepository.findAll();
    }

    public DemandeConge findById(int id) {
    return demandeCongeRepository.findById((long) id)
            .orElse(null); 
    }

    public DemandeConge save(DemandeConge dem){
        return this.demandeCongeRepository.save(dem);
    }

    public int nbCongeValid(){
        return this.demandeCongeRepository.nbCongeValid();
    }

    public List<DemandeConge> demandesValidByEmp(Long idEmp){
        return this.demandeCongeRepository.demandesValidByEmp(idEmp);
    }

    public List<DemandeConge> demandesByEmp(Long idEmp){
        return this.demandeCongeRepository.demandesByEmp(idEmp);
    }

    
}

