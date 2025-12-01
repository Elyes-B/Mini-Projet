<?php
include 'db.php';
session_destroy();
header('Location: home.php');
exit();
?>