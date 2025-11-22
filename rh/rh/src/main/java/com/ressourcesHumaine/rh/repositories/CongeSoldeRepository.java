package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.CongeSolde;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CongeSoldeRepository extends JpaRepository<CongeSolde, Long> {
    
    @Query("select c from CongeSolde c where c.annee= :an and c.employe.idEmploye= :idEmp")
    CongeSolde getCongeEmpByAnnee(@Param("an") int annee,@Param("idEmp") Long idEmp);
    
}