package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.MoisRepository;

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
public class MoisService {

    @Autowired
    private MoisRepository moisRepository;

    public List<Mois> MoisAll(){
        return moisRepository.findAll();
    }

    public Mois findById(Long id) {
        Optional<Mois> optional = moisRepository.findById(id);
        return optional.orElse(null);
    }

}