<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Toy Store</title>
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

        .btn-register {
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
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }
        .toy-card {
            border-radius: 20px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .toy-card:hover {
            transform: translateY(-5px) scale(1.01);
            box-shadow: 0 8px 32px rgba(255, 107, 107, 0.15);
        }
        .toy-img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-bottom: 4px solid var(--accent-color);
        }
        .toy-title {
            color: var(--primary-color);
            font-size: 1.5em;
            font-weight: bold;
        }
        .toy-desc {
            color: #555;
        }
        .toy-price {
            color: var(--secondary-color);
            font-size: 1.2em;
            font-weight: bold;
        }
        .btn-edit, .btn-delete {
            border-radius: 12px;
            font-weight: bold;
        }
        .btn-edit {
            background: var(--secondary-color);
            color: white;
        }
        .btn-edit:hover {
            background: #3bb6a4;
        }
        .btn-delete {
            background: var(--primary-color);
            color: white;
        }
        .btn-delete:hover {
            background: #e55a5a;
        }
    </style>
</head> 