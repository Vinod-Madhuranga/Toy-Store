<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toystore.admin.model.Admin" %>
<%@ page import="com.toystore.admin.service.AdminService" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    
    AdminService adminService = new AdminService();
    List<Admin> allAdmins = adminService.getAllAdmins();
    
    // Calculate statistics
    int totalAdmins = allAdmins.size();
    int superAdmins = (int) allAdmins.stream().filter(a -> "SUPER_ADMIN".equals(a.getRole())).count();
    int activeAdmins = (int) allAdmins.stream().filter(Admin::isActive).count();
    
    // Get recent activities (last 5 admins)
    List<Admin> recentAdmins = allAdmins.stream()
        .limit(5)
        .toList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Toy Store">
    <meta name="author" content="Vinod Madhuranga">

    <title>Toy Store Admin Dashboard</title>
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
        .dashboard-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            position: relative;
            overflow: hidden;
        }
        .dashboard-container::before {
            content: '';
            position: absolute;
            top: -60px;
            right: -60px;
            width: 120px;
            height: 120px;
            background: var(--accent-color);
            border-radius: 50%;
            z-index: 0;
        }
        .dashboard-container::after {
            content: '';
            position: absolute;
            bottom: -40px;
            left: -40px;
            width: 90px;
            height: 90px;
            background: var(--secondary-color);
            border-radius: 50%;
            z-index: 0;
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .dashboard-title {
            color: var(--primary-color);
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.08);
        }
        .profile-dropdown {
            position: relative;
            display: inline-block;
        }
        .profile-btn {
            background: none;
            border: none;
            outline: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1em;
            color: var(--primary-color);
            font-weight: bold;
        }
        .profile-btn .fa-user-circle {
            font-size: 2.2em;
        }
        .profile-menu {
            display: none;
            position: absolute;
            right: 0;
            top: 110%;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            min-width: 160px;
            z-index: 10;
        }
        .profile-menu a {
            display: block;
            padding: 12px 18px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.2s;
        }
        .profile-menu a:last-child {
            border-bottom: none;
        }
        .profile-menu a:hover {
            background: var(--secondary-color);
            color: #fff;
        }
        .profile-dropdown.open .profile-menu {
            display: block;
        }
        .stat-section {
            margin-top: 10px;
            margin-bottom: 35px;
        }
        .stat-card {
            border-radius: 20px;
            box-shadow: 0 4px 16px rgba(78,205,196,0.08);
            padding: 25px 20px;
            background: linear-gradient(135deg, #fff 60%, #f5f7fa 100%);
            text-align: center;
            margin-bottom: 25px;
        }
        .stat-icon {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .stat-title {
            font-size: 1.1em;
            color: #888;
        }
        .stat-value {
            font-size: 2em;
            font-weight: bold;
            color: var(--primary-color);
        }
        .quick-links {
            margin-top: 30px;
            text-align: center;
        }
        .quick-link-btn {
            margin: 0 10px;
            border-radius: 15px;
            padding: 12px 28px;
            font-size: 1.1em;
            font-weight: bold;
            background: linear-gradient(135deg, var(--secondary-color) 0%, #6EE7DE 100%);
            color: white;
            border: none;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .quick-link-btn:hover {
            background: linear-gradient(135deg, var(--primary-color) 0%, #FF8E8E 100%);
            color: white;
            transform: translateY(-2px) scale(1.04);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.15);
        }
        .recent-activity {
            margin-top: 40px;
        }
        .recent-activity h3 {
            color: var(--secondary-color);
            font-size: 1.3em;
            margin-bottom: 18px;
        }
        .activity-list {
            list-style: none;
            padding: 0;
        }
        .activity-list li {
            background: #f8f9fa;
            border-radius: 12px;
            margin-bottom: 10px;
            padding: 12px 18px;
            font-size: 1em;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .activity-list .fa {
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div class="dashboard-title">
                <i class="fas fa-teddy-bear"></i> Admin Dashboard
            </div>
            <div class="profile-dropdown" id="profileDropdown">
                <button class="profile-btn" id="profileBtn">
                    <i class="fas fa-user-circle"></i>
                    <span><%= admin.getFullName() %></span>
                    <i class="fas fa-caret-down"></i>
                </button>
                <div class="profile-menu" id="profileMenu">
                    <a href="profile"><i class="fas fa-user"></i> My Profile</a>
                    <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
        <div class="stat-section row text-center">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-title">Total Admins</div>
                    <div class="stat-value"><%= totalAdmins %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-user-shield"></i></div>
                    <div class="stat-title">Super Admins</div>
                    <div class="stat-value"><%= superAdmins %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-user-check"></i></div>
                    <div class="stat-title">Active Admins</div>
                    <div class="stat-value"><%= activeAdmins %></div>
                </div>
            </div>
        </div>
        <div class="quick-links">
            <a href="list" class="quick-link-btn"><i class="fas fa-list"></i> Admin List</a>
            <a href="logout" class="quick-link-btn" style="background:linear-gradient(135deg,#FF6B6B 0%,#FF8E8E 100%);"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
        <div class="recent-activity">
            <h3><i class="fas fa-history"></i> Recent Activity</h3>
            <ul class="activity-list">
                <% for (Admin recentAdmin : recentAdmins) { %>
                    <li>
                        <i class="fas fa-user-circle"></i>
                        <div>
                            <strong><%= recentAdmin.getFullName() %></strong>
                            (<%= recentAdmin.getUsername() %>)
                            <br>
                            <small class="text-muted">
                                Role: <%= recentAdmin.getRole() %> | 
                                Status: <%= recentAdmin.isActive() ? "Active" : "Inactive" %>
                            </small>
                        </div>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
    <script>
        // Profile dropdown toggle
        document.getElementById('profileBtn').onclick = function() {
            document.getElementById('profileDropdown').classList.toggle('open');
        };
        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            var dropdown = document.getElementById('profileDropdown');
            if (!dropdown.contains(event.target)) {
                dropdown.classList.remove('open');
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>