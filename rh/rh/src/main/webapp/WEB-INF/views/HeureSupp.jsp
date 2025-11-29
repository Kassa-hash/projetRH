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
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Heures Supplémentaires</h1>

        <div class="stats">
            <h3>Statistiques du mois</h3>
            <p>Nombre total d'heures ce mois : <strong>${totalHeuresMois} h</strong></p>
        </div>

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
                        <td colspan="5" style="text-align: center;">Aucune heure supplémentaire trouvée</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>