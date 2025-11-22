<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Documents</title>
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

        .btn-download {
            background: #5a9c3c;
            color: white;
            padding: 8px 16px;
            font-size: 0.85em;
        }

        .btn-download:hover {
            background: #4a7c2c;
        }

        .btn-view {
            background: #17a2b8;
            color: white;
            padding: 8px 16px;
            font-size: 0.85em;
        }

        .btn-view:hover {
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

        .documents-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .document-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .document-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
            border-color: #4a7c2c;
        }

        .document-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            margin-bottom: 15px;
            color: white;
        }

        .document-info h3 {
            color: #333;
            font-size: 1.1em;
            margin-bottom: 8px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .document-meta {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin: 15px 0;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9em;
            color: #666;
        }

        .document-actions {
            display: flex;
            gap: 8px;
            margin-top: 15px;
        }

        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: none;
        }

        .table-container.active {
            display: block;
        }

        .documents-grid.active {
            display: grid;
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

        .file-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .file-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            color: white;
        }

        .file-details {
            display: flex;
            flex-direction: column;
        }

        .file-name {
            font-weight: 600;
            color: #333;
        }

        .file-size {
            font-size: 0.85em;
            color: #666;
        }

        .employe-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .employe-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0e0e0 0%, #c0c0c0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
            color: #666;
            border: 3px solid #4a7c2c;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-cv {
            background: #d4edda;
            color: #155724;
            border: 2px solid #28a745;
        }

        .badge-contrat {
            background: #d1ecf1;
            color: #0c5460;
            border: 2px solid #17a2b8;
        }

        .badge-diplome {
            background: #fff3cd;
            color: #856404;
            border: 2px solid #ffc107;
        }

        .badge-attestation {
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #dc3545;
        }

        .badge-autre {
            background: #e2e3e5;
            color: #383d41;
            border: 2px solid #6c757d;
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

        .upload-area {
            border: 3px dashed #4a7c2c;
            border-radius: 8px;
            padding: 40px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .upload-area:hover {
            background: #e9ecef;
            border-color: #2d5016;
        }

        .upload-area input[type="file"] {
            display: none;
        }

        .upload-icon {
            font-size: 3em;
            color: #4a7c2c;
            margin-bottom: 10px;
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
            <h1>📁 Gestion des Documents</h1>
            <p>Bibliothèque de documents RH</p>
        </header>

        <div class="controls">
            <div class="filter-group">
                <input type="text" id="searchInput" placeholder="🔍 Rechercher un document...">
                <select id="filterType">
                    <option value="">Tous les types</option>
                    <option value="cv">CV</option>
                    <option value="contrat">Contrat</option>
                    <option value="diplome">Diplôme</option>
                    <option value="attestation">Attestation</option>
                    <option value="autre">Autre</option>
                </select>
                <select id="filterEmploye">
                    <option value="">Tous les employés</option>
                    <option value="1">Jean Dupont</option>
                    <option value="2">Marie Martin</option>
                    <option value="3">Paul Razafindra</option>
                </select>
            </div>
            <button class="btn btn-primary" onclick="openModal()">📤 Nouveau Document</button>
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card">
                    <h3>Total Documents</h3>
                    <div class="stat-value">42</div>
                    <div class="stat-label">Documents stockés</div>
                </div>
                <div class="stat-card">
                    <h3>Ce Mois</h3>
                    <div class="stat-value">8</div>
                    <div class="stat-label">Nouveaux documents</div>
                </div>
                <div class="stat-card">
                    <h3>Employés</h3>
                    <div class="stat-value">15</div>
                    <div class="stat-label">Avec documents</div>
                </div>
                <div class="stat-card">
                    <h3>Stockage</h3>
                    <div class="stat-value">2.4</div>
                    <div class="stat-label">GB utilisés</div>
                </div>
            </div>

            <div class="view-toggle">
                <button class="view-btn active" onclick="toggleView('grid')">🔲 Grille</button>
                <button class="view-btn" onclick="toggleView('list')">📋 Liste</button>
            </div>

            <!-- Vue Grille -->
            <div class="documents-grid active" id="gridView">
                <div class="document-card">
                    <div class="document-icon">📄</div>
                    <div class="document-info">
                        <h3>CV_Jean_Dupont.pdf</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Jean Dupont</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-cv">CV</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>1.2 MB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(1)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(1)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(1)">🗑️</button>
                    </div>
                </div>

                <div class="document-card">
                    <div class="document-icon">📑</div>
                    <div class="document-info">
                        <h3>Contrat_Marie_Martin.pdf</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Marie Martin</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-contrat">Contrat</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>854 KB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(2)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(2)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(2)">🗑️</button>
                    </div>
                </div>

                <div class="document-card">
                    <div class="document-icon">🎓</div>
                    <div class="document-info">
                        <h3>Diplome_Paul_Razafindra.pdf</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Paul Razafindra</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-diplome">Diplôme</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>2.1 MB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(3)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(3)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(3)">🗑️</button>
                    </div>
                </div>

                <div class="document-card">
                    <div class="document-icon">✅</div>
                    <div class="document-info">
                        <h3>Attestation_Travail.pdf</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Sophie Bernard</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-attestation">Attestation</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>645 KB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(4)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(4)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(4)">🗑️</button>
                    </div>
                </div>

                <div class="document-card">
                    <div class="document-icon">📋</div>
                    <div class="document-info">
                        <h3>Fiche_Poste.docx</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Luc Andriamana</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-autre">Autre</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>421 KB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(5)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(5)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(5)">🗑️</button>
                    </div>
                </div>

                <div class="document-card">
                    <div class="document-icon">📄</div>
                    <div class="document-info">
                        <h3>Lettre_Motivation.pdf</h3>
                        <div class="document-meta">
                            <div class="meta-item">
                                <span>👤</span>
                                <span>Jean Dupont</span>
                            </div>
                            <div class="meta-item">
                                <span class="badge badge-cv">CV</span>
                            </div>
                            <div class="meta-item">
                                <span>📦</span>
                                <span>789 KB</span>
                            </div>
                        </div>
                    </div>
                    <div class="document-actions">
                        <button class="btn btn-download" onclick="downloadDoc(6)">⬇️</button>
                        <button class="btn btn-view" onclick="viewDoc(6)">👁️</button>
                        <button class="btn btn-delete" onclick="deleteDoc(6)">🗑️</button>
                    </div>
                </div>
            </div>

            <!-- Vue Liste -->
            <div class="table-container" id="listView">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Fichier</th>
                            <th>Employé</th>
                            <th>Type</th>
                            <th>Taille</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#001</td>
                            <td>
                                <div class="file-info">
                                    <div class="file-icon">📄</div>
                                    <div class="file-details">
                                        <span class="file-name">CV_Jean_Dupont.pdf</span>
                                        <span class="file-size">Ajouté le 15/10/2024</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <span>Jean Dupont</span>
                                </div>
                            </td>
                            <td><span class="badge badge-cv">CV</span></td>
                            <td>1.2 MB</td>
                            <td>
                                <div class="document-actions">
                                    <button class="btn btn-download" onclick="downloadDoc(1)">⬇️</button>
                                    <button class="btn btn-view" onclick="viewDoc(1)">👁️</button>
                                    <button class="btn btn-delete" onclick="deleteDoc(1)">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>
                                <div class="file-info">
                                    <div class="file-icon">📑</div>
                                    <div class="file-details">
                                        <span class="file-name">Contrat_Marie_Martin.pdf</span>
                                        <span class="file-size">Ajouté le 22/10/2024</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <span>Marie Martin</span>
                                </div>
                            </td>
                            <td><span class="badge badge-contrat">Contrat</span></td>
                            <td>854 KB</td>
                            <td>
                                <div class="document-actions">
                                    <button class="btn btn-download" onclick="downloadDoc(2)">⬇️</button>
                                    <button class="btn btn-view" onclick="viewDoc(2)">👁️</button>
                                    <button class="btn btn-delete" onclick="deleteDoc(2)">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#003</td>
                            <td>
                                <div class="file-info">
                                    <div class="file-icon">🎓</div>
                                    <div class="file-details">
                                        <span class="file-name">Diplome_Paul_Razafindra.pdf</span>
                                        <span class="file-size">Ajouté le 05/11/2024</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="employe-info">
                                    <div class="employe-avatar">👤</div>
                                    <span>Paul Razafindra</span>
                                </div>
                            </td>
                            <td><span class="badge badge-diplome">Diplôme</span></td>
                            <td>2.1 MB</td>
                            <td>
                                <div class="document-actions">
                                    <button class="btn btn-download" onclick="downloadDoc(3)">⬇️</button>
                                    <button class="btn btn-view" onclick="viewDoc(3)">👁️</button>
                                    <button class="btn btn-delete" onclick="deleteDoc(3)">🗑️</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal Upload -->
    <div class="modal" id="documentModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>📤 Ajouter un Document</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="documentForm">
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
                        <label>Type de Document *</label>
                        <select id="typeDocument" required>
                            <option value="">Sélectionner un type</option>
                            <option value="1">CV</option>
                            <option value="2">Contrat de Travail</option>
                            <option value="3">Diplôme</option>
                            <option value="4">Attestation</option>
                            <option value="5">Certificat</option>
                            <option value="6">Fiche de Poste</option>
                            <option value="7">Autre</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Fichier *</label>
                        <div class="upload-area" onclick="document.getElementById('fileInput').click()">
                            <input type="file" id="fileInput" accept=".pdf,.doc,.docx,.jpg,.png" required>
                            <div class="upload-icon">☁️</div>
                            <p><strong>Cliquez pour sélectionner un fichier</strong></p>
                            <p style="color: #999; font-size: 0.9em; margin-top: 5px;">
                                PDF, DOC, DOCX, JPG, PNG (Max 10 MB)
                            </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Nom du Fichier</label>
                        <input type="text" id="nomFichier" placeholder="Ex: CV_Jean_Dupont" readonly>
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
        let currentView = 'grid';

        function toggleView(view) {
            currentView = view;
            const gridView = document.getElementById('gridView');
            const listView = document.getElementById('listView');
            const buttons = document.querySelectorAll('.view-btn');

            buttons.forEach(btn => btn.classList.remove('active'));

            if (view === 'grid') {
                gridView.classList.add('active');
                listView.classList.remove('active');
                buttons[0].classList.add('active');
            } else {
                gridView.classList.remove('active');
                listView.classList.add('active');
                buttons[1].classList.add('active');
            }
        }

        function openModal() {
            document.getElementById('documentModal').classList.add('active');
            document.getElementById('documentForm').reset();
            document.getElementById('nomFichier').value = '';
        }

        function closeModal() {
            document.getElementById('documentModal').classList.remove('active');
        }

        function downloadDoc(id) {
            alert('Téléchargement du document #' + id);
        }

        function viewDoc(id) {
            alert('Aperçu du document #' + id);
        }

        function deleteDoc(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer ce document ?')) {
                alert('Document #' + id + ' supprimé avec succès!');
            }
        }

        document.getElementById('fileInput').addEventListener('change', function(e) {
            const fileName = e.target.files[0]?.name || '';
            document.getElementById('nomFichier').value = fileName;
        });

        document.getElementById('documentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Document enregistré avec succès!');
            closeModal();
        });

        document.getElementById('searchInput').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();

            if (currentView === 'grid') {
                const cards = document.querySelectorAll('.document-card');
                cards.forEach(card => {
                    const text = card.textContent.toLowerCase();
                    card.style.display = text.includes(search) ? '' : 'none';
                });
            } else {
                const rows = document.querySelectorAll('#listView tbody tr');
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(search) ? '' : 'none';
                });
            }
        });

        document.getElementById('filterType').addEventListener('change', filterDocuments);
        document.getElementById('filterEmploye').addEventListener('change', filterDocuments);

        function filterDocuments() {
            const typeFilter = document.getElementById('filterType').value.toLowerCase();
            const employeFilter = document.getElementById('filterEmploye').value;

            if (currentView === 'grid') {
                const cards = document.querySelectorAll('.document-card');
                cards.forEach(card => {
                    const text = card.textContent.toLowerCase();
                    const showType = !typeFilter || text.includes(typeFilter);
                    const showEmploye = !employeFilter || card.dataset.employe === employeFilter;
                    card.style.display = (showType && showEmploye) ? '' : 'none';
                });
            } else {
                const rows = document.querySelectorAll('#listView tbody tr');
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    const showType = !typeFilter || text.includes(typeFilter);
                    const showEmploye = !employeFilter || row.dataset.employe === employeFilter;
                    row.style.display = (showType && showEmploye) ? '' : 'none';
                });
            }
        }

        document.getElementById('documentModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });
    </script>
</body>
</html>