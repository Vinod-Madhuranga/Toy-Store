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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Comic+Neue:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6B6B;
            --secondary-color: #4ECDC4;
            --accent-color: #FFE66D;
            --dark-color: #2E4053;
            --light-color: #F5F7FA;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Comic Neue', 'Comic Sans MS', cursive, sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        /* Floating toys animation */
        .floating-toys {
            position: fixed;
            width: 100vw;
            height: 100vh;
            pointer-events: none;
            z-index: 0;
            top: 0;
            left: 0;
        }
        .toy {
            position: absolute;
            font-size: 32px;
            opacity: 0.7;
            animation: float 6s infinite ease-in-out;
            color: var(--primary-color);
            z-index: -1;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        /* Navbar styling */
        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
            box-shadow: var(--shadow);
            position: relative;
            z-index: 100;
            padding: 0.8rem 0;
        }
        .navbar-brand {
            font-family: 'Fredoka One', cursive;
            font-size: 1.8rem;
            color: white !important;
        }
        .nav-link {
            font-weight: 600;
            padding: 0.5rem 1rem !important;
            border-radius: 20px;
            margin: 0 0.2rem;
            transition: all 0.3s ease;
        }
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.2);
            transform: translateY(-2px);
        }

        /* Main content container */
        .main-container {
            position: relative;
            z-index: 1;
            background-color: rgba(255,255,255,0.95);
            border-radius: 25px;
            padding: 2rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .main-container:hover {
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        /* Store title */
        .store-title {
            color: var(--primary-color);
            font-family: 'Fredoka One', cursive;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            position: relative;
            display: inline-block;
            margin-bottom: 1.5rem;
        }
        .store-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 70px;
            height: 4px;
            background: var(--secondary-color);
            border-radius: 2px;
        }

        /* Toy card styling */
        .toy-card {
            border-radius: 25px !important;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            overflow: hidden;
            transition: all 0.3s ease;
            border: none;
            background-color: white;
            position: relative;
        }
        .toy-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 30px rgba(255, 107, 107, 0.2);
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
            opacity: 0.2;
            z-index: 0;
        }
        .toy-title {
            color: var(--primary-color);
            font-family: 'Fredoka One', cursive;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            position: relative;
        }
        .toy-desc {
            color: #555;
            margin-bottom: 1rem;
            font-size: 0.95rem;
            line-height: 1.5;
        }
        .toy-price {
            color: var(--secondary-color);
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .toy-age {
            display: inline-block;
            background-color: var(--accent-color);
            color: var(--dark-color);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 0.8rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .toy-stock {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
        }
        .in-stock {
            color: #28a745;
        }
        .low-stock {
            color: #ffc107;
        }
        .out-of-stock {
            color: #dc3545;
        }

        /* Button styling */
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), #FF8E8E);
            border: none;
            border-radius: 20px;
            padding: 0.6rem 1.5rem;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(255, 107, 107, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(255, 107, 107, 0.4);
            background: linear-gradient(135deg, #FF8E8E, var(--primary-color));
        }
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 20px;
            padding: 0.5rem 1.2rem;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 107, 107, 0.2);
        }
        .btn-filter {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            margin: 0.2rem;
        }
        .btn-filter.active {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 107, 107, 0.2);
        }

        /* Form styling */
        .form-control {
            border-radius: 20px;
            font-family: 'Comic Neue', 'Comic Sans MS', cursive, sans-serif;
            padding: 0.6rem 1rem;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 205, 196, 0.25);
        }

        /* Card image styling */
        .toy-img-container {
            height: 220px;
            overflow: hidden;
            position: relative;
            border-radius: 20px 20px 0 0 !important;
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
        .img-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 3rem;
        }

        /* Search bar */
        .search-container {
            position: relative;
            margin-bottom: 1.5rem;
        }
        .search-input {
            padding-left: 3rem;
            border-radius: 20px !important;
            height: 50px;
            font-size: 1.1rem;
        }
        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 1.2rem;
            z-index: 10;
        }

        /* Age group filter */
        .age-filter {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        /* Cart badge */
        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            font-size: 0.7rem;
            background-color: var(--accent-color);
            color: var(--dark-color);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Loading spinner */
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
            width: 3rem;
            height: 3rem;
            color: var(--primary-color);
        }

        /* Quick view modal */
        .quick-view-modal .modal-content {
            border-radius: 25px;
            overflow: hidden;
            border: none;
        }
        .quick-view-modal .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-bottom: none;
        }
        .quick-view-modal .modal-body {
            padding: 2rem;
        }
        .quick-view-img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 20px;
            margin-bottom: 1rem;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .store-title {
                font-size: 2rem;
            }
            .toy-card {
                margin-bottom: 20px;
            }
            .age-filter {
                justify-content: flex-start;
            }
        }

        /* Animation classes */
        .animate-fade-in {
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Rating stars */
        .rating {
            color: #FFD700;
            margin-bottom: 0.5rem;
        }
        .rating .far {
            color: #ddd;
        }

        /* Special badge */
        .special-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: var(--accent-color);
            color: var(--dark-color);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.8rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 1;
        }

        /* Wishlist button */
        .wishlist-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(255,255,255,0.8);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.2rem;
            transition: all 0.3s ease;
            z-index: 1;
        }
        .wishlist-btn:hover {
            background: var(--primary-color);
            color: white;
            transform: scale(1.1);
        }
    </style>
</head>
<body>
<!-- Floating Toys Animation Background -->
<div class="floating-toys">
    <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
    <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
    <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
    <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    <i class="fas fa-car toy" style="top: 30%; left: 30%; animation-delay: 0.5s;"></i>
    <i class="fas fa-dice toy" style="top: 60%; right: 30%; animation-delay: 1.5s;"></i>
</div>

<!-- Loading Spinner -->
<div class="loading-spinner">
    <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-store me-2"></i>Toy Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/order/history">
                        <i class="fas fa-history me-1"></i> Order History
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/wishlist">
                        <i class="fas fa-heart me-1"></i> Wishlist
                    </a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative">
                    <i class="fas fa-shopping-cart me-1"></i> Cart
                    <c:if test="${cartCount > 0}">
                        <span class="cart-badge">${cartCount}</span>
                    </c:if>
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container main-container animate-fade-in">
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="store-title"><i class="fas fa-cubes me-2"></i>Our Amazing Toys</h2>
        </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="${pageContext.request.contextPath}/products" method="get" class="search-container">
                <i class="fas fa-search search-icon"></i>
                <input type="text" name="search" class="form-control search-input"
                       placeholder="Search for toys..." value="${param.search}">
            </form>
        </div>
        <div class="col-md-4">
            <div class="age-filter">
                <a href="${pageContext.request.contextPath}/products"
                   class="btn btn-filter btn-outline-primary ${empty param.ageGroup ? 'active' : ''}">
                    All Ages
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=0-2"
                   class="btn btn-filter btn-outline-primary ${param.ageGroup == '0-2' ? 'active' : ''}">
                    0-2
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=3-5"
                   class="btn btn-filter btn-outline-primary ${param.ageGroup == '3-5' ? 'active' : ''}">
                    3-5
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=6-8"
                   class="btn btn-filter btn-outline-primary ${param.ageGroup == '6-8' ? 'active' : ''}">
                    6-8
                </a>
                <a href="${pageContext.request.contextPath}/products?ageGroup=9+"
                   class="btn btn-filter btn-outline-primary ${param.ageGroup == '9+' ? 'active' : ''}">
                    9+
                </a>
            </div>
        </div>
    </div>

    <!-- Sort and Category Filters -->
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="sortDropdown"
                        data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-sort me-1"></i> Sort By
                </button>
                <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                    <li><a class="dropdown-item" href="?sort=price_asc"><i class="fas fa-sort-amount-up me-2"></i>Price: Low to High</a></li>
                    <li><a class="dropdown-item" href="?sort=price_desc"><i class="fas fa-sort-amount-down me-2"></i>Price: High to Low</a></li>
                    <li><a class="dropdown-item" href="?sort=name_asc"><i class="fas fa-sort-alpha-up me-2"></i>Name: A-Z</a></li>
                    <li><a class="dropdown-item" href="?sort=name_desc"><i class="fas fa-sort-alpha-down me-2"></i>Name: Z-A</a></li>
                    <li><a class="dropdown-item" href="?sort=rating"><i class="fas fa-star me-2"></i>Top Rated</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="categoryDropdown"
                        data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-tags me-1"></i> Categories
                </button>
                <ul class="dropdown-menu" aria-labelledby="categoryDropdown">
                    <li><a class="dropdown-item" href="?category=all"><i class="fas fa-th me-2"></i>All Categories</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="?category=action_figures"><i class="fas fa-robot me-2"></i>Action Figures</a></li>
                    <li><a class="dropdown-item" href="?category=board_games"><i class="fas fa-chess-board me-2"></i>Board Games</a></li>
                    <li><a class="dropdown-item" href="?category=dolls"><i class="fas fa-child me-2"></i>Dolls</a></li>
                    <li><a class="dropdown-item" href="?category=educational"><i class="fas fa-graduation-cap me-2"></i>Educational</a></li>
                    <li><a class="dropdown-item" href="?category=outdoor"><i class="fas fa-biking me-2"></i>Outdoor</a></li>
                    <li><a class="dropdown-item" href="?category=puzzles"><i class="fas fa-puzzle-piece me-2"></i>Puzzles</a></li>
                    <li><a class="dropdown-item" href="?category=vehicles"><i class="fas fa-car me-2"></i>Vehicles</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Toys Grid -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:forEach items="${toys}" var="toy">
            <div class="col">
                <div class="card toy-card h-100">
                    <!-- Special Badge -->
                    <c:if test="${toy.discount > 0}">
                        <span class="special-badge animate__animated animate__pulse animate__infinite">
                            <i class="fas fa-tag me-1"></i> ${toy.discount}% OFF
                        </span>
                    </c:if>

                    <!-- Wishlist Button -->
                    <button class="wishlist-btn" data-toy-id="${toy.toyId}">
                        <i class="far fa-heart"></i>
                    </button>

                    <!-- Toy Image -->
                    <div class="toy-img-container">
                        <c:choose>
                            <c:when test="${not empty toy.imageName}">
                                <img src="${pageContext.request.contextPath}/images/${toy.imageName}"
                                     alt="${toy.name}" class="toy-img"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-toy.jpg';"
                                     data-bs-toggle="modal" data-bs-target="#imageModal"
                                     data-bs-image="${pageContext.request.contextPath}/images/${toy.imageName}"
                                     data-bs-title="${toy.name}">
                            </c:when>
                            <c:otherwise>
                                <div class="img-placeholder">
                                    <i class="fas fa-image"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-body">
                        <!-- Age Group -->
                        <span class="toy-age">
                            <i class="fas fa-child me-1"></i>${toy.ageGroup}+
                        </span>

                        <!-- Toy Title -->
                        <h5 class="toy-title">
                            <i class="fas fa-cube me-2"></i>${toy.name}
                        </h5>

                        <!-- Rating -->
                        <div class="rating">
                            <c:forEach begin="1" end="5" var="star">
                                <c:choose>
                                    <c:when test="${star <= toy.rating}">
                                        <i class="fas fa-star"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="far fa-star"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <small class="text-muted ms-2">(${toy.reviewCount})</small>
                        </div>

                        <!-- Toy Description -->
                        <p class="toy-desc">${toy.description}</p>

                        <!-- Stock Status -->
                        <p class="toy-stock ${toy.stock > 10 ? 'in-stock' : (toy.stock > 0 ? 'low-stock' : 'out-of-stock')}">
                            <c:choose>
                                <c:when test="${toy.stock > 10}">
                                    <i class="fas fa-check-circle me-1"></i> In Stock
                                </c:when>
                                <c:when test="${toy.stock > 0}">
                                    <i class="fas fa-exclamation-circle me-1"></i> Only ${toy.stock} left!
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-times-circle me-1"></i> Out of Stock
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <!-- Price -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <c:choose>
                                    <c:when test="${toy.discount > 0}">
                                        <span class="toy-price text-danger">
                                            $${toy.price * (100 - toy.discount) / 100}
                                        </span>
                                        <small class="text-decoration-line-through text-muted ms-2">
                                            $${toy.price}
                                        </small>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="toy-price">$${toy.price}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button class="btn btn-sm btn-outline-primary quick-view-btn"
                                    data-toy-id="${toy.toyId}">
                                <i class="fas fa-eye me-1"></i> Quick View
                            </button>
                        </div>
                    </div>

                    <div class="card-footer bg-transparent border-top-0">
                        <form action="${pageContext.request.contextPath}/order/placement" method="post" class="add-to-cart-form">
                            <input type="hidden" name="toyId" value="${toy.toyId}">
                            <input type="hidden" name="toyName" value="${toy.name}">
                            <input type="hidden" name="price" value="${toy.discount > 0 ? toy.price * (100 - toy.discount) / 100 : toy.price}">

                            <div class="input-group">
                                <input type="number" name="quantity" class="form-control"
                                       value="1" min="1" max="${toy.stock}" required
                                       style="border-radius: 20px 0 0 20px;">
                                <button type="submit" class="btn btn-primary"
                                        style="border-radius: 0 20px 20px 0;"
                                    ${toy.stock == 0 ? 'disabled' : ''}>
                                    <i class="fas fa-cart-plus me-2"></i> Add to Cart
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- No Results Message -->
    <c:if test="${empty toys}">
        <div class="alert alert-info mt-4 text-center animate__animated animate__fadeIn">
            <i class="fas fa-info-circle me-2"></i> No toys found matching your criteria. Please try different filters.
        </div>
    </c:if>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-5">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&ageGroup=${param.ageGroup}&sort=${param.sort}&category=${param.category}">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>

                <c:forEach begin="1" end="${totalPages}" var="page">
                    <li class="page-item ${page == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${page}&search=${param.search}&ageGroup=${param.ageGroup}&sort=${param.sort}&category=${param.category}">
                                ${page}
                        </a>
                    </li>
                </c:forEach>

                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&ageGroup=${param.ageGroup}&sort=${param.sort}&category=${param.category}">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<!-- Quick View Modal -->
<div class="modal fade quick-view-modal" id="quickViewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="quickViewModalTitle"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <img id="quickViewImage" src="" alt="" class="quick-view-img img-fluid">
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <span class="toy-age" id="quickViewAge"></span>
                            <div class="rating" id="quickViewRating"></div>
                        </div>
                        <h4 id="quickViewName" class="toy-title mb-3"></h4>
                        <p id="quickViewDescription" class="toy-desc mb-4"></p>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <span id="quickViewPrice" class="toy-price"></span>
                                <span id="quickViewOriginalPrice" class="text-decoration-line-through text-muted ms-2"></span>
                            </div>
                            <span id="quickViewStock" class="toy-stock"></span>
                        </div>

                        <form action="${pageContext.request.contextPath}/order/placement" method="post" class="mt-4">
                            <input type="hidden" name="toyId" id="quickViewToyId">
                            <input type="hidden" name="toyName" id="quickViewToyName">
                            <input type="hidden" name="price" id="quickViewToyPrice">

                            <div class="input-group mb-3">
                                <input type="number" name="quantity" class="form-control"
                                       value="1" min="1" max="10" required
                                       style="border-radius: 20px 0 0 20px;">
                                <button type="submit" class="btn btn-primary"
                                        style="border-radius: 0 20px 20px 0;"
                                        id="quickViewAddToCart">
                                    <i class="fas fa-cart-plus me-2"></i> Add to Cart
                                </button>
                            </div>
                        </form>

                        <div class="d-flex justify-content-between mt-4">
                            <button class="btn btn-outline-primary" id="addToWishlistBtn">
                                <i class="far fa-heart me-2"></i> Add to Wishlist
                            </button>
                            <button class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i> Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Image Preview Modal -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="imageModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <img src="" alt="" class="img-fluid" id="modalImage">
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Toastr for notifications -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

<script>
    $(document).ready(function() {
        // Initialize toastr
        toastr.options = {
            "closeButton": true,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "3000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        // Show loading spinner on form submission
        $('.add-to-cart-form').on('submit', function() {
            $('.loading-spinner').show();
        });

        // Image modal
        $('#imageModal').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget);
            var imageSrc = button.data('bs-image');
            var imageTitle = button.data('bs-title');

            $('#modalImage').attr('src', imageSrc);
            $('#imageModalLabel').text(imageTitle);
        });

        // Quick view modal
        $('.quick-view-btn').on('click', function() {
            var toyId = $(this).data('toy-id');
            var toyCard = $(this).closest('.toy-card');

            // Get toy details from the card
            var toyName = toyCard.find('.toy-title').text().trim();
            var toyAge = toyCard.find('.toy-age').text().trim();
            var toyDescription = toyCard.find('.toy-desc').text().trim();
            var toyRating = toyCard.find('.rating').html();
            var toyStock = toyCard.find('.toy-stock').html();
            var toyPrice = toyCard.find('.toy-price').text().trim();
            var toyOriginalPrice = toyCard.find('.text-decoration-line-through').text().trim();
            var toyImage = toyCard.find('.toy-img').attr('src') || '${pageContext.request.contextPath}/images/default-toy.jpg';

            // Populate modal
            $('#quickViewModalTitle').text(toyName);
            $('#quickViewName').text(toyName);
            $('#quickViewAge').text(toyAge);
            $('#quickViewDescription').text(toyDescription);
            $('#quickViewRating').html(toyRating);
            $('#quickViewStock').html(toyStock);
            $('#quickViewImage').attr('src', toyImage);
            $('#quickViewToyId').val(toyId);
            $('#quickViewToyName').val(toyName);

            // Handle pricing (with or without discount)
            if (toyOriginalPrice) {
                $('#quickViewPrice').text(toyPrice).addClass('text-danger');
                $('#quickViewOriginalPrice').text(toyOriginalPrice).show();
                $('#quickViewToyPrice').val(toyPrice.replace('$', ''));
            } else {
                $('#quickViewPrice').text(toyPrice).removeClass('text-danger');
                $('#quickViewOriginalPrice').hide();
                $('#quickViewToyPrice').val(toyPrice.replace('$', ''));
            }

            // Disable add to cart if out of stock
            if (toyStock.includes('Out of Stock')) {
                $('#quickViewAddToCart').prop('disabled', true);
            } else {
                $('#quickViewAddToCart').prop('disabled', false);
            }

            // Show modal
            var quickViewModal = new bootstrap.Modal(document.getElementById('quickViewModal'));
            quickViewModal.show();
        });

        // Wishlist functionality
        $('.wishlist-btn').on('click', function(e) {
            e.preventDefault();
            var button = $(this);
            var toyId = button.data('toy-id');

            // Toggle heart icon
            var icon = button.find('i');
            icon.toggleClass('far fas');

            // Show appropriate toast message
            if (icon.hasClass('fas')) {
                toastr.success('Added to wishlist!', 'Success');
            } else {
                toastr.info('Removed from wishlist', 'Info');
            }

            // AJAX call to update wishlist (would need server-side endpoint)
            /*
            $.post('${pageContext.request.contextPath}/wishlist/toggle', {toyId: toyId})
                .done(function(response) {
                    if (response.success) {
                        if (response.added) {
                            toastr.success('Added to wishlist!', 'Success');
                            icon.removeClass('far').addClass('fas');
                        } else {
                            toastr.info('Removed from wishlist', 'Info');
                            icon.removeClass('fas').addClass('far');
                        }
                    }
                })
                .fail(function() {
                    toastr.error('Failed to update wishlist', 'Error');
                });
            */
        });

        // Add to wishlist from quick view modal
        $('#addToWishlistBtn').on('click', function() {
            var toyId = $('#quickViewToyId').val();
            var button = $('.wishlist-btn[data-toy-id="' + toyId + '"]');
            button.trigger('click');

            // Update icon in quick view
            var icon = button.find('i');
            if (icon.hasClass('fas')) {
                toastr.success('Added to wishlist!', 'Success');
                $(this).html('<i class="fas fa-heart me-2"></i> In Wishlist');
                $(this).removeClass('btn-outline-primary').addClass('btn-outline-danger');
            } else {
                toastr.info('Removed from wishlist', 'Info');
                $(this).html('<i class="far fa-heart me-2"></i> Add to Wishlist');
                $(this).removeClass('btn-outline-danger').addClass('btn-outline-primary');
            }
        });

        // Add smooth scrolling to all links
        $("a").on('click', function(event) {
            if (this.hash !== "") {
                event.preventDefault();
                var hash = this.hash;
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 800, function(){
                    window.location.hash = hash;
                });
            }
        });

        // Add animation to cards when they come into view
        function animateCards() {
            $('.toy-card').each(function() {
                var cardPosition = $(this).offset().top;
                var scrollPosition = $(window).scrollTop() + $(window).height();

                if (cardPosition < scrollPosition) {
                    $(this).addClass('animate__animated animate__fadeInUp');
                }
            });
        }

        // Run animation on load and scroll
        $(window).on('load scroll', animateCards);

        // Initialize tooltips
        $('[data-bs-toggle="tooltip"]').tooltip();

        // Add to cart form submission
        $('.add-to-cart-form').on('submit', function(e) {
            e.preventDefault();
            var form = $(this);

            // Show loading spinner
            $('.loading-spinner').show();

            // AJAX submission (would need server-side endpoint)
            /*
            $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function(response) {
                    $('.loading-spinner').hide();
                    if (response.success) {
                        // Update cart count
                        $('.cart-badge').text(response.cartCount);

                        toastr.success(response.message, 'Success');
                    } else {
                        toastr.error(response.message, 'Error');
                    }
                },
                error: function() {
                    $('.loading-spinner').hide();
                    toastr.error('Failed to add item to cart', 'Error');
                }
            });
            */

            // Simulate success for demo purposes
            setTimeout(function() {
                $('.loading-spinner').hide();
                var currentCount = parseInt($('.cart-badge').text()) || 0;
                $('.cart-badge').text(currentCount + 1).css('opacity', 0)
                    .animate({opacity: 1}, 500);
                toastr.success('Item added to cart!', 'Success');
            }, 1000);
        });

        // Filter buttons active state
        $('.btn-filter').on('click', function() {
            $('.btn-filter').removeClass('active');
            $(this).addClass('active');
        });

        // Search input debounce
        var searchTimeout;
        $('.search-input').on('keyup', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(function() {
                $('.search-container form').submit();
            }, 500);
        });
    });
</script>
</body>
</html>