<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Join Toy Store - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Password strength meter -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/password-strength-meter/2.1.1/password.min.css">
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

        .register-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .register-container::before {
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

        .register-container::after {
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

        .form-control, .form-select {
            border-radius: 15px;
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .login-link a:hover {
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
            height: 50px;
            min-width: 50px;
            font-size: 1.2rem;
            border-radius: 15px 0 0 15px !important;
            padding: 0;
        }

        .input-group .form-control {
            height: 50px;
            border-radius: 0 15px 15px 0 !important;
            font-size: 1rem;
            padding-left: 15px;
            padding-right: 15px;
            border-left: none;
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 18px;
            cursor: pointer;
            color: #6c757d;
            z-index: 5;
        }

        .password-strength-meter {
            margin-top: -10px;
            margin-bottom: 15px;
        }

        .avatar-upload {
            position: relative;
            width: 100px;
            margin: 0 auto 20px;
        }

        .avatar-edit {
            position: absolute;
            right: 5px;
            bottom: 5px;
            z-index: 1;
        }

        .avatar-edit input {
            display: none;
        }

        .avatar-edit label {
            display: inline-block;
            width: 30px;
            height: 30px;
            margin-bottom: 0;
            border-radius: 50%;
            background: #ffffff;
            border: 1px solid #d2d6de;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            font-weight: normal;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .avatar-edit label:hover {
            background: #f1f1f1;
        }

        .avatar-preview {
            width: 100px;
            height: 100px;
            position: relative;
            border-radius: 50%;
            border: 3px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }

        .avatar-preview > div {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        .form-note {
            font-size: 12px;
            color: #6c757d;
            margin-top: -10px;
            margin-bottom: 15px;
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
    <div class="register-container">
        <div class="text-center">
            <div class="avatar-upload">
                <div class="avatar-edit">
                    <input type="file" id="avatarUpload" name="avatarUpload" accept=".png, .jpg, .jpeg" />
                    <label for="avatarUpload"><i class="fas fa-pencil-alt"></i></label>
                </div>
                <div class="avatar-preview">
                    <div id="avatarPreview">
                        <i class="fas fa-user" style="color: white; font-size: 40px; display: flex; align-items: center; justify-content: center; height: 100%;"></i>
                    </div>
                </div>
            </div>
            <h1 class="store-title">Toy Store</h1>
            <p class="text-muted">Join our toy adventure!</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="register" method="post" enctype="multipart/form-data">
            <input type="hidden" name="csrfToken" value="${csrfToken}">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email *</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
            </div>
            <div class="mb-3 password-container">
                <label for="password" class="form-label">Password *</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <i class="fas fa-eye password-toggle" onclick="togglePassword('password', this)"></i>
                </div>
                <div id="password-strength-meter" class="password-strength-meter"></div>
                <small class="form-note">Password must be at least 8 characters long</small>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                    <input type="text" class="form-control" id="address" name="address">
                </div>
            </div>
            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" maxlength="10">
                </div>
                <small class="form-note">Enter 10-digit phone number (e.g., 1234567890)</small>
            </div>
            <div class="mb-3">
                <label for="bio" class="form-label">Bio</label>
                <textarea class="form-control" id="bio" name="bio" rows="3" maxlength="200"></textarea>
                <small class="form-note">Tell us about yourself (max 200 characters)</small>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="birthDate" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="birthDate" name="birthDate">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="">Select Gender</option>
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                            </select>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-register">
                <i class="fas fa-user-plus"></i> Join the Fun!
            </button>
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="login.jsp">Let's Play!</a></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.4.2/zxcvbn.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/password-strength-meter/2.1.1/password.min.js"></script>
<script>
    // Password Toggle Functionality
    function togglePassword(inputId, icon) {
        const input = document.getElementById(inputId);
        const type = input.type === 'password' ? 'text' : 'password';
        input.type = type;
        icon.classList.toggle('fa-eye');
        icon.classList.toggle('fa-eye-slash');
    }

    // Password Strength Meter
    $('#password').password({
        animate: true,
        strengthMeter: true,
        strengthMeterClass: 'password-strength-meter',
        strengthMeterText: ''
    });

    // Avatar Upload Preview
    document.getElementById('avatarUpload').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('avatarPreview');
                preview.style.backgroundImage = `url(${e.target.result})`;
                preview.querySelector('i')?.remove();
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>