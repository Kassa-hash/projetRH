<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Employe" %>
<%@ page import="com.ressourcesHumaine.rh.entities.ContratEmploye" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Departement" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Poste" %>
<%@ page import="com.ressourcesHumaine.rh.services.HeureSuppService" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système de Gestion de Paie</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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

        .filter-group select:focus {
            outline: none;
            border-color: #2d5016;
            box-shadow: 0 0 8px rgba(74, 124, 44, 0.3);
        }

        .period-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            background: white;
            padding: 10px 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .period-selector label {
            font-weight: 600;
            color: #4a7c2c;
            white-space: nowrap;
        }

        .period-selector select {
            min-width: 150px;
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

        .btn-filter {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .btn-filter:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
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

        .info-banner {
            background: #d4edda;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-banner i {
            font-size: 1.5em;
            color: #4a7c2c;
        }

        .info-banner strong {
            color: #2d5016;
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
            max-width: 1000px;
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

        /* Styles pour la fiche de paie */
        .payroll-sheet {
            font-family: Arial, sans-serif;
            color: #333;
        }

        .company-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #4a7c2c;
        }

        .company-logo {
            text-align: center;
        }

        .logo-placeholder {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #4a7c2c 0%, #2d5016 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2em;
            font-weight: bold;
            margin: 0 auto 10px;
        }

        .company-info h2 {
            color: #2d5016;
            margin-bottom: 5px;
            font-size: 1.8em;
        }

        .company-info p {
            margin: 3px 0;
            color: #666;
        }

        .document-title {
            text-align: center;
            margin: 25px 0;
        }

        .document-title h1 {
            color: #2d5016;
            font-size: 2em;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .document-title .period {
            font-size: 1.2em;
            color: #4a7c2c;
            font-weight: bold;
        }

        .employee-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 5px solid #4a7c2c;
        }

        .employee-info h3 {
            color: #2d5016;
            margin-bottom: 15px;
            font-size: 1.3em;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #ddd;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            font-weight: bold;
            color: #333;
        }

        .payroll-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .payroll-table th {
            background: #4a7c2c;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .payroll-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .payroll-table tr:hover {
            background-color: #f8f9fa;
        }

        .amount {
            text-align: right;
            font-weight: bold;
            font-family: 'Courier New', monospace;
        }

        .section-title {
            color: #2d5016;
            margin: 25px 0 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4a7c2c;
            font-size: 1.4em;
        }

        .totals-section {
            background: #e8f5e8;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            font-size: 1.1em;
            border-bottom: 1px solid #d4edda;
        }

        .total-row:last-child {
            border-bottom: none;
        }

        .net-payable {
            font-size: 1.3em;
            font-weight: bold;
            color: #2d5016;
            margin-top: 10px;
            padding-top: 15px;
            border-top: 2px solid #4a7c2c;
        }

        .legal-mentions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
            font-size: 0.9em;
            color: #666;
            text-align: center;
        }

        .payroll-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #4a7c2c;
        }

        .signature {
            text-align: center;
            width: 45%;
        }

        .signature-line {
            border-top: 1px solid #333;
            width: 80%;
            margin: 40px auto 10px;
        }

        .payroll-meta {
            font-size: 0.9em;
            color: #666;
            margin-top: 20px;
            text-align: center;
        }

        .print-btn {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        .print-btn:hover {
            background: linear-gradient(135deg, #3a6c1c 0%, #4a8c2c 100%);
        }

        @media print {
            .modal-content {
                width: 100%;
                max-width: 100%;
                box-shadow: none;
                border-radius: 0;
            }

            .modal-header,
            .close-btn,
            .print-btn {
                display: none;
            }

            .modal {
                position: static;
                background: white;
            }

            .modal.active {
                display: block;
            }
        }
    </style>
</head>
<body>
<script>
     // FONCTION PRINCIPALE : Changer la période et recharger la page
        function changerPeriode() {
            const mois = document.getElementById('selectMonth').value;
            const annee = document.getElementById('selectYear').value;
            window.location.href = '/paies?month=' + mois + '&year=' + annee;
        }
</script>
    <%
        // Récupération du mois et de l'année actuels utilisés par le contrôleur
        // On vérifie d'abord les paramètres de requête (GET), puis les attributs de requête
        Integer moisActuel = null;
        Integer anneeActuelle = null;

        String moisParam = request.getParameter("month");
        String anneeParam = request.getParameter("year");

        if (moisParam != null && !moisParam.trim().isEmpty()) {
            try {
                moisActuel = Integer.parseInt(moisParam);
            } catch (NumberFormatException e) {
                // Garder la valeur par défaut
            }
        }

        if (anneeParam != null && !anneeParam.trim().isEmpty()) {
            try {
                anneeActuelle = Integer.parseInt(anneeParam);
            } catch (NumberFormatException e) {
                // Garder la valeur par défaut
            }
        }

        // Si les paramètres GET ne sont pas présents, utiliser les attributs de la requête
        if (moisActuel == null) {
            moisActuel = (Integer) request.getAttribute("moisActuel");
        }
        if (anneeActuelle == null) {
            anneeActuelle = (Integer) request.getAttribute("anneeActuelle");
        }

        // Si toujours non définis, utiliser le mois/année actuels
        if (moisActuel == null) {
            moisActuel = java.util.Calendar.getInstance().get(java.util.Calendar.MONTH) + 1;
        }
        if (anneeActuelle == null) {
            anneeActuelle = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        }

        String[] nomsMois = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                            "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
    %>

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
                <!-- Sélecteur de période (Mois/Année) avec bouton Valider -->
                <div class="period-selector">
                    <label><i class="fas fa-calendar-alt"></i> Période :</label>
                    <select id="selectMonth">
                        <% for (int i = 1; i <= 12; i++) { %>
                            <option value="<%= i %>" <%= (i == moisActuel) ? "selected" : "" %>>
                                <%= nomsMois[i-1] %>
                            </option>
                        <% } %>
                    </select>
                    <select id="selectYear">
                        <% for (int y = 2020; y <= 2025; y++) { %>
                            <option value="<%= y %>" <%= (y == anneeActuelle) ? "selected" : "" %>>
                                <%= y %>
                            </option>
                        <% } %>
                    </select>
                    <button class="btn btn-filter" onclick="changerPeriode()">
                        <i class="fas fa-check"></i> Valider
                    </button>
                </div>

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
                <div class="info-banner">
                    <i class="fas fa-info-circle"></i>
                    <span>
                        Affichage des bulletins de paie pour
                        <strong><%= nomsMois[moisActuel-1] %> <%= anneeActuelle %></strong>
                    </span>
                </div>

                <h2>Bulletins de Paie - <%= nomsMois[moisActuel-1] %> <%= anneeActuelle %></h2>

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
                                <th>Coût Heures Supp</th>
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
                                java.util.Map heuresSuppTotals = (java.util.Map) request.getAttribute("heuresSuppTotals");

                                if (employes != null && !employes.isEmpty()) {
                                    for (Employe employe : employes) {
                                        if (employe.getIdEmploye() == null || employe.getIdEmploye() <= 0) {
                                            continue;
                                        }

                                        ContratEmploye contrat = employe.getContratEmploye();
                                        Departement dept = employe.getDepartement();

                                        BigDecimal salaireBase = BigDecimal.ZERO;
                                        BigDecimal heuresSuppDecimal = BigDecimal.ZERO;
                                        int heuresSupp = 0;
                                        String dateEmbauche = "N/A";
                                        String poste = "N/A";
                                        String nomDepartement = "N/A";

                                        String nomEmploye = (employe.getNom() != null && !employe.getNom().trim().isEmpty())
                                            ? employe.getNom()
                                            : "Employé " + employe.getIdEmploye();

                                        if (dept != null && dept.getNom() != null) {
                                            nomDepartement = dept.getNom();
                                        }

                                        // RÉCUPÉRATION DES HEURES SUPPLÉMENTAIRES
                                        java.math.BigDecimal value = java.math.BigDecimal.ZERO;
                                        if (heuresSuppTotals != null && employe.getIdEmploye() != null) {
                                            Object v = heuresSuppTotals.get(employe.getIdEmploye());
                                            if (v instanceof java.math.BigDecimal) {
                                                value = (java.math.BigDecimal) v;
                                            }
                                        }
                                        heuresSuppDecimal = value;
                                        heuresSupp = heuresSuppDecimal.intValue();

                                        if (contrat != null) {
                                            if (contrat.getDate() != null) {
                                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                dateEmbauche = sdf.format(contrat.getDate());
                                            }

                                            if (contrat.getPoste() != null && contrat.getPoste().getSalaireDeBase() != null) {
                                                poste = contrat.getPoste().getLibelle();
                                                salaireBase = contrat.getPoste().getSalaireDeBase();
                                            }
                                        }

                                        // CALCULS DE PAIE
                                        BigDecimal heuresParMois = new BigDecimal("173.33");
                                        BigDecimal tauxMajoration = new BigDecimal("1.5");
                                        BigDecimal tauxHoraireNormal = salaireBase.divide(heuresParMois, 2, RoundingMode.HALF_UP);
                                        BigDecimal tauxHoraireSupp = tauxHoraireNormal.multiply(tauxMajoration);
                                        BigDecimal majorationHeuresSupp = tauxHoraireSupp.multiply(heuresSuppDecimal);
                                        BigDecimal salaireBrut = salaireBase.add(majorationHeuresSupp);

                                        BigDecimal cnaps1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal cnaps8 = salaireBrut.multiply(new BigDecimal("0.08")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal ostie1 = salaireBrut.multiply(new BigDecimal("0.01")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal ostie5 = salaireBrut.multiply(new BigDecimal("0.05")).setScale(0, RoundingMode.HALF_UP);
                                        BigDecimal revenuImposable = salaireBrut.subtract(cnaps1).subtract(ostie1);

                                        // Calcul IRSA
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

                                        BigDecimal salaireNet = salaireBrut.subtract(cnaps8).subtract(ostie5).subtract(irsa);

                                        BigDecimal avance = BigDecimal.ZERO;
                                        if (salaireNet.compareTo(new BigDecimal("200000")) > 0) {
                                            avance = new BigDecimal("50000");
                                        }

                                        BigDecimal netAPayer = salaireNet.subtract(avance);
                            %>
                            <tr>
                                <td><%= nomEmploye %></td>
                                <td><%= dateEmbauche %></td>
                                <td><%= poste %></td>
                                <td><%= nomDepartement %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", salaireBase) %></td>
                                <td class="text-right"><%= heuresSupp %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", salaireBrut) %></td>
                                <td class="text-right"><%= String.format("%,.0f Ar", majorationHeuresSupp) %></td>
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
                                    <a href="<%= request.getContextPath() %>/paies/details?employeId=<%= employe.getIdEmploye() %>&month=<%= moisActuel %>&year=<%= anneeActuelle %>"
                                       class="btn-action btn-view">
                                        <i class="fas fa-eye"></i> Détails
                                    </a>
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
                                <td colspan="18" class="text-center">Aucun employé trouvé</td>
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
                <h2><i class="fas fa-file-invoice-dollar"></i> Fiche de Paie Détaillée</h2>
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
       
        function fermerModal() {
            document.getElementById('detailsModal').classList.remove('active');
        }

        // Fonction pour générer PDF (simulation)
        function genererPDF(employeId) {
            alert(`Génération du PDF pour l'employé ${employeId}\n\nCette fonctionnalité sera implémentée avec une bibliothèque PDF comme jsPDF.`);
        }

        // Fonction pour imprimer la fiche de paie
        function imprimerFichePaie() {
            window.print();
        }

        // Fonctions utilitaires pour formater les nombres
        function padNumber(num, size) {
            let s = num.toString();
            while (s.length < size) s = "0" + s;
            return s;
        }

        function formatDate(date) {
            const day = date.getDate().toString().padStart(2, '0');
            const month = (date.getMonth() + 1).toString().padStart(2, '0');
            const year = date.getFullYear();
            return day + '/' + month + '/' + year;
        }

<<<<<<< HEAD
       

=======
>>>>>>> 66a116a31290aa87725f19c0579e51ddd51c43fb
        // Fonction pour formater les montants
        function formaterMontant(montant) {
            return new Intl.NumberFormat('fr-FR').format(Math.round(montant)) + ' Ar';
        }

        // Fonction pour afficher les détails
        function afficherDetails(employeId, nomEmploye, dateEmbauche, poste, departement,
                                salaireBase, heuresSupp, salaireBrut, majorationHeuresSupp,
                                cnaps1, cnaps8, ostie1, ostie5, revenuImposable, irsa,
                                salaireNet, avance, netAPayer, tauxHoraireNormal, tauxHoraireSupp) {

            const moisActuel = <%= moisActuel %>;
            const anneeActuelle = <%= anneeActuelle %>;
            const nomsMois = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                             "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
            const moisNom = nomsMois[moisActuel - 1];

            // Formater les dates correctement
            const moisFormatted = moisActuel < 10 ? '0' + moisActuel : moisActuel.toString();
            const derniersJourDuMois = new Date(anneeActuelle, moisActuel, 0).getDate();

            const datePaiement = new Date(anneeActuelle, moisActuel - 1, 28);
            const datePaiementFormatted = formatDate(datePaiement);
            const periodeDu = '01/' + moisFormatted + '/' + anneeActuelle;
            const periodeAu = derniersJourDuMois + '/' + moisFormatted + '/' + anneeActuelle;

            // Matricule formaté
            const matricule = 'EMP' + padNumber(employeId, 4);

            const detailsContent = document.getElementById('detailsContent');
            detailsContent.innerHTML = `
                <div class="payroll-sheet">
                    <!-- En-tête avec logo de l'entreprise -->
                    <div class="company-header">
                        <div class="company-logo">
                            <div class="logo-placeholder">
                                <i class="fas fa-building fa-3x"></i>
                            </div>
                            <h3>GreenTech Solutions</h3>
                        </div>
                        <div class="company-info">
                            <h2>GREEN TECH SOLUTIONS SARL</h2>
                            <p>Lotissement d'Affaires Ivandry, Antananarivo 101</p>
                            <p>Tél: +261 20 22 333 44 | Email: contact@greentech.mg</p>
                            <p>NIF: 3000123456 | STAT: 63112 11 2018 0 08972</p>
                            <p>RCS: Antananarivo 2018 B 0152</p>
                        </div>
                    </div>

                    <!-- Titre du document -->
                    <div class="document-title">
                        <h1>BULLETIN DE PAIE</h1>
                        <div class="period">Période : ${moisNom} ${anneeActuelle}</div>
                    </div>

                    <!-- Informations de l'employé -->
                    <div class="employee-info">
                        <h3>INFORMATIONS EMPLOYÉ</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Nom :</span>
                                <span class="info-value">${nomEmploye}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Matricule :</span>
                                <span class="info-value">${matricule}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Fonction :</span>
                                <span class="info-value">${poste}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Département :</span>
                                <span class="info-value">${departement}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Date d'embauche :</span>
                                <span class="info-value">${dateEmbauche}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Période :</span>
                                <span class="info-value">Du ${periodeDu} au ${periodeAu}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Gains et avantages -->
                    <h3 class="section-title">GAINS ET AVANTAGES</h3>
                    <table class="payroll-table">
                        <thead>
                            <tr>
                                <th>Désignation</th>
                                <th>Unité</th>
                                <th>Quantité</th>
                                <th>Taux</th>
                                <th>Montant</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Salaire de base</td>
                                <td>Mois</td>
                                <td>1</td>
                                <td class="amount">${formaterMontant(salaireBase)}</td>
                                <td class="amount">${formaterMontant(salaireBase)}</td>
                            </tr>
                            <tr>
                                <td>Heures supplémentaires (majoration 50%)</td>
                                <td>Heures</td>
                                <td>${heuresSupp}</td>
                                <td class="amount">${formaterMontant(tauxHoraireSupp)}</td>
                                <td class="amount">${formaterMontant(majorationHeuresSupp)}</td>
                            </tr>
                            <tr style="background-color: #f0f8f0;">
                                <td colspan="4" style="text-align: right; font-weight: bold;">TOTAL DES GAINS</td>
                                <td class="amount" style="font-size: 1.1em;">${formaterMontant(salaireBrut)}</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Cotisations sociales -->
                    <h3 class="section-title">COTISATIONS SOCIALES</h3>
                    <table class="payroll-table">
                        <thead>
                            <tr>
                                <th>Désignation</th>
                                <th>Base</th>
                                <th>Taux</th>
                                <th>Employé</th>
                                <th>Employeur</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>CNAPS</td>
                                <td class="amount">${formaterMontant(salaireBrut)}</td>
                                <td>1% / 8%</td>
                                <td class="amount">${formaterMontant(cnaps1)}</td>
                                <td class="amount">${formaterMontant(cnaps8)}</td>
                            </tr>
                            <tr>
                                <td>OSTIE</td>
                                <td class="amount">${formaterMontant(salaireBrut)}</td>
                                <td>1% / 5%</td>
                                <td class="amount">${formaterMontant(ostie1)}</td>
                                <td class="amount">${formaterMontant(ostie5)}</td>
                            </tr>
                            <tr style="background-color: #f0f8f0;">
                                <td colspan="3" style="text-align: right; font-weight: bold;">TOTAL DES COTISATIONS</td>
                                <td class="amount">${formaterMontant(cnaps1 + ostie1)}</td>
                                <td class="amount">${formaterMontant(cnaps8 + ostie5)}</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Impôt sur le revenu -->
                    <h3 class="section-title">IMPÔT SUR LE REVENU (IRSA)</h3>
                    <table class="payroll-table">
                        <thead>
                            <tr>
                                <th>Revenu imposable</th>
                                <th>Taux</th>
                                <th>Montant IRSA</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="amount">${formaterMontant(revenuImposable)}</td>
                                <td>Barème progressif</td>
                                <td class="amount">${formaterMontant(irsa)}</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Récapitulatif -->
                    <div class="totals-section">
                        <h3 class="section-title">RÉCAPITULATIF</h3>
                        <div class="total-row">
                            <span>Salaire brut :</span>
                            <span class="amount">${formaterMontant(salaireBrut)}</span>
                        </div>
                        <div class="total-row">
                            <span>Cotisations sociales employé :</span>
                            <span class="amount">- ${formaterMontant(cnaps1 + ostie1)}</span>
                        </div>
                        <div class="total-row">
                            <span>Impôt sur le revenu (IRSA) :</span>
                            <span class="amount">- ${formaterMontant(irsa)}</span>
                        </div>
                        <div class="total-row">
                            <span>Salaire net avant avance :</span>
                            <span class="amount">${formaterMontant(salaireNet)}</span>
                        </div>
                        <div class="total-row">
                            <span>Avance sur salaire :</span>
                            <span class="amount">- ${formaterMontant(avance)}</span>
                        </div>
                        <div class="total-row net-payable">
                            <span>NET À PAYER :</span>
                            <span class="amount">${formaterMontant(netAPayer)}</span>
                        </div>
                    </div>

                    <!-- Détails techniques -->
                    <div class="payroll-meta">
                        <p>Taux horaire normal : ${formaterMontant(tauxHoraireNormal)} |
                           Taux horaire majoré : ${formaterMontant(tauxHoraireSupp)} |
                           Date de paiement : ${datePaiementFormatted}</p>
                    </div>

                    <!-- Mentions légales -->
                    <div class="legal-mentions">
                        <p><strong>Mentions légales :</strong> Ce bulletin de paie a été établi conformément à la législation du travail de Madagascar.</p>
                        <p>Le salaire est payable le dernier jour ouvrable du mois. Toute réclamation doit être formulée dans les 8 jours.</p>
                    </div>

                    <!-- Signature -->
                    <div class="payroll-footer">
                        <div class="signature">
                            <p>Pour l'employeur</p>
                            <div class="signature-line"></div>
                            <p>Le Directeur Général</p>
                        </div>
                        <div class="signature">
                            <p>Pour acquit</p>
                            <div class="signature-line"></div>
                            <p>L'employé</p>
                        </div>
                    </div>

                    <!-- Bouton d'impression -->
                    <button class="print-btn" onclick="imprimerFichePaie()">
                        <i class="fas fa-print"></i> Imprimer la fiche de paie
                    </button>
                </div>
            `;

            document.getElementById('detailsModal').classList.add('active');
        }

        // =============================================
        // INITIALISATION AU CHARGEMENT DE LA PAGE
        // =============================================
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page chargée - Mois: <%= moisActuel %>, Année: <%= anneeActuelle %>');
            console.log('Nombre d\'employés: <%= employes != null ? employes.size() : 0 %>');

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

            // Filtrage par département (optionnel - côté client)
            document.getElementById('filterDepartment').addEventListener('change', function() {
                const dept = this.value.toLowerCase();
                const rows = document.querySelectorAll('tbody tr');

                rows.forEach(row => {
                    if (dept === '') {
                        row.style.display = '';
                    } else {
                        const deptCell = row.cells[3]; // Colonne département
                        if (deptCell && deptCell.textContent.toLowerCase().includes(dept)) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    }
                });
            });

            // Gestion de la touche Enter sur les sélecteurs
            const selectMonth = document.getElementById('selectMonth');
            const selectYear = document.getElementById('selectYear');

            function validerAvecEnter(e) {
                if (e.key === 'Enter') {
                    changerPeriode();
                }
            }

            if (selectMonth) selectMonth.addEventListener('keypress', validerAvecEnter);
            if (selectYear) selectYear.addEventListener('keypress', validerAvecEnter);

            // Test: Vérifier que changerPeriode est accessible
            console.log('changerPeriode accessible?', typeof changerPeriode === 'function');
        });
    </script>
</body>
</html>