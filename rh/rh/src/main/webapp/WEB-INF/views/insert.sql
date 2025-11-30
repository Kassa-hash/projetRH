-- =========================================
-- INSERTION DES DONNÉES DE BASE
-- =========================================

-- Rôle
INSERT INTO Role (Id_Role, libelle) VALUES
(1, 'Cadre'),
(2, 'Cadre superieur'),
(3, 'Non cadre');

-- Genre
INSERT INTO Genre (libelle) VALUES
('Masculin'),
('Féminin');

-- Employés
INSERT INTO Employe (nom, date_de_naissance, contact, email, photo, adresse, Id_Role, Id_Genre, Mdp) VALUES
('Dupont', '1985-03-15', '+33 1 23 45 67 89', 'jean.dupont@entreprise.com', 'jean_dupont.jpg', '123 Avenue des Champs, 75008 Paris', 1, 1, 'mdp'),
('Martin', '1990-07-22', '+33 1 34 56 78 90', 'marie.martin@entreprise.com', 'marie_martin.jpg', '45 Rue de la République, 69001 Lyon', 2, 2, 'mdp'),
('Bernard', '1988-11-05', '+33 2 98 76 54 32', 'pierre.bernard@entreprise.com', 'pierre_bernard.jpg', '78 Boulevard Voltaire, 33000 Bordeaux', 1, 1, 'mdp'),
('Dubois', '1992-04-18', '+33 3 21 43 65 87', 'sophie.dubois@entreprise.com', 'sophie_dubois.jpg', '12 Rue du Commerce, 31000 Toulouse', 3, 2, 'mdp'),
('Moreau', '1983-09-30', '+33 4 56 78 90 12', 'alain.moreau@entreprise.com', 'alain_moreau.jpg', '56 Avenue Foch, 59000 Lille', 2, 1, 'mdp');

-- Type contrat
INSERT INTO type_contrat (libelle) VALUES 
('CDD'),
('CDI'),
('Stage'),
('Alternance');

-- =========================================
-- CONTRATS EMPLOYES
-- =========================================

-- CDI pour Dupont (Employee 1)
INSERT INTO contrat_employe (date_, id_employe, id_type_contrat, date_fin, duree)
VALUES ('2023-10-01', 1, 2, NULL, NULL);

-- CDD pour Martin (6 mois)
INSERT INTO contrat_employe (date_, id_employe, id_type_contrat, date_fin, duree)
VALUES ('2025-06-11', 2, 1, NULL, 6);

-- Stage de 3 mois pour Bernard
INSERT INTO contrat_employe (date_, id_employe, id_type_contrat, date_fin, duree)
VALUES ('2025-09-05', 3, 3, NULL, 3);

-- CDI pour Dubois (corrigé : id_type_contrat=2)
INSERT INTO contrat_employe (date_, id_employe, id_type_contrat, date_fin, duree)
VALUES ('2025-09-17', 4, 2, NULL, NULL);

-- =========================================
-- AUTRES TABLES
-- =========================================

-- Motifs
INSERT INTO motif (libelle) VALUES
('Vacances'),
('Rendez-vous veterinaire'),
('Rendez-vous pediatre');

-- Mois
INSERT INTO mois (libelle) VALUES
('Janvier'),('Février'),('Mars'),('Avril'),('Mai'),('Juin'),
('Juillet'),('Août'),('Septembre'),('Octobre'),('Novembre'),('Décembre');

-- Demandes de congé
INSERT INTO demande_conge (date_debut, date_fin, id_employe, id_motif, status) VALUES
('2025-10-10', '2025-10-12', 3, 3, 'en attente'),
('2025-10-10', '2025-10-12', 3, 3, 'acceptee');

-- Demandes d'avance
INSERT INTO demande_avance (date_, montant, id_employe, id_mois, status)
VALUES ('2025-11-10', 100000, 3, 12, 'en attente');

-- Postes
INSERT INTO poste (libelle, salaire_de_base) VALUES
('Developpeur fullstack', 2000000),
('Testeur', 1000000);

-- Solde de congé
INSERT INTO conge_solde (annee, nb_jour, id_employe)
VALUES (2025, 30, 3);


SELECT e.Id_Employe, e.nom, e.id_contrat_employe , c.id_contrat_employe , c.Id_Poste
FROM Employe e
LEFT JOIN contrat_employe c ON e.id_contrat_employe  = c.id_contrat_employe
WHERE e.Id_Employe = 6;