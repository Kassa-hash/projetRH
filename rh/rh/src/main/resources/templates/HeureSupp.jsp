<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Heures Supplémentaires</title>
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

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
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

        .stat-card.total {
            border-left: 5px solid #4a7c2c;
        }

        .stat-card.month {
            border-left: 5px solid #17a2b8;
        }

        .stat-card.pending {
            border-left: 5px solid #ffc107;
        }

        .stat-card.approved {
            border-left: 5px solid #28a745;
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

        .stat-card.total .stat-value {
            color: #4a7c2c;
        }

        .stat-card.month .stat-value {
            color: #17a2b8;
        }

        .stat-card.pending .stat-value {
            color: #ffc107;
        }

        .stat-card.approved .stat-value {
            color: #28a745;
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

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 8px 12px;
            font-size: 0.85em;
        }

        .btn-edit {
            background: #17a2b8;
            color: white;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        /* Modal */
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

        .form-row {
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

        /* Cartes d'heures supplémentaires */
        .heures-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .heure-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            border-left: 5px solid #4a7c2c;
        }

        .heure-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .heure-card.pending {
            border-left-color: #ffc107;
        }

        .heure-card.approved {
            border-left-color: #28a745;
        }

        .heure-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }

        .heure-id {
            font-size: 0.9em;
            color: #666;
            font-weight: 600;
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

        .heure-info {
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

        .duree {
            font-size: 1.3em;
            color: #4a7c2c;
        }

        .heure-actions {
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
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1><i class="fas fa-clock"></i> Gestion des Heures Supplémentaires</h1>
            <p>Suivi et validation des heures supplémentaires des employés</p>
        </header>

        <div class="tabs">
            <div class="tab active" data-tab="dashboard">Tableau de Bord</div>
            <div class="tab" data-tab="heures">Heures Supplémentaires</div>
            <div class="tab" data-tab="validation">Validation</div>
            <div class="tab" data-tab="rapports">Rapports</div>
        </div>

        <div class="controls">
            <div class="filter-group">
                <select id="filterEmploye">
                    <option value="">Tous les employés</option>
                    <option value="1">Martin Dupont</option>
                    <option value="2">Sophie Leroy</option>
                    <option value="3">Pierre Moreau</option>
                    <option value="4">Émilie Bernard</option>
                </select>
                <input type="month" id="filterMois" value="2023-10">
                <select id="filterStatut">
                    <option value="">Tous les statuts</option>
                    <option value="pending">En attente</option>
                    <option value="approved">Validé</option>
                    <option value="rejected">Rejeté</option>
                </select>
            </div>
            <button class="btn btn-primary" id="addHeureSuppBtn"><i class="fas fa-plus"></i> Nouvelle Heure Supp</button>
        </div>

        <div class="content">
            <!-- Tableau de bord -->
            <div class="tab-content active" id="dashboard">
                <div class="stats">
                    <div class="stat-card total">
                        <h3>Heures Supp Total</h3>
                        <div class="stat-value">156.5 h</div>
                        <p>Cette année</p>
                    </div>
                    <div class="stat-card month">
                        <h3>Heures Ce Mois</h3>
                        <div class="stat-value">42.5 h</div>
                        <p>Octobre 2023</p>
                    </div>
                    <div class="stat-card pending">
                        <h3>En Attente</h3>
                        <div class="stat-value">18 h</div>
                        <p>8 demandes</p>
                    </div>
                    <div class="stat-card approved">
                        <h3>Validées</h3>
                        <div class="stat-value">124.5 h</div>
                        <p>32 demandes</p>
                    </div>
                </div>

                <h2>Heures Supplémentaires Récentes</h2>
                <div class="heures-grid">
                    <div class="heure-card approved">
                        <div class="heure-header">
                            <div class="heure-id">HS-2023-0042</div>
                            <span class="badge badge-approved">Validé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">MD</div>
                            <div class="employe-details">
                                <h3>Martin Dupont</h3>
                                <p>Développeur Senior - IT</p>
                            </div>
                        </div>
                        <div class="heure-info">
                            <div class="info-row">
                                <span class="info-label">Date</span>
                                <span class="info-value">15/10/2023</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Durée</span>
                                <span class="info-value duree">4.5 heures</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Type</span>
                                <span class="info-value">Projet urgent</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Validé le</span>
                                <span class="info-value">16/10/2023</span>
                            </div>
                        </div>
                        <div class="heure-actions">
                            <button class="btn-action btn-view"><i class="fas fa-eye"></i> Détails</button>
                            <button class="btn-action btn-approve"><i class="fas fa-edit"></i> Modifier</button>
                        </div>
                    </div>

                    <div class="heure-card pending">
                        <div class="heure-header">
                            <div class="heure-id">HS-2023-0043</div>
                            <span class="badge badge-pending">En Attente</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">SL</div>
                            <div class="employe-details">
                                <h3>Sophie Leroy</h3>
                                <p>Chef de Projet - Management</p>
                            </div>
                        </div>
                        <div class="heure-info">
                            <div class="info-row">
                                <span class="info-label">Date</span>
                                <span class="info-value">18/10/2023</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Durée</span>
                                <span class="info-value duree">3.0 heures</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Type</span>
                                <span class="info-value">Réunion client</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Statut</span>
                                <span class="info-value">En attente de validation</span>
                            </div>
                        </div>
                        <div class="heure-actions">
                            <button class="btn-action btn-approve"><i class="fas fa-check"></i> Valider</button>
                            <button class="btn-action btn-reject"><i class="fas fa-times"></i> Rejeter</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section des heures supplémentaires -->
            <div class="tab-content" id="heures">
                <h2>Historique des Heures Supplémentaires</h2>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Employé</th>
                                <th>Date</th>
                                <th>Durée (heures)</th>
                                <th>Département</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>HS-2023-0042</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 35px; height: 35px; border-radius: 50%; background: #4a7c2c; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">MD</div>
                                        Martin Dupont
                                    </div>
                                </td>
                                <td>15/10/2023</td>
                                <td><strong>4.5</strong></td>
                                <td>IT</td>
                                <td><span class="badge badge-approved">Validé</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>HS-2023-0043</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 35px; height: 35px; border-radius: 50%; background: #17a2b8; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">SL</div>
                                        Sophie Leroy
                                    </div>
                                </td>
                                <td>18/10/2023</td>
                                <td><strong>3.0</strong></td>
                                <td>Management</td>
                                <td><span class="badge badge-pending">En attente</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-success btn-sm"><i class="fas fa-check"></i></button>
                                        <button class="btn btn-danger btn-sm"><i class="fas fa-times"></i></button>
                                        <button class="btn btn-edit btn-sm"><i class="fas fa-eye"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>HS-2023-0041</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 35px; height: 35px; border-radius: 50%; background: #6f42c1; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">PM</div>
                                        Pierre Moreau
                                    </div>
                                </td>
                                <td>12/10/2023</td>
                                <td><strong>2.5</strong></td>
                                <td>Finance</td>
                                <td><span class="badge badge-approved">Validé</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>HS-2023-0040</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 35px; height: 35px; border-radius: 50%; background: #e83e8c; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">EB</div>
                                        Émilie Bernard
                                    </div>
                                </td>
                                <td>10/10/2023</td>
                                <td><strong>5.0</strong></td>
                                <td>Création</td>
                                <td><span class="badge badge-approved">Validé</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal pour ajouter une heure supplémentaire -->
    <div class="modal" id="addHeureSuppModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Nouvelle Heure Supplémentaire</h2>
                <button class="close-btn">&times;</button>
            </div>
            <div class="modal-body">
                <form id="heureSuppForm">
                    <div class="form-group">
                        <label for="employeSelect">Employé</label>
                        <select id="employeSelect" class="form-control" required>
                            <option value="">Sélectionner un employé</option>
                            <option value="1">Martin Dupont - Développeur Senior</option>
                            <option value="2">Sophie Leroy - Chef de Projet</option>
                            <option value="3">Pierre Moreau - Comptable</option>
                            <option value="4">Émilie Bernard - Designer</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dateHeureSupp">Date</label>
                            <input type="date" id="dateHeureSupp" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="dureeHeureSupp">Durée (heures)</label>
                            <input type="number" id="dureeHeureSupp" class="form-control" step="0.5" min="0.5" max="12" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="motifHeureSupp">Motif</label>
                        <textarea id="motifHeureSupp" class="form-control" rows="3" placeholder="Décrivez la raison des heures supplémentaires..." required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="projetHeureSupp">Projet/Client</label>
                        <input type="text" id="projetHeureSupp" class="form-control" placeholder="Projet concerné...">
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary close-modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
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

        // Gestion du modal
        const addHeureSuppBtn = document.getElementById('addHeureSuppBtn');
        const addHeureSuppModal = document.getElementById('addHeureSuppModal');
        const closeModalBtns = document.querySelectorAll('.close-btn, .close-modal');

        addHeureSuppBtn.addEventListener('click', () => {
            addHeureSuppModal.classList.add('active');
        });

        closeModalBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                addHeureSuppModal.classList.remove('active');
            });
        });

        // Soumettre le formulaire d'heure supplémentaire
        document.getElementById('heureSuppForm').addEventListener('submit', (e) => {
            e.preventDefault();

            const employe = document.getElementById('employeSelect').value;
            const date = document.getElementById('dateHeureSupp').value;
            const duree = document.getElementById('dureeHeureSupp').value;
            const motif = document.getElementById('motifHeureSupp').value;

            alert(`Heure supplémentaire enregistrée pour l'employé ${employe} : ${duree}h le ${date}`);

            // Réinitialiser le formulaire
            document.getElementById('heureSuppForm').reset();
            addHeureSuppModal.classList.remove('active');
        });

        // Fermer le modal en cliquant en dehors
        window.addEventListener('click', (e) => {
            if (e.target === addHeureSuppModal) {
                addHeureSuppModal.classList.remove('active');
            }
        });

        // Gestion des boutons d'action dans le tableau
        document.querySelectorAll('.btn-success').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const row = btn.closest('tr');
                const id = row.cells[0].textContent;
                const employe = row.cells[1].textContent.trim();
                alert(`Heure supplémentaire ${id} validée pour ${employe}`);
            });
        });

        document.querySelectorAll('.btn-danger').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const row = btn.closest('tr');
                const id = row.cells[0].textContent;
                if (confirm(`Êtes-vous sûr de vouloir supprimer l'heure supplémentaire ${id} ?`)) {
                    row.remove();
                }
            });
        });

        // Simulation de données pour les statistiques
        function updateStats() {
            // Cette fonction pourrait récupérer les données réelles d'une API
            console.log('Mise à jour des statistiques des heures supplémentaires...');
        }

        // Initialisation
        updateStats();

        // Définir la date d'aujourd'hui par défaut
        document.getElementById('dateHeureSupp').valueAsDate = new Date();
    </script>
</body>
</html>