<?php
include 'db.php';
$template = 'search';

// Searching for products
$searchText=isset($_GET['searchText']) ? trim($_GET['searchText']) : '';
$categoryText=isset($_GET['category']) ? trim($_GET['category']) : 'all';
if ($categoryText === 'all') {
    $products=$pdo->prepare("SELECT * FROM Produit WHERE (prd_name LIKE :searchText OR prd_description LIKE :searchText)");
$products->execute(['searchText' => "%$searchText%", 'category' => $category]);
} else {
    $stmt = $pdo->prepare("SELECT id FROM Categorie WHERE cat_name LIKE :category");
    $stmt->execute(['category' => $categoryText]);
    $category = $stmt->fetch();
    $products=$pdo->prepare("SELECT * FROM Produit WHERE (prd_name LIKE :searchText OR prd_description LIKE :searchText OR category_id = :category)");
$products->execute(['searchText' => "%$searchText%", 'category' => $category['id']]);
}

$products = $products->fetchAll();

$tags = $pdo->prepare("SELECT tag_name FROM Tag");
$tags->execute();
$tags = $tags->fetchAll();

// Functions for tagging products

function TagNew(&$product){
    $date = $product['prd_added_at'];
    $date = strtotime($date);
    if (date('Y', $date) == date('Y')) {
        $product['tag'][]='New';
    }
}

function TagSale(&$product){
    // TagSale logic to be implemented later by user
}

function TagGaming(&$product){
    $text = strtolower($product['prd_description'] . ' ' . $product['prd_name']);
    $keywords = ['game','gaming','console','playstation','ps5','xbox','nintendo','pc','vr','controller','fps','rpg'];
    foreach ($keywords as $kw) {
        if (strpos($text, $kw) !== false) {
            $product['tag'][]='Gaming';
            return;
        }
    }
}

function TagBestRated(&$product){

    // Requires rating/average-rating fields in product or a separate ratings table.
    // Not implemented because necessary data is not present.
}

function TagMostSold(&$product){
    // Requires sales statistics (units_sold, total_sold, orders, etc.).
    // Not implemented because necessary data is not present.
}

// Calling those tagging functions

foreach ($tags as $tag) {
    for ($i = 0; $i < count($products); $i++) {
        $product = &$products[$i];
    switch ($tag['tag_name']) {
        case 'New':
            TagNew($product);
            break;
        case 'Best Rated':
            TagBestRated($product);
            break;
        case 'Sale':
            TagSale($product);
            break;
        case 'Gaming':
            TagGaming($product);
            break;
        case 'Most sold':
            TagMostSold($product);
            break;
    }
}
}

// Searching for manufacturers
$manufacturers=$pdo->prepare("SELECT fab_name FROM Fabricant");
$manufacturers->execute();
$manufacturers = $manufacturers->fetchAll();

var_dump($products);

global $products;
global $tags;
?>

<?php include 'layout.phtml'; ?>