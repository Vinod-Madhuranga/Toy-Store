<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Toy Store - Products</title>
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

        /* Floating toys background */
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

        /* Main content */
        #main-content-container {
            position: relative;
            z-index: 1;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .store-title {
            color: #333;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
        }

        .store-title:after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        /* Toy card styling */
        .toy-card {
            border: none;
            border-radius: 20px !important;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            background: white;
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .toy-card::before {
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

        .toy-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .toy-img-container {
            height: 220px;
            overflow: hidden;
            position: relative;
        }

        .toy-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .toy-card:hover .toy-img {
            transform: scale(1.1);
        }

        .toy-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background-color: var(--primary-color);
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            z-index: 1;
        }

        .toy-card-body {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .toy-title {
            color: #333;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }

        .toy-desc {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            flex-grow: 1;
        }

        .toy-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .toy-price {
            color: var(--primary-color);
            font-size: 1.25rem;
            font-weight: 700;
        }

        .toy-age {
            background-color: var(--accent-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .toy-card-footer {
            padding: 0 1.5rem 1.5rem;
            background: transparent;
            border: none;
        }

        /* Button styling */
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

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 15px;
            padding: 0.5rem 1.25rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.2);
        }

        .btn-cart {
            background-color: white;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
            border-radius: 15px;
            padding: 0.5rem 1.25rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-cart:hover {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.2);
        }

        /* Form styling */
        .form-control {
            border-radius: 15px;
            padding: 12px;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
        }

        .search-input {
            border-radius: 15px 0 0 15px !important;
            border-right: none;
        }

        .search-btn {
            border-radius: 0 15px 15px 0 !important;
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            border-left: none;
        }

        .search-btn:hover {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #7FE5E0 100%);
        }

        /* Age group filter */
        .age-filter {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .age-filter .btn {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .age-filter .btn.active {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.2);
        }

        /* Quantity input */
        .quantity-input {
            width: 70px;
            text-align: center;
            border-radius: 15px 0 0 15px !important;
            border-right: none;
        }

        .add-to-cart-btn {
            border-radius: 0 15px 15px 0 !important;
            white-space: nowrap;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .empty-state-icon {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1.5rem;
        }

        .empty-state-title {
            font-size: 1.5rem;
            color: #666;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .empty-state-text {
            color: #999;
            margin-bottom: 1.5rem;
        }

        /* Loading spinner */
        .loading-spinner {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .spinner-border {
            width: 3rem;
            height: 3rem;
            color: var(--primary-color);
        }

        .loading-text {
            margin-top: 16px;
            color: #333;
            font-weight: 500;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .store-title {
                font-size: 2rem;
            }

            .toy-img-container {
                height: 180px;
            }
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
    <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
    <div class="loading-text">Loading Awesome Toys...</div>
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

<!-- Main Content -->
<div class="container" id="main-content-container">
    <div class="row mb-4 fade-in">
        <div class="col-12">
            <h1 class="store-title">Discover Amazing Toys</h1>
            <p class="text-muted">Find the perfect toy for every age and interest</p>
        </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="row mb-4 fade-in">
        <div class="col-md-8 mb-3 mb-md-0">
            <form action="${pageContext.request.contextPath}/products" method="get" class="d-flex">
                <input type="text" name="search" class="form-control search-input"
                       placeholder="Search toys..." value="${param.search}">
                <button type="submit" class="btn search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        <div class="col-md-4">
            <div class="age-filter">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-sm ${empty param.ageGroup ? 'btn-primary' : 'btn-outline-primary'}">
                    All Ages
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=0-2" class="btn btn-sm ${param.ageGroup == '0-2' ? 'btn-primary' : 'btn-outline-primary'}">
                    0-2
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=3-5" class="btn btn-sm ${param.ageGroup == '3-5' ? 'btn-primary' : 'btn-outline-primary'}">
                    3-5
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=6-8" class="btn btn-sm ${param.ageGroup == '6-8' ? 'btn-primary' : 'btn-outline-primary'}">
                    6-8
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=9" class="btn btn-sm ${param.ageGroup == '9+' ? 'btn-primary' : 'btn-outline-primary'}">
                    9+
                </a>
            </div>
        </div>
    </div>

    <!-- Toys Grid -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4" id="toysGrid">
        <c:forEach items="${toys}" var="toy" varStatus="loop">
            <div class="col fade-in" style="animation-delay: ${loop.index * 0.1}s;">
                <div class="card toy-card">
                    <div class="toy-img-container">
                        <c:set var="imageUrl" value="${pageContext.request.contextPath}/images/${toy.imageName}"/>
                        <c:choose>
                            <c:when test="${not empty toy.imageName}">
                                <img src="${imageUrl}"
                                     alt="${toy.name}"
                                     class="toy-img"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-toy.jpg';">
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex align-items-center justify-content-center h-100 bg-light">
                                    <i class="fas fa-image fa-3x text-muted"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <span class="toy-badge">${toy.ageGroup}+ Years</span>
                    </div>

                    <div class="toy-card-body">
                        <h5 class="toy-title">${toy.name}</h5>
                        <p class="toy-desc">${toy.description}</p>
                        <div class="toy-meta">
                            <span class="toy-price">$${toy.price}</span>
                            <span class="toy-age">
                                <i class="fas fa-child me-1"></i>${toy.ageGroup}+
                            </span>
                        </div>
                    </div>

                    <div class="toy-card-footer">
                        <form action="${pageContext.request.contextPath}/order/placement" method="post" class="add-to-cart-form">
                            <input type="hidden" name="toyId" value="${toy.toyId}">
                            <input type="hidden" name="toyName" value="${toy.name}">
                            <input type="hidden" name="price" value="${toy.price}">
                            <div class="input-group">
                                <input type="number" name="quantity" class="form-control quantity-input"
                                       value="1" min="1" max="10" required>
                                <button type="submit" class="btn btn-primary add-to-cart-btn">
                                    <i class="fas fa-cart-plus me-2"></i>Add
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty toys}">
        <div class="empty-state fade-in">
            <div class="empty-state-icon">
                <i class="fas fa-search"></i>
            </div>
            <h3 class="empty-state-title">No toys found</h3>
            <p class="empty-state-text">We couldn't find any toys matching your criteria. Try adjusting your search or filters.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                <i class="fas fa-undo me-2"></i>Reset Filters
            </a>
        </div>
    </c:if>
</div>

<!-- Bootstrap JS and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Hide loading overlay when page is loaded
        setTimeout(function() {
            $('.loading-spinner').fadeOut('slow');
        }, 1000);

        // Form validation for quantity
        $('.add-to-cart-form').on('submit', function(e) {
            const quantity = $(this).find('input[name="quantity"]').val();
            if (quantity < 1 || quantity > 10) {
                e.preventDefault();
                alert('Please enter a valid quantity between 1 and 10');
            } else {
                // Add pulse animation to cart button
                $('#cartButton').addClass('animate__animated animate__pulse');
                setTimeout(function() {
                    $('#cartButton').removeClass('animate__animated animate__pulse');
                }, 500);
            }
        });

        // Add hover effect to cards
        $('.toy-card').hover(
            function() {
                $(this).find('.toy-img').css('transform', 'scale(1.1)');
            },
            function() {
                $(this).find('.toy-img').css('transform', 'scale(1)');
            }
        );

        // Smooth scroll to top when clicking on navbar brand
        $('.navbar-brand').on('click', function(e) {
            if (this.hash !== "") {
                e.preventDefault();
                $('html, body').animate({
                    scrollTop: 0
                }, 800);
            }
        });

        // Add animation to elements when they come into view
        const animateOnScroll = function() {
            const elements = $('.fade-in, .slide-in');
            const windowHeight = $(window).height();
            const windowTop = $(window).scrollTop();
            const windowBottom = windowTop + windowHeight;

            $.each(elements, function() {
                const element = $(this);
                const elementTop = element.offset().top;
                const elementBottom = elementTop + element.height();

                // Check if element is in viewport
                if (elementBottom >= windowTop && elementTop <= windowBottom) {
                    element.addClass('animate__animated animate__fadeIn');
                }
            });
        };

        $(window).on('scroll', animateOnScroll);
        animateOnScroll();
    });
</script>
</body>
</html>