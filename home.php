<?php
include 'db.php';


$stmt = $pdo->query("SELECT * FROM produit");
$pro = $stmt->fetchAll(PDO::FETCH_ASSOC);


function TagNew(&$product){
    if (!empty($product['prd_added_at'])) {
        $date = strtotime($product['prd_added_at']);
        if (date('Y', $date) == date('Y')) {
            $product['tag'][] = 'New';
        }
    }
}

function TagSale(&$product){
    $stmt = $GLOBALS['pdo']->prepare(
        "SELECT off_discount_amount
         FROM Offre
         WHERE product_id = :id
           AND off_discount_amount > 0
           AND off_end_date >= NOW()"
    );
    $stmt->execute(['id' => $product['product_id']]);
    if ($stmt->fetch()) {
        $product['tag'][] = 'Sale';
    }
}

function TagBestRated(&$product){
    $stmt = $GLOBALS['pdo']->prepare(
        "SELECT AVG(rev_rating) avg_rating
         FROM Avis
         WHERE product_id = :id"
    );
    $stmt->execute(['id' => $product['product_id']]);
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($res && $res['avg_rating'] >= 4.5) {
        $product['tag'][] = 'Best Rated';
    }
}


foreach ($pro as &$product) {
    $product['tag'] = [];
    TagNew($product);
    TagSale($product);
    TagBestRated($product);
}
unset($product);


$tab = $_GET['tab'] ?? 'new';
$filteredProducts = [];

foreach ($pro as $product) {
    if ($tab === 'new' && in_array('New', $product['tag'])) {
        $filteredProducts[] = $product;
    }
    if ($tab === 'sale' && in_array('Sale', $product['tag'])) {
        $filteredProducts[] = $product;
    }
    if ($tab === 'best' && in_array('Best Rated', $product['tag'])) {
        $filteredProducts[] = $product;
    }
}


$template = 'home';
include 'layout.phtml';
