<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Place Order - Toy Store</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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

        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            background: white;
            position: relative;
            overflow: hidden;
        }

        .card::before {
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

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            padding: 12px 25px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        .form-control, .form-select {
            border-radius: 15px;
            padding: 12px;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
        }
        
        .table {
            border-radius: 15px;
            overflow: hidden;
        }
        
        .table thead th {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background-color: rgba(255, 107, 107, 0.05);
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
        
        .loading-spinner {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            z-index: 1000;
        }
        
        .spinner-border {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
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
            background: var(--secondary-color);
            color: white;
            border: none;
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
    <!-- Floating Toys Background -->
    <div class="floating-toys">
        <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
        <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
        <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
        <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
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
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4 animate-fade-in">
        <h2 class="text-center mb-4">
            <i class="fas fa-shopping-cart me-2"></i>Place New Order
        </h2>
        
        <form action="${pageContext.request.contextPath}/order/place" method="post" class="mt-4" id="orderForm">
            <div class="row">
                <div class="col-md-8">
                    <div class="card mb-4 animate__animated animate__fadeInLeft">
                        <div class="card-header">
                            <h4><i class="fas fa-box me-2"></i>Selected Items</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-toy me-2"></i>Toy</th>
                                            <th><i class="fas fa-tag me-2"></i>Price</th>
                                            <th><i class="fas fa-sort-numeric-up me-2"></i>Quantity</th>
                                            <th><i class="fas fa-calculator me-2"></i>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cartItems}" var="item">
                                            <tr class="animate__animated animate__fadeIn">
                                                <td>
                                                    <input type="hidden" name="toyId" value="${item.toyId}">
                                                    <input type="hidden" name="toyName_${item.toyId}" value="${item.toyName}">
                                                    <input type="hidden" name="price_${item.toyId}" value="${item.price}">
                                                    ${item.toyName}
                                                </td>
                                                <td>$${item.price}</td>
                                                <td>
                                                    <input type="number" name="quantity" value="${item.quantity}" 
                                                           min="1" max="10" class="form-control" style="width: 80px">
                                                </td>
                                                <td>$${item.price * item.quantity}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mb-4 animate__animated animate__fadeInLeft">
                        <div class="card-header">
                            <h4><i class="fas fa-truck me-2"></i>Delivery Information</h4>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="deliveryAddress" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Delivery Address
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" 
                                              rows="3" required></textarea>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="paymentMethod" class="form-label">
                                    <i class="fas fa-credit-card me-2"></i>Payment Method
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-credit-card"></i></span>
                                    <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                        <option value="">Select payment method</option>
                                        <option value="CREDIT_CARD"><i class="fab fa-cc-visa"></i> Credit Card</option>
                                        <option value="DEBIT_CARD"><i class="fas fa-credit-card"></i> Debit Card</option>
                                        <option value="PAYPAL"><i class="fab fa-paypal"></i> PayPal</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card animate__animated animate__fadeInRight">
                        <div class="card-header">
                            <h4><i class="fas fa-receipt me-2"></i>Order Summary</h4>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span><i class="fas fa-shopping-basket me-2"></i>Subtotal:</span>
                                <span>$${subtotal}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span><i class="fas fa-tags me-2"></i>Discount:</span>
                                <span>$${discount}</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-3">
                                <strong><i class="fas fa-dollar-sign me-2"></i>Total:</strong>
                                <strong>$${total}</strong>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-check-circle me-2"></i>Place Order
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        document.getElementById('orderForm').addEventListener('submit', function() {
            document.querySelector('.loading-spinner').style.display = 'block';
        });
        
        // Add animation to form elements on focus
        document.querySelectorAll('.form-control, .form-select').forEach(element => {
            element.addEventListener('focus', function() {
                this.classList.add('animate__animated', 'animate__pulse');
            });
            
            element.addEventListener('blur', function() {
                this.classList.remove('animate__animated', 'animate__pulse');
            });
        });
    </script>
</body>
</html> 