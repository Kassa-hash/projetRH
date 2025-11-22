<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord RH</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        .department-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .department-stat {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .department-stat h4 {
            color: #333;
            margin-bottom: 5px;
        }

        .department-stat .count {
            font-size: 1.8em;
            font-weight: bold;
            color: #4a7c2c;
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
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <h1>RH Manager</h1>
            <p>Gestion des Ressources Humaines</p>
        </div>

        <div class="menu">
            <div class="menu-item active">
                <i class="fas fa-tachometer-alt"></i>
                <span>Tableau de Bord</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-users"></i>
                <span>Employés</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-file-contract"></i>
                <span>Contrats</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Congés</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-clock"></i>
                <span>Pointages</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-money-bill-wave"></i>
                <span>Paies</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-chart-bar"></i>
                <span>Rapports</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-cog"></i>
                <span>Paramètres</span>
            </div>
        </div>

        <div class="user-section">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="user-info">
                <h3>Marie Dubois</h3>
                <p>Responsable RH</p>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="topbar">
            <h2>Tableau de Bord RH</h2>
            <div class="topbar-actions">
                <button class="notification-btn">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </button>
                <div class="date-display">
                    <span id="current-date">Lundi 15 Janvier 2024</span>
                </div>
            </div>
        </div>

        <div class="content-area">
            <!-- Statistiques Principales -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Total Employés</h3>
                            <div class="stat-value">147</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +12% ce mois
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 85%"></div>
                    </div>
                </div>

                <div class="stat-card blue">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Présence Aujourd'hui</h3>
                            <div class="stat-value">89%</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +3% hier
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 89%"></div>
                    </div>
                </div>

                <div class="stat-card green">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Congés Approuvés</h3>
                            <div class="stat-value">23</div>
                            <div class="stat-change negative">
                                <i class="fas fa-arrow-down"></i> -2% cette semaine
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 65%"></div>
                    </div>
                </div>

                <div class="stat-card yellow">
                    <div class="stat-header">
                        <div class="stat-info">
                            <h3>Heures Supp.</h3>
                            <div class="stat-value">156h</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +18% ce mois
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 78%"></div>
                    </div>
                </div>
            </div>

            <!-- Actions Rapides -->
            <div class="quick-actions">
                <div class="quick-action-btn">
                    <i class="fas fa-user-plus"></i>
                    <span>Nouvel Employé</span>
                </div>
                <div class="quick-action-btn">
                    <i class="fas fa-file-signature"></i>
                    <span>Nouveau Contrat</span>
                </div>
                <div class="quick-action-btn">
                    <i class="fas fa-calendar-plus"></i>
                    <span>Demande Congé</span>
                </div>
                <div class="quick-action-btn">
                    <i class="fas fa-chart-pie"></i>
                    <span>Rapport Mensuel</span>
                </div>
            </div>

            <!-- Graphiques et Statistiques -->
            <div class="charts-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3>Évolution des Effectifs</h3>
                        <select style="padding: 5px 10px; border-radius: 5px; border: 1px solid #ddd;">
                            <option>6 derniers mois</option>
                            <option>Cette année</option>
                            <option>Année dernière</option>
                        </select>
                    </div>
                    <div class="chart-placeholder">
                        <i class="fas fa-chart-line" style="margin-right: 10px;"></i>
                        Graphique d'évolution des effectifs
                    </div>
                </div>

                <div class="chart-card">
                    <div class="chart-header">
                        <h3>Répartition par Département</h3>
                    </div>
                    <div class="chart-placeholder">
                        <i class="fas fa-chart-pie" style="margin-right: 10px;"></i>
                        Graphique de répartition
                    </div>
                    <div class="department-stats">
                        <div class="department-stat">
                            <h4>IT</h4>
                            <div class="count">32</div>
                        </div>
                        <div class="department-stat">
                            <h4>Marketing</h4>
                            <div class="count">28</div>
                        </div>
                        <div class="department-stat">
                            <h4>Finance</h4>
                            <div class="count">24</div>
                        </div>
                        <div class="department-stat">
                            <h4>RH</h4>
                            <div class="count">18</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Activité Récente -->
            <div class="recent-activity">
                <div class="activity-header">
                    <h3>Activité Récente</h3>
                    <button style="background: #4a7c2c; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer;">
                        Voir tout
                    </button>
                </div>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-icon green">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Nouvel employé recruté</h4>
                            <p>Jean Dupont a rejoint l'équipe Marketing</p>
                            <div class="activity-time">Il y a 2 heures</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon blue">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Congé approuvé</h4>
                            <p>Demande de congé de Sophie Martin approuvée</p>
                            <div class="activity-time">Il y a 5 heures</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon yellow">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Retard signalé</h4>
                            <p>3 employés en retard ce matin</p>
                            <div class="activity-time">Il y a 1 jour</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon red">
                            <i class="fas fa-file-contract"></i>
                        </div>
                        <div class="activity-details">
                            <h4>Contrat expiré</h4>
                            <p>Contrat de Pierre Lambert arrive à expiration</p>
                            <div class="activity-time">Il y a 2 jours</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Mise à jour de la date actuelle
        function updateCurrentDate() {
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            document.getElementById('current-date').textContent = now.toLocaleDateString('fr-FR', options);
        }

        // Simulation de données en temps réel
        function updateStats() {
            // Cette fonction pourrait être connectée à votre API backend
            console.log('Mise à jour des statistiques...');
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            updateCurrentDate();

            // Mettre à jour la date toutes les minutes
            setInterval(updateCurrentDate, 60000);

            // Simuler des mises à jour de données
            setInterval(updateStats, 30000);

            // Gestion des clics sur les éléments du menu
            document.querySelectorAll('.menu-item').forEach(item => {
                item.addEventListener('click', function() {
                    document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Gestion des actions rapides
            document.querySelectorAll('.quick-action-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const action = this.querySelector('span').textContent;
                    alert(`Action déclenchée: ${action}`);
                });
            });
        });
    </script>
</body>
</html>