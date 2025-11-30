package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.HeureSupp;
import com.ressourcesHumaine.rh.repositories.HeureSuppRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HeureSuppService {

    @Autowired
    private HeureSuppRepository heureSuppRepository;

    public List<HeureSupp> getAllHeuresSupp() {
        return heureSuppRepository.findAll();
    }

    
}