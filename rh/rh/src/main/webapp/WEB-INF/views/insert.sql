-- Insérer d'abord les rôles et genres si nécessaire
INSERT INTO Role (Id_Role) VALUES
('1'),
('2'),
('3');



INSERT INTO Genre (libelle) VALUES
('Masculin'),
('Féminin');

-- Puis insérer les employés
INSERT INTO Employe (nom, date_de_naissance, contact, email, photo, adresse, Id_Role, Id_Genre) VALUES
('Dupont', '1985-03-15', '+33 1 23 45 67 89', 'jean.dupont@entreprise.com', 'jean_dupont.jpg', '123 Avenue des Champs, 75008 Paris', 1, 1),
('Martin', '1990-07-22', '+33 1 34 56 78 90', 'marie.martin@entreprise.com', 'marie_martin.jpg', '45 Rue de la République, 69001 Lyon', 2, 2),
('Bernard', '1988-11-05', '+33 2 98 76 54 32', 'pierre.bernard@entreprise.com', 'pierre_bernard.jpg', '78 Boulevard Voltaire, 33000 Bordeaux', 1, 1),
('Dubois', '1992-04-18', '+33 3 21 43 65 87', 'sophie.dubois@entreprise.com', 'sophie_dubois.jpg', '12 Rue du Commerce, 31000 Toulouse', 3, 2),
('Moreau', '1983-09-30', '+33 4 56 78 90 12', 'alain.moreau@entreprise.com', 'alain_moreau.jpg', '56 Avenue Foch, 59000 Lille', 2, 1);

INSERT INTO Mois (libelle) VALUES
('Janvier'),
('Février'),
('Mars'),
('Avril'),
('Mai'),
('Juin'),
('Juillet'),
('Août'),
('Septembre'),
('Octobre'),
('Novembre'),
('Décembre');
