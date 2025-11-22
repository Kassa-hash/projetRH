<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | RH Manager</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2d5016 0%, #1a1a1a 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .login-container {
            width: 420px;
            background: #ffffff;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-area {
            text-align: center;
            margin-bottom: 25px;
        }

        .logo-area h1 {
            font-size: 2em;
            margin-bottom: 5px;
            color: #2d5016;
        }

        .logo-area p {
            font-size: 0.9em;
            color: #666;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #444;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group input:focus {
            border-color: #4a7c2c;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 124, 44, 0.3);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4a7c2c 0%, #5a9c3c 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1em;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(74, 124, 44, 0.35);
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            border-left: 4px solid #dc3545;
        }

        .footer-text {
            margin-top: 18px;
            text-align: center;
            font-size: 0.85em;
            color: #777;
        }
    </style>
</head>

<body>
    <div class="login-container">

        <div class="logo-area">
            <h1>🏢 Domaine employe</h1>
            <p>Connexion</p>
        </div>

        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>

        <form action="/employes/login" method="post">
            <div class="form-group">
                <label for="username">Nom d'utilisateur</label>
                <input type="text" name="nom" id="username" placeholder="Votre identifiant" required>
            </div>

            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" name="mdp" id="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-login">Se connecter</button>
        </form>

    </div>
</body>
</html>
