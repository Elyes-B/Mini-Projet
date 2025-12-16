<?php
include 'db.php';
if (!isset($_SESSION['client_id'])) {
    header('Location: signin.php');
    exit();
}

$template = 'search';


$searchText=isset($_GET['searchText']) ? trim($_GET['searchText']) : '';
$categoryText=isset($_GET['category']) ? trim($_GET['category']) : 'all';

$stmt = $pdo->prepare("SELECT category_id FROM Categorie WHERE cat_name LIKE :category");
$stmt->execute(['category' => $categoryText]);
$category = $stmt->fetch();

$stmt = $pdo->prepare("INSERT INTO Historique_De_Recherche (search_id, search_text, search_date, client_id,category_id) VALUES (NULL, :search_text, NOW(), :client_id,:category_id)");
$stmt->execute([
    'search_text' => $searchText,
    'client_id' => (int)$_SESSION['client_id'],
    'category_id' => $category ? $category['category_id'] : null
]);


if ($categoryText === 'all') {
    $products=$pdo->prepare("SELECT * FROM Produit WHERE (prd_name LIKE :searchText OR prd_description LIKE :searchText)");
$products->execute(['searchText' => "%$searchText%", 'category' => $category]);
} else {
    $stmt = $pdo->prepare("SELECT category_id FROM Categorie WHERE cat_name LIKE :category");
    $stmt->execute(['category' => $categoryText]);
    $category = $stmt->fetch();
    $products=$pdo->prepare("SELECT * FROM Produit WHERE (prd_name LIKE :searchText OR prd_description LIKE :searchText) AND category_id = :category");
$products->execute(['searchText' => "%$searchText%", 'category' => $category['category_id']]);
}

$products = $products->fetchAll();

$tags = $pdo->prepare("SELECT tag_name FROM Tag");
$tags->execute();
$tags = $tags->fetchAll();



function TagNew(&$product){
    $date = $product['prd_added_at'];
    $date = strtotime($date);
    if (date('Y', $date) == date('Y')) {
        $product['tag'][]='New';
    }
}

function TagSale(&$product){
    $stmt = $GLOBALS['pdo']->prepare("SELECT off_discount_amount FROM Offre WHERE product_id = :product_id");
    $stmt->execute(['product_id' => $product['product_id']]);
    $result = $stmt->fetch();
    if ($result && isset($result['off_discount_amount']) && $result['off_discount_amount'] > 0) {
        $product['tag'][]='Sale';
    }
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
    $stmt = $GLOBALS['pdo']->prepare("SELECT AVG(rev_rating) as avg_rating FROM Avis WHERE product_id = :product_id");
    $stmt->execute(['product_id' => $product['product_id']]);
    $result = $stmt->fetch();
    if ($result && isset($result['avg_rating']) && $result['avg_rating'] >= 4.5) {
        $product['tag'][]='Best Rated';
    }
}

for ($i = 0; $i < count($products); $i++) {
        $product = &$products[$i];
        $stmt = $pdo->prepare("SELECT cat_name FROM Categorie WHERE category_id = :category_id");
        $stmt->execute(['category_id' => $product['category_id']]);
        $category = $stmt->fetch();
        $product['category']=$category['cat_name'];
}

for ($i = 0; $i < count($products); $i++) {
        $product = &$products[$i];
        $stmt = $pdo->prepare("SELECT off_discount_amount FROM Offre WHERE product_id = :product_id AND off_end_date >= NOW()");
        $stmt->execute(['product_id' => $product['product_id']]);
        $category = $stmt->fetch();
        $product['discount']=$category['off_discount_amount'];
}

for ($i = 0; $i < count($products); $i++) {
        $product = &$products[$i];
        $stmt = $pdo->prepare("SELECT fab_name FROM Fabricant WHERE manufacturer_id = :fabricant_id");
        $stmt->execute(['fabricant_id' => $product['manufacturer_id']]);
        $category = $stmt->fetch();
        $product['manufacturer']=$category['fab_name'];
}

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
    unset($product);
}
}

function Rating($product_id){
    $stmt = $GLOBALS['pdo']->prepare("SELECT AVG(rev_rating) as avg_rating FROM Avis WHERE product_id = :product_id");
    $stmt->execute(['product_id' => $product_id]);
    $result = $stmt->fetch();
    if ($result && isset($result['avg_rating'])) {
        return $result['avg_rating'];
    }
    return null;
}


$manufacturers=$pdo->prepare("SELECT fab_name FROM Fabricant");
$manufacturers->execute();
$manufacturers = $manufacturers->fetchAll();

$filtered = [];

$minPrice = isset($_GET['minPrice']) && $_GET['minPrice'] !== '' ? floatval($_GET['minPrice']) : null;
$maxPrice = isset($_GET['maxPrice']) && $_GET['maxPrice'] !== '' ? floatval($_GET['maxPrice']) : null;
$selectedBrands = isset($_GET['brands']) && is_array($_GET['brands']) ? $_GET['brands'] : [];
$selectedTags = isset($_GET['tags']) && is_array($_GET['tags']) ? $_GET['tags'] : [];
$availability = isset($_GET['availability']) ? $_GET['availability'] : null;
$rating_type = isset($_GET['rating']) ? $_GET['rating'] : null;

if ($minPrice === null && $maxPrice === null && empty($selectedBrands) && empty($selectedTags) && ($availability === null || $availability === 'all')  && $rating_type === null) {
    $filtered = $products;
}
else{
foreach ($products as $product) {
    $effectivePrice = null;
    $price = floatval($product['prd_price']);
    $discount = isset($product['discount']) && is_numeric($product['discount']) ? floatval($product['discount']) : 0;
    $effectivePrice = $price - $discount;

    if ($minPrice !== null && $effectivePrice !== null && $effectivePrice >= $minPrice) {
        $filtered[] = $product;
    }
    if ($maxPrice !== null && $effectivePrice !== null && $effectivePrice <= $maxPrice) {
        $filtered[] = $product;
    }

    if (!empty($selectedBrands)) {
        $manu = $product['manufacturer'];
        $matchedBrand = false;
        foreach ($selectedBrands as $b) {
            if ($manu !== null && strcasecmp($manu, $b) === 0) {
                $matchedBrand = true;
                $filtered[] = $product;
                break;
            }
        }
        if (!$matchedBrand) continue;
    }
    if ($availability === 'in-stock') {
        if (isset($product['prd_stock']) && $product['prd_stock'] > 0)
            $filtered[] = $product;
        else continue;
    }

    if (!empty($selectedTags)) {
        $productTags = isset($product['tag'])? $product['tag'] : [];
        $hasTag = false;
        foreach ($selectedTags as $t) {
            foreach ($productTags as $pt) {
                if (strcasecmp(trim($pt), trim($t)) === 0) {
                    $hasTag = true;
                    $filtered[] = $product;
                    break 2;
                }
            }
        }
        if (!$hasTag) continue;
    }

    
        $avgRating = Rating($product['product_id']);
        if($avgRating !== null){
        if ($avgRating >= 4 && $rating_type === 'positive') {
            $filtered[] = $product;
        } elseif ($avgRating <= 2 && $rating_type === 'negative') {
            $filtered[] = $product;
        }
    }
}
}
?>

<?php include 'layout.phtml'; ?>