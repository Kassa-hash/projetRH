<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Contrats</title>
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
            max-width: 1400px;
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

        .filter-group input:focus,
        .filter-group select:focus {
            outline: none;
            border-color: #2d5016;
            box-shadow: 0 0 0 3px rgba(74, 124, 44, 0.2);
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

        .btn-view {
            background: #5a9c3c;
            color: white;
            padding: 8px 16px;
            font-size: 0.85em;
        }

        .btn-view:hover {
            background: #4a7c2c;
        }

        .btn-edit {
            background: #17a2b8;
            color: white;
            padding: 8px 16px;
            font-size: 0.85em;
        }

        .btn-edit:hover {
            background: #138496;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 0.85em;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .content {
            padding: 30px;
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
            border-left: 5px solid #4a7c2c;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .stat-card .stat-value {
            color: #4a7c2c;
            font-size: 2.2em;
            font-weight: bold;
        }

        .stat-card .stat-label {
            color: #999;
            font-size: 0.85em;
            margin-top: 5px;
        }

        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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
            transform: scale(1.01);
        }

        .employe-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .employe-avatar {
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

        .employe-email {
            font-size: 0.85em;
            color: #666;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-cdi {
            background: #d4edda;
            color: #155724;
            border: 2px solid #28a745;
        }

        .badge-cdd {
            background: #fff3cd;
            color: #856404;
            border: 2px solid #ffc107;
        }

        .badge-stage {
            background: #d1ecf1;
            color: #0c5460;
            border: 2px solid #17a2b8;
        }

        .badge-freelance {
            background: #e2e3e5;
            color: #383d41;
            border: 2px solid #6c757d;
        }

        .badge-actif {
            background: #d4edda;
            color: #155724;
        }

        .badge-expire {
            background: #f8d7da;
            color: #721c24;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
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
            max-width: 650px;
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
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #4a7c2c;
            box-shadow: 0 0 0 3px rgba(74, 124, 44, 0.2);
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

        .detail-view {
            padding: 20px;
        }

        .detail-row {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
            width: 200px;
        }

        .detail-value {
            color: #333;
            flex: 1;
        }

        .contract-timeline {
            margin-top: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .timeline-item {
            padding: 10px;
            border-left: 3px solid #4a7c2c;
            margin-left: 10px;
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Gestion des Contrats</h1>
            <p>Suivi et administration des contrats employés</p>
        </header>

        <div class="controls">
            <div class="filter-group">
                <input type="text" id="searchInput" placeholder="🔍 Rechercher un contrat...">
                <select id="filterType">
                    <option value="">Tous les types</option>
                    <option value="cdi">CDI</option>
                    <option value="cdd">CDD</option>
                    <option value="stage">Stage</option>
                    <option value="freelance">Freelance</option>
                </select>
                <select id="filterStatut">
                    <option value="">Tous les statuts</option>
                    <option value="actif">Actif</option>
                    <option value="expire">Expiré</option>
                </select>
            </div>
            <button class="btn btn-primary" onclick="openModal()">+ Nouveau Contrat</button>
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card">
                    <h3>Total Contrats</h3>
                    <div class="stat-value">8</div>
                    <div class="stat-label">Contrats enregistrés</div>
                </div>
                <div class="stat-card">
                    <h3>Contrats Actifs</h3>
                    <div class="stat-value">6</div>
                    <div class="stat-label">En cours</div>
                </div>
                <div class="stat-card">
                    <h3>CDI</h3>
                    <div class="stat-value">4</div>
                    <div class="stat-label">Contrats permanents</div>
                </div>
                <div class="stat-card">
                    <h3>Ce Mois</h3>
                    <div class="stat-value">2</div>
                    <div class="stat-label">Nouveaux contrats</div>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employé</th>
                            <th>Type de Contrat</th>
                            <th>Date de Signature</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <tr>
                            <td>#001</td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Jean Dupont</span>
                                        <span class="employe-email">jean.dupont@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge badge-cdi">CDI</span></td>
                            <td>15/01/2023</td>
                            <td><span class="badge badge-actif">Actif</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-view" onclick="viewContrat(1)">👁️ Voir</button>
                                    <button class="btn btn-edit" onclick="editContrat(1)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteContrat(1)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Marie Martin</span>
                                        <span class="employe-email">marie.martin@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge badge-cdi">CDI</span></td>
                            <td>22/03/2023</td>
                            <td><span class="badge badge-actif">Actif</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-view" onclick="viewContrat(2)">👁️ Voir</button>
                                    <button class="btn btn-edit" onclick="editContrat(2)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteContrat(2)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#003</td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Paul Razafindra</span>
                                        <span class="employe-email">paul.raza@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge badge-cdd">CDD</span></td>
                            <td>10/06/2024</td>
                            <td><span class="badge badge-actif">Actif</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-view" onclick="viewContrat(3)">👁️ Voir</button>
                                    <button class="btn btn-edit" onclick="editContrat(3)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteContrat(3)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#004</td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Sophie Bernard</span>
                                        <span class="employe-email">sophie.b@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge badge-stage">Stage</span></td>
                            <td>01/09/2024</td>
                            <td><span class="badge badge-actif">Actif</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-view" onclick="viewContrat(4)">👁️ Voir</button>
                                    <button class="btn btn-edit" onclick="editContrat(4)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteContrat(4)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#005</td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <div class="employe-details">
                                        <span class="employe-name">Luc Andriamana</span>
                                        <span class="employe-email">luc.a@email.com</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge badge-freelance">Freelance</span></td>
                            <td>15/08/2024</td>
                            <td><span class="badge badge-expire">Expiré</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-view" onclick="viewContrat(5)">👁️ Voir</button>
                                    <button class="btn btn-edit" onclick="editContrat(5)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteContrat(5)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal Ajouter/Modifier -->
    <div class="modal" id="contratModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Nouveau Contrat</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="contratForm">
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
                        <label>Type de Contrat *</label>
                        <select id="typeContrat" required>
                            <option value="">Sélectionner un type</option>
                            <option value="1">CDI - Contrat à Durée Indéterminée</option>
                            <option value="2">CDD - Contrat à Durée Déterminée</option>
                            <option value="3">Stage</option>
                            <option value="4">Freelance</option>
                            <option value="5">Apprentissage</option>
                            <option value="6">Intérim</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Date de Signature *</label>
                        <input type="date" id="dateSignature" required>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModal()">Annuler</button>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Détails -->
    <div class="modal" id="detailModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Détails du Contrat</h2>
                <button class="close-btn" onclick="closeDetailModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="detail-view">
                    <div class="detail-row">
                        <div class="detail-label">ID Contrat:</div>
                        <div class="detail-value">#001</div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Employé:</div>
                        <div class="detail-value">
                            <div class="employe-info">
                                <div class="employe-avatar">👤</div>
                                <div class="employe-details">
                                    <span class="employe-name">Jean Dupont</span>
                                    <span class="employe-email">jean.dupont@email.com</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Type de Contrat:</div>
                        <div class="detail-value"><span class="badge badge-cdi">CDI</span></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Date de Signature:</div>
                        <div class="detail-value">15 Janvier 2023</div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Statut:</div>
                        <div class="detail-value"><span class="badge badge-actif">Actif</span></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Durée:</div>
                        <div class="detail-value">1 an et 10 mois</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('contratModal').classList.add('active');
            document.getElementById('modalTitle').textContent = 'Nouveau Contrat';
            document.getElementById('contratForm').reset();
        }

        function closeModal() {
            document.getElementById('contratModal').classList.remove('active');
        }

        function viewContrat(id) {
            document.getElementById('detailModal').classList.add('active');
        }

        function closeDetailModal() {
            document.getElementById('detailModal').classList.remove('active');
        }

        function editContrat(id) {
            openModal();
            document.getElementById('modalTitle').textContent = 'Modifier Contrat #' + id;
        }

        function deleteContrat(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer ce contrat ?')) {
                alert('Contrat #' + id + ' supprimé avec succès!');
            }
        }

        document.getElementById('contratForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Contrat enregistré avec succès!');
            closeModal();
        });

        document.getElementById('searchInput').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#tableBody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(search) ? '' : 'none';
            });
        });

        document.getElementById('filterType').addEventListener('change', filterTable);
        document.getElementById('filterStatut').addEventListener('change', filterTable);

        function filterTable() {
            const typeFilter = document.getElementById('filterType').value.toLowerCase();
            const statutFilter = document.getElementById('filterStatut').value.toLowerCase();
            const rows = document.querySelectorAll('#tableBody tr');

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                const showType = !typeFilter || text.includes(typeFilter);
                const showStatut = !statutFilter || text.includes(statutFilter);
                row.style.display = (showType && showStatut) ? '' : 'none';
            });
        }

        document.getElementById('contratModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });

        document.getElementById('detailModal').addEventListener('click', function(e) {
            if (e.target === this) closeDetailModal();
        });
    </script>
</body>
</html>