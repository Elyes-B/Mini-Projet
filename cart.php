<?php 
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}

if ($_POST['action'] == 'cart') {
    $product_id = isset($_POST['product_id']) ? $_POST['product_id'] : null;
    $stmt = $pdo->prepare("SELECT prd_stock FROM Produit WHERE product_id = :product_id");
    $stmt->execute(['product_id' => $product_id]);
    $stmt = $stmt->fetch();
    if ($stmt["prd_stock"] <1) {
        header('Location: product.php?id=' . $product_id . '&error=out_of_stock');
        exit('Produit non trouvé');
    }
    $quantity = isset($_POST['quantity']) ? (int)$_POST['quantity'] : 1;
}

if ($product_id) {
        $stmt = $pdo->prepare("INSERT INTO Article_Panier (client_id, product_id, cart_quantity) VALUES (:client_id, :product_id, :quantity)
                               ON DUPLICATE KEY UPDATE cart_quantity = cart_quantity + :quantity");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id'],
            'product_id' => $product_id,
            'quantity' => $quantity
        ]);
    }
if ($_POST['action'] == 'remove') {
    $product_id = isset($_POST['product_id']) ? $_POST['product_id'] : null;
    if ($product_id) {
        $stmt = $pdo->prepare("DELETE FROM Article_Panier WHERE client_id = :client_id AND product_id = :product_id");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id'],
            'product_id' => $product_id
        ]);
    }
}
$products = $pdo->prepare("SELECT p.*, ap.cart_quantity FROM Produit p
                        JOIN Article_Panier ap ON p.product_id = ap.product_id
                        WHERE ap.client_id = :client_id");
$products->execute(['client_id' => (int)$_SESSION['client_id']]);
$products = $products->fetchAll();


for ($i = 0; $i < count($products); $i++) {
        $stmt = $pdo->prepare("SELECT off_discount_amount FROM Offre WHERE product_id = :product_id AND off_end_date >= NOW()");
        $stmt->execute(['product_id' => $products[$i]['product_id']]);
        $category = $stmt->fetch();
        $products[$i]['discount']=$category['off_discount_amount'];
}

$total = 0;
foreach ($products as $product) {
    $total += ($product['discount'] ? ($product['prd_price'] - $product['discount']) * $product['cart_quantity'] : $product['prd_price'] * $product['cart_quantity']);
}

$numberOfItems = count($products);
$avgPrice = round($numberOfItems ? $total / $numberOfItems : 0, 2);

$totalAfterShipping = $products!=null ? $total + 10 + 32.8 : 0;
$template = 'cart';
include 'layout.phtml';
?>