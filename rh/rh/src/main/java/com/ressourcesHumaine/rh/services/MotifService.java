package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Motif;
import com.ressourcesHumaine.rh.repositories.MotifRepository;

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
public class MotifService {

    @Autowired
    private MotifRepository motifRepository;

    public List<Motif> motifsAll(){
        return motifRepository.findAll();
    }

    public Motif findById(int id){
        Optional<Motif> motifs=motifRepository.findById((long)id);
        Motif motif=null;
        if(motifs.isPresent())
        {
            motif=motifs.get();
        }
        return motif;
    }

}