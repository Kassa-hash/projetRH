package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.Genre;
import com.ressourcesHumaine.rh.repositories.GenreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class GenreService {

    @Autowired
    private GenreRepository genreRepository;

    public List<Genre> getAllGenres() {
        return genreRepository.findAll();
    }

    public Optional<Genre> getGenreById(Long id) {
        return genreRepository.findById(id);
    }

    public Genre saveGenre(Genre genre) {
        return genreRepository.save(genre);
    }

    public void deleteGenre(Long id) {
        genreRepository.deleteById(id);
    }
}