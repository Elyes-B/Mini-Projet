<?php 
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}

$template = 'wishlist';
include 'layout.phtml';
?>