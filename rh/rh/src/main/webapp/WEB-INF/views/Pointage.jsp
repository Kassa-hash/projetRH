<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pointage des Employés</title>
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

        .clock-section {
            background: white;
            padding: 30px;
            text-align: center;
            border-bottom: 3px solid #4a7c2c;
        }

        .current-time {
            font-size: 3.5em;
            font-weight: bold;
            color: #4a7c2c;
            margin-bottom: 10px;
            font-variant-numeric: tabular-nums;
        }

        .current-date {
            font-size: 1.5em;
            color: #666;
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

        .search-box {
            padding: 12px 20px;
            border: 2px solid #4a7c2c;
            border-radius: 8px;
            font-size: 1em;
            min-width: 250px;
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

        .stat-card.late {
            border-left: 5px solid #ffc107;
        }

        .stat-card.absent {
            border-left: 5px solid #dc3545;
        }

        .stat-card.active {
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
        }

        .stat-card.present .stat-value {
            color: #28a745;
        }

        .stat-card.late .stat-value {
            color: #ffc107;
        }

        .stat-card.absent .stat-value {
            color: #dc3545;
        }

        .stat-card.active .stat-value {
            color: #17a2b8;
        }

        .pointages-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .employee-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            border-left: 5px solid #4a7c2c;
        }

        .employee-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .employee-card.present {
            border-left-color: #28a745;
        }

        .employee-card.late {
            border-left-color: #ffc107;
        }

        .employee-card.absent {
            border-left-color: #dc3545;
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
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            color: white;
            border: 4px solid #e0e0e0;
        }

        .employee-card.present .employee-avatar {
            border-color: #28a745;
        }

        .employee-card.late .employee-avatar {
            border-color: #ffc107;
        }

        .employee-card.absent .employee-avatar {
            border-color: #dc3545;
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

        .time-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
        }

        .time-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .time-row:last-child {
            border-bottom: none;
        }

        .time-label {
            font-weight: 600;
            color: #666;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .time-value {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
            font-variant-numeric: tabular-nums;
        }

        .time-value.late {
            color: #dc3545;
        }

        .time-value.empty {
            color: #999;
            font-size: 1em;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9em;
        }

        .status-badge.present {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.late {
            background: #fff3cd;
            color: #856404;
        }

        .status-badge.absent {
            background: #f8d7da;
            color: #721c24;
        }

        .status-badge.in-progress {
            background: #d1ecf1;
            color: #0c5460;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-action {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-entry {
            background: #28a745;
            color: white;
        }

        .btn-entry:hover {
            background: #218838;
        }

        .btn-exit {
            background: #dc3545;
            color: white;
        }

        .btn-exit:hover {
            background: #c82333;
        }

        .btn-entry:disabled,
        .btn-exit:disabled {
            background: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
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

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
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
        }

        .btn-primary {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .duration {
            text-align: center;
            padding: 15px;
            background: #e7f5e7;
            border-radius: 8px;
            margin-top: 15px;
        }

        .duration-label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }

        .duration-value {
            font-size: 1.8em;
            font-weight: bold;
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>⏰ Pointage des Employés</h1>
            <p>Gestion des entrées et sorties</p>
        </header>

        <div class="clock-section">
            <div class="current-time" id="currentTime">--:--:--</div>
            <div class="current-date" id="currentDate">--</div>
        </div>

        <div class="controls">
            <div class="date-selector">
                <button class="btn-nav" onclick="changeDate(-1)">◀</button>
                <input type="date" id="dateInput">
                <button class="btn-nav" onclick="changeDate(1)">▶</button>
                <button class="btn-nav" onclick="setToday()" title="Aujourd'hui">📍</button>
            </div>
            <input type="text" class="search-box" id="searchInput" placeholder="🔍 Rechercher un employé...">
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card present">
                    <h3>Présents</h3>
                    <div class="stat-value">8</div>
                </div>
                <div class="stat-card late">
                    <h3>En Retard</h3>
                    <div class="stat-value">2</div>
                </div>
                <div class="stat-card absent">
                    <h3>Absents</h3>
                    <div class="stat-value">1</div>
                </div>
                <div class="stat-card active">
                    <h3>En Cours</h3>
                    <div class="stat-value">6</div>
                </div>
            </div>

            <div class="pointages-grid" id="pointagesGrid">
                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Jean Dupont</h3>
                            <p>Développeur</p>
                        </div>
                    </div>
                    <div class="status-badge in-progress">🟢 En cours</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value">08:15</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value empty">--:--</span>
                        </div>
                    </div>
                    <div class="duration">
                        <div class="duration-label">Temps de travail</div>
                        <div class="duration-value">6h 45m</div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" disabled>✅ Entrée</button>
                        <button class="btn-action btn-exit" onclick="markExit(1)">🚪 Sortie</button>
                    </div>
                </div>

                <div class="employee-card late">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Marie Martin</h3>
                            <p>Chef de Projet</p>
                        </div>
                    </div>
                    <div class="status-badge late">⚠️ Retard</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value late">09:15</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value">17:30</span>
                        </div>
                    </div>
                    <div class="duration">
                        <div class="duration-label">Temps de travail</div>
                        <div class="duration-value">8h 15m</div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" disabled>✅ Entrée</button>
                        <button class="btn-action btn-exit" disabled>🚪 Sortie</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Paul Razafindra</h3>
                            <p>Analyste</p>
                        </div>
                    </div>
                    <div class="status-badge present">✅ À l'heure</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value">08:00</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value">17:00</span>
                        </div>
                    </div>
                    <div class="duration">
                        <div class="duration-label">Temps de travail</div>
                        <div class="duration-value">9h 00m</div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" disabled>✅ Entrée</button>
                        <button class="btn-action btn-exit" disabled>🚪 Sortie</button>
                    </div>
                </div>

                <div class="employee-card absent">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Sophie Bernard</h3>
                            <p>Designer</p>
                        </div>
                    </div>
                    <div class="status-badge absent">❌ Absent</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value empty">Non pointé</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value empty">--:--</span>
                        </div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" onclick="markEntry(4)">✅ Entrée</button>
                        <button class="btn-action btn-exit" disabled>🚪 Sortie</button>
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
                    <div class="status-badge in-progress">🟢 En cours</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value">07:45</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value empty">--:--</span>
                        </div>
                    </div>
                    <div class="duration">
                        <div class="duration-label">Temps de travail</div>
                        <div class="duration-value">7h 15m</div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" disabled>✅ Entrée</button>
                        <button class="btn-action btn-exit" onclick="markExit(5)">🚪 Sortie</button>
                    </div>
                </div>

                <div class="employee-card present">
                    <div class="employee-header">
                        <div class="employee-avatar">👤</div>
                        <div class="employee-info">
                            <h3>Claire Rasoanaivo</h3>
                            <p>Comptable</p>
                        </div>
                    </div>
                    <div class="status-badge in-progress">🟢 En cours</div>
                    <div class="time-info">
                        <div class="time-row">
                            <span class="time-label">🔽 Entrée</span>
                            <span class="time-value">08:30</span>
                        </div>
                        <div class="time-row">
                            <span class="time-label">🔼 Sortie</span>
                            <span class="time-value empty">--:--</span>
                        </div>
                    </div>
                    <div class="duration">
                        <div class="duration-label">Temps de travail</div>
                        <div class="duration-value">6h 30m</div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-action btn-entry" disabled>✅ Entrée</button>
                        <button class="btn-action btn-exit" onclick="markExit(6)">🚪 Sortie</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            document.getElementById('currentTime').textContent = `${hours}:${minutes}:${seconds}`;

            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const dateStr = now.toLocaleDateString('fr-FR', options);
            document.getElementById('currentDate').textContent = dateStr.charAt(0).toUpperCase() + dateStr.slice(1);
        }

        function setToday() {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            document.getElementById('dateInput').value = `${yyyy}-${mm}-${dd}`;
        }

        function changeDate(days) {
            const dateInput = document.getElementById('dateInput');
            const currentDate = new Date(dateInput.value);
            currentDate.setDate(currentDate.getDate() + days);

            const yyyy = currentDate.getFullYear();
            const mm = String(currentDate.getMonth() + 1).padStart(2, '0');
            const dd = String(currentDate.getDate()).padStart(2, '0');
            dateInput.value = `${yyyy}-${mm}-${dd}`;
        }

        function markEntry(id) {
            const now = new Date();
            const time = `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;
            alert(`Entrée enregistrée pour l'employé #${id} à ${time}`);
        }

        function markExit(id) {
            const now = new Date();
            const time = `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;
            if (confirm(`Confirmer la sortie pour l'employé #${id} à ${time} ?`)) {
                alert(`Sortie enregistrée à ${time}`);
            }
        }

        document.getElementById('searchInput').addEventListener('input', function(e) {
            const search = e.target.value.toLowerCase();
            document.querySelectorAll('.employee-card').forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(search) ? '' : 'none';
            });
        });

        setInterval(updateClock, 1000);
        updateClock();
        setToday();
    </script>
</body>
</html>