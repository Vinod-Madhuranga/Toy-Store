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

    <title>Edit Review - Toy Store</title>
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
        .edit-container {
            max-width: 520px;
            margin: 60px auto 0 auto;
            padding: 35px 30px 30px 30px;
            background: #fff;
            border-radius: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.10);
            position: relative;
            z-index: 1;
            animation: fadeInUp 1s;
        }
        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(40px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .edit-container::before {
            content: '';
            position: absolute;
            top: -50px; right: -50px;
            width: 110px; height: 110px;
            background: var(--accent-color);
            border-radius: 50%;
            z-index: 0;
            opacity: 0.5;
        }
        .edit-container::after {
            content: '';
            position: absolute;
            bottom: -30px; left: -30px;
            width: 80px; height: 80px;
            background: var(--secondary-color);
            border-radius: 50%;
            z-index: 0;
            opacity: 0.4;
        }
        .store-title {
            text-align: center;
            color: var(--primary-color);
            font-size: 2.2em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 8px #ffe66d99, 0 0 10px #4ecdc4;
            letter-spacing: 2px;
            animation: popIn 1.2s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes popIn {
            0% { transform: scale(0.7); opacity: 0; }
            80% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }
        .edit-badge {
            background: var(--accent-color);
            color: #333;
            padding: 6px 18px;
            border-radius: 22px;
            font-size: 1em;
            margin-bottom: 18px;
            display: inline-block;
            box-shadow: 0 2px 8px #ffe66d55;
            animation: badgeBounce 2s infinite;
        }
        @keyframes badgeBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }
        .form-label {
            color: var(--primary-color);
            font-weight: bold;
        }
        .form-control, .form-select {
            border-radius: 15px;
            box-shadow: 0 2px 8px #4ecdc422;
            border: 2px solid #eee;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.18);
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            border-radius: 18px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #ffb6b9 0%, #ff6b6b 100%);
            transform: scale(1.08) rotate(-2deg);
        }
        .btn-secondary {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #6fffe9 100%);
            color: #333;
            border: none;
            border-radius: 18px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #ffe66d 0%, #4ecdc4 100%);
            color: #222;
            transform: scale(1.08) rotate(2deg);
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
    <div class="edit-container">
        <div class="text-center mb-3">
            <h1 class="store-title">Toy Store</h1>
            <span class="edit-badge">
                <i class="fas fa-edit"></i> Edit Review
            </span>
        </div>
        <form action="${pageContext.request.contextPath}/review/update" method="post" class="row g-3">
            <input type="hidden" name="id" value="${review.id}"/>
            <div class="col-12">
                <label class="form-label">Product ID</label>
                <input type="text" class="form-control" name="productId" value="${review.productId}" readonly>
            </div>
            <div class="col-12">
                <label class="form-label">User ID</label>
                <input type="text" class="form-control" name="userId" value="${review.userId}" readonly>
            </div>
            <div class="col-12">
                <label class="form-label">Rating</label>
                <select class="form-select" name="rating" required>
                    <option value="">Rating</option>
                    <option value="1" ${review.rating == 1 ? 'selected' : ''}>1 Star</option>
                    <option value="2" ${review.rating == 2 ? 'selected' : ''}>2 Stars</option>
                    <option value="3" ${review.rating == 3 ? 'selected' : ''}>3 Stars</option>
                    <option value="4" ${review.rating == 4 ? 'selected' : ''}>4 Stars</option>
                    <option value="5" ${review.rating == 5 ? 'selected' : ''}>5 Stars</option>
                </select>
            </div>
            <div class="col-12">
                <label class="form-label">Comment</label>
                <input type="text" class="form-control" name="comment" value="${review.comment}" required>
            </div>
            <div class="col-12 d-flex justify-content-between mt-3">
                <button type="submit" class="btn btn-primary px-4"><i class="fas fa-save"></i> Save</button>
                <a href="${pageContext.request.contextPath}/review" class="btn btn-secondary px-4"><i class="fas fa-arrow-left"></i> Cancel</a>
            </div>
        </form>
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
    for (let i = 0; i < 20; i++) createConfettiPiece();
    </script>
</body>
</html>