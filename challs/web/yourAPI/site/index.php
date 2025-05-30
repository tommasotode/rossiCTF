<?php 
$env = parse_ini_file('/var/www/.env'); 
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
    <html lang="it">     
    <head>         
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>yourAPI - File Reader</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: #0f172a;
                color: #e2e8f0;
                line-height: 1.6;
                padding: 2rem;
                min-height: 100vh;
            }
            
            .container {
                max-width: 600px;
                margin: 0 auto;
            }
            
            h1 {
                font-size: 2.5rem;
                margin-bottom: 2rem;
                text-align: center;
                background: linear-gradient(135deg, #6366f1, #10b981);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            
            .files-list {
                background: #1e293b;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }
            
            ul {
                list-style: none;
            }
            
            li {
                padding: 0.75rem 1rem;
                margin-bottom: 0.5rem;
                background: #334155;
                border-radius: 8px;
                border-left: 3px solid #6366f1;
                transition: all 0.2s ease;
                font-family: 'Courier New', monospace;
            }
            
            li:hover {
                background: #475569;
                transform: translateX(4px);
            }
            
            li:last-child {
                margin-bottom: 0;
            }
            
            .empty-state {
                text-align: center;
                color: #64748b;
                font-style: italic;
                padding: 2rem;
            }
        </style>
    </head>     
    <body>
        <div class="container">
            <h1>yourAPI</h1>
            <p style="text-align: center; color: #64748b; margin-bottom: 2rem; font-style: italic;">Yet <span style="font-size: 0.8em;">(one)</span> Other Useless REST API</p>
            <h2 style="font-size: 1.5rem; margin-bottom: 2rem; text-align: center; color: #e2e8f0;">File disponibili</h2>
            <div class="files-list">
                <ul>             
                    <?php             
                    $files = glob(FILES . '*.txt');             
                    if (empty($files)) {
                        echo '<div class="empty-state">Nessun file disponibile</div>';
                    } else {
                        foreach ($files as $file) {                 
                            echo '<li>' . htmlspecialchars(basename($file)) . '</li>';             
                        }
                    }
                    ?>         
                </ul>
            </div>
        </div>
    </body>     
    </html>     
    <?php 
} 
?>