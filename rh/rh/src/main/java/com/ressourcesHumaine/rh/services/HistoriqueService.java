package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Historique;
import com.ressourcesHumaine.rh.repositories.HistoriqueRepository;

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
public class HistoriqueService {

    @Autowired
    private HistoriqueRepository historiqueRepository;

    public Historique saveHistorique(Historique h){
        return historiqueRepository.save(h);
    }

    public List<Historique> recentHistorique(){
        return historiqueRepository.recentHistorique();
    }
}