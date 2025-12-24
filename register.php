<?php
include 'db.php';
if (isset($_SESSION['client_id'])) {
    header('Location: home.php');
    exit();
}
if($_POST) {
    $email = $_POST['email'];
    $first_name = $_POST['cl_first_name'];
    $last_name = $_POST['cl_last_name'];
    $phone = $_POST['cl_phone_number'];
    $password = $_POST['pswd'];
    $confirm_password = $_POST['confirm_password'];

    $username = $first_name . ' ' . $last_name;

    if($password !== $confirm_password) {
        echo "Les mots de passe ne correspondent pas !";
    } else {
        
        $stmt = $pdo->prepare("SELECT * FROM CLIENT WHERE cl_email = ? OR cl_username = ?");
        $stmt->execute([$email, $username]);
        if($stmt->rowCount() > 0) {
            $error = "Email ou nom d'utilisateur déjà utilisé.";
        } else {
            $hash = password_hash($password, PASSWORD_DEFAULT);

            $insert = $pdo->prepare("INSERT INTO CLIENT (cl_username,cl_email,cl_pass_word,cl_first_name,cl_last_name,cl_phone_number) 
                                    VALUES (?, ?, ?, ?, ?, ?)");
            $insert->execute([$username,$email, $hash, $first_name, $last_name, $phone]);

            $_SESSION['client_id'] = $pdo->lastInsertId();
            $_SESSION['client_fullname'] = $first_name . ' ' . $last_name;

            header("Location: home.php");
            exit();
        }
    }
}
$template = 'register';
include 'layout.phtml';
?>
