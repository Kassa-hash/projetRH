package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.repositories.DemandeAvanceRepository;

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
public class DemandeAvanceService {

    @Autowired
    private DemandeAvanceRepository demandeAvanceRepository;

    public List<DemandeAvance> demandeAttente(){
        List<DemandeAvance> demandes=demandeAvanceRepository.demandeAttente();
        return demandes;
    }

    public List<DemandeAvance> demandeAll(){
        return demandeAvanceRepository.findAll();
    }

    public int nbAvanceValid(){
        return demandeAvanceRepository.nbAvanceValid();
    }
}