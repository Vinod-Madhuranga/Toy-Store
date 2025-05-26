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

    <title>Profile - Toy Store</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Password strength meter -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/password-strength-meter/2.1.1/password.min.css">
    <style>
        :root {
            --primary-color: #FF6B6B;
            --secondary-color: #4ECDC4;
            --accent-color: #FFE66D;
            --dark-color: #333;
            --light-color: #f8f9fa;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 40px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .profile-container::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: var(--accent-color);
            border-radius: 50%;
            z-index: 0;
            opacity: 0.3;
        }

        .profile-container::after {
            content: '';
            position: absolute;
            bottom: -30px;
            left: -30px;
            width: 100px;
            height: 100px;
            background: var(--secondary-color);
            border-radius: 50%;
            z-index: 0;
            opacity: 0.2;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 40px;
            animation: slideDown 0.5s ease-out;
            position: relative;
            z-index: 1

        ;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            border: 4px solid white;
        }

        .profile-avatar:hover {
            transform: scale(1.1) rotate(10deg);
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 12px 15px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: 2px solid #e9ecef;
            font-size: 15px;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 205, 196, 0.25);
        }

        .btn-update {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            border-radius: 12px;
            padding: 12px;
            color: white;
            font-weight: bold;
            width: 100%;
            margin-top: 15px;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .btn-update:hover {
            background: linear-gradient(135deg, #FF8E8E 0%, var(--primary-color) 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
        }

        .btn-logout {
            background: var(--primary-color);
            border: none;
            border-radius: 12px;
            padding: 12px;
            color: white;
            font-weight: bold;
            width: 100%;
            margin-top: 15px;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .btn-logout:hover {
            background: #e05565;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            border: none;
            border-radius: 12px;
            padding: 12px;
            color: white;
            font-weight: bold;
            width: 100%;
            margin-top: 15px;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #ff4b2b 0%, #ff416c 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 65, 108, 0.4);
        }

        .modal-content {
            border-radius: 20px;
            animation: fadeIn 0.3s ease-out;
            border: none;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-bottom: none;
            padding: 20px;
        }

        .modal-footer .btn-secondary {
            background: #6c757d;
            border: none;
            border-radius: 12px;
            padding: 10px 20px;
        }

        .modal-footer .btn-danger {
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            border: none;
            border-radius: 12px;
            padding: 10px 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideDown {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
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
            font-size: 28px;
            animation: float 8s infinite ease-in-out;
            opacity: 0.7;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(10deg); }
        }

        .alert {
            border-radius: 12px;
            animation: slideDown 0.5s ease-out;
            padding: 15px;
            border: none;
        }

        .alert-success {
            background-color: rgba(40, 167, 69, 0.15);
            color: #28a745;
        }

        .alert-danger {
            background-color: rgba(220, 53, 69, 0.15);
            color: #dc3545;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }

        .loading-spinner {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            z-index: 1000;
        }

        .spinner-border {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 3rem;
            height: 3rem;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.4rem;
        }

        .nav-link {
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.25);
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 48px;
            cursor: pointer;
            color: #6c757d;
            z-index: 5;
        }

        .password-strength-meter {
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .profile-stats {
            display: flex;
            justify-content: space-around;
            margin: 30px 0;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            min-width: 150px;
            margin: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border: 1px solid #f1f1f1;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: var(--primary-color);
            margin: 10px 0;
        }

        .stat-label {
            color: #6c757d;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .tab-content {
            padding: 20px 0;
        }

        .nav-tabs {
            border-bottom: 2px solid #dee2e6;
            margin-bottom: 20px;
        }

        .nav-tabs .nav-link {
            border: none;
            color: #495057;
            font-weight: 500;
            padding: 12px 20px;
            margin-right: 5px;
            border-radius: 8px 8px 0 0;
        }

        .nav-tabs .nav-link.active {
            color: var(--primary-color);
            background-color: white;
            border-bottom: 3px solid var(--primary-color);
        }

        .nav-tabs .nav-link:hover:not(.active) {
            border-color: transparent;
            color: var(--primary-color);
        }

        .order-history-item {
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .order-history-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-color: var(--secondary-color);
        }

        .order-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .order-date {
            color: #6c757d;
            font-size: 14px;
        }

        .order-total {
            font-weight: bold;
            font-size: 18px;
        }

        .badge-notification {
            position: absolute;
            top: -5px;
            right: -5px;
            font-size: 10px;
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-section {
            margin-bottom: 40px;
        }

        .section-title {
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 10px;
            margin-bottom: 20px;
            color: var(--dark-color);
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: var(--secondary-color);
        }

        .profile-badge {
            display: inline-block;
            background: var(--accent-color);
            color: var(--dark-color);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }

        .profile-progress {
            height: 8px;
            border-radius: 4px;
            margin-bottom: 20px;
            background-color: #e9ecef;
        }

        .profile-progress-bar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 4px;
        }

        .form-note {
            font-size: 13px;
            color: #6c757d;
            margin-top: -15px;
            margin-bottom: 15px;
        }

        .avatar-upload {
            position: relative;
            width: 120px;
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
            width: 34px;
            height: 34px;
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
            width: 120px;
            height: 120px;
            position: relative;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
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

        .social-links {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #f1f1f1;
            color: #333;
            margin: 0 8px;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }

        .two-factor-section {
            background: #f9f9f9;
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
        }

        .qr-code-container {
            text-align: center;
            margin: 20px 0;
        }

        .qr-code {
            width: 180px;
            height: 180px;
            margin: 0 auto;
            background: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .backup-codes {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            font-family: monospace;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .backup-code {
            display: inline-block;
            margin: 5px;
            padding: 5px 10px;
            background: #f1f1f1;
            border-radius: 4px;
        }

        .security-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }

        .badge-enabled {
            background: #d4edda;
            color: #155724;
        }

        .badge-disabled {
            background: #f8d7da;
            color: #721c24;
        }

        .activity-item {
            padding: 15px 0;
            border-bottom: 1px solid #f1f1f1;
            display: flex;
            align-items: center;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary-color);
        }

        .activity-details {
            flex: 1;
        }

        .activity-time {
            font-size: 12px;
            color: #6c757d;
        }

        .device-item {
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .device-info {
            display: flex;
            align-items: center;
        }

        .device-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--secondary-color);
        }

        .device-current {
            background: var(--accent-color);
            color: var(--dark-color);
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="floating-toys">
    <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
    <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
    <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
    <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    <i class="fas fa-car toy" style="top: 30%; left: 30%; animation-delay: 4s;"></i>
    <i class="fas fa-drum toy" style="bottom: 30%; right: 30%; animation-delay: 5s;"></i>
</div>

<!-- Loading Spinner -->
<div class="loading-spinner">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-store me-2"></i>Toy Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/order/history">
                        <i class="fas fa-history me-1"></i>Order History
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/update-profile">
                        <i class="fas fa-user me-1"></i>Profile
                    </a>
                </li>
                <li class="nav-item">
                    <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                        <button type="submit" class="nav-link btn btn-link" style="cursor: pointer;">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="profile-container">
        <div class="profile-header">
            <form id="avatarForm" action="${pageContext.request.contextPath}/update-profile" method="post" enctype="multipart/form-data">
                <input type="hidden" name="csrfToken" value="${csrfToken}">
                <div class="avatar-upload">
                    <div class="avatar-edit">
                        <input type="file" id="avatarUpload" name="avatarUpload" accept=".png, .jpg, .jpeg" />
                        <label for="avatarUpload"><i class="fas fa-pencil-alt"></i></label>
                    </div>
                    <div class="avatar-preview">
                        <div id="avatarPreview" style="background-image: url('${user.avatarUrl != null ? user.avatarUrl : ''}');">
                            <c:if test="${user.avatarUrl == null}">
                                <i class="fas fa-user" style="color: white; font-size: 50px; display: flex; align-items: center; justify-content: center; height: 100%;"></i>
                            </c:if>
                        </div>
                    </div>
                </div>
            </form>
            <h2>${user.fullName}</h2>
            <p class="text-muted">${user.username}</p>
            <span class="profile-badge"><i class="fas fa-star me-1"></i>Member</span>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <ul class="nav nav-tabs" id="profileTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab">
                    <i class="fas fa-user-circle me-1"></i>Profile
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab">
                    <i class="fas fa-shield-alt me-1"></i>Security
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="orders-tab" data-bs-toggle="tab" data-bs-target="#orders" type="button" role="tab">
                    <i class="fas fa-shopping-bag me-1"></i>Orders
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="activity-tab" data-bs-toggle="tab" data-bs-target="#activity" type="button" role="tab">
                    <i class="fas fa-history me-1"></i>Activity
                </button>
            </li>
        </ul>

        <div class="tab-content" id="profileTabsContent">
            <!-- Profile Tab -->
            <div class="tab-pane fade show active" id="profile" role="tabpanel">
                <form action="${pageContext.request.contextPath}/update-profile" method="post" id="profileForm" enctype="multipart/form-data">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       value="${user.fullName}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username"
                                       value="${user.username}" required disabled>
                                <small class="form-note">Username cannot be changed</small>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${user.email}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                                       value="${user.phoneNumber}">
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="3">${user.address}</textarea>
                    </div>
                    <div class="mb-3">
                        <label for="bio" class="form-label">Bio</label>
                        <textarea class="form-control" id="bio" name="bio" rows="3" maxlength="200">${user.bio}</textarea>
                        <small class="form-note">Tell us something about yourself (max 200 characters)</small>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="birthDate" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="birthDate" name="birthDate"
                                       value="${user.birthDate}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="">Select Gender</option>
                                    <option value="MALE" ${user.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                    <option value="FEMALE" ${user.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                    <option value="OTHER" ${user.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                                    <option value="PREFER_NOT_TO_SAY" ${user.gender == 'PREFER_NOT_TO_SAY' ? 'selected' : ''}>Prefer not to say</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-update">
                        <i class="fas fa-save me-2"></i>Update Profile
                    </button>
                </form>
            </div>

            <!-- Security Tab -->
            <div class="tab-pane fade" id="security" role="tabpanel">
                <div class="profile-section">
                    <h5 class="section-title"><i class="fas fa-key"></i>Change Password</h5>
                    <form action="${pageContext.request.contextPath}/change-password" method="post" id="passwordForm">
                        <input type="hidden" name="csrfToken" value="${csrfToken}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3 password-container">
                                    <label for="currentPassword" class="form-label">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    <i class="fas fa-eye password-toggle" onclick="togglePassword('currentPassword', this)"></i>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3 password-container">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    <i class="fas fa-eye password-toggle" onclick="togglePassword('newPassword', this)"></i>
                                    <div id="password-strength-meter" class="password-strength-meter"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3 password-container">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <i class="fas fa-eye password-toggle" onclick="togglePassword('confirmPassword', this)"></i>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-update">
                            <i class="fas fa-lock me-2"></i>Change Password
                        </button>
                    </form>
                </div>

                <div class="two-factor-section">
                    <h5 class="section-title"><i class="fas fa-shield-alt"></i>Two-Factor Authentication
                        <span class="security-badge ${user.twoFactorEnabled ? 'badge-enabled' : 'badge-disabled'}">
                            ${user.twoFactorEnabled ? 'Enabled' : 'Disabled'}
                        </span>
                    </h5>

                    <c:choose>
                        <c:when test="${user.twoFactorEnabled}">
                            <p>Two-factor authentication is currently enabled on your account.</p>
                            <div class="qr-code-container">
                                <p>Scan this QR code with your authenticator app:</p>
                                <div class="qr-code">
                                    <i class="fas fa-qrcode" style="font-size: 100px; color: #333;"></i>
                                </div>
                            </div>
                            <div class="backup-codes">
                                <h6>Backup Codes</h6>
                                <p>Save these codes in a safe place. Each code can be used only once.</p>
                                <div>
                                    <span class="backup-code">A1B2C3D4</span>
                                    <span class="backup-code">E5F6G7H8</span>
                                    <span class="backup-code">I9J0K1L2</span>
                                    <span class="backup-code">M3N4O5P6</span>
                                    <span class="backup-code">Q7R8S9T0</span>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/disable-2fa" method="post" class="mt-3">
                                <input type="hidden" name="csrfToken" value="${csrfToken}">
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-times-circle me-2"></i>Disable Two-Factor Authentication
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p>Enhance your account security by enabling two-factor authentication.</p>
                            <form action="${pageContext.request.contextPath}/enable-2fa" method="post">
                                <input type="hidden" name="csrfToken" value="${csrfToken}">
                                <button type="submit" class="btn btn-update">
                                    <i class="fas fa-shield-alt me-2"></i>Enable Two-Factor Authentication
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="profile-section">
                    <h5 class="section-title"><i class="fas fa-desktop"></i>Active Sessions</h5>
                    <c:forEach var="session" items="${activeSessions}">
                        <div class="device-item">
                            <div class="device-info">
                                <div class="device-icon">
                                    <i class="fas ${session.deviceType == 'MOBILE' ? 'fa-mobile-alt' : session.deviceType == 'TABLET' ? 'fa-tablet-alt' : 'fa-laptop'}"></i>
                                </div>
                                <div>
                                    <div><strong>${session.deviceName}</strong></div>
                                    <div class="text-muted">${session.location} - Last active: ${session.lastActive}</div>
                                    <c:if test="${session.current}">
                                        <span class="device-current">Current Session</span>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${!session.current}">
                                <form action="${pageContext.request.contextPath}/terminate-session" method="post">
                                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                                    <input type="hidden" name="sessionId" value="${session.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-sign-out-alt me-1"></i>Terminate
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Orders Tab -->
            <div class="tab-pane fade" id="orders" role="tabpanel">
                <div class="profile-section">
                    <h5 class="section-title"><i class="fas fa-shopping-bag"></i>Order History</h5>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <p class="text-muted">No orders found.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <div class="order-history-item">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="order-date">${order.orderDate}</div>
                                            <div>Order #${order.orderId}</div>
                                        </div>
                                        <div class="col-md-4">
                                            <span class="order-status status-${order.status.toLowerCase()}">${order.status}</span>
                                        </div>
                                        <div class="col-md-4 text-end">
                                            <div class="order-total">$${order.totalAmount}</div>
                                            <a href="${pageContext.request.contextPath}/order/details/${order.orderId}" class="btn btn-link">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Activity Tab -->
            <div class="tab-pane fade" id="activity" role="tabpanel">
                <div class="profile-section">
                    <h5 class="section-title"><i class="fas fa-history"></i>Recent Activity</h5>
                    <c:choose>
                        <c:when test="${empty activities}">
                            <p class="text-muted">No recent activity.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="activity" items="${activities}">
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas ${activity.type == 'LOGIN' ? 'fa-sign-in-alt' : activity.type == 'PURCHASE' ? 'fa-shopping-cart' : 'fa-user-edit'}"></i>
                                    </div>
                                    <div class="activity-details">
                                        <div>${activity.description}</div>
                                        <div class="activity-time">${activity.timestamp}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Delete Account Section -->
        <div class="profile-section">
            <h5 class="section-title"><i class="fas fa-trash-alt"></i>Delete Account</h5>
            <p class="text-muted">Permanently delete your account and all associated data. This action cannot be undone.</p>
            <button class="btn btn-delete" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                <i class="fas fa-trash-alt me-2"></i>Delete Account
            </button>
        </div>
    </div>
</div>

<!-- Delete Account Modal -->
<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteAccountModalLabel">Confirm Account Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete your account? This action is permanent and cannot be undone.</p>
                <div class="mb-3 password-container">
                    <label for="deletePassword" class="form-label">Enter Password to Confirm</label>
                    <input type="password" class="form-control" id="deletePassword" name="deletePassword" required>
                    <i class="fas fa-eye password-toggle" onclick="togglePassword('deletePassword', this)"></i>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="${pageContext.request.contextPath}/delete-profile" method="post">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <input type="hidden" name="deletePassword" id="modalDeletePassword">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash-alt me-2"></i>Delete Account
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Password Strength Meter -->
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
    $('#newPassword').password({
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
                // Auto-submit avatar form
                document.getElementById('avatarForm').submit();
            };
            reader.readAsDataURL(file);
        }
    });

    // Delete Account Modal Password Sync
    document.getElementById('deletePassword').addEventListener('input', function() {
        document.getElementById('modalDeletePassword').value = this.value;
    });

    // Form Submission Loading Spinner
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function() {
            document.querySelector('.loading-spinner').style.display = 'block';
        });
    });

    // Initialize Tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
</script>
</body>
</html>