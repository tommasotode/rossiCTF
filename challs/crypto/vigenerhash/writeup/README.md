La challenge fornisce due file:
- `secret.txt`, contenente una serie di stringhe esadecimali 
- `flagenc.txt`, contenente la flag cifrata in qualche modo

Il **titolo** e la **descrizione** danno un **hint** molto grande su cosa siano questi file, il primo una serie di hash e il secondo la flag cifrata con vigenere, nello specifico con la chiave contenuta in `secret.txt`

A questo abbiamo degli hash, con cui in teoria non potremmo fare niente perché **non reversibili**.
Tuttavia in questo caso si tratta di `sha512` di singole lettere, che hanno quindi una bassissima entropia, e si trovano in pressoché ogni database o "tabella" di hash.
Per rendersene conto è sufficiente provare a reversarli con uno dei numerosi tool online, o scrivendo uno script che faccia l'operazione inversa, provando per ogni lettera a trovare dei match.

Una volta concatenati tutti gli hash reversati si ottiene la stringa `lirililarilaisbetterthantralalerotralala` (fr), che è la chiave per la flag cifrata. 
A questo punto basta decifrare la flag con vigenere e un tool come `cyberchef`, ed abbiamo finito.

Flag: `rossiCTF{Th3_k3Y_1s_5pItT1ng_f4ctS_Th0uGh_r1Ght??_9dba2d}`
