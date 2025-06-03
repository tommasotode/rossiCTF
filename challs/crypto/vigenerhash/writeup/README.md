La challenge fornisce due file:
- `secret.txt`, contenente una serie di stringhe esadecimali 
- `flagenc.txt`, contenente la flag cifrata in qualche modo

Il **titolo** e la **descrizione** danno un **hint** molto grande su cosa siano questi file, il primo una serie di hash e il secondo la flag cifrata con vigenere, nello specifico con la chiave contenuta in `secret.txt`

A questo punto basta provare a 'reversare' gli hash, per rendersi conto che sono hash di singole lettere, e quindi esistono in ogni database di hash, e che sono `sha512`.

Reversando tutti gli hash si ottiene la stringa `lirililarilaisbetterthantralalerotralala` (fr), che è la chiave per la flag cifrata. 
A questo punto basta decifrare la flag con vigenere e un tool come `cyberchef`, ed abbiamo finito.

Flag: `rossiCTF{Th3_k3Y_1s_5pItT1ng_f4ctS_Th0uGh_r1Ght??_9dba2d}`
