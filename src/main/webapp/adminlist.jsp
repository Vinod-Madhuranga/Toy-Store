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

    <title>Toy Store - Admin List</title>
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

        .admin-list-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }

        .card {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            padding: 15px;
        }

        .btn-action {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            border: none;
            border-radius: 15px;
            padding: 8px 15px;
            color: white;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            border-top: none;
            background-color: rgba(78, 205, 196, 0.1);
        }

        .status-active {
            color: var(--secondary-color);
            font-weight: bold;
        }

        .status-inactive {
            color: var(--primary-color);
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="admin-list-container">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3 class="mb-0">Admin List</h3>
                <a href="dashboard" class="btn btn-action" style="background: linear-gradient(135deg, var(--secondary-color) 0%, #6EE7DE 100%);">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${admins}" var="admin">
                                <tr>
                                    <td>${admin.username}</td>
                                    <td>${admin.fullName}</td>
                                    <td>${admin.email}</td>
                                    <td>${admin.role}</td>
                                    <td>
                                        <span class="status-${admin.active ? 'active' : 'inactive'}">
                                            ${admin.active ? 'Active' : 'Inactive'}
                                        </span>
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
        function confirmDelete(adminId) {
            if (confirm('Are you sure you want to delete this admin?')) {
                window.location.href = `admin/delete?id=${adminId}`;
            }
        }
    </script>
</body>
</html> 