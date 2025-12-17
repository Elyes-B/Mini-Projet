<?php

include 'db.php';
$products =$pdo->query('SELECT * FROM produit');
$pro=$products->fetchAll();
$template = 'home';
include 'layout.phtml';
?>