<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.ressourcesHumaine.rh.entities.DemandeConge" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Motif" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Mois" %>

<%
    com.ressourcesHumaine.rh.entities.Employe emp =
            (com.ressourcesHumaine.rh.entities.Employe) session.getAttribute("utilisateur");

    if (emp == null) {
        response.sendRedirect("/employes/login");
        return;
    }
    
    // Récupérer les congés validés depuis le controller
    List<DemandeConge> congesValides = (List<DemandeConge>) session.getAttribute("congesValides");

    //toutes les demandes
    List<DemandeConge> toutesDemandes=(List<DemandeConge>) request.getAttribute("demandesConge");

    //liste des motifs
    List<Motif> motifs=(List<Motif>) session.getAttribute("motifs");

    //liste des mois
    List<Mois> mois=(List<Mois>) session.getAttribute("mois");

    //message
    String message=(String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil Employé</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, sans-serif; }
        body { background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%); min-height: 100vh; display: flex; }

        /* SIDEBAR */
        .sidebar { width: 280px; background: linear-gradient(180deg, #1b5e20 0%, #2e7d32 50%, #388e3c 100%); height: 100vh; padding: 25px 20px; color: white; position: fixed; left: 0; transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15); z-index: 1000; overflow-y: auto; }
        .sidebar-header { text-align: center; padding-bottom: 25px; border-bottom: 1px solid rgba(255, 255, 255, 0.2); margin-bottom: 25px; }
        .sidebar-header h2 { font-size: 1.5em; font-weight: 700; letter-spacing: 1px; }
        .sidebar-header .logo-icon { font-size: 2.5em; margin-bottom: 10px; display: block; }
        .nav-section { margin-bottom: 20px; }
        .nav-section-title { font-size: 0.75em; text-transform: uppercase; letter-spacing: 2px; color: rgba(255, 255, 255, 0.6); margin-bottom: 12px; padding-left: 12px; }
        .sidebar a { display: flex; align-items: center; gap: 12px; padding: 14px 18px; background: rgba(255, 255, 255, 0.1); margin-bottom: 8px; border-radius: 12px; color: white; text-decoration: none; transition: all 0.3s ease; font-weight: 500; font-size: 0.95em; border: 1px solid transparent; cursor: pointer; }
        .sidebar a:hover, .sidebar a.active { background: rgba(255, 255, 255, 0.25); transform: translateX(8px); border-color: rgba(255, 255, 255, 0.3); box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); }
        .sidebar a .icon { font-size: 1.3em; }

        /* Toggle Button */
        .toggle-btn { position: fixed; left: 290px; top: 25px; background: linear-gradient(135deg, #2e7d32, #1b5e20); color: white; padding: 12px 16px; cursor: pointer; border-radius: 12px; transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); z-index: 1001; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); font-size: 1.2em; }
        .toggle-btn:hover { background: linear-gradient(135deg, #388e3c, #2e7d32); transform: scale(1.05); }
        .collapsed { left: -280px; }
        .collapsed-btn { left: 25px !important; }

        /* CONTENT */
        .content { margin-left: 280px; padding: 40px; width: 100%; transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); min-height: 100vh; }
        .collapsed-content { margin-left: 0 !important; }

        /* Welcome Banner */
        .welcome-banner { background: linear-gradient(135deg, #1b5e20 0%, #4caf50 100%); color: white; padding: 35px 40px; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 10px 40px rgba(27, 94, 32, 0.3); animation: slideDown 0.6s ease; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }
        .welcome-banner h1 { font-size: 2em; margin-bottom: 8px; font-weight: 700; }
        .welcome-banner p { opacity: 0.9; font-size: 1.1em; }

        /* Section containers */
        .section-container { display: none; animation: fadeInUp 0.5s ease; }
        .section-container.active { display: block; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }

        /* Cards */
        .card { background: white; padding: 30px; border-radius: 20px; box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1); border: 1px solid rgba(0, 0, 0, 0.05); transition: all 0.3s ease; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15); }
        .card-header { display: flex; align-items: center; gap: 15px; margin-bottom: 25px; padding-bottom: 20px; border-bottom: 2px solid #e8f5e9; }
        .card-icon { width: 50px; height: 50px; background: linear-gradient(135deg, #4caf50, #2e7d32); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5em; }
        .card-title { font-size: 1.4em; color: #1b5e20; font-weight: 700; }
        .info-grid { display: grid; gap: 15px; }
        .info-item { display: flex; align-items: center; gap: 12px; padding: 12px 15px; background: #f8fdf8; border-radius: 10px; transition: all 0.3s ease; }
        .info-item:hover { background: #e8f5e9; transform: translateX(5px); }
        .info-item .label { font-weight: 600; color: #2e7d32; min-width: 140px; font-size: 0.9em; }
        .info-item .value { color: #333; font-size: 0.95em; }
        .info-item .item-icon { font-size: 1.2em; }

        /* CALENDAR */
        .calendar-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; flex-wrap: wrap; gap: 15px; }
        .calendar-nav { display: flex; align-items: center; gap: 15px; }
        .calendar-nav button { background: linear-gradient(135deg, #4caf50, #2e7d32); color: white; border: none; width: 42px; height: 42px; border-radius: 10px; cursor: pointer; font-size: 1.2em; transition: all 0.3s ease; }
        .calendar-nav button:hover { transform: scale(1.1); box-shadow: 0 5px 15px rgba(46, 125, 50, 0.4); }
        .calendar-month-year { font-size: 1.4em; font-weight: 700; color: #1b5e20; min-width: 200px; text-align: center; }
        .calendar-legend { display: flex; gap: 20px; flex-wrap: wrap; }
        .legend-item { display: flex; align-items: center; gap: 8px; font-size: 0.85em; color: #555; }
        .legend-dot { width: 12px; height: 12px; border-radius: 3px; }
        .legend-dot.conge { background: linear-gradient(135deg, #4caf50, #2e7d32); }
        .legend-dot.today { background: #2196f3; }
        .calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); gap: 6px; }

        /* TABLE STYLES */
        .table-container { overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .data-table th, .data-table td { padding: 14px 16px; text-align: left; border-bottom: 1px solid #e8f5e9; }
        .data-table th { background: linear-gradient(135deg, #1b5e20, #2e7d32); color: white; font-weight: 600; font-size: 0.9em; text-transform: uppercase; letter-spacing: 0.5px; }
        .data-table tr:hover { background: #f1f8e9; }
        .data-table td { font-size: 0.95em; color: #333; }
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 0.8em; font-weight: 600; text-transform: capitalize; }
        .status-validee { background: #c8e6c9; color: #2e7d32; }
        .status-refusee { background: #ffcdd2; color: #c62828; }
        .status-en-attente { background: #fff3e0; color: #e65100; }
        .no-data-msg { text-align: center; padding: 40px; color: #888; }
        .no-data-msg .icon { font-size: 3em; margin-bottom: 10px; display: block; }

        .calendar-day-header { text-align: center; font-weight: 700; color: #1b5e20; padding: 12px 5px; font-size: 0.85em; text-transform: uppercase; letter-spacing: 1px; }
        .calendar-day { aspect-ratio: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; border-radius: 10px; cursor: default; transition: all 0.3s ease; position: relative; background: #f8fdf8; min-height: 55px; }
        .calendar-day:hover:not(.empty) { transform: scale(1.05); box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); }
        .calendar-day.empty { background: transparent; }
        .calendar-day .day-number { font-size: 1em; font-weight: 600; color: #333; }
        .calendar-day.today { background: linear-gradient(135deg, #2196f3, #1976d2); }
        .calendar-day.today .day-number { color: white; }
        .calendar-day.conge { background: linear-gradient(135deg, #4caf50, #2e7d32); cursor: pointer; }
        .calendar-day.conge .day-number { color: white; }
        .calendar-day.conge:hover { transform: scale(1.08); box-shadow: 0 8px 25px rgba(46, 125, 50, 0.4); }
        .conge-badge { font-size: 0.65em; background: rgba(255,255,255,0.3); padding: 2px 6px; border-radius: 4px; margin-top: 2px; color: white; }
        .calendar-day.conge[data-tooltip]:hover::after { content: attr(data-tooltip); position: absolute; bottom: 105%; left: 50%; transform: translateX(-50%); background: #333; color: white; padding: 8px 12px; border-radius: 8px; font-size: 0.75em; white-space: nowrap; z-index: 100; }

        /* MODAL */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); backdrop-filter: blur(5px); display: none; justify-content: center; align-items: center; z-index: 2000; }
        .modal { background: white; width: 90%; max-width: 500px; border-radius: 24px; overflow: hidden; box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3); animation: slideUp 0.4s ease; }
        @keyframes slideUp { from { opacity: 0; transform: translateY(50px) scale(0.95); } to { opacity: 1; transform: translateY(0) scale(1); } }
        .modal-header { background: linear-gradient(135deg, #1b5e20 0%, #4caf50 100%); color: white; padding: 25px 30px; display: flex; justify-content: space-between; align-items: center; }
        .modal-header.orange { background: linear-gradient(135deg, #e65100 0%, #ff9800 100%); }
        .modal-header h3 { font-size: 1.4em; font-weight: 700; display: flex; align-items: center; gap: 12px; }
        .close-btn { background: rgba(255, 255, 255, 0.2); border: none; color: white; width: 40px; height: 40px; border-radius: 50%; cursor: pointer; font-size: 1.5em; transition: all 0.3s ease; display: flex; align-items: center; justify-content: center; }
        .close-btn:hover { background: rgba(255, 255, 255, 0.3); transform: rotate(90deg); }
        .modal-body { padding: 30px; }
        .form-group { margin-bottom: 22px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #333; font-size: 0.95em; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 14px 18px; border: 2px solid #e0e0e0; border-radius: 12px; font-size: 1em; transition: all 0.3s ease; background: #fafafa; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #4caf50; background: white; box-shadow: 0 0 0 4px rgba(76, 175, 80, 0.1); }
        .form-group textarea { resize: vertical; min-height: 100px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .submit-btn { width: 100%; padding: 16px; background: linear-gradient(135deg, #4caf50, #2e7d32); color: white; border: none; border-radius: 12px; font-size: 1.1em; font-weight: 700; cursor: pointer; transition: all 0.3s ease; margin-top: 10px; }
        .submit-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(46, 125, 50, 0.4); }
        .submit-btn.orange { background: linear-gradient(135deg, #ff9800, #f57c00); }
        .submit-btn.orange:hover { box-shadow: 0 8px 25px rgba(255, 152, 0, 0.4); }

        /* No data message */
        .no-data { text-align: center; padding: 40px; color: #666; }
        .no-data .icon { font-size: 3em; margin-bottom: 15px; }

        @media (max-width: 768px) {
            .sidebar { width: 100%; height: auto; position: relative; }
            .content { margin-left: 0; padding: 20px; }
            .toggle-btn { display: none; }
            .form-row { grid-template-columns: 1fr; }
            .calendar-header { flex-direction: column; }
            .calendar-day { min-height: 40px; }
        }

        /* Message neutre - style propre et discret */
.message-info {
    margin: 25px 0;
    padding: 18px 24px;
    background: #f5f7fa;
    border-left: 5px solid #4a90e2;
    border-radius: 0 12px 12px 0;
    font-weight: 600;
    color: #2c3e50;
    font-size: 1.05em;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    animation: fadeIn 0.6s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div id="sidebar" class="sidebar">
    <div class="sidebar-header">
        <span class="logo-icon">🏢</span>
        <h2>RH Portail</h2>
    </div>

    <div class="nav-section">
        <div class="nav-section-title">Navigation</div>
        <a href="#" onclick="showSection('accueil')" id="nav-accueil" class="active">
            <span class="icon">🏠</span> Accueil
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-section-title">Demandes</div>
        <a href="#" onclick="openModal('conge')">
            <span class="icon">🏖️</span> Demande de congé
        </a>
        <a href="#" onclick="openModal('avance')">
            <span class="icon">💰</span> Demande d'avance
        </a>
        <a href="#" onclick="showSection('listeDemandes')" id="nav-listeDemandes">
            <span class="icon">📋</span> Mes demandes de congé
        </a>
        <a href="#" onclick="showSection('planning')" id="nav-planning">
            <span class="icon">📅</span> Planning congés
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-section-title">Compte</div>
        <a href="/employes/goAccueil">
            <span class="icon">👤</span> Mon profil
        </a>
        <a href="/">
            <span class="icon">🚪</span> Déconnexion
        </a>
    </div>
</div>

<div id="toggle" class="toggle-btn" onclick="toggleSidebar()">☰</div>

<!-- CONTENT -->
<div id="content" class="content">
    <div class="welcome-banner">
        <h1>Bienvenue, <%= emp.getNom() %> 👋</h1>
        <p>Gérez vos demandes et consultez vos informations personnelles</p>
    </div>

    <div class="message-info">
        <% if(message!=null && !message.isEmpty()){%>
            <p><%= message %></p>
        <% }%>
    </div>

    <!-- SECTION ACCUEIL -->
    <div id="section-accueil" class="section-container active">
        <div class="card">
            <div class="card-header">
                <div class="card-icon">👤</div>
                <div class="card-title">Mes Informations</div>
            </div>
            <div class="info-grid">
                <div class="info-item"><span class="item-icon">📛</span><span class="label">Nom complet</span><span class="value"><%= emp.getNom() %></span></div>
                <div class="info-item"><span class="item-icon">🎂</span><span class="label">Date de naissance</span><span class="value"><%= emp.getDateDeNaissance() %></span></div>
                <div class="info-item"><span class="item-icon">📍</span><span class="label">Adresse</span><span class="value"><%= emp.getAdresse() %></span></div>
                <div class="info-item"><span class="item-icon">📧</span><span class="label">Email</span><span class="value"><%= emp.getEmail() %></span></div>
                <div class="info-item"><span class="item-icon">📱</span><span class="label">Contact</span><span class="value"><%= emp.getContact() %></span></div>
            </div>
        </div>
    </div>

    <!-- SECTION PLANNING -->
    <div id="section-planning" class="section-container">
        <div class="card">
            <div class="card-header">
                <div class="card-icon">📅</div>
                <div class="card-title">Planning de mes Congés Validés</div>
            </div>
            <div class="calendar-header">
                <div class="calendar-nav">
                    <button onclick="changeMonth(-1)">❮</button>
                    <span id="calendar-month-year" class="calendar-month-year"></span>
                    <button onclick="changeMonth(1)">❯</button>
                </div>
                <div class="calendar-legend">
                    <div class="legend-item"><span class="legend-dot conge"></span><span>Congé validé</span></div>
                    <div class="legend-item"><span class="legend-dot today"></span><span>Aujourd'hui</span></div>
                </div>
            </div>
            <div id="calendar-grid" class="calendar-grid"></div>
        </div>
    </div>

    <!-- SECTION LISTE DES DEMANDES -->
    <div id="section-listeDemandes" class="section-container">
        <div class="card">
            <div class="card-header">
                <div class="card-icon">📋</div>
                <div class="card-title">Mes Demandes de Congé</div>
            </div>
            <div class="table-container">
                <% if (toutesDemandes != null && !toutesDemandes.isEmpty()) { %>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Motif</th>
                            <th>Date Début</th>
                            <th>Date Fin</th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        java.text.SimpleDateFormat sdfTable = new java.text.SimpleDateFormat("dd/MM/yyyy");
                        for (DemandeConge demande : toutesDemandes) { 
                            String statusClass = "status-en-attente";
                            if ("validee".equalsIgnoreCase(demande.getStatus())) {
                                statusClass = "status-validee";
                            } else if ("refusee".equalsIgnoreCase(demande.getStatus())) {
                                statusClass = "status-refusee";
                            }
                        %>
                        <tr>
                            <td>#<%= demande.getIdDemandeConge() %></td>
                            <td><%= demande.getMotif() != null ? demande.getMotif().getLibelle() : "N/A" %></td>
                            <td><%= sdfTable.format(demande.getDateDebut()) %></td>
                            <td><%= sdfTable.format(demande.getDateFin()) %></td>
                            <td><span class="status-badge <%= statusClass %>"><%= demande.getStatus() %></span></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="no-data-msg">
                    <span class="icon">📭</span>
                    <p>Aucune demande de congé trouvée.</p>
                    <p style="margin-top: 10px; font-size: 0.9em;">Cliquez sur "Demande de congé" pour en créer une.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- MODAL CONGE -->
<div id="modalConge" class="modal-overlay" onclick="closeModalOnOverlay(event, 'conge')">
    <div class="modal" onclick="event.stopPropagation()">
        <div class="modal-header">
            <h3>🏖️ Demande de Congé</h3>
            <button class="close-btn" onclick="closeModal('conge')">&times;</button>
        </div>
        <div class="modal-body">
            <form action="/demandes/conge" method="POST">
                <div class="form-group">
                    <label>Motif du congé</label>
                    <% if(motifs!=null && !motifs.isEmpty()){%>
                        <select name="motifId" required>
                            <% for (Motif motifUnit:motifs){%>
                                <option value="<%= motifUnit.getIdMotif()%>"><%= motifUnit.getLibelle()%></option>
                            <% }%>
                        </select>
                    <% } else {%>
                        Pas de motifs
                    <% }%>
                </div>
                <div class="form-row">
                    <div class="form-group"><label>Date de début</label><input type="date" name="dateDebut" required></div>
                    <div class="form-group"><label>Date de fin</label><input type="date" name="dateFin" required></div>
                </div>
                <div class="form-group">
                    <label>Date de la demande </label><input type="date" name="dateDemande" required>
                </div>
                <div class="form-group"><label>Commentaire (optionnel)</label><textarea name="commentaire" placeholder="Ajoutez des détails..."></textarea></div>
                <button type="submit" class="submit-btn">Soumettre la demande</button>
            </form>
        </div>
    </div>
</div>

<!-- MODAL AVANCE -->
<div id="modalAvance" class="modal-overlay" onclick="closeModalOnOverlay(event, 'avance')">
    <div class="modal" onclick="event.stopPropagation()">
        <div class="modal-header orange">
            <h3>💰 Demande d'Avance</h3>
            <button class="close-btn" onclick="closeModal('avance')">&times;</button>
        </div>
        <div class="modal-body">
            <form action="/demande/avance" method="POST">
                <div class="form-group">
                    <label>Mois concerné</label>
                    <% if(mois!=null && !mois.isEmpty()){%>
                        <select name="moisId" required>
                            <% for(Mois m:mois){%>
                                <option value="<%= m.getIdMois() %>"><%= m.getLibelle()%></option>
                            <% }%>
                        </select>
                    <% } else {%>
                        Aucun mois a afficher
                    <% }%>
                </div>
                <div class="form-group"><label>Montant demandé (Ar)</label><input type="number" name="montant" placeholder="Ex: 500000" min="0" step="1000" required></div>
                <div class="form-group"><label>Justification</label><textarea name="justification" placeholder="Expliquez la raison..." required></textarea></div>
                <button type="submit" class="submit-btn orange">Soumettre la demande</button>
            </form>
        </div>
    </div>
</div>

<script>
    // Congés validés (données du serveur)
    const congesValides = [
        <% if (congesValides != null && !congesValides.isEmpty()) {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            for (int i = 0; i < congesValides.size(); i++) {
                DemandeConge dc = congesValides.get(i);
                String motifNom = (dc.getMotif() != null) ? dc.getMotif().getLibelle() : "Congé";
        %>
        { dateDebut: "<%= sdf.format(dc.getDateDebut()) %>", dateFin: "<%= sdf.format(dc.getDateFin()) %>", motif: "<%= motifNom %>" }<%= (i < congesValides.size() - 1) ? "," : "" %>
        <% } } else { %>
        { dateDebut: "2025-10-10", dateFin: "2025-10-12", motif: "Congé maternité" }
        <% } %>
    ];

    let currentDate = new Date();
    const months = ['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre'];
    const days = ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'];

    // Navigation sections
    function showSection(section) {
        document.querySelectorAll('.section-container').forEach(s => s.classList.remove('active'));
        document.querySelectorAll('.sidebar a').forEach(a => a.classList.remove('active'));
        document.getElementById('section-' + section).classList.add('active');
        document.getElementById('nav-' + section).classList.add('active');
        if (section === 'planning') renderCalendar();
    }

    // Sidebar toggle
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("collapsed");
        document.getElementById("content").classList.toggle("collapsed-content");
        document.getElementById("toggle").classList.toggle("collapsed-btn");
    }

    // Modals
    function openModal(type) {
        document.getElementById('modal' + type.charAt(0).toUpperCase() + type.slice(1)).style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    function closeModal(type) {
        document.getElementById('modal' + type.charAt(0).toUpperCase() + type.slice(1)).style.display = 'none';
        document.body.style.overflow = 'auto';
    }
    function closeModalOnOverlay(e, type) { if (e.target.classList.contains('modal-overlay')) closeModal(type); }

    // Calendar
    function changeMonth(delta) {
        currentDate.setMonth(currentDate.getMonth() + delta);
        renderCalendar();
    }

    function isDateInConge(year, month, day) {
        // Créer la date au format YYYY-MM-DD
        const dateStr = year + '-' + String(month + 1).padStart(2, '0') + '-' + String(day).padStart(2, '0');
        for (let c of congesValides) {
            if (dateStr >= c.dateDebut && dateStr <= c.dateFin) return c;
        }
        return null;
    }

    function renderCalendar() {
        const grid = document.getElementById('calendar-grid');
        const monthYear = document.getElementById('calendar-month-year');
        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();
        
        monthYear.textContent = months[month] + ' ' + year;
        grid.innerHTML = '';

        // Headers
        days.forEach(d => {
            const h = document.createElement('div');
            h.className = 'calendar-day-header';
            h.textContent = d;
            grid.appendChild(h);
        });

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        // Empty cells
        for (let i = 0; i < firstDay; i++) {
            const empty = document.createElement('div');
            empty.className = 'calendar-day empty';
            grid.appendChild(empty);
        }

        // Days
        for (let d = 1; d <= daysInMonth; d++) {
            const dayEl = document.createElement('div');
            dayEl.className = 'calendar-day';
            
            const conge = isDateInConge(year, month, d);
            
            // Today
            if (today.getDate() === d && today.getMonth() === month && today.getFullYear() === year) {
                dayEl.classList.add('today');
            }
            
            // Congé
            if (conge) {
                dayEl.classList.add('conge');
                dayEl.setAttribute('data-tooltip', conge.motif + ' (' + conge.dateDebut + ' → ' + conge.dateFin + ')');
            }
            
            const num = document.createElement('span');
            num.className = 'day-number';
            num.textContent = d;
            dayEl.appendChild(num);

            if (conge) {
                const badge = document.createElement('span');
                badge.className = 'conge-badge';
                badge.textContent = conge.motif;
                dayEl.appendChild(badge);
            }

            grid.appendChild(dayEl);
        }
    }

    // Init
    document.addEventListener('keydown', e => { if (e.key === 'Escape') { closeModal('conge'); closeModal('avance'); } });
    document.addEventListener('DOMContentLoaded', () => {
        const today = new Date().toISOString().split('T')[0];
        document.querySelectorAll('input[type="date"]').forEach(i => i.setAttribute('min', today));
    });
</script>
</body>
</html>