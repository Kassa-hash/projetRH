-- Insérer d'abord les rôles et genres si nécessaire
INSERT INTO Role (Id_Role,libelle) VALUES
('1',"Cadre"),
('2',"Cadre superieur"),
('3',"Non cadre");

INSERT INTO Genre (libelle) VALUES
('Masculin'),
('Féminin');

-- Puis insérer les employés
INSERT INTO Employe (nom, date_de_naissance, contact, email, photo, adresse, Id_Role, Id_Genre,Mdp) VALUES
('Dupont', '1985-03-15', '+33 1 23 45 67 89', 'jean.dupont@entreprise.com', 'jean_dupont.jpg', '123 Avenue des Champs, 75008 Paris', 1, 1,"mdp"),
('Martin', '1990-07-22', '+33 1 34 56 78 90', 'marie.martin@entreprise.com', 'marie_martin.jpg', '45 Rue de la République, 69001 Lyon', 2, 2,"mdp"),
('Bernard', '1988-11-05', '+33 2 98 76 54 32', 'pierre.bernard@entreprise.com', 'pierre_bernard.jpg', '78 Boulevard Voltaire, 33000 Bordeaux', 1, 1,"mdp"),
('Dubois', '1992-04-18', '+33 3 21 43 65 87', 'sophie.dubois@entreprise.com', 'sophie_dubois.jpg', '12 Rue du Commerce, 31000 Toulouse', 3, 2,"mdp"),
('Moreau', '1983-09-30', '+33 4 56 78 90 12', 'alain.moreau@entreprise.com', 'alain_moreau.jpg', '56 Avenue Foch, 59000 Lille', 2, 1,"mdp");

--insertion des types de contrat
insert into type_contrat(libelle) values ('CDD');
insert into type_contrat(libelle) values ('CDI');
insert into type_contrat(libelle) values ('Stage');
insert into type_contrat(libelle) values ('Alternance');

--insertion dans contrat employe 
--CDI Pour Dupont 
insert into contrat_employe (date_,id_employe,id_type_contrat,date_fin,duree) 
values ('2023-10-01',1,2,null,null);

--CDD Pour Martin (6 mois)
insert into contrat_employe (date_,id_employe,id_type_contrat,date_fin,duree) 
values ('2025-06-11',2,1,null,6);

--Stage de 3 mois pour Bernard
insert into contrat_employe (date_,id_employe,id_type_contrat,date_fin,duree) 
values ('2025-09-05',3,3,null,3);

--CDI Dubois
insert into contrat_employe (date_,id_employe,id_type_contrat,date_fin,duree) 
values ('2025-09-17',4,1,'2025-09-28',null);

--insert dans motif
insert into motif(libelle) 
values ("Vacances"),
("Rendez-vous veterinaire"),
("Rendez-vous pediatre");

--insert dans mois
INSERT INTO mois (libelle) VALUES
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

--insert dans demande conge (en attente,acceptee,refusee)
insert into demande_conge (date_debut,date_fin,id_employe,id_motif,status)
values ('2025-10-10','2025-10-12',3,3,'en attente');

insert into demande_conge (date_debut,date_fin,id_employe,id_motif,status)
values ('2025-10-10','2025-10-12',3,3,'acceptee');

--insert dans demande avance
insert into demande_avance (date_,montant,id_employe,id_mois,status)
values ('2025-11-10',100000,3,12,'en attente');

--insert dans poste
insert into poste(libelle,salaire_de_base) 
values ("Developpeur fullstack",2000000);

insert into poste(libelle,salaire_de_base) 
values ("Testeur",1000000);

--solde de conge
--conge de bernard
insert into conge_solde (annee,nb_jour,id_employe)
values (2025,30,3);

--select pour avoir les employes du moment
--employes avec CDI du moment
select id_employe 
from contrat_employe
where date_fin is null
and duree is null;

--employes du moment OK
select id_employe
from contrat_employe 
where date_ <= NOW()
and date_fin is null; 

--nb d'employes d'un mois avant 
select count(*)
from contrat_employe 
where date_ <=




