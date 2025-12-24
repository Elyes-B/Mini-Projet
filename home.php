<?php
include 'db.php';


$stmt = $pdo->query("SELECT * FROM Produit where prd_stock > 0 ORDER BY prd_added_at DESC");
$pro = $stmt->fetchAll(PDO::FETCH_ASSOC);

$categoris = $pdo->query("SELECT cat_name FROM Categorie")->fetchAll(PDO::FETCH_ASSOC);

for ($i = 0; $i < count($categoris); $i++) {
    switch($categoris[$i]['cat_name']) {
        case 'Laptops':
            $categoris[$i]['icon'] = 'bi bi-laptop';
            break;
        case 'Phones':
            $categoris[$i]['icon'] = 'bi bi-phone';
            break;
        case 'Peripherals':
            $categoris[$i]['icon'] = 'bi bi-keyboard';
            break;
        case 'Computers':
            $categoris[$i]['icon'] = 'bi bi-pc-display-horizontal';
            break;
        case 'Wearables':
            $categoris[$i]['icon'] = 'bi bi-watch';
            break;
    }
}


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
    $discount = $stmt->fetch();
    if ($discount) {
        $product['tag'][] = 'Sale';
        $product['discount'] = $discount['off_discount_amount'];
    }
}

function TagBestRated(&$product){
    $stmt = $GLOBALS['pdo']->prepare(
        "SELECT AVG(rev_rating) avg_rating
         FROM Avis
         WHERE product_id = :id"
    );
    $stmt->execute(['id' => $product['product_id']]);
    $res = $stmt->fetch();
    if ($res && $res['avg_rating'] >= 4.5) {
        $product['tag'][] = 'Best Rated';
    }
}

$stmt = $pdo->prepare("select p.*,off_discount_amount from Produit p join Offre o on p.product_id = o.product_id where o.off_discount_amount > 0 and o.off_end_date >= NOW() and prd_stock > 0 order by o.off_discount_amount/p.prd_price desc limit 1; ");
$stmt->execute();
$bestProduct = $stmt->fetch();

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
    if (count($filteredProducts) >= 8) {
        break;
    }
}


$template = 'home';
include 'layout.phtml';
?>