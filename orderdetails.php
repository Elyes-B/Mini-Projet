<?php
include 'db.php';
 if(!isset($_SESSION['client_id'])) {
    header('Location: sigin.php');
    exit();
}

$order_id = isset($_GET['order_id']) ? (int)$_GET['order_id'] : null;

$stmt = $pdo->prepare('SELECT cd_quantity,cd_price,ac.product_id,prd_name,prd_image_url,fab_name,cat_name
 from Article_Commande ac JOIN Produit p ON ac.product_id = p.product_id join Fabricant f on p.manufacturer_id=f.manufacturer_id join Categorie c on p.category_id=c.category_id
 WHERE ac.order_id = :order_id');
$stmt->execute(['order_id' => $order_id]);
$products = $stmt->fetchAll();

$template = 'orderdetails';
include 'layout.phtml';
?>