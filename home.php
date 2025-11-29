<?php
$products = [
['id' => 1, 'name' => 'Huawei MediaPad', 'price' => 225, 'oldPrice' => 300, 'badge' => '-25%', 'category' => 'featured'],
['id' => 2, 'name' => 'Sony MDRZX310W', 'price' => 379, 'oldPrice' => null, 'badge' => null, 'category' => 'best-rated'],
['id' => 3, 'name' => 'Canon STM Kit', 'price' => 225, 'oldPrice' => null, 'badge' => null, 'category' => 'featured'],
['id' => 4, 'name' => 'Lenovo IdeaPad', 'price' => 379, 'oldPrice' => null, 'badge' => 'new', 'category' => 'on-sale']
    ];
$template = 'home';
include 'layout.phtml';
?>