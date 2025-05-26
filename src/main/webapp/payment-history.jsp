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

    <title>Payment History - Toy Store</title>
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

        .payment-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .payment-container::before {
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

        .payment-container::after {
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

        .payment-icon {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
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

        .add-payment-btn {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            border-radius: 15px;
            padding: 12px 25px;
            color: white;
            font-weight: bold;
            transition: all 0.3s ease;
            margin-bottom: 20px;
            text-decoration: none;
            display: inline-block;
        }

        .add-payment-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .payment-table {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: 20px;
        }

        .payment-table th {
            background: var(--primary-color);
            color: white;
            font-weight: bold;
            padding: 15px;
            text-align: center;
        }

        .payment-table td {
            padding: 15px;
            vertical-align: middle;
            text-align: center;
        }

        .payment-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .payment-table tr:hover {
            background-color: #f0f0f0;
        }

        .btn-action {
            border-radius: 10px;
            padding: 8px 15px;
            margin: 0 5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-edit {
            background: var(--secondary-color);
            color: white;
        }

        .btn-delete {
            background: var(--primary-color);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
        }

        .payment-type-icon {
            font-size: 1.2em;
            margin-right: 5px;
        }

        .card-number {
            font-family: monospace;
            letter-spacing: 1px;
        }

        .empty-message {
            text-align: center;
            padding: 30px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="floating-toys">
        <i class="fas fa-credit-card toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
        <i class="fas fa-money-bill-wave toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
        <i class="fas fa-wallet toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
        <i class="fas fa-piggy-bank toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    </div>

    <div class="container">
        <div class="payment-container">
            <div class="text-center">
                <i class="fas fa-history payment-icon"></i>
                <h1 class="store-title">Payment History</h1>
                <p class="text-muted">Manage your payment methods!</p>
            </div>

            <div class="text-center">
                <a href="add-payment.jsp" class="add-payment-btn">
                    <i class="fas fa-plus-circle"></i> Add New Payment Method
                </a>
            </div>

            <div class="table-responsive payment-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Card Number</th>
                            <th>Card Holder</th>
                            <th>Expiry Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${payments}" var="payment">
                            <tr>
                                <td>
                                    <i class="fas ${payment.type == 'CREDIT_CARD' ? 'fa-credit-card' : 
                                                   payment.type == 'DEBIT_CARD' ? 'fa-credit-card' : 
                                                   'fa-paypal'} payment-type-icon"></i>
                                    ${payment.type}
                                </td>
                                <td class="card-number">
                                    <c:choose>
                                        <c:when test="${payment.type == 'PAYPAL'}">
                                            ${payment.cardNumber}
                                        </c:when>
                                        <c:when test="${not empty payment.cardNumber and payment.cardNumber.length() >= 4}">
                                            **** **** **** ${payment.cardNumber.substring(payment.cardNumber.length()-4)}
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${payment.cardHolderName}</td>
                                <td>${payment.expiryDate}</td>
                                <td>
                                    <a href="edit-payment?id=${payment.id}" class="btn-action btn-edit">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="delete-payment?id=${payment.id}" class="btn-action btn-delete"
                                       onclick="return confirm('Are you sure you want to delete this payment method?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty payments}">
                            <tr>
                                <td colspan="5" class="empty-message">
                                    <i class="fas fa-info-circle"></i> No payment methods found. Add your first payment method!
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 