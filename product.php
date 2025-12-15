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
    } else {
        $error = "Product not found.";
    }
} else {
    $error = "No product ID provided.";
}

include 'layout.phtml';
?>