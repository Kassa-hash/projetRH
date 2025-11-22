<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Présences</title>
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

        .date-selector {
            display: flex;
            align-items: center;
            gap: 15px;
            background: white;
            padding: 10px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .date-selector input {
            padding: 10px;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
        }

        .date-nav {
            display: flex;
            gap: 10px;
        }

        .btn-nav {
            padding: 10px 15px;
            background: #4a7c2c;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.2em;
            transition: all 0.3s;
        }

        .btn-nav:hover {
            background: #2d5016;
            transform: scale(1.1);
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

        .stat-card.present {
            border-left: 5px solid #28a745;
        }

        .stat-card.absent {
            border-left: 5px solid #dc3545;
        }

        .stat-card.total {
            border-left: 5px solid #4a7c2c;
        }

        .stat-card.taux {
            border-left: 5px solid #17a2b8;
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

        .stat-card.present .stat-value {
            color: #28a745;
        }

        .stat-card.absent .stat-value {
            color: #dc3545;
        }

        .stat-card.total .stat-value {
            color: #4a7c2c;
        }

        .stat-card.taux .stat-value {
            color: #17a2b8;
        }

        .stat-card .stat-label {
            color: #999;
            font-size: 0.85em;
        }

        .date-title {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .date-title h2 {
            color: #4a7c2c;
            font-size: 1.8em;
        }

        .date-title p {
            color: #666;
            margin-top: 5px;
        }

        .presence-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .employee-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            border: 3px solid transparent;
        }

        .employee-card.present {
            border-color: #28a745;
            background: linear-gradient(to bottom, white 0%, #f0fff4 100%);
        }

        .employee-card.absent {
            border-color: #dc3545;
            background: linear-gradient(to bottom, white 0%, #fff5f5 100%);
        }

        .employee-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .employee-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .employee-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0e0e0 0%, #c0c0c0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            color: #666;
        }

        .employee-card.present .employee-avatar {
            border: 4px solid #28a745;
        }

        .employee-card.absent .employee-avatar {
            border: 4px solid #dc3545;
        }

        .employee-info h3 {
            color: #333;
            font-size: 1.2em;
            margin-bottom: 5px;
        }

        .employee-info p {
            color: #666;
            font-size: 0.9em;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1em;
            margin: 15px 0;
        }

        .status-badge.present {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.absent {
            background: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-toggle {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-present {
            background: #28a745;
            color: white;
        }

        .btn-present:hover {
            background: #218838;
        }

        .btn-absent {
            background: #dc3545;
            color: white;
        }

        .btn-absent:hover {
            background: #c82333;
        }

        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        tbody tr {
            transition: all 0.3s;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        .employe-cell {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .employe-avatar-small {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0e0e0 0%, #c0c0c0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3em;
            color: #666;
            border: 3px solid #4a7c2c;
        }

        .employe-details {
            display: flex;
            flex-direction: column;
        }

        .employe-name {
            font-weight: 600;
            color: #333;
        }

        .employe-role {
            font-size: 0.85em;
            color: #666;
        }

        .status-cell {
            text-align: center;
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
            max-width: 500px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 12px 12px 0 0;
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

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #4a7c2c;
            box-shadow: 0 0 0 3px rgba(74, 124, 44, 0.2);
        }

        .status-options {
            display: flex;
            gap: 15px;
        }

        .status-option {
            flex: 1;
            padding: 15px;
            border: 3px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s;
            font-weight: 600;
        }

        .status-option input[type="radio"] {
            display: none;
        }

        .status-option.present-option:hover,
        .status-option.present-option.selected {
            border-color: #28a745;
            background: #d4edda;
            color: #155724;
        }

        .status-option.absent-option:hover,
        .status-option.absent-option.selected {
            border-color: #dc3545;
            background: #f8d7da;
            color: #721c24;
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

        .search-box {
            padding: 12px 20px;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            font-size: 1em;
            min-width: 250px;
        }

        .view-toggle {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .view-btn {
            padding: 10px 20px;
            background: white;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
        }

        .view-btn.active {
            background: #4a7c2c;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📅 Gestion des Présences</h1>
            <p>Suivi quotidien de la présence des employés</p>
        </header>

        <div class="controls">
            <div class="date-selector">
                <div class="date-nav">
                    <button class="btn-nav" onclick="changeDate(-1)">◀</button>
                </div>
                <input type="date" id="dateInput" value="2024-11-06">
                <div class="date-nav">
                    <button class="btn-nav" onclick="changeDate(1)">▶</button>
                    <button class="btn-nav" onclick="setToday()" title="Aujourd'hui">📍</button>
                </div>
            </div>
            <input type="text" class="search-box" id="searchInput" placeholder="🔍 Rechercher un employé...">
            <button class="btn btn-primary" onclick="openModal()">✏️ Marquer Présence</button>
        </div>

        <div class="content">
            <div class="date-title">
                <h2 id="displayDate">Mercredi 6 Novembre 2024</h2>
                <p>Feuille de présence journalière</p>
            </div>

            <div class="stats">
                <div class="stat-card present">
                    <h3>Présents</h3>
                    <div class="stat-value">8</div>
                    <div class="stat-label">Employés présents</div>
                </div>
                <div class="stat-card absent">
                    <h3>Absents</h3>
                    <div class="stat-value">2</div>
                    <div class="stat-label">Employés absents</div>
                </div>
                <div class="stat-card total">
                    <h3>Total</h3>
                    <div class="stat-value">10</div>
                    <div class="stat-label">Employés enregistrés</div>
                </div>
                <div class="stat-card taux">
                    <h3>Taux de Présence</h3>
                    <div class="stat-value">80%</div>
                    <div class="stat-label">Présence du jour</div>
                </div>
            </div>

            <div class="view-toggle">
                <button class="view-btn active" onclick="toggleView('cards')">🔲 Cartes</button>
                <button class="view-btn" onclick="toggleView('table')">📋 Tableau</button>
            </div>

            <div class="presence-grid" id="cardsView">
                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Jean Dupont</h3>
                            <p>Développeur</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(1, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(1, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Marie Martin</h3>
                            <p>Chef de Projet</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(2, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(2, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card absent">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Paul Razafindra</h3>
                            <p>Analyste</p>
                        </div>
                    </div>
                    <div class="status-badge absent">
                        ❌ Absent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(3, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(3, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Sophie Bernard</h3>
                            <p>Designer</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(4, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(4, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Luc Andriamana</h3>
                            <p>Technicien</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(5, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(5, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card absent">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Claire Rasoanaivo</h3>
                            <p>Comptable</p>
                        </div>
                    </div>
                    <div class="status-badge absent">
                        ❌ Absent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(6, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(6, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Thomas Rakoto</h3>
                            <p>Manager</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(7, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(7, false)">❌ Absent</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Emma Randria</h3>
                            <p>RH</p>
                        </div>
                    </div>
                    <div class="status-badge present">
                        ✅ Présent
                    </div>
                    <div class="action-buttons">
                        <button class="btn-toggle btn-present" onclick="togglePresence(8, true)">✅ Présent</button>
                        <button class="btn-toggle btn-absent" onclick="togglePresence(8, false)">❌ Absent</button>
                    </div>
                </div>
            </div>

            <div class="table-container" id="tableView" style="display: none;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employé</th>
                            <th>Rôle</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#001</td>
                            <td>
                                <div class="employe-cell">
                                    <div class="employe-avatar-small">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Jean Dupont</span>
                                        <span class="employe-role">jean.dupont@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td>Développeur</td>
                            <td class="status-cell">
                                <span class="status-badge present">✅ Présent</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-toggle btn-present" onclick="togglePresence(1, true)">✅</button>
                                    <button class="btn-toggle btn-absent" onclick="togglePresence(1, false)">❌</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>
                                <div class="employe-cell">
                                    <div class="employe-avatar-small">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Marie Martin</span>
                                        <span class="employe-role">marie.martin@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td>Chef de Projet</td>
                            <td class="status-cell">
                                <span class="status-badge present">✅ Présent</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-toggle btn-present" onclick="togglePresence(2, true)">✅</button>
                                    <button class="btn-toggle btn-absent" onclick="togglePresence(2, false)">❌</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#003</td>
                            <td>
                                <div class="employe-cell">
                                    <div class="employe-avatar-small">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Paul Razafindra</span>
                                        <span class="employe-role">paul.raza@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td>Analyste</td>
                            <td class="status-cell">
                                <span class="status-badge absent">❌ Absent</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-toggle btn-present" onclick="togglePresence(3, true)">✅</button>
                                    <button class="btn-toggle btn-absent" onclick="togglePresence(3, false)">❌</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal" id="presenceModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Marquer une Présence</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="presenceForm">
                    <div class="form-group">
                        <label>Employé *</label>
                        <select id="employe" required>
                            <option value="">Sélectionner un employé</option>
                            <option value="1">Jean Dupont</option>
                            <option value="2">Marie Martin</option>
                            <option value="3">Paul Razafindra</option>
                            <option value="4">Sophie Bernard</option>
                            <option value="5">Luc Andriamana</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Date *</label>
                        <input type="date" id="datePresence" required>
                    </div>
                    <div class="form-group">
                        <label>Statut *</label>
                        <div class="status-options">
                            <label class="status-option present-option">
                                <input type="radio" name="statut" value="true" required>
                                <div>✅ Présent</div>
                            </label>
                            <label class="status-option absent-option">
                                <input type="radio" name="statut" value="false" required>
                                <div>❌ Absent</div>
                            </label>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModal()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        let currentView = 'cards';

        function setToday() {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            document.getElementById('dateInput').value = `${yyyy}-${mm}-${dd}`;
            updateDisplayDate();
        }

        function changeDate(days) {
            const dateInput = document.getElementById('dateInput');
            const currentDate = new Date(dateInput.value);
            currentDate.setDate(currentDate.getDate() + days);

            const yyyy = currentDate.getFullYear();
            const mm = String(currentDate.getMonth() + 1).padStart(2, '0');
            const dd = String(currentDate.getDate()).padStart(2, '0');
            dateInput.value = `${yyyy}-${mm}-${dd}`;
            updateDisplayDate();
        }

        function updateDisplayDate() {
            const dateInput = document.getElementById('dateInput').value;
            const date = new Date(dateInput + 'T00:00:00');

            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const formattedDate = date.toLocaleDateString('fr-FR', options);
            const capitalizedDate = formattedDate.charAt(0).toUpperCase() + formattedDate.slice(1);

            document.getElementById('displayDate').textContent = capitalizedDate;
        }

        function toggleView(view) {
            currentView = view;
            const cardsView = document.getElementById('cardsView');
            const tableView = document.getElementById('tableView');
            const buttons = document.querySelectorAll('.view-btn');

            buttons.forEach(btn => btn.classList.remove('active'));

            if (view === 'cards') {
                cardsView.style.display = 'grid';
                tableView.style.display = 'none';
                buttons[0].classList.add('active');
            } else {
                cardsView.style.display = 'none';
                tableView.style.display = 'block';
                buttons[1].classList.add('active');
            }
        }

        function togglePresence(employeId, isPresent) {
            const message = isPresent ?
                `Employé #${employeId} marqué comme PRÉSENT` :
                `Employé #${employeId} marqué comme ABSENT`;

            alert(message);

            // Simuler la mise à jour de l'interface
            // Dans une vraie application, ceci enverrait une requête au backend
        }

        function openModal() {
            document.getElementById('presenceModal').classList.add('active');
            document.getElementById('presenceForm').reset();
            document.getElementById('datePresence').value = document.getElementById('dateInput').value;
        }

        function closeModal() {
            document.getElementById('presenceModal').classList.remove('active');
        }

        document.getElementById('presenceForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const employe = document.getElementById('employe').value;
            const date = document.getElementById('datePresence').value;
            const statut = document.querySelector('input[name="statut"]:checked').value;
            const statutText = statut === 'true' ? 'PRÉSENT' : 'ABSENT';

            alert(`Présence enregistrée!\nEmployé: ${employe}\nDate: ${date}\nStatut: ${statutText}`);
            closeModal();
        });

        document.getElementById('searchInput').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();

            if (currentView === 'cards') {
                const cards = document.querySelectorAll('.employee-card');
                cards.forEach(card => {
                    const text = card.textContent.toLowerCase();
                    card.style.display = text.includes(search) ? '' : 'none';
                });
            } else {
                const rows = document.querySelectorAll('#tableView tbody tr');
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(search) ? '' : 'none';
                });
            }
        });

        document.getElementById('dateInput').addEventListener('change', updateDisplayDate);

        document.querySelectorAll('.status-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.status-option').forEach(opt =>
                    opt.classList.remove('selected')
                );
                this.classList.add('selected');
                this.querySelector('input[type="radio"]').checked = true;
            });
        });

        document.getElementById('presenceModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });

        window.addEventListener('DOMContentLoaded', function() {
            setToday();
        });
    </script>
</body>
</html>