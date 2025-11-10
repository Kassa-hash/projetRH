<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Demandes</title>
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
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📝 Gestion des Demandes</h1>
            <p>Suivi des demandes de congés et d'avances</p>
        </header>

        <div class="tabs">
            <div class="tab active" onclick="switchTab('conges')">
                🏖️ Demandes de Congés
            </div>
            <div class="tab" onclick="switchTab('avances')">
                💰 Demandes d'Avances
            </div>
        </div>

        <!-- Onglet Congés -->
        <div id="conges-tab" class="tab-content active">
            <div class="controls">
                <div class="filter-group">
                    <input type="text" id="searchConges" placeholder="🔍 Rechercher...">
                    <select id="filterStatutConges">
                        <option value="">Tous les statuts</option>
                        <option value="pending">En attente</option>
                        <option value="approved">Approuvé</option>
                        <option value="rejected">Rejeté</option>
                    </select>
                </div>
                <button class="btn btn-primary" onclick="openModalConges()">+ Nouvelle Demande</button>
            </div>

            <div class="content">
                <div class="stats">
                    <div class="stat-card pending">
                        <h3>En Attente</h3>
                        <div class="stat-value">5</div>
                    </div>
                    <div class="stat-card approved">
                        <h3>Approuvées</h3>
                        <div class="stat-value">12</div>
                    </div>
                    <div class="stat-card rejected">
                        <h3>Refusées</h3>
                        <div class="stat-value">2</div>
                    </div>
                    <div class="stat-card total">
                        <h3>Total</h3>
                        <div class="stat-value">19</div>
                    </div>
                </div>

                <div class="demandes-grid" id="congesGrid">
                    <div class="demande-card pending">
                        <div class="demande-header">
                            <span class="demande-id">#DCG-001</span>
                            <span class="badge badge-pending">⏳ En attente</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Jean Dupont</h3>
                                <p>Développeur</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Début:</span>
                                <span class="info-value">15 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📅 Fin:</span>
                                <span class="info-value">20 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">⏱️ Durée:</span>
                                <span class="info-value">6 jours</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📋 Motif:</span>
                                <span class="info-value">Vacances</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-approve" onclick="approveConge(1)">✅ Approuver</button>
                            <button class="btn-action btn-reject" onclick="rejectConge(1)">❌ Refuser</button>
                        </div>
                    </div>

                    <div class="demande-card approved">
                        <div class="demande-header">
                            <span class="demande-id">#DCG-002</span>
                            <span class="badge badge-approved">✅ Approuvé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Marie Martin</h3>
                                <p>Chef de Projet</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Début:</span>
                                <span class="info-value">10 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📅 Fin:</span>
                                <span class="info-value">12 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">⏱️ Durée:</span>
                                <span class="info-value">3 jours</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📋 Motif:</span>
                                <span class="info-value">Événement familial</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-view" onclick="viewConge(2)">👁️ Détails</button>
                        </div>
                    </div>

                    <div class="demande-card rejected">
                        <div class="demande-header">
                            <span class="demande-id">#DCG-003</span>
                            <span class="badge badge-rejected">❌ Refusé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Paul Razafindra</h3>
                                <p>Analyste</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Début:</span>
                                <span class="info-value">08 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📅 Fin:</span>
                                <span class="info-value">10 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">⏱️ Durée:</span>
                                <span class="info-value">3 jours</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📋 Motif:</span>
                                <span class="info-value">Personnel</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-view" onclick="viewConge(3)">👁️ Détails</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Onglet Avances -->
        <div id="avances-tab" class="tab-content">
            <div class="controls">
                <div class="filter-group">
                    <input type="text" id="searchAvances" placeholder="🔍 Rechercher...">
                    <select id="filterStatutAvances">
                        <option value="">Tous les statuts</option>
                        <option value="pending">En attente</option>
                        <option value="approved">Approuvé</option>
                        <option value="rejected">Rejeté</option>
                    </select>
                </div>
                <button class="btn btn-primary" onclick="openModalAvances()">+ Nouvelle Demande</button>
            </div>

            <div class="content">
                <div class="stats">
                    <div class="stat-card pending">
                        <h3>En Attente</h3>
                        <div class="stat-value">3</div>
                    </div>
                    <div class="stat-card approved">
                        <h3>Approuvées</h3>
                        <div class="stat-value">8</div>
                    </div>
                    <div class="stat-card rejected">
                        <h3>Refusées</h3>
                        <div class="stat-value">1</div>
                    </div>
                    <div class="stat-card total">
                        <h3>Montant Total</h3>
                        <div class="stat-value">4.5M Ar</div>
                    </div>
                </div>

                <div class="demandes-grid" id="avancesGrid">
                    <div class="demande-card pending">
                        <div class="demande-header">
                            <span class="demande-id">#DAV-001</span>
                            <span class="badge badge-pending">⏳ En attente</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Jean Dupont</h3>
                                <p>Développeur</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Date:</span>
                                <span class="info-value">05 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📆 Mois:</span>
                                <span class="info-value">Novembre 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">💵 Montant:</span>
                                <span class="info-value montant">500,000 Ar</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-approve" onclick="approveAvance(1)">✅ Approuver</button>
                            <button class="btn-action btn-reject" onclick="rejectAvance(1)">❌ Refuser</button>
                        </div>
                    </div>

                    <div class="demande-card approved">
                        <div class="demande-header">
                            <span class="demande-id">#DAV-002</span>
                            <span class="badge badge-approved">✅ Approuvé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Marie Martin</h3>
                                <p>Chef de Projet</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Date:</span>
                                <span class="info-value">01 Nov 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📆 Mois:</span>
                                <span class="info-value">Novembre 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">💵 Montant:</span>
                                <span class="info-value montant">750,000 Ar</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-view" onclick="viewAvance(2)">👁️ Détails</button>
                        </div>
                    </div>

                    <div class="demande-card rejected">
                        <div class="demande-header">
                            <span class="demande-id">#DAV-003</span>
                            <span class="badge badge-rejected">❌ Refusé</span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar">👤</div>
                            <div class="employe-details">
                                <h3>Paul Razafindra</h3>
                                <p>Analyste</p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row">
                                <span class="info-label">📅 Date:</span>
                                <span class="info-value">28 Oct 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">📆 Mois:</span>
                                <span class="info-value">Octobre 2024</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">💵 Montant:</span>
                                <span class="info-value montant">1,000,000 Ar</span>
                            </div>
                        </div>
                        <div class="demande-actions">
                            <button class="btn-action btn-view" onclick="viewAvance(3)">👁️ Détails</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Congé -->
    <div class="modal" id="congesModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>🏖️ Nouvelle Demande de Congé</h2>
                <button class="close-btn" onclick="closeModalConges()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="congesForm">
                    <div class="form-group">
                        <label>Employé *</label>
                        <select required>
                            <option value="">Sélectionner un employé</option>
                            <option value="1">Jean Dupont</option>
                            <option value="2">Marie Martin</option>
                            <option value="3">Paul Razafindra</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Période *</label>
                        <div class="date-range">
                            <input type="date" placeholder="Date début" required>
                            <input type="date" placeholder="Date fin" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Motif *</label>
                        <select required>
                            <option value="">Sélectionner un motif</option>
                            <option value="1">Vacances</option>
                            <option value="2">Maladie</option>
                            <option value="3">Événement familial</option>
                            <option value="4">Personnel</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModalConges()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Soumettre</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Avance -->
    <div class="modal" id="avancesModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>💰 Nouvelle Demande d'Avance</h2>
                <button class="close-btn" onclick="closeModalAvances()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="avancesForm">
                    <div class="form-group">
                        <label>Employé *</label>
                        <select required>
                            <option value="">Sélectionner un employé</option>
                            <option value="1">Jean Dupont</option>
                            <option value="2">Marie Martin</option>
                            <option value="3">Paul Razafindra</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Date *</label>
                        <input type="date" required>
                    </div>
                    <div class="form-group">
                        <label>Mois *</label>
                        <select required>
                            <option value="">Sélectionner un mois</option>
                            <option value="11">Novembre 2024</option>
                            <option value="12">Décembre 2024</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Montant (Ar) *</label>
                        <input type="number" placeholder="500000" min="0" required>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModalAvances()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Soumettre</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));

            if (tab === 'conges') {
                document.querySelectorAll('.tab')[0].classList.add('active');
                document.getElementById('conges-tab').classList.add('active');
            } else {
                document.querySelectorAll('.tab')[1].classList.add('active');
                document.getElementById('avances-tab').classList.add('active');
            }
        }

        function openModalConges() {
            document.getElementById('congesModal').classList.add('active');
        }

        function closeModalConges() {
            document.getElementById('congesModal').classList.remove('active');
        }

        function openModalAvances() {
            document.getElementById('avancesModal').classList.add('active');
        }

        function closeModalAvances() {
            document.getElementById('avancesModal').classList.remove('active');
        }

        function approveConge(id) {
            if (confirm('Approuver cette demande de congé ?')) {
                alert('Demande #' + id + ' approuvée !');
            }
        }

        function rejectConge(id) {
            if (confirm('Refuser cette demande de congé ?')) {
                alert('Demande #' + id + ' refusée.');
            }
        }

        function viewConge(id) {
            alert('Détails de la demande #' + id);
        }

        function approveAvance(id) {
            if (confirm('Approuver cette demande d\'avance ?')) {
                alert('Demande #' + id + ' approuvée !');
            }
        }

        function rejectAvance(id) {
            if (confirm('Refuser cette demande d\'avance ?')) {
                alert('Demande #' + id + ' refusée.');
            }
        }

        function viewAvance(id) {
            alert('Détails de la demande #' + id);
        }

        document.getElementById('congesForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Demande de congé soumise avec succès!');
            closeModalConges();
        });

        document.getElementById('avancesForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Demande d\'avance soumise avec succès!');
            closeModalAvances();
        });

        document.getElementById('searchConges').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();
            document.querySelectorAll('#congesGrid .demande-card').forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(search) ? '' : 'none';
            });
        });

        document.getElementById('searchAvances').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();
            document.querySelectorAll('#avancesGrid .demande-card').forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(search) ? '' : 'none';
            });
        });

        document.getElementById('filterStatutConges').addEventListener('change', function(e) {
            const filter = e.target.value;
            document.querySelectorAll('#congesGrid .demande-card').forEach(card => {
                if (!filter || card.classList.contains(filter)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        document.getElementById('filterStatutAvances').addEventListener('change', function(e) {
            const filter = e.target.value;
            document.querySelectorAll('#avancesGrid .demande-card').forEach(card => {
                if (!filter || card.classList.contains(filter)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        document.getElementById('congesModal').addEventListener('click', function(e) {
            if (e.target === this) closeModalConges();
        });

        document.getElementById('avancesModal').addEventListener('click', function(e) {
            if (e.target === this) closeModalAvances();
        });
    </script>
</body>
</html>