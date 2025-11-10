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
}