-- =========================================
-- INSERTION DES DONNÉES DE BASE
-- =========================================

-- Rôle
INSERT INTO Role (Id_Role, libelle) VALUES
(1, 'Cadre'),
(2, 'Cadre superieur'),
(3, 'Non cadre');

-- Départements
INSERT INTO departement (id_departement, nom) VALUES
(1, 'Ressources Humaines'),
(2, 'Informatique'),
(3, 'Comptabilité'),
(4, 'Marketing'),
(5, 'Logistique');

-- Genre
INSERT INTO Genre (id_genre, libelle) VALUES
(1, 'Masculin'),
(2, 'Féminin');

-- Type contrat
INSERT INTO type_contrat (id_type_contrat, libelle) VALUES
(1, 'CDD'),
(2, 'CDI'),
(3, 'Stage'),
(4, 'Alternance');

-- Postes
INSERT INTO poste (id_poste, libelle, salaire_de_base) VALUES
(1, 'Developpeur fullstack', 2000000),
(2, 'Responsable RH', 1500000),
(3, 'Comptable', 1200000),
(4, 'Chargé de communication', 1300000),
(5, 'Responsable logistique', 1400000);

-- =========================================
-- INSERTION DES EMPLOYÉS
-- =========================================

INSERT INTO employe (id_employe, adresse, contact, date_de_naissance, email, mdp, nom, photo, id_departement, id_genre, id_role) VALUES
-- 1. Employé Informatique
(1, 'Lot II A 12 Andavamamba', '+261340123456', '1996-02-18', 'hery.rakoto@example.com', 'hery123', 'Rakoto Hery', 'hery.jpg', 2, 1, 2),

-- 2. Employée RH
(2, 'Lot I T 33 Anjanahary', '+261330987654', '1994-10-05', 'noro.rasoa@example.com', 'noro123', 'Rasoa Noro', 'noro.png', 1, 2, 3),

-- 3. Employé Finance
(3, 'Ambodivona Immeuble B', '+261320556677', '1989-07-20', 'tiana.rabeson@example.com', 'tiana456', 'Rabeson Tiana', 'tiana.jpg', 3, 1, 2),

-- 4. Employée Communication
(4, 'Ivandry Résidence C', '+261343344556', '1997-12-11', 'sarah.ravel@example.com', 'sarah789', 'Ravel Sarah', 'sarah.png', 4, 2, 2),

-- 5. Employé Logistique
(5, 'Ambohibao Lot 12B', '+261320998877', '1990-04-28', 'patrick.andry@example.com', 'pato111', 'Andry Patrick', 'patrick.jpg', 5, 1, 2);

-- =========================================
-- INSERTION DES CONTRATS
-- =========================================

INSERT INTO contrat_employe (id_contrat_employe, date_, date_fin, duree, id_employe, id_poste, id_type_contrat) VALUES
-- 1. Rakoto Hery – Informatique – Développeur – CDI
(1, '2024-01-10', NULL, NULL, 1, 1, 2),

-- 2. Rasoa Noro – RH – Responsable RH – CDI
(2, '2023-09-01', NULL, NULL, 2, 2, 2),

-- 3. Rabeson Tiana – Finance – Comptable – CDD 12 mois
(3, '2024-03-01', '2025-03-01', 12, 3, 3, 1),

-- 4. Ravel Sarah – Communication – CDD 6 mois
(4, '2024-08-15', '2025-02-15', 6, 4, 4, 1),

-- 5. Andry Patrick – Logistique – CDD 12 mois
(5, '2024-04-01', '2025-04-01', 12, 5, 5, 1);

-- =========================================
-- MISE À JOUR DES EMPLOYÉS AVEC LEUR CONTRAT
-- =========================================

UPDATE employe SET id_contrat_employe = 1 WHERE id_employe = 1;
UPDATE employe SET id_contrat_employe = 2 WHERE id_employe = 2;
UPDATE employe SET id_contrat_employe = 3 WHERE id_employe = 3;
UPDATE employe SET id_contrat_employe = 4 WHERE id_employe = 4;
UPDATE employe SET id_contrat_employe = 5 WHERE id_employe = 5;

-- =========================================
-- INSERTION DES AUTRES DONNÉES
-- =========================================

-- Motifs
INSERT INTO motif (id_motif, libelle) VALUES
(1, 'Vacances'),
(2, 'Rendez-vous veterinaire'),
(3, 'Rendez-vous pediatre');

-- Mois
INSERT INTO mois (id_mois, libelle) VALUES
(1, 'Janvier'), (2, 'Février'), (3, 'Mars'), (4, 'Avril'), (5, 'Mai'), (6, 'Juin'),
(7, 'Juillet'), (8, 'Août'), (9, 'Septembre'), (10, 'Octobre'), (11, 'Novembre'), (12, 'Décembre');

-- Demandes de congé
INSERT INTO demande_conge (id_demande_conge, date_debut, date_fin, id_employe, id_motif, status) VALUES
(1, '2025-10-10', '2025-10-12', 3, 3, 'en attente'),
(2, '2025-10-10', '2025-10-12', 3, 3, 'acceptee');

-- Demandes d'avance
INSERT INTO demande_avance (id_demande_avance, date_, montant, id_employe, id_mois, status) VALUES
(1, '2025-11-10', 100000, 3, 12, 'en attente');

-- Solde de congé
INSERT INTO conge_solde (id_conge_solde, annee, nb_jour, id_employe) VALUES
(1, 2025, 30, 3);

-- =========================================
-- VÉRIFICATION DES DONNÉES INSÉRÉES
-- =========================================

-- Afficher le nombre d'enregistrements par table
SELECT 'Role' as table_name, COUNT(*) as count FROM Role
UNION ALL SELECT 'departement', COUNT(*) FROM departement
UNION ALL SELECT 'Genre', COUNT(*) FROM Genre
UNION ALL SELECT 'type_contrat', COUNT(*) FROM type_contrat
UNION ALL SELECT 'poste', COUNT(*) FROM poste
UNION ALL SELECT 'employe', COUNT(*) FROM employe
UNION ALL SELECT 'contrat_employe', COUNT(*) FROM contrat_employe
UNION ALL SELECT 'motif', COUNT(*) FROM motif
UNION ALL SELECT 'mois', COUNT(*) FROM mois
UNION ALL SELECT 'demande_conge', COUNT(*) FROM demande_conge
UNION ALL SELECT 'demande_avance', COUNT(*) FROM demande_avance
UNION ALL SELECT 'conge_solde', COUNT(*) FROM conge_solde;