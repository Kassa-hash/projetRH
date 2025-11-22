<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
            max-width: 1600px;
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card.pending {
            border-left: 5px solid #ffc107;
        }

        .stat-card.approved {
            border-left: 5px solid #28a745;
        }

        .stat-card.rejected {
            border-left: 5px solid #dc3545;
        }

        .stat-card.total {
            border-left: 5px solid #4a7c2c;
        }

        .stat-card h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .stat-card .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-card.pending .stat-value {
            color: #ffc107;
        }

        .stat-card.approved .stat-value {
            color: #28a745;
        }

        .stat-card.rejected .stat-value {
            color: #dc3545;
        }

        .stat-card.total .stat-value {
            color: #4a7c2c;
        }

        .demandes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .demande-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            border-left: 5px solid #4a7c2c;
        }

        .demande-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .demande-card.pending {
            border-left-color: #ffc107;
        }

        .demande-card.approved {
            border-left-color: #28a745;
        }

        .demande-card.rejected {
            border-left-color: #dc3545;
        }

        .demande-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }

        .demande-id {
            font-size: 0.9em;
            color: #666;
            font-weight: 600;
        }

        .badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-pending {
            background: #fff3cd;
            color: #856404;
        }

        .badge-approved {
            background: #d4edda;
            color: #155724;
        }

        .badge-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .employe-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .employe-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            color: white;
        }

        .employe-details h3 {
            color: #333;
            font-size: 1.1em;
        }

        .employe-details p {
            color: #666;
            font-size: 0.9em;
        }

        .demande-info {
            margin: 15px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            color: #333;
            font-weight: 600;
        }

        .montant {
            font-size: 1.3em;
            color: #4a7c2c;
        }

        .demande-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-action {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-approve {
            background: #28a745;
            color: white;
        }

        .btn-approve:hover {
            background: #218838;
        }

        .btn-reject {
            background: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background: #c82333;
        }

        .btn-view {
            background: #17a2b8;
            color: white;
        }

        .btn-view:hover {
            background: #138496;
        }

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
            max-width: 600px;
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #4a7c2c;
            box-shadow: 0 0 0 3px rgba(74, 124, 44, 0.2);
        }

        .date-range {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        /* Styles pour les tableaux */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        /* Nouveaux styles pour les détails de paie */
        .paie-details {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .paie-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #4a7c2c;
        }

        .paie-values {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .paie-value {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .paie-label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }

        .paie-amount {
            font-size: 1.5em;
            font-weight: bold;
            color: #4a7c2c;
        }

        .net-amount {
            color: #2d5016;
            font-size: 1.8em;
        }

        /* Styles pour les onglets de paie */
        .paie-tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 2px solid #4a7c2c;
        }

        .paie-tab {
            padding: 12px 24px;
            cursor: pointer;
            font-weight: 600;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
        }

        .paie-tab.active {
            color: #4a7c2c;
            border-bottom-color: #4a7c2c;
        }

        .paie-tab:hover {
            background: #f0f0f0;
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
            <div class="tab active" data-tab="dashboard">Tableau de Bord</div>
            <div class="tab" data-tab="employees">Employés</div>
            <div class="tab" data-tab="payments">Paiements</div>
            <div class="tab" data-tab="payroll">Bulletins de Paie</div>
            <div class="tab" data-tab="reports">Rapports</div>
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
            <button class="btn btn-primary" id="addPaymentBtn"><i class="fas fa-plus"></i> Nouveau Paiement</button>
        </div>

        <div class="content">
            <!-- Tableau de bord -->
            <div class="tab-content active" id="dashboard">
                <div class="stats">
                    <div class="stat-card total">
                        <h3>Total Paiements du Mois</h3>
                        <div class="stat-value">125,680 €</div>
                        <p>+5.2% vs mois dernier</p>
                    </div>
                    <div class="stat-card approved">
                        <h3>Paiements Validés</h3>
                        <div class="stat-value">42</div>
                        <p>87.5% des paiements</p>
                    </div>
                    <div class="stat-card pending">
                        <h3>En Attente</h3>
                        <div class="stat-value">6</div>
                        <p>12.5% des paiements</p>
                    </div>
                    <div class="stat-card rejected">
                        <h3>Paiements Rejetés</h3>
                        <div class="stat-value">0</div>
                        <p>0% des paiements</p>
                    </div>
                </div>

                <h2>Paiements Récents</h2>
                <div class="demandes-grid">
                    <div class="demande-card approved">
                        <div class="demande-header">
                            <div class="demande-id">PAY-2023-0012</div>
                            <span class="badge badge-approved">Validé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">MD</div>
                            <div class="employe-details">
                                <h3>Martin Dupont</h3>
                                <p>Développeur Senior</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">Mois</span>
                                <span class="info-value">Octobre 2023</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Salaire Net</span>
                                <span class="info-value montant">3,250 €</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Date de Paiement</span>
                                <span class="info-value">30/10/2023</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-view"><i class="fas fa-eye"></i> Détails</button>
                            <button class="btn-action btn-approve"><i class="fas fa-file-pdf"></i> Bulletin</button>
                        </div>
                    </div>

                    <div class="demande-card pending">
                        <div class="demande-header">
                            <div class="demande-id">PAY-2023-0013</div>
                            <span class="badge badge-pending">En Attente</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">SL</div>
                            <div class="employe-details">
                                <h3>Sophie Leroy</h3>
                                <p>Chef de Projet</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">Mois</span>
                                <span class="info-value">Octobre 2023</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Salaire Net</span>
                                <span class="info-value montant">3,980 €</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Date de Paiement</span>
                                <span class="info-value">En attente</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-approve"><i class="fas fa-check"></i> Valider</button>
                            <button class="btn-action btn-reject"><i class="fas fa-times"></i> Rejeter</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section des bulletins de paie -->
            <div class="tab-content" id="payroll">
                <h2>Bulletins de Paie</h2>

                <div class="paie-tabs">
                    <div class="paie-tab active" data-paie-tab="details">Détails de Paie</div>
                    <div class="paie-tab" data-paie-tab="history">Historique</div>
                </div>

                <div class="paie-details">
                    <div class="paie-header">
                        <h3>Bulletin de Paie - Octobre 2023</h3>
                        <div class="demande-id">EMP-001 | Martin Dupont</div>
                    </div>

                    <div class="paie-values">
                        <div class="paie-value">
                            <div class="paie-label">Salaire de Base</div>
                            <div class="paie-amount">3,500 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label">Salaire Brut</div>
                            <div class="paie-amount">3,800 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label">CNAPS</div>
                            <div class="paie-amount">-190 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label">OSTIE</div>
                            <div class="paie-amount">-95 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label">Revenu Imposable</div>
                            <div class="paie-amount">3,515 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label">Impôt dû</div>
                            <div class="paie-amount">-265 €</div>
                        </div>
                        <div class="paie-value">
                            <div class="paie-label net-amount">Net à Payer</div>
                            <div class="paie-amount net-amount">3,250 €</div>
                        </div>
                    </div>
                </div>

                <h3>Historique des Paiements</h3>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID Paie</th>
                                <th>Mois</th>
                                <th>Salaire Base</th>
                                <th>Salaire Brut</th>
                                <th>CNAPS</th>
                                <th>OSTIE</th>
                                <th>Revenu Imposable</th>
                                <th>Impôt dû</th>
                                <th>Net à Payer</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>PAY-2023-0012</td>
                                <td>Octobre 2023</td>
                                <td>3,500 €</td>
                                <td>3,800 €</td>
                                <td>190 €</td>
                                <td>95 €</td>
                                <td>3,515 €</td>
                                <td>265 €</td>
                                <td>3,250 €</td>
                                <td>
                                    <button class="btn-action btn-view"><i class="fas fa-eye"></i></button>
                                    <button class="btn-action btn-approve"><i class="fas fa-file-pdf"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>PAY-2023-0009</td>
                                <td>Septembre 2023</td>
                                <td>3,500 €</td>
                                <td>3,800 €</td>
                                <td>190 €</td>
                                <td>95 €</td>
                                <td>3,515 €</td>
                                <td>265 €</td>
                                <td>3,250 €</td>
                                <td>
                                    <button class="btn-action btn-view"><i class="fas fa-eye"></i></button>
                                    <button class="btn-action btn-approve"><i class="fas fa-file-pdf"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>PAY-2023-0006</td>
                                <td>Août 2023</td>
                                <td>3,500 €</td>
                                <td>3,800 €</td>
                                <td>190 €</td>
                                <td>95 €</td>
                                <td>3,515 €</td>
                                <td>265 €</td>
                                <td>3,250 €</td>
                                <td>
                                    <button class="btn-action btn-view"><i class="fas fa-eye"></i></button>
                                    <button class="btn-action btn-approve"><i class="fas fa-file-pdf"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal pour ajouter un paiement -->
    <div class="modal" id="addPaymentModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Nouveau Paiement</h2>
                <button class="close-btn">&times;</button>
            </div>
            <div class="modal-body">
                <form id="paymentForm">
                    <div class="form-group">
                        <label for="employeeSelect">Employé</label>
                        <select id="employeeSelect" class="form-control" required>
                            <option value="">Sélectionner un employé</option>
                            <option value="1">Martin Dupont</option>
                            <option value="2">Sophie Leroy</option>
                            <option value="3">Pierre Moreau</option>
                            <option value="4">Émilie Bernard</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="monthSelect">Mois de paie</label>
                        <select id="monthSelect" class="form-control" required>
                            <option value="">Sélectionner un mois</option>
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
                    </div>
                    <div class="form-group">
                        <label for="yearSelect">Année</label>
                        <select id="yearSelect" class="form-control" required>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="salaireBase">Salaire de Base (€)</label>
                        <input type="number" id="salaireBase" class="form-control" step="0.01" min="0" required>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary close-modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Calculer et Enregistrer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Gestion des onglets principaux
        document.querySelectorAll('.tab').forEach(tab => {
            tab.addEventListener('click', () => {
                // Retirer la classe active de tous les onglets
                document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));

                // Ajouter la classe active à l'onglet cliqué
                tab.classList.add('active');
                const tabId = tab.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });

        // Gestion des onglets de paie
        document.querySelectorAll('.paie-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.paie-tab').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                // Ici, vous pouvez ajouter la logique pour changer le contenu des onglets de paie
            });
        });

        // Gestion du modal
        const addPaymentBtn = document.getElementById('addPaymentBtn');
        const addPaymentModal = document.getElementById('addPaymentModal');
        const closeModalBtns = document.querySelectorAll('.close-btn, .close-modal');

        addPaymentBtn.addEventListener('click', () => {
            addPaymentModal.classList.add('active');
        });

        closeModalBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                addPaymentModal.classList.remove('active');
            });
        });

        // Soumettre le formulaire de paiement
        document.getElementById('paymentForm').addEventListener('submit', (e) => {
            e.preventDefault();
            // Ici, vous ajouteriez la logique pour traiter le formulaire
            alert('Paiement ajouté avec succès!');
            addPaymentModal.classList.remove('active');
        });

        // Fermer le modal en cliquant en dehors
        window.addEventListener('click', (e) => {
            if (e.target === addPaymentModal) {
                addPaymentModal.classList.remove('active');
            }
        });

        // Simulation de données pour les statistiques
        function updateStats() {
            // Cette fonction pourrait récupérer les données réelles d'une API
            console.log('Mise à jour des statistiques...');
        }

        // Initialisation
        updateStats();
    </script>
</body>
</html>