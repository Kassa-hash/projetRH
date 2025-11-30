package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Employe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Long> {
    // Recherche par nom
    List<Employe> findByNomContainingIgnoreCase(String nom);

    // Recherche par email
    Optional<Employe> findByEmail(String email);

    // Recherche par contact
    Optional<Employe> findByContact(String contact);

    // Recherche par rôle
    @Query("SELECT e FROM Employe e WHERE e.role.idRole = :roleId")
    List<Employe> findByRoleId(@Param("roleId") Long roleId);

    // Recherche par genre
    @Query("SELECT e FROM Employe e WHERE e.genre.idGenre = :genreId")
    List<Employe> findByGenreId(@Param("genreId") Long genreId);

    //age moyen 
    @Query(
        value = "SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, date_de_naissance, CURDATE()))) FROM employe",
        nativeQuery = true
    )
    int getAgeMoyen();

    //anciennete moyenne
    @Query(
        value = "SELECT ROUND(AVG(TIMESTAMPDIFF(MONTH, date_, COALESCE(Date_Fin, CURDATE())) / 12), 1) " +
                "FROM contrat_employe",
        nativeQuery = true
    )
    Double getAncienneteMoyenne();

    //login
    @Query("select c from Employe c where c.nom= :nom and c.mdp= :mdp")
    Employe login(@Param("nom") String nom,@Param("mdp") String mdp);

   // @Query("SELECT e FROM Employe e LEFT JOIN FETCH e.contrat_employe LEFT JOIN FETCH e.contratEmploye.poste WHERE e.idEmploye = :id")
    //Optional<Employe> findByIdWithContratAndPoste(@Param("id") Long id);

//
//    @Query("SELECT e.Id_Employe, e.nom, e.id_contrat_employe , c.id_contrat_employe , c.Id_Poste\n" +
//            "FROM Employe e\n" +
//            "LEFT JOIN contrat_employe c ON e.id_contrat_employe  = c.id_contrat_employe\n" +
//            "WHERE e.Id_Employe = :id")
//    Optional<Employe> findByIdWithContrat(@Param("id") Long id);
    
}