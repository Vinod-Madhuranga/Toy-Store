<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Welcome to Toy Store - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6B6B;
            --secondary-color: #4ECDC4;
            --accent-color: #FFE66D;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Comic Sans MS', cursive, sans-serif;
        }

        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 100px;
            height: 100px;
            background: var(--accent-color);
            border-radius: 50%;
            z-index: 0;
        }

        .login-container::after {
            content: '';
            position: absolute;
            bottom: -30px;
            left: -30px;
            width: 80px;
            height: 80px;
            background: var(--secondary-color);
            border-radius: 50%;
            z-index: 0;
        }

        .store-title {
            text-align: center;
            color: var(--primary-color);
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .toy-icon {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .form-control {
            border-radius: 15px;
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
        }

        .btn-login {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            border-radius: 15px;
            padding: 12px;
            color: white;
            font-weight: bold;
            width: 100%;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            color: var(--primary-color);
        }

        .floating-toys {
            position: fixed;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .toy {
            position: absolute;
            font-size: 24px;
            animation: float 6s infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        .alert {
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .input-group {
            width: 100%;
            align-items: stretch;
        }

        .input-group-text {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 60px;
            min-width: 60px;
            font-size: 1.5rem;
            border-radius: 20px 0 0 20px !important;
            padding: 0;
        }

        .input-group .form-control {
            height: 60px;
            border-radius: 0 20px 20px 0 !important;
            font-size: 1.2rem;
            padding-left: 20px;
            padding-right: 20px;
            border-left: none;
        }
    </style>
</head>
<body>
    <div class="floating-toys">
        <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
        <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
        <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
        <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    </div>

    <div class="container">
        <div class="login-container">
            <div class="text-center">
                <i class="fas fa-teddy-bear toy-icon"></i>
                <h1 class="store-title">Toy Store</h1>
                <p class="text-muted">Welcome to the world of fun!</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="login" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                </div>
                <!-- Forgot Password Link -->
                <div class="forgot-password text-center mt-3">
                    <a href="forgetpassword.jsp" style="color: var(--primary-color); font-weight: bold; text-decoration: none; display: inline-flex; align-items: center; gap: 5px;">
                        <i class="fas fa-key"></i>
                        Forgot Password?
                    </a>
                </div>
                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </form>

            <div class="register-link">
                <p>Don't have an account? <a href="register.jsp">Join the fun!</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 