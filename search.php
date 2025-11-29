<?php 
$template = 'search';

$searchText=isset($_GET['searchText']) ? trim($_GET['searchText']) : '';
$categoryText=isset($_GET['category']) ? trim($_GET['category']) : 'all';
if ($categoryText === 'all') {
    $category = '%';
} else {
    $stmt = $pdo->prepare("SELECT id FROM Categorie WHERE cat_name LIKE :category");
    $stmt->execute(['category' => $categoryText]);
    $category = $stmt->fetch()['id'];
}
$products=$pdo->prepare("SELECT * FROM Produit WHERE (prd_name LIKE :searchText OR prd_description LIKE :searchText OR category_id LIKE :category)");
$products->execute(['searchText' => "%$searchText%", 'category' => $category]);
$products = $products->fetchAll();
var_dump($products);
include 'layout.phtml';
?>