<?php
$params = session_get_cookie_params();
setcookie(session_name(), '', time() - 1, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
session_destroy();
header("Location: .");
