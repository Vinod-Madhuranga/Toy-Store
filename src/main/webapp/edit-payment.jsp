<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Edit Payment - Toy Store</title>
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
            max-width: 600px;
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

        .form-control {
            border-radius: 15px;
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid #eee;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
        }

        .btn-payment {
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

        .btn-payment:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
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
    <div class="floating-toys">
        <i class="fas fa-credit-card toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
        <i class="fas fa-money-bill-wave toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
        <i class="fas fa-wallet toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
        <i class="fas fa-piggy-bank toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    </div>

    <div class="container">
        <div class="payment-container">
            <div class="text-center">
                <i class="fas fa-edit payment-icon"></i>
                <h1 class="store-title">Edit Payment Method</h1>
                <p class="text-muted">Update your payment details!</p>
            </div>

            <form action="edit-payment" method="post">
                <input type="hidden" name="id" value="${payment.id}">
                
                <div class="mb-3">
                    <label for="type" class="form-label">Payment Type *</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-credit-card"></i></span>
                        <select class="form-control" id="type" name="type" required>
                            <option value="CREDIT_CARD" ${payment.type == 'CREDIT_CARD' ? 'selected' : ''}>Credit Card</option>
                            <option value="DEBIT_CARD" ${payment.type == 'DEBIT_CARD' ? 'selected' : ''}>Debit Card</option>
                            <option value="PAYPAL" ${payment.type == 'PAYPAL' ? 'selected' : ''}>PayPal</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="cardNumber" class="form-label">Card Number *</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="${payment.cardNumber}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="cardHolderName" class="form-label">Card Holder Name *</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" value="${payment.cardHolderName}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="expiryDate" class="form-label">Expiry Date *</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                        <input type="text" class="form-control" id="expiryDate" name="expiryDate" value="${payment.expiryDate}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="cvv" class="form-label">CVV *</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="text" class="form-control" id="cvv" name="cvv" value="${payment.cvv}" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-payment">
                    <i class="fas fa-save"></i> Update Payment Method
                </button>
            </form>

            <div class="back-link">
                <p>Back to <a href="payment-history">Payment History</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 