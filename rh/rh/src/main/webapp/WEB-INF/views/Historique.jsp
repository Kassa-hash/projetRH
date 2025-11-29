<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Historique" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historique des Activités - RH Manager</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #2d5016 0%, #1a1a1a 100%);
            color: white;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 12px rgba(0, 0, 0, 0.3);
            z-index: 100;
        }

        .logo {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }

        .logo h1 {
            font-size: 1.8em;
            margin-bottom: 5px;
        }

        .logo p {
            font-size: 0.9em;
            opacity: 0.8;
        }

        .menu {
            flex: 1;
            padding: 20px 0;
            overflow-y: auto;
        }

        .menu a {
            text-decoration: none;
            color: inherit;
        }

        .menu-item {
            padding: 15px 25px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 15px;
            border-left: 4px solid transparent;
        }

        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
            border-left-color: #5a9c3c;
        }

        .menu-item.active {
            background: rgba(90, 156, 60, 0.3);
            border-left-color: #5a9c3c;
        }

        .menu-item i {
            font-size: 1.5em;
            width: 30px;
            text-align: center;
        }

        .menu-item span {
            font-weight: 500;
            font-size: 1.05em;
        }

        .user-section {
            padding: 20px;
            border-top: 2px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #5a9c3c;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
        }

        .user-info h3 {
            font-size: 1em;
            margin-bottom: 3px;
        }

        .user-info p {
            font-size: 0.85em;
            opacity: 0.8;
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .topbar {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar h2 {
            color: #333;
            font-size: 1.8em;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .content-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            background: #f5f5f5;
        }

        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .filter-group label {
            font-size: 0.9em;
            color: #666;
            font-weight: 600;
        }

        .filter-group input,
        .filter-group select {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
            min-width: 200px;
        }

        .filter-group input:focus,
        .filter-group select:focus {
            outline: none;
            border-color: #4a7c2c;
        }

        .filter-btn {
            padding: 10px 25px;
            background: #4a7c2c;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 20px;
        }

        .filter-btn:hover {
            background: #3d6624;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(74, 124, 44, 0.3);
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }

        .stat-mini {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-left: 4px solid #4a7c2c;
        }

        .stat-mini.blue {
            border-left-color: #17a2b8;
        }

        .stat-mini.green {
            border-left-color: #28a745;
        }

        .stat-mini.yellow {
            border-left-color: #ffc107;
        }

        .stat-mini.red {
            border-left-color: #dc3545;
        }

        .stat-mini h4 {
            color: #666;
            font-size: 0.85em;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .stat-mini .value {
            font-size: 2em;
            font-weight: bold;
            color: #333;
        }

        .timeline-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .timeline-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }

        .timeline-header h3 {
            font-size: 1.5em;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .timeline {
            position: relative;
            padding-left: 50px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 20px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: linear-gradient(180deg, #4a7c2c 0%, #e0e0e0 100%);
        }

        .timeline-item {
            position: relative;
            padding: 20px;
            margin-bottom: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }

        .timeline-item:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            background: white;
        }

        .timeline-item.blue {
            border-left-color: #17a2b8;
        }

        .timeline-item.green {
            border-left-color: #28a745;
        }

        .timeline-item.yellow {
            border-left-color: #ffc107;
        }

        .timeline-item.red {
            border-left-color: #dc3545;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -34px;
            top: 25px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: white;
            border: 3px solid #4a7c2c;
            z-index: 1;
        }

        .timeline-item.blue::before {
            border-color: #17a2b8;
        }

        .timeline-item.green::before {
            border-color: #28a745;
        }

        .timeline-item.yellow::before {
            border-color: #ffc107;
        }

        .timeline-item.red::before {
            border-color: #dc3545;
        }

        .timeline-header-item {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 10px;
        }

        .timeline-icon {
            font-size: 2em;
            margin-right: 15px;
        }

        .timeline-title {
            font-size: 1.1em;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .timeline-description {
            color: #666;
            line-height: 1.5;
            margin-bottom: 8px;
        }

        .timeline-details {
            color: #888;
            font-size: 0.9em;
            font-style: italic;
        }

        .timeline-time {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #999;
            font-size: 0.9em;
            font-weight: 600;
        }

        .timeline-date {
            background: #e9ecef;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
        }

        .badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8em;
            font-weight: 600;
        }

        .badge.success {
            background: #d4edda;
            color: #155724;
        }

        .badge.danger {
            background: #f8d7da;
            color: #721c24;
        }

        .badge.warning {
            background: #fff3cd;
            color: #856404;
        }

        .badge.info {
            background: #d1ecf1;
            color: #0c5460;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 1.3em;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 0.95em;
        }

        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
            }

            .filter-section {
                flex-direction: column;
            }

            .filter-group input,
            .filter-group select {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <h1>🏢 RH Manager</h1>
            <p>Système de Gestion RH</p>
        </div>

        <div class="menu">
            <a href="/"><div class="menu-item">
                <i>📊</i>
                <span>Tableau de Bord</span>
            </div></a>
            <a href="/employes"><div class="menu-item">
                <i>👥</i>
                <span>Employés</span>
            </div></a>
            <a href="/contrats"><div class="menu-item">
                <i>📋</i>
                <span>Contrats</span>
            </div></a>
            <div class="menu-item">
                <i>📁</i>
                <span>Demandes</span>
            </div>
            <a href="/presences"><div class="menu-item">
                <i>✅</i>
                <span>Présences</span>
            </div></a>
            <a href="/pointages"><div class="menu-item">
                <i>⏰</i>
                <span>Pointages</span>
            </div></a>
            <div class="menu-item">
                <i>⏱️</i>
                <span>Heures Supp</span>
            </div>
            <a href="/demandes"><div class="menu-item">
                <i>🏖️</i>
                <span>Congés</span>
            </div></a>
            <a href="/employes/goLogin"><div class="menu-item">
                <i>👥</i>
                <span>Utilisateur</span>
            </div></a>
            <div class="menu-item">
                <i>💰</i>
                <span>Avances</span>
            </div>
            <a href="/listeHistorique"><div class="menu-item active">
                <i>📜</i>
                <span>Historique</span>
            </div></a>
            <div class="menu-item">
                <i>⚙️</i>
                <span>Paramètres</span>
            </div>
        </div>

        <div class="user-section">
            <div class="user-avatar">👤</div>
            <div class="user-info">
                <h3>Admin RH</h3>
                <p>Administrateur</p>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="topbar">
            <h2>
                <span>📜</span>
                Historique des Activités
            </h2>
        </div>

        <div class="content-area">
            <!-- Filtres de recherche -->
            <!--<div class="filter-section">
                <div class="filter-group">
                    <label>🔍 Recherche</label>
                    <input type="text" id="searchInput" placeholder="Rechercher une activité...">
                </div>
                <div class="filter-group">
                    <label>📅 Date de début</label>
                    <input type="date" id="dateDebut">
                </div>
                <div class="filter-group">
                    <label>📅 Date de fin</label>
                    <input type="date" id="dateFin">
                </div>
                <div class="filter-group">
                    <label>📂 Type d'action</label>
                    <select id="typeAction">
                        <option value="">Tous les types</option>
                        <option value="employe">Employé</option>
                        <option value="conge">Congé</option>
                        <option value="avance">Avance</option>
                        <option value="contrat">Contrat</option>
                    </select>
                </div>
                <button class="filter-btn" onclick="filtrerHistorique()">Filtrer</button>
            </div>-->

            <!-- Statistiques rapides -->
            <div class="stats-row">
                <div class="stat-mini blue">
                    <h4>Total d'activités</h4>
                    <div class="value" id="totalActivites">
                        <% 
                            List<Historique> historiques = (List<Historique>) request.getAttribute("historique");
                            int total = (historiques != null) ? historiques.size() : 0;
                            out.print(total);
                        %>
                    </div>
                </div>
                <div class="stat-mini green">
                    <h4>Aujourd'hui</h4>
                    <div class="value" id="activitesJour">
                        <% 
                            if (historiques != null) {
                                long aujourdhui = historiques.stream()
                                    .filter(h -> h.getMomentAction().toLocalDate().equals(java.time.LocalDate.now()))
                                    .count();
                                out.print(aujourdhui);
                            } else {
                                out.print(0);
                            }
                        %>
                    </div>
                </div>
                <div class="stat-mini yellow">
                    <h4>Cette semaine</h4>
                    <div class="value" id="activitesSemaine">
                        <% 
                            if (historiques != null) {
                                java.time.LocalDate debut = java.time.LocalDate.now().minusDays(7);
                                long semaine = historiques.stream()
                                    .filter(h -> h.getMomentAction().toLocalDate().isAfter(debut))
                                    .count();
                                out.print(semaine);
                            } else {
                                out.print(0);
                            }
                        %>
                    </div>
                </div>
                <div class="stat-mini red">
                    <h4>Ce mois</h4>
                    <div class="value" id="activitesMois">
                        <% 
                            if (historiques != null) {
                                java.time.YearMonth moisActuel = java.time.YearMonth.now();
                                long mois = historiques.stream()
                                    .filter(h -> java.time.YearMonth.from(h.getMomentAction()).equals(moisActuel))
                                    .count();
                                out.print(mois);
                            } else {
                                out.print(0);
                            }
                        %>
                    </div>
                </div>
            </div>

            <!-- Timeline des activités -->
            <div class="timeline-container">
                <div class="timeline-header">
                    <h3>⏱️ Chronologie des événements</h3>
                </div>

                <div class="timeline" id="timelineContent">
                    <% 
                        if (historiques != null && !historiques.isEmpty()) {
                            java.text.SimpleDateFormat sdfDate = new java.text.SimpleDateFormat("dd/MM/yyyy");
                            java.text.SimpleDateFormat sdfTime = new java.text.SimpleDateFormat("HH:mm");
                            
                            for (Historique h : historiques) {
                                String colorClass = "blue";
                                String emoji = "📋";
                                String badgeClass = "info";
                                String badgeText = "Information";
                                
                                String desc = (h.getDescription() != null) ? h.getDescription().toLowerCase() : "";
                                String classe = (h.getClasse() != null) ? h.getClasse().getSimpleName() : "";
                                
                                // Déterminer la couleur et l'icône
                                if (desc.contains("refus")) {
                                    colorClass = "red";
                                    emoji = "❌";
                                    badgeClass = "danger";
                                    badgeText = "Refusé";
                                } else if (desc.contains("approuv") || desc.contains("valid") || desc.contains("accept")) {
                                    colorClass = "green";
                                    emoji = "✅";
                                    badgeClass = "success";
                                    badgeText = "Approuvé";
                                } else if (desc.contains("créé") || desc.contains("ajout") || desc.contains("enregistr")) {
                                    colorClass = "blue";
                                    emoji = "🆕";
                                    badgeClass = "info";
                                    badgeText = "Création";
                                } else if (desc.contains("modif") || desc.contains("mis à jour") || desc.contains("chang")) {
                                    colorClass = "yellow";
                                    emoji = "✏️";
                                    badgeClass = "warning";
                                    badgeText = "Modification";
                                }
                                
                                // Icône selon le type d'entité
                                if ("DemandeConge".equals(classe)) {
                                    emoji = "🏖️";
                                } else if ("DemandeAvance".equals(classe)) {
                                    emoji = "💰";
                                } else if ("Employe".equals(classe)) {
                                    emoji = "👤";
                                } else if ("Contrat".equals(classe) || "ContratEmploye".equals(classe)) {
                                    emoji = "📋";
                                }
                                
                                java.util.Date dateAction = java.util.Date.from(
                                    h.getMomentAction().atZone(java.time.ZoneId.systemDefault()).toInstant()
                                );
                    %>
                    <div class="timeline-item <%= colorClass %>" data-type="<%= classe.toLowerCase() %>" data-date="<%= sdfDate.format(dateAction) %>">
                        <div class="timeline-header-item">
                            <div class="timeline-title">
                                <span class="timeline-icon"><%= emoji %></span>
                                <%= h.getDescription() %>
                            </div>
                            <span class="badge <%= badgeClass %>"><%= badgeText %></span>
                        </div>
                        <% if (h.getDetails() != null && !h.getDetails().isEmpty()) { %>
                        <div class="timeline-description">
                            <%= h.getDetails() %>
                        </div>
                        <% } %>
                        <div class="timeline-time">
                            <span>🕐</span>
                            <span class="timeline-date"><%= sdfDate.format(dateAction) %></span>
                            <span>à <%= sdfTime.format(dateAction) %></span>
                            <% if (h.getClasse() != null) { %>
                            <span style="margin-left: 10px; color: #4a7c2c; font-weight: 600;">
                                [<%= h.getClasse().getSimpleName() %>]
                            </span>
                            <% } %>
                        </div>
                    </div>
                    <% 
                            }
                        } else { 
                    %>
                    <div class="empty-state">
                        <i>📭</i>
                        <h3>Aucune activité enregistrée</h3>
                        <p>L'historique des activités apparaîtra ici au fur et à mesure</p>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Fonction de filtrage
        function filtrerHistorique() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const dateDebut = document.getElementById('dateDebut').value;
            const dateFin = document.getElementById('dateFin').value;
            const typeAction = document.getElementById('typeAction').value.toLowerCase();
            
            const items = document.querySelectorAll('.timeline-item');
            let visibleCount = 0;
            
            items.forEach(item => {
                let visible = true;
                
                // Filtre par recherche textuelle
                if (searchTerm && !item.textContent.toLowerCase().includes(searchTerm)) {
                    visible = false;
                }
                
                // Filtre par type
                if (typeAction && !item.dataset.type.includes(typeAction)) {
                    visible = false;
                }
                
                // Filtre par date
                const itemDate = item.dataset.date;
                if (dateDebut || dateFin) {
                    const itemDateParts = itemDate.split('/');
                    const itemDateObj = new Date(itemDateParts[2], itemDateParts[1] - 1, itemDateParts[0]);
                    
                    if (dateDebut) {
                        const debutObj = new Date(dateDebut);
                        if (itemDateObj < debutObj) visible = false;
                    }
                    
                    if (dateFin) {
                        const finObj = new Date(dateFin);
                        if (itemDateObj > finObj) visible = false;
                    }
                }
                
                item.style.display = visible ? 'block' : 'none';
                if (visible) visibleCount++;
            });
            
            // Afficher un message si aucun résultat
            const timeline = document.getElementById('timelineContent');
            let emptyMsg = timeline.querySelector('.empty-search-msg');
            
            if (visibleCount === 0 && items.length > 0) {
                if (!emptyMsg) {
                    emptyMsg = document.createElement('div');
                    emptyMsg.className = 'empty-state empty-search-msg';
                    emptyMsg.innerHTML = '<i>🔍</i><h3>Aucun résultat trouvé</h3><p>Essayez de modifier vos critères de recherche</p>';
                    timeline.appendChild(emptyMsg);
                }
            } else if (emptyMsg) {
                emptyMsg.remove();
            }
        }
        
        // Recherche en temps réel
        document.getElementById('searchInput').addEventListener('input', filtrerHistorique);
        
        // Activer l'élément du menu
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>