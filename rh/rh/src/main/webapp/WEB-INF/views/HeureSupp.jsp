<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Heures Supplémentaires</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2d5016;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4a7c2c;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 16px;
            background-color: #4a7c2c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #2d5016;
        }
        .stats {
            background: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .form-container {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2d5016;
            font-weight: bold;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr auto;
            gap: 15px;
            align-items: end;
        }
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Heures Supplémentaires</h1>

        <!-- Formulaire d'ajout -->
        <div class="form-container">
            <h3>Ajouter une heure supplémentaire</h3>
            <form action="/heures-supp/save" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="employeId">Employé *</label>
                        <select id="employeId" name="employeId" required>
                            <option value="">-- Sélectionner un employé --</option>
                            <c:forEach var="employe" items="${employes}">
                                <option value="${employe.idEmploye}">${employe.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="date">Date *</label>
                        <input type="date" id="date" name="date" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="duree">Durée (heures) *</label>
                        <input type="number" id="duree" name="duree" step="0.5" min="0.5" placeholder="Ex: 2.5" required>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn">Ajouter</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Statistiques -->
        <div class="stats">
            <h3>Statistiques du mois</h3>
            <p>Nombre total d'heures ce mois : <strong>${totalHeuresMois} h</strong></p>
        </div>

        <!-- Tableau des heures supplémentaires -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Employé</th>
                    <th>Date</th>
                    <th>Durée (heures)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="heure" items="${heuressupps}">
                    <tr>
                        <td>HS-${heure.idHeureSupp}</td>
                        <td>${heure.employe.nom}</td>
                        <td>
                            <fmt:formatDate value="${heure.date}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td><strong>${heure.duree}</strong></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty heuressupps}">
                    <tr>
                        <td colspan="4" style="text-align: center;">Aucune heure supplémentaire trouvée</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>