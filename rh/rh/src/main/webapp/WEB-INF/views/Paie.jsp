<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Employe" %>
<%@ page import="com.ressourcesHumaine.rh.entities.ContratEmploye" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Departement" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Poste" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système de Gestion de Paie</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* [Vos styles CSS restent exactement les mêmes] */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2d5016 0%, #1a1a1a 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1800px;
            margin: 0 auto;
            background: #f5f5f5;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        header {
            background: linear-gradient(135deg, #4a7c2c 0%, #2d5016 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .tabs {
            display: flex;
            background: #e8e8e8;
            border-bottom: 3px solid #4a7c2c;
        }

        .tab {
            flex: 1;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1em;
            transition: all 0.3s;
            border-bottom: 4px solid transparent;
        }

        .tab:hover {
            background: #d8d8d8;
        }

        .tab.active {
            background: white;
            color: #4a7c2c;
            border-bottom-color: #4a7c2c;
        }

        .controls {
            padding: 25px 30px;
            background: #e8e8e8;
            border-bottom: 2px solid #4a7c2c;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .filter-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            flex: 1;
        }

        .filter-group input,
        .filter-group select {
            padding: 12px 20px;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
            min-width: 200px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(74, 124, 44, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(74, 124, 44, 0.4);
        }

        .content {
            padding: 30px;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Styles pour les tableaux */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1600px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
            white-space: nowrap;
        }

        th {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .text-center {
            text-align: center;
        }

        .text-right {
            text-align: right;
        }

        .btn-action {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            margin: 2px;
            font-size: 0.85em;
        }

        .btn-view {
            background: #17a2b8;
            color: white;
        }

        .btn-view:hover {
            background: #138496;
        }

        .btn-pdf {
            background: #dc3545;
            color: white;
        }

        .btn-pdf:hover {
            background: #c82333;
        }

        .btn-edit {
            background: #28a745;
            color: white;
        }

        .btn-edit:hover {
            background: #218838;
        }

        .actions-column {
            width: 150px;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            font-size: 1.5em;
        }

        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 2em;
            cursor: pointer;
            line-height: 1;
        }

        .modal-body {
            padding: 30px;
        }

        .detail-section {
            margin-bottom: 25px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .detail-section h3 {
            color: #4a7c2c;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4a7c2c;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
        }

        .detail-value {
            font-weight: 600;
            color: #333;
        }

        .total-section {
            background: #e8f5e8;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .total-item {
            display: flex;
            justify-content: space-between;
            font-size: 1.2em;
            font-weight: bold;
            padding: 10px 0;
        }

        .net-payer {
            color: #2d5016;
            font-size: 1.4em;
            border-top: 2px solid #4a7c2c;
            padding-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1><i class="fas fa-money-check-alt"></i> Système de Gestion de Paie</h1>
            <p>Gestion complète des paiements et des bulletins de salaire</p>
        </header>

        <div class="tabs">
            <div class="tab active" data-tab="payroll">Bulletins de Paie</div>
        </div>

        <div class="controls">
            <div class="filter-group">
                <select id="filterMonth">
                    <option value="">Tous les mois</option>
                    <option value="1">Janvier</option>
                    <option value="2">Février</option>
                    <option value="3">Mars</option>
                    <option value="4">Avril</option>
                    <option value="5">Mai</option>
                    <option value="6">Juin</option>
                    <option value="7">Juillet</option>
                    <option value="8">Août</option>
                    <option value="9">Septembre</option>
                    <option value="10">Octobre</option>
                    <option value="11">Novembre</option>
                    <option value="12">Décembre</option>
                </select>
                <select id="filterYear">
                    <option value="">Toutes les années</option>
                    <option value="2023">2023</option>
                    <option value="2024">2024</option>
                </select>
                <select id="filterDepartment">
                    <option value="">Tous les départements</option>
                    <option value="IT">IT</option>
                    <option value="Finance">Finance</option>
                    <option value="RH">Ressources Humaines</option>
                    <option value="Marketing">Marketing</option>
                </select>
            </div>
            <button class="btn btn-primary" id="addPaymentBtn">
                <i class="fas fa-plus"></i> Ajouter Paiement
            </button>
        </div>

        <div class="content">
            <!-- Section des bulletins de paie -->
            <div class="tab-content active" id="payroll">
                <h2>Bulletins de Paie</h2>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Date d'embauche</th>
                                <th>Poste</th>
                                <th>Département</th>
                                <th>Salaire de Base</th>
                                <th>Heures Supp</th>
                                <th>Salaire Brut</th>
                                <th>CNAPS 1%</th>
                                <th>CNAPS 8%</th>
                                <th>OSTIE 1%</th>
                                <th>OSTIE 5%</th>
                                <th>Revenu Imposable</th>
                                <th>IRSA</th>
                                <th>Salaire Net</th>
                                <th>Avance</th>
                                <th>Net à Payer</th>
                                <th class="actions-column">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Employe> employes = (List<Employe>) request.getAttribute("employes");
                                if (employes != null && !employes.isEmpty()) {
                                    int index = 0;
                                    for (Employe employe : employes) {
                                        // Vérification de sécurité pour éviter les ID null ou 0
                                        if (employe.getIdEmploye() == null || employe.getIdEmploye() <= 0) {
                                            continue; // Skip les employés avec ID invalide
                                        }

                                        // Récupération des informations du contrat et département
                                        ContratEmploye contrat = employe.getContratEmploye();
                                        Departement dept = employe.getDepartement();

                                        // Valeurs par défaut pour les nouveaux employés sans contrat
                                        BigDecimal salaireBase = BigDecimal.ZERO;
                                        int heuresSupp = 0;
                                        String dateEmbauche = "N/A";
                                        String poste = "N/A";
                                        String nomDepartement = "N/A";

                                        // Gestion du nom de l'employé
                                        String nomEmploye = (employe.getNom() != null && !employe.getNom().trim().isEmpty())
                                            ? employe.getNom()
                                            : "Employé " + employe.getIdEmploye();

                                        // Gestion du département
                                        if (dept != null && dept.getNom() != null) {
                                            nomDepartement = dept.getNom();
                                        }

                                        if (contrat != null) {
                                            // Récupération de la date d'embauche
                                            if (contrat.getDate() != null) {
                                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                dateEmbauche = sdf.format(contrat.getDate());
                                            }

                                            // Récupération du poste
                                            if (contrat.getPoste() != null && contrat.getPoste().getSalaireDeBase() != null) {
                                                poste = contrat.getPoste().getLibelle();
                                                salaireBase = contrat.getPoste().getSalaireDeBase();
                                            }
                                        }

                                        // Calculs de paie avec BigDecimal
                                        BigDecimal heuresParMois = new BigDecimal("173.33");
                                        BigDecimal tauxMajoration = new BigDecimal("1.5");

                                        // Taux horaire normal = salaireBase / 173.33
                                        BigDecimal tauxHoraireNormal = salaireBase.divide(heuresParMois, 2, RoundingMode.HALF_UP);

                                        // Taux horaire supplémentaire = taux horaire normal * 1.5
                                        BigDecimal tauxHoraireSupp = tauxHoraireNormal.multiply(tauxMajoration);

                                        // Majoration heures supplémentaires
                                        BigDecimal majorationHeuresSupp = tauxHoraireSupp.multiply(new BigDecimal(heuresSupp));

                                        // Salaire brut = salaire de base + majoration heures supp
                                        BigDecimal salaireBrut = salaireBase.add(majorationHeuresSupp);

                                        // Calcul des cotisations
                                        BigDecimal cnaps1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal cnaps8 = salaireBrut.multiply(new BigDecimal("0.08")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal ostie1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal ostie5 = salaireBrut.multiply(new BigDecimal("0.05")).setScale(0, RoundingMode.HALF_UP);

                                        // Revenu imposable = salaire brut - cnaps1 - ostie1
                                        BigDecimal revenuImposable = salaireBrut.subtract(cnaps1).subtract(ostie1);

                                        // Calcul IRSA progressif avec BigDecimal
                                        BigDecimal irsa = BigDecimal.ZERO;
                                        BigDecimal seuil1 = new BigDecimal("350000");
                                        BigDecimal seuil2 = new BigDecimal("650000");
                                        BigDecimal seuil3 = new BigDecimal("1000000");
                                        BigDecimal seuil4 = new BigDecimal("1500000");

                                        if (revenuImposable.compareTo(seuil1) > 0) {
                                            BigDecimal tranche1 = revenuImposable.subtract(seuil1);
                                            if (tranche1.compareTo(new BigDecimal("300000")) > 0) {
                                                tranche1 = new BigDecimal("300000");
                                            }
                                            irsa = irsa.add(tranche1.multiply(new BigDecimal("0.05")));
                                        }

                                        if (revenuImposable.compareTo(seuil2) > 0) {
                                            BigDecimal tranche2 = revenuImposable.subtract(seuil2);
                                            if (tranche2.compareTo(new BigDecimal("350000")) > 0) {
                                                tranche2 = new BigDecimal("350000");
                                            }
                                            irsa = irsa.add(tranche2.multiply(new BigDecimal("0.10")));
                                        }

                                        if (revenuImposable.compareTo(seuil3) > 0) {
                                            BigDecimal tranche3 = revenuImposable.subtract(seuil3);
                                            if (tranche3.compareTo(new BigDecimal("500000")) > 0) {
                                                tranche3 = new BigDecimal("500000");
                                            }
                                            irsa = irsa.add(tranche3.multiply(new BigDecimal("0.15")));
                                        }

                                        if (revenuImposable.compareTo(seuil4) > 0) {
                                            BigDecimal tranche4 = revenuImposable.subtract(seuil4);
                                            irsa = irsa.add(tranche4.multiply(new BigDecimal("0.20")));
                                        }

                                        irsa = irsa.setScale(0, RoundingMode.HALF_UP);

                                        // Salaire net = salaire brut - cnaps8 - ostie5 - irsa
                                        BigDecimal salaireNet = salaireBrut.subtract(cnaps8).subtract(ostie5).subtract(irsa);

                                        // Avance conditionnelle
                                        BigDecimal avance = BigDecimal.ZERO;
                                        if (salaireNet.compareTo(new BigDecimal("200000")) > 0) {
                                            avance = new BigDecimal("50000");
                                        }

                                        // Net à payer = salaire net - avance
                                        BigDecimal netAPayer = salaireNet.subtract(avance);

                                        index++;
                            %>
                            <tr>
                                <td><%= nomEmploye %></td>
                                <td><%= dateEmbauche %></td>
                                <td><%= poste %></td>
                                <td><%= nomDepartement %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", salaireBase) %></td>
                                <td class="text-right"><%= heuresSupp %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", salaireBrut) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", cnaps1) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", cnaps8) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", ostie1) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", ostie5) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", revenuImposable) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", irsa) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", salaireNet) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", avance) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", netAPayer) %></td>
                                <td class="text-center">
                                    <button class="btn-action btn-view" onclick="afficherDetails(<%= employe.getIdEmploye() %>)">
                                        <i class="fas fa-eye"></i> Détails
                                    </button>
                                    <button class="btn-action btn-pdf" onclick="genererPDF(<%= employe.getIdEmploye() %>)">
                                        <i class="fas fa-file-pdf"></i> PDF
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="17" class="text-center">Aucun employé trouvé</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal pour les détails de paie -->
    <div class="modal" id="detailsModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-file-invoice-dollar"></i> Détails du Bulletin de Paie</h2>
                <button class="close-btn" onclick="fermerModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div id="detailsContent">
                    <!-- Le contenu des détails sera injecté ici par JavaScript -->
                </div>
            </div>
        </div>
    </div>

    <script>
        // Fonction pour formater les montants
        function formaterMontant(montant) {
            return new Intl.NumberFormat('fr-FR').format(montant) + ' Ar';
        }

        // Fonction pour afficher les détails
        function afficherDetails(employeId) {
            // Pour l'instant, on utilise des données statiques
            const detailsContent = document.getElementById('detailsContent');

            detailsContent.innerHTML = `
                <div class="detail-section">
                    <h3>Informations Employé</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">ID Employé:</span>
                            <span class="detail-value">${employeId}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Nom:</span>
                            <span class="detail-value">Chargement...</span>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <p>Les détails complets seront chargés via une requête AJAX</p>
                    <button class="btn btn-primary" onclick="chargerDetailsComplets(${employeId})">
                        Charger les détails complets
                    </button>
                </div>
            `;

            document.getElementById('detailsModal').classList.add('active');
        }

        // Fonction pour charger les détails complets (à implémenter)
        function chargerDetailsComplets(employeId) {
            alert(`Chargement des détails pour l'employé ${employeId}\n\nÀ implémenter avec une requête AJAX vers le serveur.`);
        }

        // Fonction pour générer PDF (simulation)
        function genererPDF(employeId) {
            alert(`Génération du PDF pour l'employé ${employeId}\n\nCette fonctionnalité sera implémentée avec une bibliothèque PDF comme jsPDF.`);
        }

        // Fonction pour fermer le modal
        function fermerModal() {
            document.getElementById('detailsModal').classList.remove('active');
        }

        // Gestion des événements
        document.addEventListener('DOMContentLoaded', function() {
            // Gestion des onglets principaux
            document.querySelectorAll('.tab').forEach(tab => {
                tab.addEventListener('click', () => {
                    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                    tab.classList.add('active');
                    const tabId = tab.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });

            // Bouton ajouter paiement
            document.getElementById('addPaymentBtn').addEventListener('click', function() {
                alert('Fonctionnalité d\'ajout de paiement à implémenter');
            });

            // Fermer le modal en cliquant en dehors
            document.getElementById('detailsModal').addEventListener('click', function(e) {
                if (e.target === this) {
                    fermerModal();
                }
            });
        });
    </script>
</body>
</html>