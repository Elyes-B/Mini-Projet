<?php
include 'db.php';
if (!isset($_SESSION)) {
    header('Location: signin.php');
    exit();
}
if ($_POST['action'] == 'review') {
    $rating = isset($_POST['rating']) ? (int)$_POST['rating'] : null;
    $review_text = isset($_POST['reviewText']) ? trim($_POST['reviewText']) : '';
    $product_id = isset($_POST['product_id']) ? (int)$_POST['product_id'] : null;
    if ($rating && $review_text) {
        $stmt = $pdo->prepare("INSERT INTO Avis (review_id,rev_rating, rev_comment, rev_created_at,product_id, client_id) VALUES (NULL, :rating, :review_text, null, :product_id, :client_id)");
        $stmt->execute([
            'rating' => $rating,
            'review_text' => $review_text,
            'product_id' => (int)$product_id,
            'client_id' => (int)$_SESSION['client_id']
        ]);
    }
    header("Location: product.php?id=" . $product_id);
    exit();
}
header("Location: home.php");
exit();
?>
