<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Employés</title>
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

        .search-box {
            display: flex;
            gap: 10px;
            flex: 1;
            min-width: 250px;
        }

        .search-box input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .search-box input:focus {
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

        .btn-edit {
            background: #5a9c3c;
            color: white;
            padding: 8px 16px;
            font-size: 0.9em;
        }

        .btn-edit:hover {
            background: #4a7c2c;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 0.9em;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .content {
            padding: 30px;
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

        .photo-cell {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .photo-thumb {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0e0e0 0%, #c0c0c0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            color: #666;
            border: 3px solid #4a7c2c;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-role {
            background: #d4edda;
            color: #2d5016;
            border: 1px solid #4a7c2c;
        }

        .badge-genre {
            background: #e2e3e5;
            color: #383d41;
            border: 1px solid #6c757d;
        }

        .actions {
            display: flex;
            gap: 8px;
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a7c2c;
        }

        .stat-card h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 8px;
        }

        .stat-card p {
            color: #4a7c2c;
            font-size: 2em;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🏢 Gestion des Employés</h1>
            <p>Système de gestion des ressources humaines</p>
        </header>

        <div class="controls">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Rechercher un employé...">
            </div>
            <button class="btn btn-primary" onclick="openModal()">+ Nouvel Employé</button>
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card">
                    <h3>Total Employés</h3>
                    <p id="totalEmployes">5</p>
                </div>
                <div class="stat-card">
                    <h3>Rôles</h3>
                    <p id="totalRoles">3</p>
                </div>
                <div class="stat-card">
                    <h3>Nouveaux ce mois</h3>
                    <p id="nouveaux">2</p>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employé</th>
                            <th>Date de Naissance</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Adresse</th>
                            <th>Rôle</th>
                            <th>Genre</th>
                            <th>Actions</th>
                            <th>Ancienneté</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <tr>
                            <td>1</td>
                            <td>
                                <div class="photo-cell">
                                    <div class="photo-thumb">👤</div>
                                    <strong>Jean Dupont</strong>
                                </div>
                            </td>
                            <td>15/03/1985</td>
                            <td>+261 34 12 345 67</td>
                            <td>jean.dupont@email.com</td>
                            <td>Antananarivo, Madagascar</td>
                            <td><span class="badge badge-role">Développeur</span></td>
                            <td><span class="badge badge-genre">Homme</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-edit" onclick="editEmploye(1)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteEmploye(1)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>
                                <div class="photo-cell">
                                    <div class="photo-thumb">👤</div>
                                    <strong>Marie Martin</strong>
                                </div>
                            </td>
                            <td>22/07/1990</td>
                            <td>+261 34 98 765 43</td>
                            <td>marie.martin@email.com</td>
                            <td>Fianarantsoa, Madagascar</td>
                            <td><span class="badge badge-role">Chef de Projet</span></td>
                            <td><span class="badge badge-genre">Femme</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-edit" onclick="editEmploye(2)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteEmploye(2)">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>
                                <div class="photo-cell">
                                    <div class="photo-thumb">👤</div>
                                    <strong>Paul Razafindra</strong>
                                </div>
                            </td>
                            <td>10/11/1988</td>
                            <td>+261 33 45 678 90</td>
                            <td>paul.raza@email.com</td>
                            <td>Toamasina, Madagascar</td>
                            <td><span class="badge badge-role">Analyste</span></td>
                            <td><span class="badge badge-genre">Homme</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-edit" onclick="editEmploye(3)">✏️ Modifier</button>
                                    <button class="btn btn-delete" onclick="deleteEmploye(3)">🗑️ Supprimer</button>
                                </div>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal" id="employeModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Nouvel Employé</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="employeForm">
                    <div class="form-group">
                        <label>Nom Complet *</label>
                        <input type="text" id="nom" required>
                    </div>
                    <div class="form-group">
                        <label>Date de Naissance *</label>
                        <input type="date" id="dateNaissance" required>
                    </div>
                    <div class="form-group">
                        <label>Contact *</label>
                        <input type="tel" id="contact" placeholder="+261 34 12 345 67" required>
                    </div>
                    <div class="form-group">
                        <label>Email *</label>
                        <input type="email" id="email" required>
                    </div>
                    <div class="form-group">
                        <label>Adresse *</label>
                        <input type="text" id="adresse" required>
                    </div>
                    <div class="form-group">
                        <label>Photo (URL)</label>
                        <input type="text" id="photo" placeholder="https://exemple.com/photo.jpg">
                    </div>
                    <div class="form-group">
                        <label>Rôle *</label>
                        <select id="role" required>
                            <option value="">Sélectionner un rôle</option>
                            <option value="1">Développeur</option>
                            <option value="2">Chef de Projet</option>
                            <option value="3">Analyste</option>
                            <option value="4">Manager</option>
                            <option value="5">RH</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Genre *</label>
                        <select id="genre" required>
                            <option value="">Sélectionner un genre</option>
                            <option value="1">Homme</option>
                            <option value="2">Femme</option>
                            <option value="3">Autre</option>
                        </select>
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
        function openModal() {
            document.getElementById('employeModal').classList.add('active');
            document.getElementById('modalTitle').textContent = 'Nouvel Employé';
            document.getElementById('employeForm').reset();
        }

        function closeModal() {
            document.getElementById('employeModal').classList.remove('active');
        }

        function editEmploye(id) {
            openModal();
            document.getElementById('modalTitle').textContent = 'Modifier Employé #' + id;
            // Ici, vous chargeriez les données de l'employé
        }

        function deleteEmploye(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cet employé ?')) {
                alert('Employé #' + id + ' supprimé avec succès!');
                // Ici, vous supprimeriez l'employé
            }
        }

        document.getElementById('employeForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Employé enregistré avec succès!');
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

        // Fermer la modal en cliquant en dehors
        document.getElementById('employeModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
    </script>
</body>
</html>