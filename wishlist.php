<?php 
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}

if ($_POST['action'] == 'wishlist') {
    $product_id = isset($_POST['product_id']) ? $_POST['product_id'] : null;
}

if ($product_id) {
        $stmt = $pdo->prepare("INSERT INTO Article_Souhaits (client_id, product_id) VALUES (:client_id, :product_id);");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id'],
            'product_id' => (int)$product_id
        ]);
    }
if ($_POST['action'] == 'remove') {
    $product_id = isset($_POST['product_id']) ? $_POST['product_id'] : null;
    if ($product_id) {
        $stmt = $pdo->prepare("DELETE FROM Article_Souhaits WHERE client_id = :client_id AND product_id = :product_id");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id'],
            'product_id' => $product_id
        ]);
    }
}
$products = $pdo->prepare("SELECT p.* FROM Produit p
                        JOIN Article_Souhaits as ap ON p.product_id = ap.product_id
                        WHERE ap.client_id = :client_id");
$products->execute(['client_id' => (int)$_SESSION['client_id']]);
$products = $products->fetchAll();

$template = 'wishlist';
include 'layout.phtml';
?>