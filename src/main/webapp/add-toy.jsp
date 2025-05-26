<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/theme-header.jsp" %>

<body>
    <!-- Floating Toys Animation Background -->
    <div class="floating-toys">
        <i class="fas fa-teddy-bear toy" style="top: 10%; left: 10%; animation-delay: 0s;"></i>
        <i class="fas fa-robot toy" style="top: 20%; right: 15%; animation-delay: 1s;"></i>
        <i class="fas fa-gamepad toy" style="bottom: 15%; left: 20%; animation-delay: 2s;"></i>
        <i class="fas fa-puzzle-piece toy" style="bottom: 25%; right: 25%; animation-delay: 3s;"></i>
    </div>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/list-toys">Toy Store</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/list-toys">List Toys</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/add-toy">Add Toy</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container toy-container mt-4" style="position: relative; z-index: 1;">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card" style="border-radius: 30px; box-shadow: 0 10px 30px rgba(255,107,107,0.10);">
                <div class="card-header bg-white" style="border-radius: 30px 30px 0 0; border-bottom: none;">
                    <div class="text-center">
                        <i class="fas fa-cube toy-icon" style="font-size: 48px; color: var(--primary-color);"></i>
                        <h2 class="store-title" style="font-size: 2.2em; margin-bottom: 0;">Add a New Toy</h2>
                        <p class="text-muted">Bring more fun to the Toy Store!</p>
                    </div>
                </div>
                <div class="card-body">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>
                    <form action="${pageContext.request.contextPath}/add-toy" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-cube"></i></span>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                                <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="ageGroup" class="form-label">Age Group</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-child"></i></span>
                                <select class="form-select" id="ageGroup" name="ageGroup" required>
                                    <option value="">Select Age Group</option>
                                    <option value="0-2">0-2 years</option>
                                    <option value="3-5">3-5 years</option>
                                    <option value="6-8">6-8 years</option>
                                    <option value="9">9+ years</option>
                                </select>
                            </div>
                        </div>


                        <div class="mb-3">
                            <label for="image" class="form-label">Toy Image</label>
                            <div class="drop-zone" id="dropZone">
                                <div class="drop-zone__prompt">
                                    <i class="fas fa-cloud-upload-alt fa-3x mb-3"></i>
                                    <p>Drag and drop your image here or click to select</p>
                                    <small class="text-muted">Supported formats: JPG, PNG, GIF (max 5MB)</small>
                                </div>
                                <input type="file" name="image" id="image" class="drop-zone__input" accept="image/*" required>
                            </div>
                            <div id="imagePreview" class="mt-3 text-center" style="display: none;">
                                <img id="preview" src="#" alt="Preview" class="img-thumbnail" style="max-height: 200px;">
                            </div>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-register">
                                <i class="fas fa-save"></i> Save Toy
                            </button>
                            <a href="${pageContext.request.contextPath}/list-toys" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
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
    animation: float 6s infinite;
}
@keyframes float {
    0%, 100% { transform: translateY(0) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(10deg); }
}
.bg-primary {
    background-color: #FF6B6B !important;
}
</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const dropZoneElement = document.getElementById('dropZone');
    const inputElement = dropZoneElement.querySelector('.drop-zone__input');
    const previewElement = document.getElementById('imagePreview');
    const previewImage = document.getElementById('preview');

    dropZoneElement.addEventListener('click', e => {
        inputElement.click();
    });

    inputElement.addEventListener('change', e => {
        if (inputElement.files.length) {
            updateThumbnail(dropZoneElement, inputElement.files[0]);
        }
    });

    dropZoneElement.addEventListener('dragover', e => {
        e.preventDefault();
        dropZoneElement.classList.add('drop-zone--over');
    });

    ['dragleave', 'dragend'].forEach(type => {
        dropZoneElement.addEventListener(type, e => {
            dropZoneElement.classList.remove('drop-zone--over');
        });
    });

    dropZoneElement.addEventListener('drop', e => {
        e.preventDefault();
        if (e.dataTransfer.files.length) {
            inputElement.files = e.dataTransfer.files;
            updateThumbnail(dropZoneElement, e.dataTransfer.files[0]);
        }
        dropZoneElement.classList.remove('drop-zone--over');
    });
    function updateThumbnail(dropZoneElement, file) {
        if (file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () => {
                previewImage.src = reader.result;
                previewElement.style.display = 'block';
                dropZoneElement.style.display = 'none';
            };
        } else {
            alert('Please upload an image file!');
        }
    }
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>