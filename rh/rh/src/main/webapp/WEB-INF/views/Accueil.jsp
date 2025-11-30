<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord RH</title>
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
        }

        .topbar-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .notification-btn {
            position: relative;
            padding: 10px;
            background: #f8f9fa;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.3em;
            transition: all 0.3s;
        }

        .notification-btn:hover {
            background: #e9ecef;
        }

        .notification-badge {
            position: absolute;
            top: 5px;
            right: 5px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 0.7em;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .content-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            background: #f5f5f5;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            border-left: 5px solid #4a7c2c;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .stat-card.blue {
            border-left-color: #17a2b8;
        }

        .stat-card.green {
            border-left-color: #28a745;
        }

        .stat-card.yellow {
            border-left-color: #ffc107;
        }

        .stat-card.red {
            border-left-color: #dc3545;
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }

        .stat-icon {
            font-size: 2.5em;
            opacity: 0.3;
        }

        .stat-card.blue .stat-icon {
            color: #17a2b8;
        }

        .stat-card.green .stat-icon {
            color: #28a745;
        }

        .stat-card.yellow .stat-icon {
            color: #ffc107;
        }

        .stat-card.red .stat-icon {
            color: #dc3545;
        }

        .stat-info h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-change {
            font-size: 0.9em;
            color: #666;
        }

        .stat-change.positive {
            color: #28a745;
        }

        .stat-change.negative {
            color: #dc3545;
        }

        .charts-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .chart-header h3 {
            color: #333;
            font-size: 1.3em;
        }

        .recent-activity {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .activity-header h3 {
            color: #333;
            font-size: 1.3em;
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .activity-item:hover {
            background: #e9ecef;
        }

        .activity-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3em;
            flex-shrink: 0;
        }

        .activity-icon.blue {
            background: #d1ecf1;
            color: #0c5460;
        }

        .activity-icon.green {
            background: #d4edda;
            color: #155724;
        }

        .activity-icon.yellow {
            background: #fff3cd;
            color: #856404;
        }

        .activity-icon.red {
            background: #f8d7da;
            color: #721c24;
        }

        .activity-details {
            flex: 1;
        }

        .activity-details h4 {
            color: #333;
            margin-bottom: 5px;
        }

        .activity-details p {
            color: #666;
            font-size: 0.9em;
        }

        .activity-time {
            color: #999;
            font-size: 0.85em;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .quick-action-btn {
            background: white;
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .quick-action-btn:hover {
            border-color: #4a7c2c;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .quick-action-btn i {
            font-size: 2.5em;
            margin-bottom: 10px;
            color: #4a7c2c;
        }

        .quick-action-btn span {
            display: block;
            font-weight: 600;
            color: #333;
        }

        .chart-placeholder {
            height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 8px;
            color: #666;
            font-size: 1.2em;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e9ecef;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 10px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4a7c2c 0%, #5a9c3c 100%);
            transition: width 0.3s;
        }

        @media (max-width: 1200px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<%@ page import="java.util.List"%>
<%@ page import="com.ressourcesHumaine.rh.entities.Employe"%>
<%@ page import="com.ressourcesHumaine.rh.entities.DemandeConge"%>
<%@ page import="com.ressourcesHumaine.rh.entities.DemandeAvance"%>
<%@ page import="com.ressourcesHumaine.rh.entities.Historique"%>

<% 
    List<Employe> employesActuels=(List<Employe>) request.getAttribute("employesActuels");
    int nbEmployesActuels=employesActuels.size();

    List<DemandeConge> demandesConge=(List<DemandeConge>) request.getAttribute("demandesConge");
    int nbdemandesConge=demandesConge.size();

    List<DemandeAvance> demandesAvance=(List<DemandeAvance>) request.getAttribute("demandesAvance");
    int nbdemandesAvances=demandesAvance.size();

    //total demandes
    int nbDemandes=nbdemandesAvances+nbdemandesConge;

    //liste des historiques des evenements
    List<Historique> historiques=(List<Historique>) request.getAttribute("historiques");
%>

<body>
    <div class="sidebar">
        <div class="logo">
            <h1>🏢 RH Manager</h1>
            <p>Système de Gestion RH</p>
        </div>

        <div class="menu">
            <a href="/"><div class="menu-item active">
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

            <a href="/presences"><div class="menu-item">
                <i>✅</i>
                <span>Présences</span>
            </div></a>
            <a href="/pointages"><div class="menu-item">
                <i>⏰</i>
                <span>Pointages</span>
            </div></a>
            <a href="/heures-supp">
                <div class="menu-item">
                    <i>⏱️</i>
                    <span>Heures Supp</span>
                </div>
            </a>
            <a href="/demandes"><div class="menu-item">
                <i>🏖️</i>
                <span>Demande de congés et d'avances'</span>
            </div></a>

              <a href="/employes/goLogin"><div class="menu-item">
                <i>👥</i>
              <span>Utilisateur</span>
            </div></a>

              <a href="/paies"><div class="menu-item">
                            <i>👥</i>
                          <span>Gestion de paiement</span>
                        </div></a>
             <div class="menu-item">
                <i>📁</i>
                 <span>Gestion de document</span>
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
            <h2>Tableau de Bord</h2>
            <div class="topbar-actions">
                <button class="notification-btn">
                    🔔
                    <span class="notification-badge">5</span>
                </button>
                <button class="notification-btn">⚙️</button>
            </div>
        </div>

        <div class="content-area">
            <!-- Statistiques principales -->
            <div class="dashboard-grid">
                <div class="stat-card blue">
    <div class="stat-header">
        <div class="stat-info">
            <h3>Total Employés</h3>
            <div class="stat-value">
                <%
                    int effectifNow = (int) request.getAttribute("effectifNow");
                    if (effectifNow > 0) {
                        out.print("<strong>" + effectifNow + "</strong>");
                    } else {
                        out.print("Aucun employé en activité");
                    }
                %>
            </div>
        </div>
        <div class="stat-icon">👥</div>
    </div>
</div>

                <div class="stat-card green">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Présents Aujourd'hui</h3>
                            <div class="stat-value"> 
                            <% 
                                int presents = (int) request.getAttribute("nbpersonnepresentesnow");
                                out.println(presents);
                            %>
                            </div>
                        </div>
                        <div class="stat-icon">✅</div>
                    </div>
                </div>

                <div class="stat-card yellow">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Demandes en Attente</h3>
                            <div class="stat-value"><%= nbDemandes %></div>
                            <div class="stat-change"><%= nbdemandesConge %> congés, <%= nbdemandesAvances%> avances</div>
                        </div>
                        <div class="stat-icon">⏳</div>
                    </div>
                </div>

                <div class="stat-card red">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Heures Supp (Mois)</h3>
                            <div class="stat-value">156.5h</div>
                            <div class="stat-change negative">↑ +12% vs mois dernier</div>
                        </div>
                        <div class="stat-icon">⏱️</div>
                    </div>
                </div>
            </div>



            <!-- Graphiques -->
            <div class="charts-grid">
                <div class="chart-card">
    <div class="chart-header">
        <h3>Évolution des Effectifs sur les 6 derniers mois</h3>
    </div>
    <canvas id="effectifChart" height="100"></canvas>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('effectifChart').getContext('2d');
    let chart;

    function loadChart(periode) {
        fetch(`/api/effectif/evolution?periode=${periode}`)
            .then(res => res.json())
            .then(data => {
                const labels = data.map(d => d.mois);
                const effectifs = data.map(d => d.effectif);

                // Calcul des arrivées/départs par mois
                const arrivees = [];
                const departs = [];
                let previous = 0;

                effectifs.forEach((current, i) => {
                    const diff = current - previous;
                    if (diff > 0) {
                        arrivees.push(diff);
                        departs.push(0);
                    } else if (diff < 0) {
                        arrivees.push(0);
                        departs.push(-diff);
                    } else {
                        arrivees.push(0);
                        departs.push(0);
                    }
                    previous = current;
                });

                if (chart) chart.destroy();

                chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                type: 'bar',
                                label: 'Arrivées',
                                data: arrivees,
                                backgroundColor: '#28a745',
                                borderColor: '#218838',
                                borderWidth: 1
                            },
                            {
                                type: 'bar',
                                label: 'Départs',
                                data: departs,
                                backgroundColor: '#dc3545',
                                borderColor: '#c82333',
                                borderWidth: 1
                            },
                            {
                                type: 'line',
                                label: 'Effectif total',
                                data: effectifs,
                                borderColor: '#4a7c2c',
                                backgroundColor: 'rgba(74, 124, 44, 0.1)',
                                fill: true,
                                tension: 0.4,
                                borderWidth: 3,
                                pointBackgroundColor: '#4a7c2c',
                                pointRadius: 6,
                                yAxisID: 'y'
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false
                            }
                        },
                        scales: {
                            x: {
                                stacked: false,
                            },
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: 'Nombre d\'employés'
                                },
                                ticks: {
                                    stepSize: 1
                                }
                            }
                        }
                    }
                });
            })
            .catch(err => {
                console.error("Erreur chargement graphique :", err);
                document.getElementById('effectifChart').parentElement.innerHTML = 
                    "<p style='color:red; text-align:center; padding:50px;'>Erreur de chargement du graphique</p>";
            });
    }

    // Chargement initial
    loadChart('6mois');

    // Changement de période
    document.getElementById('periodeSelect').addEventListener('change', function() {
        loadChart(this.value);
    });
</script>
                </div>

                <div class="chart-card">
    <div class="chart-header">
        <h3>🎯 Répartition de la Présence (Aujourd'hui)</h3>
    </div>
    
    <canvas id="presencePieChart" height="250"></canvas> 
    
    <%
        // Récupération des valeurs passées par le contrôleur
        int effectifNowChart = (int) request.getAttribute("effectifNow");
        int nbPersonneCongeNow = (int) request.getAttribute("nbpersonnecongenow");
        int nbPersonnePresentesNow = (int) request.getAttribute("nbpersonnepresentesnow");
        
        int absentsAutres = effectifNowChart - nbPersonnePresentesNow - nbPersonneCongeNow;
        
        if (absentsAutres < 0) {
            absentsAutres = 0;
        }

    %>

    <script>
        const ctxPresence = document.getElementById('presencePieChart').getContext('2d');
        
        const present = <%= nbPersonnePresentesNow %>;
        const conge = <%= nbPersonneCongeNow %>;
        const autresAbsents = <%= absentsAutres %>;
        
        // On crée le graphique en camembert
        new Chart(ctxPresence, {
            type: 'pie',
            data: {
                labels: [
                    'Présents', 
                    'En Congé', 
                    'Absents (Autres raisons)'
                ],
                datasets: [{
                    data: [present, conge, autresAbsents],
                    backgroundColor: [
                        '#28a745', // Vert pour Présents
                        '#ffc107', // Jaune pour Congé
                        '#dc3545'  // Rouge pour Absents
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'right', // Position de la légende à droite
                        labels: {
                            padding: 15,
                            font: {
                                size: 14
                            },
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + ' (' + context.dataset.data[context.dataIndex] + ' employés)';
                                }
                                return label;
                            }
                        }
                    },
                    title: {
                        display: false
                    }
                }
            }
        });
    </script>
</div>
            </div>
            <div class="recent-activity">
    <div class="activity-header">
        <h3>Activités Récentes</h3>
        <a href="/listeHistorique"><button style="padding: 8px 16px; background: #4a7c2c; color: white; border: none; border-radius: 6px; cursor: pointer;">Voir tout</button></a>
    </div>
    <div class="activity-list">
        <%
            if (historiques != null && !historiques.isEmpty()) {
                for (Historique h : historiques) {
                    String iconClass = "blue";  // par défaut
                    String emoji = "📋";        // document par défaut

                    String desc = h.getDescription() != null ? h.getDescription().toLowerCase() : "";

                    if (desc.contains("refus")) {
                        iconClass = "red";
                        emoji = "❌";
                    } else if (desc.contains("approuv") || desc.contains("valid") || desc.contains("accept")) {
                        iconClass = "green";
                        emoji = "✅";
                    } else if (desc.contains("créé") || desc.contains("ajout") || desc.contains("enregistr")) {
                        iconClass = "blue";
                        emoji = "🆕";
                    }

                    // Selon la classe (type d'entité)
                    if ("DemandeConge".equals(h.getClasse())) {
                        emoji = "🏖️";   // congé
                    } else if ("DemandeAvance".equals(h.getClasse())) {
                        emoji = "💰";   // argent
                    } else if ("Employe".equals(h.getClasse())) {
                        emoji = "👤";   // personne
                    }
        %>
            <div class="activity-item">
                <div class="activity-icon <%= iconClass %>"><%= emoji %></div>
                <div class="activity-details">
                    <h4><%= h.getDescription() %></h4>
                    <p><%= h.getDetails() != null ? h.getDetails() : "" %></p>
                </div>
                <div class="activity-time">
                    <%= new java.text.SimpleDateFormat("HH:mm").format(java.util.Date.from(h.getMomentAction().atZone(java.time.ZoneId.systemDefault()).toInstant())) %>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <div class="activity-item">
                <div class="activity-details">
                    <p style="color:#888; font-style:italic;">Aucune activité récente</p>
                </div>
            </div>
        <%
            }
        %>
    </div>
</div>

            <!-- Indicateurs de performance -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <h3 style="color: #666; font-size: 0.9em; margin-bottom: 10px;">AGE MOYEN DU PERSONNEL</h3>
                    <div class="stat-value" style="color: #28a745;"><%= request.getAttribute("ageMoyen")%></div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 94.5%;"></div>
                    </div>
                </div>

                <div class="stat-card">
                    <h3 style="color: #666; font-size: 0.9em; margin-bottom: 10px;">ANCIENNETE MOYENNE (en Annees)</h3>
                    <div class="stat-value" style="color: #17a2b8;"><%= request.getAttribute("ancienneteMoyenne")%></div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 91%; background: linear-gradient(90deg, #17a2b8 0%, #138496 100%);"></div>
                    </div>
                </div>

                <div class="stat-card">
                    <h3 style="color: #666; font-size: 0.9em; margin-bottom: 10px;">DOCUMENTS VALIDÉS</h3>
                    <div class="stat-value" style="color: #ffc107;"><%= request.getAttribute("docValid")%>/<%= request.getAttribute("totalDemande")%></div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 90%; background: linear-gradient(90deg, #ffc107 0%, #e0a800 100%);"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
            });
        });

        document.querySelectorAll('.quick-action-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const action = this.querySelector('span').textContent;
                alert('Navigation vers : ' + action);
            });
        });
    </script>
</body>
</html>