<?php
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}
$template = 'product';

$product_id = isset($_GET['id']) ? $_GET['id'] : null;

$product = null;
$error = null;

if ($product_id) {
    $stmt = $pdo->prepare("SELECT * FROM Produit WHERE product_id = :id");
    $stmt->execute(['id' => $product_id]);
    $product = $stmt->fetch();
    
    if ($product) {
        $stmt = $pdo->prepare("SELECT cat_name FROM Categorie WHERE category_id = :category_id");
        $stmt->execute(['category_id' => $product['category_id']]);
        $category = $stmt->fetch();
        $product['category'] = $category ? $category['cat_name'] : 'N/A';
        
        $stmt = $pdo->prepare("SELECT fab_name FROM Fabricant WHERE manufacturer_id = :manufacturer_id");
        $stmt->execute(['manufacturer_id' => $product['manufacturer_id']]);
        $manufacturer = $stmt->fetch();
        $product['manufacturer'] = $manufacturer ? $manufacturer['fab_name'] : 'N/A';
        
        $stmt = $pdo->prepare("SELECT off_discount_amount FROM Offre WHERE product_id = :product_id");
        $stmt->execute(['product_id' => $product['product_id']]);
        $discount = $stmt->fetch();
        $product['discount'] = $discount ? $discount['off_discount_amount'] : 0;
        
        $product['tag'] = [];
        
        $date = $product['prd_added_at'];
        $dateTime = strtotime($date);
        if ($dateTime && date('Y', $dateTime) == date('Y')) {
            $product['tag'][] = 'New';
        }
        
        $text = strtolower($product['prd_description'] . ' ' . $product['prd_name']);
        $keywords = ['game','gaming','console','playstation','ps5','xbox','nintendo','pc','vr','controller','fps','rpg'];
        foreach ($keywords as $kw) {
            if (strpos($text, $kw) !== false) {
                $product['tag'][] = 'Gaming';
                break;
            }
        }
        

        
        $stmt = $pdo->prepare("SELECT a.rev_rating as rating, a.rev_comment as review_text, a.rev_created_at as created_at, c.cl_first_name, c.cl_last_name FROM Avis a JOIN CLIENT c ON a.client_id = c.client_id WHERE a.product_id = :product_id ORDER BY a.rev_created_at DESC");
        $stmt->execute(['product_id' => $product_id]);
        $reviews = $stmt->fetchAll();
        
        $mostPositive = null;
        $leastPositive = null;
        foreach ($reviews as $review) {
            if ((!$mostPositive || $review['rating'] > $mostPositive['rating']) && $review['rating'] >= 4) {
                $mostPositive = $review;
            }
            if ((!$leastPositive || $review['rating'] < $leastPositive['rating']) && $review['rating'] <= 2) {
                $leastPositive = $review;
            }
        }
    } else {
        $error = "Product not found.";
    }
} else {
    $error = "No product ID provided.";
}

include 'layout.phtml';
?>