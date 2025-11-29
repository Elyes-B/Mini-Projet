// TechZone Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Tab switching on Featured Products
    const tabLinks = document.querySelectorAll('[data-tab]');
    const productItems = document.querySelectorAll('.product-item');
    
    tabLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const tabValue = this.getAttribute('data-tab');
            
            // Remove active class from all tabs
            tabLinks.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            
            // Filter products
            productItems.forEach(item => {
                if (tabValue === 'featured' || item.getAttribute('data-category') === tabValue) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });

    // Cart functionality
    const addToCartButtons = document.querySelectorAll('.btn-primary');
    addToCartButtons.forEach(btn => {
        if (btn.innerHTML.includes('Add to')) {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                alert('Product added to cart!');
            });
        }
    });

    // Wishlist functionality
    const wishlistButtons = document.querySelectorAll('.fa-heart');
    wishlistButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            this.classList.toggle('fas');
            this.classList.toggle('far');
        });
    });

    // Product quantity
    const quantityInputs = document.querySelectorAll('input[type="number"]');
    quantityInputs.forEach(input => {
        input.addEventListener('change', function() {
            if (this.value < 1) {
                this.value = 1;
            }
        });
    });
});


