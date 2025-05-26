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

    <title>Order History - Toy Store</title>
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
        
        .card::after {
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
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem;
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
        
        .btn-group .btn {
            border-radius: 15px;
            margin: 0 2px;
            transition: all 0.3s ease;
        }
        
        .btn-group .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.2);
        }
        
        .badge {
            padding: 8px 12px;
            border-radius: 15px;
            font-weight: 500;
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
        
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            color: #6c757d;
            background: linear-gradient(135deg, rgba(255, 107, 107, 0.05), rgba(78, 205, 196, 0.05));
            border-radius: 20px;
            margin: 2rem 0;
        }
        
        .empty-state i.main-icon {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
            filter: drop-shadow(0 2px 8px rgba(255, 107, 107, 0.2));
        }
        
        .empty-state h4 {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            color: #858796;
        }
        
        .empty-state .btn-start-shopping {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.2);
        }
        
        .empty-state .btn-start-shopping:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }
        
        .empty-state .btn-start-shopping i {
            font-size: 1.2rem;
            margin-right: 10px;
            vertical-align: middle;
        }
        
        .empty-state .decoration {
            position: relative;
            margin: 2rem 0;
        }
        
        .empty-state .decoration::before,
        .empty-state .decoration::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 100px;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--primary-color), transparent);
        }
        
        .empty-state .decoration::before {
            left: 20%;
        }
        
        .empty-state .decoration::after {
            right: 20%;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/order/history">
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
            <i class="fas fa-history me-2"></i>Order History
        </h2>
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="card animate__animated animate__fadeInUp">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-hashtag me-2"></i>Order ID</th>
                                        <th><i class="fas fa-calendar me-2"></i>Date</th>
                                        <th><i class="fas fa-box me-2"></i>Items</th>
                                        <th><i class="fas fa-dollar-sign me-2"></i>Total</th>
                                        <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                        <th><i class="fas fa-cogs me-2"></i>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr class="animate__animated animate__fadeIn">
                                            <td>${order.orderId}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" 
                                                              pattern="MMM dd, yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:forEach items="${order.items}" var="item" varStatus="status">
                                                    ${item.toyName} (${item.quantity})
                                                    <c:if test="${!status.last}">, </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>$${order.totalAmount}</td>
                                            <td>
                                                <span class="badge bg-${order.status == 'PENDING' ? 'warning' : 
                                                                     order.status == 'SHIPPED' ? 'info' : 
                                                                     order.status == 'DELIVERED' ? 'success' : 
                                                                     'secondary'}">
                                                    <i class="fas ${order.status == 'PENDING' ? 'fa-clock' : 
                                                                  order.status == 'SHIPPED' ? 'fa-truck' : 
                                                                  order.status == 'DELIVERED' ? 'fa-check-circle' : 
                                                                  'fa-times-circle'} me-1"></i>
                                                    ${order.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="${pageContext.request.contextPath}/order/details?orderId=${order.orderId}" 
                                                       class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-eye me-1"></i>View
                                                    </a>
                                                    <c:if test="${order.status == 'PENDING'}">
                                                        <form action="${pageContext.request.contextPath}/order/cancel" 
                                                              method="post" class="d-inline">
                                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                    onclick="return confirm('Are you sure you want to cancel this order?')">
                                                                <i class="fas fa-times-circle me-1"></i>Cancel
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty orders}">
                            <div class="empty-state animate__animated animate__fadeIn">
                                <i class="fas fa-box-open main-icon"></i>
                                <div class="decoration">
                                    <i class="fas fa-star" style="color: var(--accent-color); margin: 0 10px;"></i>
                                    <i class="fas fa-star" style="color: var(--primary-color); margin: 0 10px;"></i>
                                    <i class="fas fa-star" style="color: var(--secondary-color); margin: 0 10px;"></i>
                                </div>
                                <h4>No Orders Yet!</h4>
                                <p>Looks like you haven't started your shopping adventure.<br>Let's find something special for you!</p>
                                <a href="${pageContext.request.contextPath}/#" class="btn btn-start-shopping animate__animated animate__pulse animate__infinite">
                                    <i class="fas fa-shopping-cart"></i>
                                    Start Shopping Now
                                </a>
                                <div class="mt-4">
                                    <small class="text-muted">
                                        <i class="fas fa-gift me-1"></i>
                                        Discover amazing toys and create wonderful memories
                                    </small>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Add animation to table rows on hover
        document.querySelectorAll('.table tbody tr').forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.classList.add('animate__animated', 'animate__pulse');
            });
            
            row.addEventListener('mouseleave', function() {
                this.classList.remove('animate__animated', 'animate__pulse');
            });
        });
    </script>
</body>
</html> 