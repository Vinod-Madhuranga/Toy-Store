<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Edit Order - Toy Store</title>
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
            --warning-color: #FFA726;
            --success-color: #66BB6A;
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
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-2px);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem;
        }

        .order-summary-card {
            position: sticky;
            top: 20px;
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

        .btn-outline-secondary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 15px;
            padding: 12px 25px;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.2);
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
        }

        .table tbody tr:hover {
            background-color: rgba(255, 107, 107, 0.05);
        }

        .badge {
            padding: 8px 12px;
            border-radius: 15px;
            font-weight: 500;
        }

        .alert {
            border-radius: 15px;
            border: none;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        .alert-warning {
            background: linear-gradient(135deg, var(--accent-color), #fff3cd);
            color: #856404;
            border-left: 4px solid var(--warning-color);
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

        .input-group-text {
            background: var(--secondary-color);
            color: white;
            border: none;
            border-radius: 15px 0 0 15px !important;
        }

        .input-group .form-control, .input-group .form-select {
            border-radius: 0 15px 15px 0 !important;
            border-left: none;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }

        .order-info-item:last-child {
            border-bottom: none;
        }

        .quantity-input {
            width: 80px;
            text-align: center;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
            padding: 2rem 0;
        }

        .page-header h2 {
            color: var(--primary-color);
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #6c757d;
            font-size: 1.1rem;
        }

        .edit-restrictions {
            background: linear-gradient(135deg, #fff3cd, var(--accent-color));
            border-left: 4px solid var(--warning-color);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-section {
            margin-bottom: 2rem;
        }

        .form-section:last-child {
            margin-bottom: 0;
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

<div class="container mt-4">
    <!-- Page Header -->
    <div class="page-header animate__animated animate__fadeInDown">
        <h2><i class="fas fa-edit me-2"></i>Edit Order</h2>
        <p>Modify your order details while it's still pending</p>
    </div>

    <!-- Order Status Check -->
    <c:if test="${order.status != 'PENDING'}">
        <div class="edit-restrictions animate__animated animate__fadeIn">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-triangle me-3 fs-3 text-warning"></i>
                <div>
                    <h5 class="mb-1">Order Cannot Be Modified</h5>
                    <p class="mb-2">This order cannot be edited because it is no longer in PENDING status.</p>
                    <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i>Return to Order History
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Edit Form -->
    <c:if test="${order.status == 'PENDING'}">
        <form action="${pageContext.request.contextPath}/order/update" method="post" id="editForm">
            <input type="hidden" name="orderId" value="${order.orderId}">

            <div class="row">
                <!-- Left Column - Order Details -->
                <div class="col-lg-8">
                    <!-- Order Items Section -->
                    <div class="card animate__animated animate__fadeInLeft">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-box me-2"></i>Order Items</h5>
                        </div>
                        <div class="card-body p-10">
                            <div class="table-responsive">
                                <table class="table mb-0">
                                    <thead>
                                    <tr>
                                        <th><i class="fas fa-cube me-2"></i>Product</th>
                                        <th><i class="fas fa-tag me-2"></i>Price</th>
                                        <th><i class="fas fa-sort-numeric-up me-2"></i>Quantity</th>
                                        <th><i class="fas fa-calculator me-2"></i>Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${order.items}" var="item">
                                        <tr>
                                            <td>
                                                <input type="hidden" name="toyId" value="${item.toyId}">
                                                <input type="hidden" name="toyName_${item.toyId}" value="${item.toyName}">
                                                <input type="hidden" name="price_${item.toyId}" value="${item.price}">
                                                <strong>${item.toyName}</strong>
                                            </td>
                                            <td>$${item.price}</td>
                                            <td>
                                                <input type="number" name="quantity" value="${item.quantity}"
                                                       min="1" max="10" class="form-control quantity-input">
                                            </td>
                                            <td><strong>$${item.price * item.quantity}</strong></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Delivery Information Section -->
                    <div class="card animate__animated animate__fadeInLeft" style="animation-delay: 0.1s">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-truck me-2"></i>Delivery Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-section">
                                <label for="deliveryAddress" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Delivery Address *
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <textarea class="form-control" id="deliveryAddress" name="deliveryAddress"
                                              rows="3" required placeholder="Enter your complete delivery address...">${order.deliveryAddress}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="card animate__animated animate__fadeInLeft" style="animation-delay: 0.2s">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Payment Method</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="radio" name="paymentMethod"
                                               id="existingCard" value="existing_card" checked>
                                        <label class="form-check-label" for="existingCard">
                                            <i class="fas fa-credit-card me-2"></i>
                                            Use saved card ending in ****1234
                                        </label>
                                    </div>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="radio" name="paymentMethod"
                                               id="newCard" value="new_card">
                                        <label class="form-check-label" for="newCard">
                                            <i class="fas fa-plus-circle me-2"></i>
                                            Add new payment method
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <!-- New Payment Form -->
                            <div id="newPaymentForm" class="payment-form-container" style="display: none;">
                                <h6 class="mb-3">
                                    <i class="fas fa-credit-card me-2"></i>New Payment Details
                                </h6>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="type" class="form-label">Card Type *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-credit-card"></i></span>
                                            <select class="form-control" id="type" name="type">
                                                <option value="CREDIT_CARD">Credit Card</option>
                                                <option value="DEBIT_CARD">Debit Card</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="cardNumber" class="form-label">Card Number *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                            <input type="text" class="form-control" id="cardNumber" name="cardNumber"
                                                   maxlength="16" placeholder="1234567890123456">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="cardHolderName" class="form-label">Cardholder Name *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" class="form-control" id="cardHolderName" name="cardHolderName"
                                                   placeholder="John Doe">
                                        </div>
                                    </div>

                                    <div class="col-md-3 mb-3">
                                        <label for="expiryDate" class="form-label">Expiry Date *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                            <input type="month" class="form-control" id="expiryDate" name="expiryDate">
                                        </div>
                                    </div>

                                    <div class="col-md-3 mb-3">
                                        <label for="cvv" class="form-label">CVV *</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                            <input type="text" class="form-control" id="cvv" name="cvv"
                                                   maxlength="3" placeholder="123">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Order Summary -->
                <div class="col-lg-4">
                    <div class="card order-summary-card animate__animated animate__fadeInRight">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Order Summary</h5>
                        </div>
                        <div class="card-body">
                            <div class="order-info-item">
                                <span><i class="fas fa-hashtag me-2"></i>Order ID:</span>
                                <span><strong>#${order.orderId}</strong></span>
                            </div>

                            <div class="order-info-item">
                                <span><i class="fas fa-calendar me-2"></i>Order Date:</span>
                                <span>
                                    <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy"/>
                                </span>
                            </div>

                            <div class="order-info-item">
                                <span><i class="fas fa-clock me-2"></i>Order Time:</span>
                                <span>
                                    <fmt:formatDate value="${order.orderDate}" pattern="HH:mm"/>
                                </span>
                            </div>

                            <div class="order-info-item">
                                <span><i class="fas fa-info-circle me-2"></i>Status:</span>
                                <span class="badge bg-warning status-badge">
                                    <i class="fas fa-clock me-1"></i>${order.status}
                                </span>
                            </div>

                            <hr class="my-3">

                            <div class="order-info-item">
                                <span><i class="fas fa-shopping-basket me-2"></i>Items Total:</span>
                                <span>$${order.totalAmount}</span>
                            </div>

                            <div class="order-info-item">
                                <span><i class="fas fa-truck me-2"></i>Shipping:</span>
                                <span class="text-success">Free</span>
                            </div>

                            <div class="order-info-item mb-3">
                                <strong><i class="fas fa-dollar-sign me-2"></i>Total Amount:</strong>
                                <strong class="text-primary fs-5">$${order.totalAmount}</strong>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Update Order
                                </button>
                                <a href="${pageContext.request.contextPath}/order/history"
                                   class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-2"></i>Cancel Changes
                                </a>
                            </div>

                            <div class="text-center mt-3">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Changes will be saved immediately
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </c:if>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById('editForm')?.addEventListener('submit', function(e) {
        // Show loading spinner
        document.querySelector('.loading-spinner').style.display = 'block';

        // Add a small delay to show the loading effect
        setTimeout(() => {
            // Form will submit naturally
        }, 100);
    });

    // Add animation to form elements on focus
    document.querySelectorAll('.form-control, .form-select').forEach(element => {
        element.addEventListener('focus', function() {
            this.style.transform = 'scale(1.02)';
        });

        element.addEventListener('blur', function() {
            this.style.transform = 'scale(1)';
        });
    });

    // Toggle payment form visibility
    document.getElementById('newCard').addEventListener('change', function() {
        const paymentForm = document.getElementById('newPaymentForm');
        if (this.checked) {
            paymentForm.style.display = 'block';
            paymentForm.classList.add('animate__animated', 'animate__fadeIn');
        }
    });

    document.getElementById('existingCard').addEventListener('change', function() {
        if (this.checked) {
            document.getElementById('newPaymentForm').style.display = 'none';
        }
    });

    // Real-time total calculation
    document.querySelectorAll('input[name="quantity"]').forEach(input => {
        input.addEventListener('change', function() {
            // You can add real-time calculation logic here
            console.log('Quantity changed:', this.value);
        });
    });

    // Add hover effects to table rows
    document.querySelectorAll('.table tbody tr').forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.backgroundColor = 'rgba(255, 107, 107, 0.05)';
        });

        row.addEventListener('mouseleave', function() {
            this.style.backgroundColor = '';
        });
    });
</script>
</body>
</html>
