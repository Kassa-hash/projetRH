package com.ressourcesHumaine.rh.tools;

import com.ressourcesHumaine.rh.RhApplication;
import com.ressourcesHumaine.rh.entities.DemandeAvance;
import com.ressourcesHumaine.rh.entities.Employe;
import com.ressourcesHumaine.rh.entities.Mois;
import com.ressourcesHumaine.rh.repositories.EmployeRepository;
import com.ressourcesHumaine.rh.repositories.MoisRepository;
import com.ressourcesHumaine.rh.repositories.DemandeAvanceRepository;
import com.ressourcesHumaine.rh.services.DemandeAvanceService;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;

import java.util.List;
import java.util.Optional;

public class DemoRunner {
    public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(RhApplication.class, args);

        DemandeAvanceService demandeAvanceService = ctx.getBean(DemandeAvanceService.class);
        DemandeAvanceRepository demandeAvanceRepository = ctx.getBean(DemandeAvanceRepository.class);
        EmployeRepository employeRepository = ctx.getBean(EmployeRepository.class);
        MoisRepository moisRepository = ctx.getBean(MoisRepository.class);

        // Determine employe: first arg = id (numeric) or none -> take first available
        Employe employe = null;
        if (args.length >= 1) {
            try {
                long id = Long.parseLong(args[0]);
                Optional<Employe> eopt = employeRepository.findById(id);
                if (eopt.isPresent())
                    employe = eopt.get();
            } catch (NumberFormatException ignored) {
            }
        }
        if (employe == null) {
            employe = employeRepository.findAll().stream().findFirst().orElse(null);
        }

        // Determine mois: second arg = libelle or id, else take first
        Mois mois = null;
        if (args.length >= 2) {
            String arg = args[1];
            try {
                long idm = Long.parseLong(arg);
                Optional<Mois> mopt = moisRepository.findById(idm);
                if (mopt.isPresent())
                    mois = mopt.get();
            } catch (NumberFormatException ex) {
                Optional<Mois> mopt = moisRepository.findByLibelle(arg);
                if (mopt.isPresent())
                    mois = mopt.get();
            }
        }
        if (mois == null) {
            mois = moisRepository.findAll().stream().findFirst().orElse(null);
        }

        if (employe == null) {
            System.out.println("No Employe found in the database. Please create one or pass an id as first arg.");
            SpringApplication.exit(ctx);
            return;
        }
        if (mois == null) {
            System.out.println("No Mois found in the database. Please create one or pass an id/libelle as second arg.");
            SpringApplication.exit(ctx);
            return;
        }

        System.out.println("Using employe id=" + employe.getIdEmploye() + " name='" + employe.getNom() + "'");
        System.out.println("Using mois id=" + mois.getIdMois() + " libelle='" + mois.getLibelle() + "'");

        List<DemandeAvance> avances = demandeAvanceService.getAvancesValideesByEmployeAndMois(employe, mois);

        System.out.println("Found " + (avances == null ? 0 : avances.size()) + " validated avances:");
        if (avances != null) {
            for (DemandeAvance d : avances) {
                System.out.println("- id=" + d.getIdDemandeAvance() + " date=" + d.getDate() + " montant="
                        + d.getMontant() + " status=" + d.getStatus());
            }
        }

        // Also call repository directly and print raw values for debugging
        List<DemandeAvance> avancesRepo = demandeAvanceRepository.findAvanceValideeByEmployeAndMois(employe, mois);
        System.out.println(
                "[Repository] Found " + (avancesRepo == null ? 0 : avancesRepo.size()) + " validated avances (raw):");
        if (avancesRepo != null) {
            for (DemandeAvance d : avancesRepo) {
                System.out.println("[Repository] - id=" + d.getIdDemandeAvance() + " montant=" + d.getMontant()
                        + " status='" + d.getStatus() + "' employeId="
                        + (d.getEmploye() != null ? d.getEmploye().getIdEmploye() : "null") + " moisId="
                        + (d.getMois() != null ? d.getMois().getIdMois() : "null"));
            }
        }

        SpringApplication.exit(ctx);
    }
}
