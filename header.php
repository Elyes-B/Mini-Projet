
<header class="sticky-header">
    <div class="top-header py-2 bg-dark text-white">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="contact-info">
                    <span class="me-3"><i class="fas fa-phone"></i> +38 068 005 3570</span>
                    <span><i class="fas fa-envelope"></i> TechZone@gmail.com</span>
                </div>
                <div class="user-actions">
                    <a href="register.php" class="me-3">Register</a>
                    <a href="signin.php">Sign In</a>
                </div>
            </div>
        </div>
    </div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <div class="logoContainer">
                <img src="assets/logo.png" alt="TechZone Logo" class="img-fluid">
            </div>
            <a class="navbar-brand" href="index.php">TechZone</a>
            <div class="search-bar flex-grow-1 mx-4">
                <form class="input-group" method="GET" action="search.php">
                    <input type="text" name="q" class="form-control" placeholder="Search for products..." value="<?php echo isset($_GET['q']) ? htmlspecialchars($_GET['q']) : ''; ?>">
                    <select name="category" class="form-select" style="max-width: 150px;">
                        <option value="all" <?php echo (isset($_GET['category']) && $_GET['category'] === 'all') ? 'selected' : ''; ?>>All Categories</option>
                        <option value="computers" <?php echo (isset($_GET['category']) && $_GET['category'] === 'computers') ? 'selected' : ''; ?>>Computers & Laptops</option>
                        <option value="phones" <?php echo (isset($_GET['category']) && $_GET['category'] === 'phones') ? 'selected' : ''; ?>>Smartphones & Tablets</option>
                        <option value="cameras" <?php echo (isset($_GET['category']) && $_GET['category'] === 'cameras') ? 'selected' : ''; ?>>Cameras</option>
                        <option value="accessories" <?php echo (isset($_GET['category']) && $_GET['category'] === 'accessories') ? 'selected' : ''; ?>>Accessories</option>
                        <option value="videogames" <?php echo (isset($_GET['category']) && $_GET['category'] === 'videogames') ? 'selected' : ''; ?>>Video games</option>
                        <option value="smartwatches" <?php echo (isset($_GET['category']) && $_GET['category'] === 'smartwatches') ? 'selected' : ''; ?>>Smart watches</option>
                    </select>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                </form>
            </div>
            <div class="user-controls">
                <a href="wishlist.php" class="btn btn-outline-secondary me-2">
                    <i class="far fa-heart"></i>
                    <span class="badge bg-danger">115</span>
                </a>
                <a href="cart.php" class="btn btn-outline-secondary">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="badge bg-danger">$85</span>
                </a>
            </div>
        </div>
    </nav>
</header>
