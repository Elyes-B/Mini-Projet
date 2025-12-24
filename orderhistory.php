<?php
include 'db.php';
 if(!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}

$stmt = $pdo->prepare('SELECT order_id,order_date,order_status from Commande WHERE client_id = :client_id ORDER BY order_date DESC');
$stmt->execute(['client_id' => (int)$_SESSION['client_id']]);
$orders = $stmt->fetchAll();

for ($i = 0; $i < count($orders); $i++) {
    $stmt = $pdo->prepare('SELECT sum(cd_quantity) from Article_Commande where order_id = :order_id GROUP BY order_id');
    $stmt->execute(['order_id' => (int)$orders[$i]['order_id']]);
    $orders[$i]['item_count'] = $stmt->fetchColumn();
}


$template = 'orderhistory';
include 'layout.phtml';
?>