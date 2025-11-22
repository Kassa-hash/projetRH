<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ressourcesHumaine.rh.entities.DemandeConge" %>
<%@ page import="com.ressourcesHumaine.rh.entities.DemandeAvance" %>
<%@ page import="com.ressourcesHumaine.rh.entities.Employe" %>
<%@ page import="com.ressourcesHumaine.rh.entities.ContratEmploye" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Demandes</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:linear-gradient(135deg,#2d5016 0%,#1a1a1a 100%);min-height:10vh;padding:20px;}
        .container{max-width:1600px;margin:0 auto;background:#f5f5f5;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,0.3);overflow:hidden;}
        header{background:linear-gradient(135deg,#4a7c2c 0%,#2d5016 100%);color:white;padding:30px;text-align:center;}
        header h1{font-size:2.5em;margin-bottom:10px;text-shadow:2px 2px 4px rgba(0,0,0,0.3);}
        .tabs{display:flex;background:#e8e8e8;border-bottom:3px solid #4a7c2c;}
        .tab{flex:1;padding:20px;text-align:center;cursor:pointer;font-weight:600;font-size:1.1em;transition:all .3s;border-bottom:4px solid transparent;}
        .tab:hover{background:#d8d8d8;}
        .tab.active{background:white;color:#4a7c2c;border-bottom-color:#4a7c2c;}
        .controls{padding:25px 30px;background:#e8e8e8;border-bottom:2px solid #4a7c2c;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:15px;}
        .filter-group{display:flex;gap:10px;flex-wrap:wrap;flex:1;}
        .filter-group input,.filter-group select{padding:12px 20px;border:2px solid #4a7c2c;border-radius:8px;font-size:1em;min-width:200px;}
        .btn{padding:12px 24px;border:none;border-radius:8px;font-size:1em;cursor:pointer;font-weight:600;text-transform:uppercase;letter-spacing:.5px;transition:all .3s;}
        .btn-primary{background:linear-gradient(135deg,#4a7c2c 0%,#5a9c3c 100%);color:white;box-shadow:0 4px 12px rgba(74,124,44,.3);}
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(74,124,44,.4);}
        .content{padding:30px;}
        .tab-content{display:none;}
        .tab-content.active{display:block;}
        .stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:20px;margin-bottom:30px;}
        .stat-card{background:white;padding:25px;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,.1);transition:transform .3s;}
        .stat-card:hover{transform:translateY(-5px);}
        .stat-card.pending{border-left:5px solid #ffc107;}
        .stat-card.approved{border-left:5px solid #28a745;}
        .stat-card.rejected{border-left:5px solid #dc3545;}
        .stat-card.total{border-left:5px solid #4a7c2c;}
        .stat-card h3{color:#666;font-size:.9em;margin-bottom:10px;text-transform:uppercase;}
        .stat-card .stat-value{font-size:2.5em;font-weight:bold;}
        .stat-card.pending .stat-value{color:#ffc107;}
        .stat-card.approved .stat-value{color:#28a745;}
        .stat-card.rejected .stat-value{color:#dc3545;}
        .stat-card.total .stat-value{color:#4a7c2c;}
        .demandes-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(350px,1fr));gap:20px;}
        .demande-card{background:white;border-radius:10px;padding:25px;box-shadow:0 2px 8px rgba(0,0,0,.1);transition:all .3s;border-left:5px solid #4a7c2c;}
        .demande-card:hover{transform:translateY(-5px);box-shadow:0 6px 16px rgba(0,0,0,.15);}
        .demande-card.pending{border-left-color:#ffc107;}
        .demande-card.approved{border-left-color:#28a745;}
        .demande-card.rejected{border-left-color:#dc3545;}
        .demande-header{display:flex;justify-content:space-between;align-items:start;margin-bottom:15px;}
        .demande-id{font-size:.9em;color:#666;font-weight:600;}
        .badge{padding:6px 14px;border-radius:20px;font-size:.85em;font-weight:600;}
        .badge-pending{background:#fff3cd;color:#856404;}
        .badge-approved{background:#d4edda;color:#155724;}
        .badge-rejected{background:#f8d7da;color:#721c24;}
        .employe-info{display:flex;align-items:center;gap:15px;margin-bottom:15px;padding:15px;background:#f8f9fa;border-radius:8px;}
        .employe-avatar{width:50px;height:50px;border-radius:50%;background:linear-gradient(135deg,#4a7c2c 0%,#5a9c3c 100%);display:flex;align-items:center;justify-content:center;font-size:1.5em;color:white;}
        .employe-details h3{color:#333;font-size:1.1em;}
        .employe-details p{color:#666;font-size:.9em;}
        .demande-info{margin:15px 0;}
        .info-row{display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #e0e0e0;}
        .info-row:last-child{border-bottom:none;}
        .info-label{font-weight:600;color:#666;}
        .info-value{color:#333;font-weight:600;}
        .montant{font-size:1.4em;color:#2d5016;font-weight:700;}
        .demande-actions{display:flex;gap:10px;margin-top:15px;}
        .btn-action{flex:1;padding:10px;border:none;border-radius:8px;cursor:pointer;font-weight:600;transition:all .3s;}
        .btn-approve{background:#28a745;color:white;}
        .btn-approve:hover{background:#218838;}
        .btn-reject{background:#dc3545;color:white;}
        .btn-reject:hover{background:#c82333;}
        .btn-view{background:#17a2b8;color:white;}
        .btn-view:hover{background:#138496;}
        .alert {
    padding: 15px 20px;
    margin: 20px 30px;
    border-radius: 10px;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    animation: slideDown 0.5s ease-out;
}

.alert-success {
    background: linear-gradient(135deg, #d4edda, #c3e6cb);
    color: #155724;
    border-left: 6px solid #28a745;
}

.alert-danger {
    background: linear-gradient(135deg, #f8d7da, #f5c6cb);
    color: #721c24;
    border-left: 6px solid #dc3545;
}

.btn-close {
    background: none;
    border: none;
    font-size: 1.4em;
    cursor: pointer;
    opacity: 0.6;
    transition: opacity 0.3s;
}

.btn-close:hover {
    opacity: 1;
}

@keyframes slideDown {
    from { opacity: 0; transform: translateY(-20px); }
    to   { opacity: 1; transform: translateY(0); }
}
    </style>
</head>
<body>

<%
    // Remarque: Il est essentiel que ces classes Java soient présentes dans WEB-INF/lib ou WEB-INF/classes
    List<DemandeConge> demandesConge = (List<DemandeConge>) request.getAttribute("demandesConge");
    List<DemandeAvance> demandesAvance = (List<DemandeAvance>) request.getAttribute("demandesAvance");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    String messageConge=(String)request.getAttribute("messageConge");
    String typeConge=(String)request.getAttribute("typeConge");
%>

<div class="container">
    <header>
        <h1>Gestion des Demandes</h1>
        <p>Suivi des demandes de congés et d'avances</p>
    </header>

    <div class="tabs">
        <div class="tab active" onclick="switchTab('conges')">Demandes de Congés</div>
        <div class="tab" onclick="switchTab('avances')">Demandes d'Avances</div>
    </div>

    <!-- ==================== ONGLET CONGÉS ==================== -->
    <div id="conges-tab" class="tab-content active">
        <div class="controls">
            <div class="filter-group">
                <input type="text" id="searchConges" placeholder="Rechercher...">
                <select id="filterStatutConges">
                    <option value="">Tous les statuts</option>
                    <option value="en attente">En attente</option>
                    <option value="acceptee">Approuvé</option>
                    <option value="refusee">Refusé</option>
                </select>
                <% if (messageConge != null && !messageConge.isEmpty()) { %>
                    <div class="alert alert-<%= "succes".equals(typeConge) ? "success" : "danger" %> alert-dismissible">
                        <%= messageConge %>
                        <button type="button" class="btn-close" onclick="this.parentElement.style.display='none'"></button>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="content">
            <!-- Stats Congés -->
            <div class="stats">
                <% 
                    int cPending = 0, cApproved = 0, cRejected = 0;
                    if (demandesConge != null) {
                        for (DemandeConge dc : demandesConge) {
                            String s = dc.getStatus() != null ? dc.getStatus().toLowerCase().trim() : "";
                            if ("en attente".equals(s)) cPending++;
                            else if ("validee".equals(s)) cApproved++;
                            else if ("refusee".equals(s)) cRejected++;
                        }
                    }
                    int cTotal = cPending + cApproved + cRejected;
                %>
                <div class="stat-card pending"><h3>En Attente</h3><div class="stat-value"><%=cPending%></div></div>
                <div class="stat-card approved"><h3>Approuvées</h3><div class="stat-value"><%=cApproved%></div></div>
                <div class="stat-card rejected"><h3>Refusées</h3><div class="stat-value"><%=cRejected%></div></div>
                <div class="stat-card total"><h3>Total</h3><div class="stat-value"><%=cTotal%></div></div>
            </div>

            <!-- Cartes Congés -->
            <div class="demandes-grid" id="congesGrid">
                <% if (demandesConge == null || demandesConge.isEmpty()) { %>
                    <div style="grid-column:1/-1;text-align:center;padding:60px;color:#888;font-size:1.4em;">
                        Aucune demande de congé.
                    </div>
                <% } else {
                    for (DemandeConge dc : demandesConge) {
                        String status = dc.getStatus() != null ? dc.getStatus().toLowerCase().trim() : "";
                        String cardClass = "pending", badgeClass = "badge-pending", badgeText = "En attente";
                        if ("validee".equals(status)) { cardClass = "approved"; badgeClass = "badge-approved"; badgeText = "Approuvé"; }
                        else if ("refusee".equals(status)) { cardClass = "rejected"; badgeClass = "badge-rejected"; badgeText = "Refusé"; }

                        String debut = dc.getDateDebut() != null ? sdf.format(dc.getDateDebut()) : "—";
                        String fin = dc.getDateFin() != null ? sdf.format(dc.getDateFin()) : "—";
                        long duree = 0;
                        if (dc.getDateDebut() != null && dc.getDateFin() != null) {
                            // Calcul de la durée en jours (incluant les deux jours)
                            duree = (dc.getDateFin().getTime() - dc.getDateDebut().getTime()) / (1000L*60*60*24) + 1; 
                        }

                        Employe emp = dc.getEmploye();
                        String nom = emp != null && emp.getNom() != null ? emp.getNom() : "Inconnu";
                        String initiale = nom.isEmpty() ? "?" : nom.substring(0,1).toUpperCase();
                        String poste = "Non défini";
                        if (emp != null && emp.getContratEmploye() != null && emp.getContratEmploye().getPoste() != null) {
                            poste = emp.getContratEmploye().getPoste().getLibelle();
                        }
                        String motifLib = dc.getMotif() != null && dc.getMotif().getLibelle() != null ? dc.getMotif().getLibelle() : "Non spécifié";
                %>
                    <div class="demande-card <%=cardClass%>" data-status="<%=status%>">
                        <div class="demande-header">
                            <span class="demande-id">#DCG-<%=String.format("%03d", dc.getIdDemandeConge())%></span>
                            <span class="badge <%=badgeClass%>"><%=badgeText%></span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar"><%=initiale%></div>
                            <div class="employe-details">
                                <h3><%=nom%></h3>
                                <p><%=poste%></p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row"><span class="info-label">Début :</span><span class="info-value"><%=debut%></span></div>
                            <div class="info-row"><span class="info-label">Fin :</span><span class="info-value"><%=fin%></span></div>
                            
                            <div class="info-row"><span class="info-label">Durée :</span><span class="info-value"><%=duree%> jour<%=duree>1?"s":""%></span></div>
                            <div class="info-row"><span class="info-label">Motif :</span><span class="info-value"><%=motifLib%></span></div>
                        </div>
                        <div class="demande-actions">
                            <% if ("en attente".equals(status)) { %>
                                <button class="btn-action btn-approve" onclick="approveConge(<%=dc.getIdDemandeConge()%>)">Approuver</button>
                                <form action="<%= request.getContextPath() %>/demandes/refuserConge" method="get">                                <input type="hidden" name="id" value="<%=dc.getIdDemandeConge()%>">
                                    <button class="btn-action btn-reject">Refuser</button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                <% } } %>
            </div>
        </div>
    </div>

    <!-- ==================== ONGLET AVANCES ==================== -->
    <div id="avances-tab" class="tab-content">
        <div class="controls">
            <div class="filter-group">
                <input type="text" id="searchAvances" placeholder="Rechercher...">
                <select id="filterStatutAvances">
                    <option value="">Tous les statuts</option>
                    <option value="en attente">En attente</option>
                    <option value="acceptee">Approuvé</option>
                    <option value="refusee">Refusé</option>
                </select>
            </div>
        </div>

        <div class="content">
            <!-- Stats Avances -->
            <div class="stats">
                <% 
                    int aPending = 0, aApproved = 0, aRejected = 0;
                    BigDecimal totalMontant = BigDecimal.ZERO;
                    if (demandesAvance != null) {
                        for (DemandeAvance da : demandesAvance) {
                            String s = da.getStatus() != null ? da.getStatus().toLowerCase().trim() : "";
                            if ("en attente".equals(s)) aPending++;
                            else if ("acceptee".equals(s)) aApproved++;
                            else if ("refusee".equals(s)) aRejected++;
                            if (da.getMontant() != null) {
                                totalMontant = totalMontant.add(da.getMontant());
                            }
                        }
                    }
                    int aTotal = aPending + aApproved + aRejected;
                %>
                <div class="stat-card pending"><h3>En Attente</h3><div class="stat-value"><%=aPending%></div></div>
                <div class="stat-card approved"><h3>Approuvées</h3><div class="stat-value"><%=aApproved%></div></div>
                <div class="stat-card rejected"><h3>Refusées</h3><div class="stat-value"><%=aRejected%></div></div>
                <div class="stat-card total"><h3>Montant Total</h3><div class="stat-value"><%=String.format("%,.0f Ar", totalMontant)%></div></div>
            </div>

            <!-- Cartes Avances -->
            <div class="demandes-grid" id="avancesGrid">
                <% if (demandesAvance == null || demandesAvance.isEmpty()) { %>
                    <div style="grid-column:1/-1;text-align:center;padding:60px;color:#888;font-size:1.4em;">
                        Aucune demande d'avance.
                    </div>
                <% } else {
                    for (DemandeAvance da : demandesAvance) {
                        String rawStatus = da.getStatus();
String status = (rawStatus != null) ? rawStatus.trim().toLowerCase() : "";
                        String cardClass = "pending", badgeClass = "badge-pending", badgeText = "En attente";
                        if ("acceptee".equals(status)) { cardClass = "approved"; badgeClass = "badge-approved"; badgeText = "Approuvé"; }
                        else if ("refusee".equals(status)) { cardClass = "rejected"; badgeClass = "badge-rejected"; badgeText = "Refusé"; }

                        String dateDemande = da.getDate() != null ? sdf.format(da.getDate()) : "—";
                        String moisLibelle = da.getMois() != null ? da.getMois().getLibelle() : "Non spécifié";
                        String montantStr = da.getMontant() != null ? String.format("%,.0f Ar", da.getMontant()) : "0 Ar";

                        Employe emp = da.getEmploye();
                        String nom = emp != null && emp.getNom() != null ? emp.getNom() : "Inconnu";
                        String initiale = nom.isEmpty() ? "?" : nom.substring(0,1).toUpperCase();
                        String poste = "Non défini";
                        if (emp != null && emp.getContratEmploye() != null && emp.getContratEmploye().getPoste() != null) {
                            poste = emp.getContratEmploye().getPoste().getLibelle();
                        }
                %>
                    <div class="demande-card <%=cardClass%>" data-status="<%=status%>">
                        <div class="demande-header">
                            <span class="demande-id">#DAV-<%=String.format("%03d", da.getIdDemandeAvance())%></span>
                            <span class="badge <%=badgeClass%>"><%=badgeText%></span>
                        </div>
                        <div class="employe-info">
                            <div class="employe-avatar"><%=initiale%></div>
                            <div class="employe-details">
                                <h3><%=nom%></h3>
                                <p><%=poste%></p>
                            </div>
                        </div>
                        <div class="demande-info">
                            <div class="info-row"><span class="info-label">Date :</span><span class="info-value"><%=dateDemande%></span></div>
                            <div class="info-row"><span class="info-label">Mois :</span><span class="info-value"><%=moisLibelle%></span></div>
                            <div class="info-row"><span class="info-label">Montant :</span><span class="info-value montant"><%=montantStr%></span></div>
                        </div>
                        <div class="demande-actions">
                            <% if ("en attente".equals(status)) { %>
                                <button class="btn-action btn-approve" onclick="approveAvance(<%=da.getIdDemandeAvance()%>)">Approuver</button>
                                <button class="btn-action btn-reject" onclick="rejectAvance(<%=da.getIdDemandeAvance()%>)">Refuser</button>
                            <% } else { %>
                                <button class="btn-action btn-view" onclick="viewAvance(<%=da.getIdDemandeAvance()%>)">Détails</button>
                            <% } %>
                        </div>
                    </div>
                <% } } %>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialisation de l'onglet actif
    document.addEventListener('DOMContentLoaded', () => {
        switchTab('conges');
    });

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

    // --- Actions (Pour les boutons d'Approbation/Refus) ---
    // NOTE: Remplacer confirm() par une modal personnalisée est conseillé en production.
    
    // Actions Congés
    function approveConge(id) { 
        if(confirm("Approuver cette demande de congé ?")) { 
            // TODO: Remplacer par un appel POST propre
            location.href = "/demandes/accepterConge?id=" + id; 
        } 
    }
    function rejectConge(id)  { 
        if(confirm("Refuser cette demande de congé ?")) {
            // TODO: Remplacer par un appel POST propre
            location.href = "/demandes/refuserConge?id=" + id; 
        } 
    }
    function viewConge(id)    { 
        location.href = "/detailConge?id=" + id; 
    }

    // Actions Avances
    function approveAvance(id) { 
        if(confirm("Approuver cette avance ?")) {
            // TODO: Remplacer par un appel POST propre
            location.href = "/approuverAvance?id=" + id; 
        } 
    }
    function rejectAvance(id)  { 
        if(confirm("Refuser cette avance ?")) {
            // TODO: Remplacer par un appel POST propre
            location.href = "/refuserAvance?id=" + id; 
        } 
    }
    function viewAvance(id)    { 
        location.href = "/detailAvance?id=" + id; 
    }

    // --- Fonctions de Filtrage ---

    // Filtre + Recherche Congés
    function filterConges() {
        const search = document.getElementById('searchConges').value.toLowerCase();
        const statut = document.getElementById('filterStatutConges').value;
        document.querySelectorAll('#congesGrid .demande-card').forEach(card => {
            // Utiliser innerText au lieu de textContent pour ignorer les balises, mais capturer le texte lisible
            const text = card.innerText.toLowerCase(); 
            const cardStatus = card.dataset.status || "";
            const matchSearch = text.includes(search);
            const matchStatut = !statut || cardStatus === statut;
            card.style.display = (matchSearch && matchStatut) ? '' : 'none';
        });
    }
    document.getElementById('searchConges').addEventListener('input', filterConges);
    document.getElementById('filterStatutConges').addEventListener('change', filterConges);

    // Filtre + Recherche Avances
    function filterAvances() {
        const search = document.getElementById('searchAvances').value.toLowerCase();
        const statut = document.getElementById('filterStatutAvances').value;
        document.querySelectorAll('#avancesGrid .demande-card').forEach(card => {
            const text = card.innerText.toLowerCase();
            const cardStatus = card.dataset.status || "";
            const matchSearch = text.includes(search);
            const matchStatut = !statut || cardStatus === statut;
            card.style.display = (matchSearch && matchStatut) ? '' : 'none';
        });
    }
    document.getElementById('searchAvances').addEventListener('input', filterAvances);
    document.getElementById('filterStatutAvances').addEventListener('change', filterAvances);
</script>
</body>
</html>