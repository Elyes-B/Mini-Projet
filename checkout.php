<?php
include 'db.php';
if (!isset($_SESSION)) {
    header('Location: signin.php');
    exit();
}
if ($_POST['action'] == 'checkout') {

    $address = isset($_POST['street_address']) ? trim($_POST['street_address']) : '';
    $country = isset($_POST['country']) ? trim($_POST['country']) : '';
    $city = isset($_POST['city']) ? trim($_POST['city']) : '';
    $zip_code = isset($_POST['zip_code']) ? trim($_POST['zip_code']) : '';

    if ($address && $country && $city && $zip_code) {

        $stmt = $pdo->prepare("INSERT INTO Address (address_id,ad_street_address, ad_city,  ad_zip_code, ad_country, client_id) VALUES (NULL, :ad_street_address, :ad_city, :ad_zip_code, :ad_country, :client_id)");
        $stmt->execute([
            'ad_street_address' => $address,
            'ad_city' => $city,
            'ad_zip_code' => (int)$zip_code,
            'ad_country' => $country,
            'client_id' => (int)$_SESSION['client_id']
        ]);

        $stmt = $pdo->prepare("SELECT address_id FROM Address WHERE client_id = :client_id ORDER BY address_id DESC LIMIT 1");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id']
        ]);
        $address = $stmt->fetch();
        $address_id = $address['address_id'];

        $stmt = $pdo->prepare("INSERT INTO Commande (order_id, client_id,order_date,order_status,address_id) VALUES (NULL, :client_id, NOW(), 'pending', :address_id)");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id'],
            'address_id' => (int)$address_id
        ]);

        $stmt = $pdo->prepare("SELECT order_id FROM Commande WHERE client_id = :client_id ORDER BY order_date DESC LIMIT 1");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id']
        ]);
        $order = $stmt->fetch();
        $order_id = $order['order_id'];

        $stmt = $pdo->prepare("SELECT * FROM Article_Panier WHERE client_id=:client_id");
        $stmt->execute([
            'client_id' => (int)$_SESSION['client_id']
        ]);
        $cart_items = $stmt->fetchAll();



        for ($i = 0; $i < count($cart_items); $i++) {
        $stmt = $pdo->prepare("SELECT off_discount_amount FROM Offre WHERE product_id = :product_id AND off_end_date >= NOW()");
        $stmt->execute(['product_id' => $cart_items[$i]['product_id']]);
        $category = $stmt->fetch();
        
        $stmt = $pdo->prepare("SELECT prd_price FROM Produit WHERE product_id = :product_id");
        $stmt->execute(['product_id' => $cart_items[$i]['product_id']]);
        $priceResult = $stmt->fetch();

        $discount = isset($category['off_discount_amount']) ? (float)$category['off_discount_amount'] : 0.0;
        $original_price = (float)$priceResult['prd_price'];
        $cart_items[$i]['cart_price'] = $original_price - $discount;
        }

        foreach ($cart_items as $item) {
            $stmt = $pdo->prepare("INSERT INTO Article_Commande (order_id, product_id, cd_quantity,cd_price) VALUES (:order_id, :product_id, :cd_quantity, :cd_price)");
            $stmt->execute([
                'order_id' => $order_id,
                'product_id' => $item['product_id'],
                'cd_quantity' => $item['cart_quantity'],
                'cd_price' => round($item['cart_price'], 2)
            ]);
        }

        foreach ($cart_items as $item) {
            $stmt = $pdo->prepare("DELETE FROM Article_Panier WHERE client_id = :client_id AND product_id = :product_id");
            $stmt->execute([
                'client_id' => (int)$_SESSION['client_id'],
                'product_id' => $item['product_id']
            ]);
            $stmt = $pdo->prepare("UPDATE Produit SET prd_stock = prd_stock - :quantity WHERE product_id = :product_id");
            $stmt->execute([
                'quantity' => $item['cart_quantity'],
                'product_id' => $item['product_id']
            ]);
        }
    }

    header('Location: home.php');
    exit();
}
?>
