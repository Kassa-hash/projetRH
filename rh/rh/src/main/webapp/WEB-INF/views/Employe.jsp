
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, com.ressourcesHumaine.rh.entities.*" %>
<%
    // Récupération des données depuis la requête
    List<Employe> employes = (List<Employe>) request.getAttribute("employes");
    Integer totalEmployes = (Integer) request.getAttribute("totalEmployes");
    Integer totalRoles = (Integer) request.getAttribute("totalRoles");
    Integer nouveauxCeMois = (Integer) request.getAttribute("nouveauxCeMois");

    // Valeurs par défaut si null
    if (employes == null) employes = new ArrayList<>();
    if (totalEmployes == null) totalEmployes = 0;
    if (totalRoles == null) totalRoles = 0;
    if (nouveauxCeMois == null) nouveauxCeMois = 0;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
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
            text-decoration: none;
            display: inline-block;
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

        .photo-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
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

        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.2em;
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
            <a href="<%= request.getContextPath() %>/employe/nouveau" class="btn btn-primary">+ Nouvel Employé</a>
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card">
                    <h3>Total Employés</h3>
                    <p><%= totalEmployes %></p>
                </div>
                <div class="stat-card">
                    <h3>Rôles</h3>
                    <p><%= totalRoles %></p>
                </div>
                <div class="stat-card">
                    <h3>Nouveaux ce mois</h3>
                    <p><%= nouveauxCeMois %></p>
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
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <%
                        if (employes.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="9" class="no-data">
                                    Aucun employé trouvé dans la base de données
                                </td>
                            </tr>
                        <%
                        } else {
                            for (Employe employe : employes) {
                        %>
                            <tr>
                                <td><%= employe.getIdEmploye() %></td>
                                <td>
                                    <div class="photo-cell">
                                        <div class="photo-thumb">
                                            <% if (employe.getPhoto() != null && !employe.getPhoto().isEmpty()) { %>
                                                <img src="<%= employe.getPhoto() %>" alt="<%= employe.getNom() %>">
                                            <% } else { %>
                                                👤
                                            <% } %>
                                        </div>
                                        <strong><%= employe.getNom() %></strong>
                                    </div>
                                </td>
                                <td>
                                    <%= employe.getDateDeNaissance() != null ? sdf.format(employe.getDateDeNaissance()) : "N/A" %>
                                </td>
                                <td><%= employe.getContact() != null ? employe.getContact() : "N/A" %></td>
                                <td><%= employe.getEmail() != null ? employe.getEmail() : "N/A" %></td>
                                <td><%= employe.getAdresse() != null ? employe.getAdresse() : "N/A" %></td>
                                <td>
                                    <span class="badge badge-role">
                                        <%= employe.getRole() != null ? employe.getRole().getIdRole(): "N/A" %>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-genre">
                                        <%= employe.getGenre() != null ? employe.getGenre().getLibelle() : "N/A" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="<%= request.getContextPath() %>/employe/modifier/<%= employe.getIdEmploye() %>"
                                           class="btn btn-edit">✏️ Modifier</a>
                                        <form action="<%= request.getContextPath() %>/employe/supprimer/<%= employe.getIdEmploye() %>"
                                              method="post" style="display:inline;"
                                              onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cet employé ?');">
                                            <button type="submit" class="btn btn-delete">🗑️ Supprimer</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#tableBody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(search) ? '' : 'none';
            });
        });
    </script>
</body>
</html>