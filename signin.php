<?php
session_start();
$template = 'signin';
include 'layout.phtml';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    include 'db.php';
    extract($_POST);

    $stmt = $pdo->prepare("SELECT * FROM client WHERE cl_email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['pswd'])) {
    $_SESSION['user_id'] = $user['client_id'];
    $_SESSION['user_fullname'] = $user['cl_first_name'] . ' ' . $user['cl_last_name'];
    header('Location: home.php');
    exit();
}

    } else {
        $error = "Email ou mot de passe incorrect";
    }
}
?>
