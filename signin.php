<?php
include 'db.php';
if (isset($_SESSION['client_id'])) {
    header('Location: home.php');
    exit();
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    extract($_POST);
    $stmt = $pdo->prepare("SELECT * FROM CLIENT WHERE cl_email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['cl_pass_word'])) {
        echo "Connexion réussie !";
    $_SESSION['client_id'] = $user['client_id'];
    $_SESSION['client_fullname'] = $user['cl_first_name'] . ' ' . $user['cl_last_name'];
    header('Location: home.php');
    exit();
}
    }
$template = 'signin';
include 'layout.phtml';
?>
