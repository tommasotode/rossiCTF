<?php
session_start();
if (!isset($_SESSION['user'])) { header('Location: .'); exit; }
$admin = $_SESSION['user'] === 'admin';
?>
<!DOCTYPE html><html lang="it"><head><meta charset="utf-8"><title>Il tuo profilo</title><meta name="viewport" content="width=device-width"><style>html,body{height:100%}body{margin:0;padding:16px;box-sizing:border-box;background-image:linear-gradient(45deg,#8ec5fc 0,#8dd3ff 25%,#a1d8ff 50%,#c1d2ff 75%,#e0c3ff 100%);display:flex;flex-direction:column;justify-content:center;align-items:center;gap:32px;font-family:monospace;font-size:2rem;text-align:center}p{margin:0}span{background-image:linear-gradient(300deg,#af342b 0,#af760f 33.333%,#7daf23 66.667%,#1faf5e 100%);background-clip:text;color:transparent;font-weight:bold}<?php if ($admin): ?>code{border-radius:8px;background-color:rgba(239,239,239,.87)}<?php endif; ?>a{color:#6200ee}a:not(:hover){text-decoration:none}</style></head><body><p>Ciao <?= htmlspecialchars($_SESSION['user']) ?>,<br>ti trovi in un <span>bellissimo</span> sito</p><?php if ($admin): ?><p>La tua flag è <code>rossiCTF{1_l0v3_Cl13n751d3_53cUr17y}</code></p><?php endif; ?><a href="logout.php">Esci</a></body></html>
