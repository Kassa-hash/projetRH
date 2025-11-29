<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, com.ressourcesHumaine.rh.entities.*" %>
<%
    Employe employe = (Employe) request.getAttribute("employe");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");


    if (employe == null) {
        employe = new Employe();
    }
    if (genres == null) {
        genres = new ArrayList<>();
    }



    String action = employe.getIdEmploye() != null ? "Modifier" : "Ajouter";
    String formAction = employe.getIdEmploye() != null ?
        request.getContextPath() + "/employes/modifier/" + employe.getIdEmploye() :
        request.getContextPath() + "/employes/ajouter";

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= action %> un Employé</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 800px;
            width: 100%;
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
            font-size: 2em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .content {
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

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
            background: white;
        }

        .form-control:focus {
            outline: none;
            border-color: #4a7c2c;
            box-shadow: 0 0 0 3px rgba(74, 124, 44, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
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
            text-align: center;
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

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .required::after {
            content: " *";
            color: #dc3545;
        }

        .photo-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0e0e0 0%, #c0c0c0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            color: #666;
            border: 3px solid #4a7c2c;
            margin: 10px auto;
            overflow: hidden;
        }

        .photo-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1><%= action %> un Employé</h1>
            <p>Remplissez les informations de l'employé</p>
        </header>

        <div class="content">
            <%-- Messages d'erreur --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <%-- Messages de succès --%>
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getParameter("success") %>
                </div>
            <% } %>

            <form action="<%= formAction %>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="nom" class="required">Nom complet</label>
                    <input type="text" id="nom" name="nom" class="form-control"
                           value="<%= employe.getNom() != null ? employe.getNom() : "" %>"
                           required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="dateDeNaissance" class="required">Date de naissance</label>
                        <input type="date" id="dateDeNaissance" name="dateDeNaissance" class="form-control"
                               value="<%= employe.getDateDeNaissance() != null ? sdf.format(employe.getDateDeNaissance()) : "" %>"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="genre" class="required">Genre</label>
                        <select id="genre" name="idGenre" class="form-control" required>
                            <option value="">Sélectionnez un genre</option>
                            <% for (Genre genre : genres) { %>
                                <option value="<%= genre.getIdGenre() %>"
                                    <%= (employe.getGenre() != null && employe.getGenre().getIdGenre().equals(genre.getIdGenre())) ? "selected" : "" %>>
                                    <%= genre.getLibelle() %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="contact" class="required">Contact</label>
                        <input type="tel" id="contact" name="contact" class="form-control"
                               value="<%= employe.getContact() != null ? employe.getContact() : "" %>"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="required">Email</label>
                        <input type="email" id="email" name="email" class="form-control"
                               value="<%= employe.getEmail() != null ? employe.getEmail() : "" %>"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="adresse" class="required">Adresse</label>
                    <textarea id="adresse" name="adresse" class="form-control" rows="3" required><%= employe.getAdresse() != null ? employe.getAdresse() : "" %></textarea>
                </div>

                <div class="form-row">


                    <div class="form-group">
                        <label for="mdp" <%= employe.getIdEmploye() == null ? "class=\"required\"" : "" %>>Mot de passe</label>
                        <input type="password" id="mdp" name="mdp" class="form-control"
                               <%= employe.getIdEmploye() == null ? "required" : "" %>>
                        <% if (employe.getIdEmploye() != null) { %>
                            <small style="color: #666;">Laissez vide pour ne pas modifier</small>
                        <% } %>
                    </div>
                </div>

                <div class="form-group">
                    <label for="photo">Photo</label>
                    <input type="file" id="photo" name="photo" class="form-control"
                           accept="image/*" onchange="previewPhoto(this)">

                    <%-- Aperçu de la photo --%>
                    <div class="photo-preview" id="photoPreview">
                        <% if (employe.getPhoto() != null && !employe.getPhoto().isEmpty()) { %>
                            <img src="<%= employe.getPhoto() %>" alt="Photo actuelle">
                        <% } else { %>
                            👤
                        <% } %>
                    </div>

                    <%-- Champ caché pour conserver l'URL de la photo existante --%>
                    <% if (employe.getPhoto() != null && !employe.getPhoto().isEmpty()) { %>
                        <input type="hidden" name="existingPhoto" value="<%= employe.getPhoto() %>">
                    <% } %>
                </div>

                <div class="form-actions">
                    <a href="<%= request.getContextPath() %>/employes" class="btn btn-secondary">
                        ← Retour
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <%= action %> l'employé
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Prévisualisation de la photo
        function previewPhoto(input) {
            const preview = document.getElementById('photoPreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.innerHTML = '<img src="' + e.target.result + '" alt="Aperçu photo">';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const contact = document.getElementById('contact').value;
            const genre = document.getElementById('genre').value;


            // Validation basique de l'email
            if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
                alert('Veuillez entrer une adresse email valide');
                e.preventDefault();
                return;
            }



            // Validation du genre
            if (!genre) {
                alert('Veuillez sélectionner un genre');
                e.preventDefault();
                return;
            }


        });
    </script>
</body>
</html>