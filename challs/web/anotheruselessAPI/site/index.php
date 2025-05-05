<?php
$env = parse_ini_file(__DIR__ . '/.env');
define('TOKEN', $env['TOKEN']);
define('FILES', $env['FILES']);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');
    
    $request = json_decode(file_get_contents('php://input'), true);
    if ($request === null || !isset($request['file'], $request['token'], $request['lines'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Formatta bene il JSON! >:(']);
        exit;
    }
        
    $reqFile = basename($request['file']);
    $reqToken = $request['token'];
    $reqLines = abs((int)$request['lines']);
    $reqPath = FILES . $reqFile;
    
    if (!file_exists($reqPath) || !is_readable($reqPath)) {
        http_response_code(404);
        echo json_encode(['error' => 'File non trovato']);
        exit;
    }
    
    $lines = file($reqPath, FILE_IGNORE_NEW_LINES);
    if ($lines === false) {
        http_response_code(500);
        echo json_encode(['error' => 'Impossibile leggere il file']);
        exit;
    }
    
    if ($reqToken == TOKEN) {
        $linesCount = min($reqLines, count($lines));
    } else {
        $linesCount = min($reqLines, 5, count($lines));
    }
    
    $text = implode("\n", array_slice($lines, 0, $linesCount));    
    echo json_encode([
        'text' => $text,
        'length' => strlen($text)
    ]);
    
} else {
    header('Content-Type: text/html');
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title>API super mega utile per leggere i file!</title>
    </head>
    <body>
        <h1>File disponibili</h1>
        <ul>
            <?php
            $files = glob(FILES . '*.txt');
            foreach ($files as $file) {
                echo '<li>' . basename($file) . '</li>';
            }
            ?>
        </ul>
    </body>
    </html>
    <?php
}
?>