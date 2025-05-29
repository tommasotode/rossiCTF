<?php
function reject(string $msg) {
  header('Content-Type: text/plain');
  echo $msg;
  exit;
}

if (!isset($_POST['user'])) reject('Non mi hai detto chi sei');

$user = $_POST['user'];
if (!is_string($user)) reject('Non capiscp chi sei');

$len = strlen(trim($user));
if (!$len) reject('Chi sei??');
if ($len > 16) reject('Non ho voglia di capire chi sei');

if (rand(0, 1)) reject('La sfera di cristallo mi ha detto che non ti conosco');

session_start();
session_regenerate_id(true);
$_SESSION['user'] = $user;
