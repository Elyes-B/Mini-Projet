<?php
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}
$template = 'product';
include 'layout.phtml';
?>