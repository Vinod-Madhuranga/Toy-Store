<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Toy Store - Reviews</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6B6B;
            --secondary-color: #4ECDC4;
            --accent-color: #FFE66D;
            --bg-gradient: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            --toy-pink: #ffb6b9;
            --toy-blue: #a0e7e5;
            --toy-yellow: #fff5ba;
            --toy-green: #baffc9;
        }
        body {
            background: var(--bg-gradient);
            min-height: 100vh;
            font-family: 'Comic Sans MS', cursive, sans-serif;
            overflow-x: hidden;
        }
        .store-title {
            text-align: center;
            color: var(--primary-color);
            font-size: 2.8em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px #ffe66d99, 0 0 10px #4ecdc4;
            letter-spacing: 2px;
            animation: popIn 1.2s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes popIn {
            0% { transform: scale(0.7); opacity: 0; }
            80% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }
        .admin-badge {
            background: var(--accent-color);
            color: #333;
            padding: 7px 22px;
            border-radius: 30px;
            font-size: 1em;
            margin-bottom: 20px;
            display: inline-block;
            box-shadow: 0 2px 8px #ffe66d55;
            animation: badgeBounce 2s infinite;
        }
        @keyframes badgeBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }
        .floating-toys {
            position: fixed;
            width: 100vw;
            height: 100vh;
            pointer-events: none;
            z-index: -1;
        }
        .toy {
            position: absolute;
            font-size: 32px;
            opacity: 0.7;
            animation: float 6s infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(10deg); }
        }
        .card {
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.10);
            border: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .card:hover {
            box-shadow: 0 16px 40px rgba(255,107,107,0.15);
        }
        .btn-primary, .btn-warning, .btn-danger {
            border-radius: 18px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #ffb6b9 0%, #ff6b6b 100%);
            transform: scale(1.08) rotate(-2deg);
        }
        .btn-warning {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #6fffe9 100%);
            color: #333;
            border: none;
        }
        .btn-warning:hover {
            background: linear-gradient(135deg, #ffe66d 0%, #4ecdc4 100%);
            color: #222;
            transform: scale(1.08) rotate(2deg);
        }
        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b 0%, #ffbaba 100%);
            border: none;
        }
        .btn-danger:hover {
            background: linear-gradient(135deg, #ffbaba 0%, #ff6b6b 100%);
            transform: scale(1.08) rotate(-2deg);
        }
        .table th, .table td {
            vertical-align: middle;
            font-size: 1.08em;
        }
        .star {
            color: #FFD700;
            font-size: 1.3em;
            filter: drop-shadow(0 0 2px #ffe66d);
            transition: color 0.2s;
        }
        .star.text-muted {
            color: #e0e0e0;
        }
        .review-form .form-control, .review-form .form-select {
            border-radius: 15px;
            box-shadow: 0 2px 8px #4ecdc422;
            border: 2px solid #eee;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .review-form .form-control:focus, .review-form .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.18);
        }
        .card-header.bg-primary, .card-header.bg-secondary {
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--secondary-color) 100%) !important;
            color: #fff !important;
            letter-spacing: 1px;
            font-size: 1.2em;
        }
        .card-header.bg-secondary {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--primary-color) 100%) !important;
        }
        .table-responsive {
            animation: fadeInUp 1s;
        }
        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        /* Fun confetti animation */
        .confetti {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            pointer-events: none;
            z-index: 9999;
        }
        .confetti-piece {
            position: absolute;
            width: 12px; height: 12px;
            border-radius: 50%;
            opacity: 0.7;
            animation: confetti-fall 3s linear infinite;
        }
        @keyframes confetti-fall {
            0% { transform: translateY(-20px) scale(1); }
            100% { transform: translateY(100vh) scale(0.7); }
        }
    </style>
</head>
<body>
    <div class="confetti"></div>
    <div class="floating-toys">
        <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s; color: var(--toy-pink);"></i>
        <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s; color: var(--toy-blue);"></i>
        <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s; color: var(--toy-yellow);"></i>
        <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s; color: var(--toy-green);"></i>
    </div>
    <div class="container py-5">
        <div class="text-center mb-4">
            <h1 class="store-title">Toy Store</h1>
            <span class="admin-badge">
                <i class="fas fa-star"></i> Product Reviews
            </span>
        </div>
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <i class="fas fa-plus"></i> Add New Review
            </div>
            <div class="card-body">
                <form action="review" method="post" class="row g-3 review-form align-items-end">
                    <div class="col-md-3">
                        <label class="form-label">Product ID</label>
                        <input type="text" class="form-control" name="productId" placeholder="Product ID" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">User ID</label>
                        <input type="text" class="form-control" name="userId" placeholder="User ID" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Rating</label>
                        <select class="form-select" name="rating" required>
                            <option value="">Rating</option>
                            <option value="1">1 Star</option>
                            <option value="2">2 Stars</option>
                            <option value="3">3 Stars</option>
                            <option value="4">4 Stars</option>
                            <option value="5">5 Stars</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Comment</label>
                        <input type="text" class="form-control" name="comment" placeholder="Comment" required>
                    </div>
                    <div class="col-md-1 d-grid">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i></button>
                    </div>
                </form>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg-secondary text-white">
                <i class="fas fa-list"></i> Recent Reviews
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Product ID</th>
                                <th>User ID</th>
                                <th>Rating</th>
                                <th>Comment</th>
                                <th>Created At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%-- Loop through your reviews here --%>
                        <c:forEach items="${reviews}" var="review">
                            <tr>
                                <td>${review.id}</td>
                                <td>${review.productId}</td>
                                <td>${review.userId}</td>
                                <td>
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star star ${i <= review.rating ? '' : 'text-muted'}"></i>
                                    </c:forEach>
                                </td>
                                <td>${review.comment}</td>
                                <td><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/review/edit/${review.id}" class="btn btn-sm btn-warning me-2"><i class="fas fa-edit"></i> Edit</a>
                                    <form action="${pageContext.request.contextPath}/review/${review.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this review?');">
                                        <input type="hidden" name="_method" value="DELETE"/>
                                        <button type="submit" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i> Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Confetti animation
    function randomColor() {
        const colors = ['#FF6B6B', '#4ECDC4', '#FFE66D', '#ffb6b9', '#a0e7e5', '#fff5ba', '#baffc9'];
        return colors[Math.floor(Math.random() * colors.length)];
    }
    function createConfettiPiece() {
        const confetti = document.createElement('div');
        confetti.className = 'confetti-piece';
        confetti.style.left = Math.random() * 100 + 'vw';
        confetti.style.background = randomColor();
        confetti.style.animationDelay = (Math.random() * 3) + 's';
        document.querySelector('.confetti').appendChild(confetti);
    }
    for (let i = 0; i < 30; i++) createConfettiPiece();
    </script>
</body>
</html> 