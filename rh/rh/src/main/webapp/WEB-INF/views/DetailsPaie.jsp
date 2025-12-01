<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fiche de Paie Détaillée</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header-bar {
            background: linear-gradient(135deg, #4a7c2c 0%, #2d5016 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-bar h1 {
            font-size: 1.8em;
            margin: 0;
        }

        .btn-back {
            background: white;
            color: #4a7c2c;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-back:hover {
            background: #f5f5f5;
            transform: translateY(-2px);
        }

        .payroll-sheet {
            padding: 30px;
        }

        .company-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #4a7c2c;
        }

        .company-logo {
            text-align: center;
        }

        .logo-placeholder {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #4a7c2c 0%, #2d5016 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1em;
            font-weight: bold;
            margin: 0 auto 10px;
        }

        .company-info h2 {
            color: #2d5016;
            margin-bottom: 5px;
            font-size: 1.5em;
        }

        .company-info p {
            margin: 3px 0;
            color: #666;
            font-size: 0.9em;
        }

        .document-title {
            text-align: center;
            margin: 25px 0;
        }

        .document-title h1 {
            color: #2d5016;
            font-size: 1.8em;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .document-title .period {
            font-size: 1.1em;
            color: #4a7c2c;
            font-weight: bold;
        }

        .employee-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 5px solid #4a7c2c;
        }

        .employee-info h3 {
            color: #2d5016;
            margin-bottom: 15px;
            font-size: 1.2em;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #ddd;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            font-weight: bold;
            color: #333;
        }

        .payroll-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .payroll-table th {
            background: #4a7c2c;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .payroll-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .payroll-table tr:hover {
            background-color: #f8f9fa;
        }

        .amount {
            text-align: right;
            font-weight: bold;
            font-family: 'Courier New', monospace;
        }

        .section-title {
            color: #2d5016;
            margin: 25px 0 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4a7c2c;
            font-size: 1.3em;
        }

        .totals-section {
            background: #e8f5e8;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            font-size: 1.1em;
            border-bottom: 1px solid #d4edda;
        }

        .total-row:last-child {
            border-bottom: none;
        }

        .net-payable {
            font-size: 1.2em;
            font-weight: bold;
            color: #2d5016;
            margin-top: 10px;
            padding-top: 15px;
            border-top: 2px solid #4a7c2c;
        }

        .legal-mentions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
            font-size: 0.9em;
            color: #666;
            text-align: center;
        }

        .payroll-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #4a7c2c;
        }

        .signature {
            text-align: center;
            width: 45%;
        }

        .signature-line {
            border-top: 1px solid #333;
            width: 80%;
            margin: 40px auto 10px;
        }

        .payroll-meta {
            font-size: 0.9em;
            color: #666;
            margin-top: 20px;
            text-align: center;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #3a6c1c 0%, #4a8c2c 100%);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        @media print {
            .header-bar,
            .action-buttons,
            .btn-back {
                display: none;
            }

            body {
                background: white;
                padding: 0;
            }

            .container {
                box-shadow: none;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
    <%
        // Récupérer les données du modèle
        String nomEmploye = (String) request.getAttribute("nomEmploye");
        String dateEmbauche = (String) request.getAttribute("dateEmbauche");
        String poste = (String) request.getAttribute("poste");
        String departement = (String) request.getAttribute("departement");
        BigDecimal salaireBase = (BigDecimal) request.getAttribute("salaireBase");
        Integer heuresSupp = (Integer) request.getAttribute("heuresSupp");
        BigDecimal salaireBrut = (BigDecimal) request.getAttribute("salaireBrut");
        BigDecimal majorationHeuresSupp = (BigDecimal) request.getAttribute("majorationHeuresSupp");
        BigDecimal cnaps1 = (BigDecimal) request.getAttribute("cnaps1");
        BigDecimal cnaps8 = (BigDecimal) request.getAttribute("cnaps8");
        BigDecimal ostie1 = (BigDecimal) request.getAttribute("ostie1");
        BigDecimal ostie5 = (BigDecimal) request.getAttribute("ostie5");
        BigDecimal revenuImposable = (BigDecimal) request.getAttribute("revenuImposable");
        BigDecimal irsa = (BigDecimal) request.getAttribute("irsa");
        BigDecimal salaireNet = (BigDecimal) request.getAttribute("salaireNet");
        BigDecimal avance = (BigDecimal) request.getAttribute("avance");
        BigDecimal netAPayer = (BigDecimal) request.getAttribute("netAPayer");
        BigDecimal tauxHoraireNormal = (BigDecimal) request.getAttribute("tauxHoraireNormal");
        BigDecimal tauxHoraireSupp = (BigDecimal) request.getAttribute("tauxHoraireSupp");
        Integer mois = (Integer) request.getAttribute("mois");
        Integer annee = (Integer) request.getAttribute("annee");
        String moisNom = (String) request.getAttribute("moisNom");
        Object employeObj = request.getAttribute("employe");

        // Calculer le dernier jour du mois
        int dernierJour = 30;
        String moisFormatted = "01";
        if (mois != null && annee != null) {
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.YEAR, annee);
            cal.set(Calendar.MONTH, mois - 1);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            dernierJour = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            moisFormatted = mois < 10 ? "0" + mois : String.valueOf(mois);
        }

        // Formater avec séparateur de milliers
        java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");

        // Formater tous les montants
        String salaireBaseFormatted = (salaireBase != null ? df.format(salaireBase) : "0") + " Ar";
        String salaireBrutFormatted = (salaireBrut != null ? df.format(salaireBrut) : "0") + " Ar";
        String majorationHeuresSuppFormatted = (majorationHeuresSupp != null ? df.format(majorationHeuresSupp) : "0") + " Ar";
        String tauxHoraireSuppFormatted = (tauxHoraireSupp != null ? df.format(tauxHoraireSupp) : "0") + " Ar";
        String cnaps1Formatted = (cnaps1 != null ? df.format(cnaps1) : "0") + " Ar";
        String cnaps8Formatted = (cnaps8 != null ? df.format(cnaps8) : "0") + " Ar";
        String ostie1Formatted = (ostie1 != null ? df.format(ostie1) : "0") + " Ar";
        String ostie5Formatted = (ostie5 != null ? df.format(ostie5) : "0") + " Ar";
        String revenuImposableFormatted = (revenuImposable != null ? df.format(revenuImposable) : "0") + " Ar";
        String irsaFormatted = (irsa != null ? df.format(irsa) : "0") + " Ar";
        String salaireNetFormatted = (salaireNet != null ? df.format(salaireNet) : "0") + " Ar";
        String avanceFormatted = (avance != null ? df.format(avance) : "0") + " Ar";
        String netAPayerFormatted = (netAPayer != null ? df.format(netAPayer) : "0") + " Ar";
        String tauxHoraireNormalFormatted = (tauxHoraireNormal != null ? df.format(tauxHoraireNormal) : "0") + " Ar";

        // Calculer les totaux
        BigDecimal totalCotisationsEmploye = BigDecimal.ZERO;
        if (cnaps1 != null) totalCotisationsEmploye = totalCotisationsEmploye.add(cnaps1);
        if (ostie1 != null) totalCotisationsEmploye = totalCotisationsEmploye.add(ostie1);
        String totalCotisationsEmployeFormatted = df.format(totalCotisationsEmploye) + " Ar";

        BigDecimal totalCotisationsEmployeur = BigDecimal.ZERO;
        if (cnaps8 != null) totalCotisationsEmployeur = totalCotisationsEmployeur.add(cnaps8);
        if (ostie5 != null) totalCotisationsEmployeur = totalCotisationsEmployeur.add(ostie5);
        String totalCotisationsEmployeurFormatted = df.format(totalCotisationsEmployeur) + " Ar";

        // Obtenir le matricule
        String matricule = "EMP0000";
        if (employeObj != null) {
            try {
                Long employeId = null;

                // Essayer d'obtenir l'ID de différentes manières
                if (employeObj instanceof com.ressourcesHumaine.rh.entities.Employe) {
                    com.ressourcesHumaine.rh.entities.Employe emp = (com.ressourcesHumaine.rh.entities.Employe) employeObj;
                    employeId = emp.getIdEmploye();
                }

                if (employeId != null) {
                    matricule = String.format("EMP%04d", employeId);
                }
            } catch (Exception e) {
                // Ignorer les erreurs
            }
        }
    %>

    <div class="container">
        <!-- Barre d'en-tête avec bouton retour -->
        <div class="header-bar">
            <h1><i class="fas fa-file-invoice-dollar"></i> Fiche de Paie Détaillée</h1>
            <a href="<%= request.getContextPath() %>/paies?month=<%= mois %>&year=<%= annee %>"
               class="btn-back">
                <i class="fas fa-arrow-left"></i> Retour à la liste
            </a>
        </div>

        <div class="payroll-sheet">
            <!-- En-tête avec logo de l'entreprise -->
            <div class="company-header">
                <div class="company-logo">
                    <div class="logo-placeholder">
                        <i class="fas fa-building fa-2x"></i>
                    </div>
                    <h3>GreenTech Solutions</h3>
                </div>
                <div class="company-info">
                    <h2>GREEN TECH SOLUTIONS SARL</h2>
                    <p>Lotissement d'Affaires Ivandry, Antananarivo 101</p>
                    <p>Tél: +261 20 22 333 44 | Email: contact@greentech.mg</p>
                    <p>NIF: 3000123456 | STAT: 63112 11 2018 0 08972</p>
                </div>
            </div>

            <!-- Titre du document -->
            <div class="document-title">
                <h1>BULLETIN DE PAIE</h1>
                <div class="period">Période : <%= moisNom != null ? moisNom : "" %> <%= annee != null ? annee : "" %></div>
            </div>

            <!-- Informations de l'employé -->
            <div class="employee-info">
                <h3>INFORMATIONS EMPLOYÉ</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Nom :</span>
                        <span class="info-value"><%= nomEmploye != null ? nomEmploye : "Non spécifié" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Matricule :</span>
                        <span class="info-value"><%= matricule %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Fonction :</span>
                        <span class="info-value"><%= poste != null ? poste : "Non spécifié" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Département :</span>
                        <span class="info-value"><%= departement != null ? departement : "Non spécifié" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Date d'embauche :</span>
                        <span class="info-value"><%= dateEmbauche != null ? dateEmbauche : "Non spécifié" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Période :</span>
                        <span class="info-value">Du 01/<%= moisFormatted %>/<%= annee != null ? annee : "" %> au <%= dernierJour %>/<%= moisFormatted %>/<%= annee != null ? annee : "" %></span>
                    </div>
                </div>
            </div>

            <!-- Gains et avantages -->
            <h3 class="section-title">GAINS ET AVANTAGES</h3>
            <table class="payroll-table">
                <thead>
                    <tr>
                        <th>Désignation</th>
                        <th>Unité</th>
                        <th>Quantité</th>
                        <th>Taux</th>
                        <th>Montant</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Salaire de base</td>
                        <td>Mois</td>
                        <td>1</td>
                        <td class="amount"><%= salaireBaseFormatted %></td>
                        <td class="amount"><%= salaireBaseFormatted %></td>
                    </tr>
                    <tr>
                        <td>Heures supplémentaires (majoration 50%)</td>
                        <td>Heures</td>
                        <td><%= heuresSupp != null ? heuresSupp : 0 %></td>
                        <td class="amount"><%= tauxHoraireSuppFormatted %></td>
                        <td class="amount"><%= majorationHeuresSuppFormatted %></td>
                    </tr>
                    <tr style="background-color: #f0f8f0;">
                        <td colspan="4" style="text-align: right; font-weight: bold;">TOTAL DES GAINS</td>
                        <td class="amount" style="font-size: 1.1em;"><%= salaireBrutFormatted %></td>
                    </tr>
                </tbody>
            </table>

            <!-- Cotisations sociales -->
            <h3 class="section-title">COTISATIONS SOCIALES</h3>
            <table class="payroll-table">
                <thead>
                    <tr>
                        <th>Désignation</th>
                        <th>Base</th>
                        <th>Taux</th>
                        <th>Employé</th>
                        <th>Employeur</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>CNAPS</td>
                        <td class="amount"><%= salaireBrutFormatted %></td>
                        <td>1% / 8%</td>
                        <td class="amount"><%= cnaps1Formatted %></td>
                        <td class="amount"><%= cnaps8Formatted %></td>
                    </tr>
                    <tr>
                        <td>OSTIE</td>
                        <td class="amount"><%= salaireBrutFormatted %></td>
                        <td>1% / 5%</td>
                        <td class="amount"><%= ostie1Formatted %></td>
                        <td class="amount"><%= ostie5Formatted %></td>
                    </tr>
                    <tr style="background-color: #f0f8f0;">
                        <td colspan="3" style="text-align: right; font-weight: bold;">TOTAL DES COTISATIONS</td>
                        <td class="amount"><%= totalCotisationsEmployeFormatted %></td>
                        <td class="amount"><%= totalCotisationsEmployeurFormatted %></td>
                    </tr>
                </tbody>
            </table>

            <!-- Impôt sur le revenu -->
            <h3 class="section-title">IMPÔT SUR LE REVENU (IRSA)</h3>
            <table class="payroll-table">
                <thead>
                    <tr>
                        <th>Revenu imposable</th>
                        <th>Taux</th>
                        <th>Montant IRSA</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="amount"><%= revenuImposableFormatted %></td>
                        <td>Barème progressif</td>
                        <td class="amount"><%= irsaFormatted %></td>
                    </tr>
                </tbody>
            </table>

            <!-- Récapitulatif -->
            <div class="totals-section">
                <h3 class="section-title">RÉCAPITULATIF</h3>
                <div class="total-row">
                    <span>Salaire brut :</span>
                    <span class="amount"><%= salaireBrutFormatted %></span>
                </div>
                <div class="total-row">
                    <span>Cotisations sociales employé :</span>
                    <span class="amount">- <%= totalCotisationsEmployeFormatted %></span>
                </div>
                <div class="total-row">
                    <span>Impôt sur le revenu (IRSA) :</span>
                    <span class="amount">- <%= irsaFormatted %></span>
                </div>
                <div class="total-row">
                    <span>Salaire net avant avance :</span>
                    <span class="amount"><%= salaireNetFormatted %></span>
                </div>
                <div class="total-row">
                    <span>Avance sur salaire :</span>
                    <span class="amount">- <%= avanceFormatted %></span>
                </div>
                <div class="total-row net-payable">
                    <span>NET À PAYER :</span>
                    <span class="amount"><%= netAPayerFormatted %></span>
                </div>
            </div>

            <!-- Détails techniques -->
            <div class="payroll-meta">
                <p>Taux horaire normal : <%= tauxHoraireNormalFormatted %> |
                   Taux horaire majoré : <%= tauxHoraireSuppFormatted %></p>
            </div>

            <!-- Mentions légales -->
            <div class="legal-mentions">
                <p><strong>Mentions légales :</strong> Ce bulletin de paie a été établi conformément à la législation du travail de Madagascar.</p>
                <p>Le salaire est payable le dernier jour ouvrable du mois.</p>
            </div>

            <!-- Signature -->
            <div class="payroll-footer">
                <div class="signature">
                    <p>Pour l'employeur</p>
                    <div class="signature-line"></div>
                    <p>Le Directeur Général</p>
                </div>
                <div class="signature">
                    <p>Pour acquit</p>
                    <div class="signature-line"></div>
                    <p>L'employé</p>
                </div>
            </div>

            <!-- Boutons d'action -->
            <div class="action-buttons">
                <button class="btn btn-primary" onclick="window.print()">
                    <i class="fas fa-print"></i> Imprimer
                </button>
                <button class="btn btn-primary" onclick="genererPDF()">
                    <i class="fas fa-file-pdf"></i> Générer PDF
                </button>
                <a href="<%= request.getContextPath() %>/paies?month=<%= mois != null ? mois : "" %>&year=<%= annee != null ? annee : "" %>"
                   class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
            </div>
        </div>
    </div>

    <script>
        function genererPDF() {
            // Masquer les boutons d'action avant la génération du PDF
            const actionButtons = document.querySelector('.action-buttons');
            const headerBar = document.querySelector('.header-bar');

            if (actionButtons) actionButtons.style.display = 'none';
            if (headerBar) headerBar.style.display = 'none';

            // Déclencher l'impression (qui peut être utilisée pour "Enregistrer au format PDF")
            window.print();

            // Restaurer les boutons après un court délai
            setTimeout(function() {
                if (actionButtons) actionButtons.style.display = 'flex';
                if (headerBar) headerBar.style.display = 'flex';
            }, 1000);
        }
    </script>
</body>
</html>