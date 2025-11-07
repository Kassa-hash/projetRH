package com.ressourcesHumaine.rh.repositories;

import com.ressourcesHumaine.rh.entities.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long> {
}