package com.ressourcesHumaine.rh.services;

import com.ressourcesHumaine.rh.entities.ContratEmploye;
import com.ressourcesHumaine.rh.repositories.ContratEmployeRepository;

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
public class ContratEmployeService {

    @Autowired
    private ContratEmployeRepository contratemployeRepository;

    //contrats actuels
    List<ContratEmploye> contratsActuels() {
        List<ContratEmploye> contrats = contratemployeRepository.contratsActuels();
        return contrats;
    }

    private LocalDate toLocalDate(java.util.Date date) {
        if (date == null) {
            return null;
        }
        if (date instanceof java.sql.Date) {
            return ((java.sql.Date) date).toLocalDate();
        }
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    public List<Map<String, Object>> getEvolutionEffectif(String periode) {
        List<ContratEmploye> contrats = contratemployeRepository.findAll();
        LocalDate aujourdHui = LocalDate.now();

        LocalDate debutPeriode = switch (periode) {
            case "6mois" ->
                aujourdHui.minusMonths(6).withDayOfMonth(1);
            case "12mois" ->
                aujourdHui.minusMonths(12).withDayOfMonth(1);
            case "annee" ->
                LocalDate.of(aujourdHui.getYear(), 1, 1);
            default ->
                aujourdHui.minusMonths(6).withDayOfMonth(1);
        };

        // 1. Créer tous les mois de la période
        Map<YearMonth, Set<Long>> employesParMois = new TreeMap<>();
        YearMonth moisCourant = YearMonth.from(debutPeriode);
        YearMonth moisAujourdhui = YearMonth.from(aujourdHui);

        while (!moisCourant.isAfter(moisAujourdhui)) {
            employesParMois.put(moisCourant, new HashSet<>());
            moisCourant = moisCourant.plusMonths(1);
        }

        for (ContratEmploye c : contrats) {
            if (c.getDate() == null || c.getEmploye() == null || c.getEmploye().getIdEmploye() == null) {
                continue;
            }

            LocalDate dateDebut = toLocalDate(c.getDate());
            LocalDate dateFin = toLocalDate(c.getDateFin());

            // Pour chaque mois de la période
            for (YearMonth mois : employesParMois.keySet()) {
                LocalDate debutMois = mois.atDay(1);
                LocalDate finMois = mois.atEndOfMonth();

                boolean actifCeMois = !dateDebut.isAfter(finMois)
                        && (dateFin == null || !dateFin.isBefore(debutMois));

                if (actifCeMois) {
                    employesParMois.get(mois).add(c.getEmploye().getIdEmploye());
                }
            }
        }

        // 3. Construire le résultat
        List<Map<String, Object>> resultat = new ArrayList<>();
        for (YearMonth ym : employesParMois.keySet()) {
            Map<String, Object> point = new HashMap<>();
            point.put("mois", ym.format(DateTimeFormatter.ofPattern("MMM yyyy", Locale.FRENCH)));
            point.put("effectif", employesParMois.get(ym).size());

            resultat.add(point);
        }

        return resultat;
    }

    public int effectifLastMonth() {
        return this.contratemployeRepository.getEffectifMoisDernier();
    }

    public int effectifNow() {
        return this.contratemployeRepository.getEffectifActuel();
    }

    public String getVariationPourcentage() {
        int last = effectifLastMonth();
        int now = effectifNow();

        if (last == 0) {
            return now == 0 ? "0%" : "+100%"; // si 0 → tout le monde est arrivé ce mois-ci
        }

        double variation = ((double) (now - last) / last) * 100;
        String signe = variation > 0 ? "+" : "";
        return String.format("%s%.0f%%", signe, variation);
    }

    // Bonus : pour afficher une flèche haut/bas dans la vue
    public String getVariationClasseCss() {
        int diff = effectifNow() - effectifLastMonth();
        if (diff > 0) {
            return "text-success";   // vert

        }
        if (diff < 0) {
            return "text-danger";    // rouge

        }
        return "text-muted";                   // gris
    }
}
