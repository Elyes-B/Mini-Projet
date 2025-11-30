<?php
session_start();
$template = 'register';
include 'layout.phtml';
include 'db.php'; // connexion à la base

if($_POST) {
    $email = $_POST['email'];
    $username = $_POST['cl_user_name'];
    $first_name = $_POST['cl_first_name'];
    $last_name = $_POST['cl_last_name'];
    $phone = $_POST['cl_phone_number'];
    $password = $_POST['pswd'];
    $confirm_password = $_POST['confirm_password'];

    if($password !== $confirm_password) {
        echo "Les mots de passe ne correspondent pas !";
    } else {
        // Vérifier si email ou username existe déjà
        
        $stmt = $pdo->prepare("SELECT * FROM CLIENT WHERE cl_email = ? OR cl_username = ?");
        $stmt->execute([$email, $username]);
        if($stmt->rowCount() > 0) {
            $error = "Email ou nom d'utilisateur déjà utilisé.";
        } else {
            // Hash du mot de passe
            $hash = password_hash($password, PASSWORD_DEFAULT);

            // Insertion dans la table
            $insert = $pdo->prepare("INSERT INTO CLIENT (cl_username,cl_email,cl_pass_word,cl_first_name,cl_last_name,cl_phone_number) 
                                    VALUES (?, ?, ?, ?, ?, ?)");
            $insert->execute([$username,$email, $hash, $first_name, $last_name, $phone]);

            $_SESSION['user_id'] = $db->lastInsertId();
            $_SESSION['user_fullname'] = $first_name . ' ' . $last_name;

            header("Location: home.php");
            exit();
        }
    }
}
?>
