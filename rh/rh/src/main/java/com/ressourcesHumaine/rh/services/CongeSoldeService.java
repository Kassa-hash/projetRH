package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.repositories.CongeSoldeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import com.ressourcesHumaine.rh.entities.CongeSolde;

@Service
public class CongeSoldeService {

    @Autowired
    private CongeSoldeRepository congeSoldeRepository;

    public CongeSolde getCongeEmpByAnnee(int annee,Long idEmp){
        return congeSoldeRepository.getCongeEmpByAnnee(annee,idEmp);
    }

    public CongeSolde save(CongeSolde solde){
        return congeSoldeRepository.save(solde);
    }
}