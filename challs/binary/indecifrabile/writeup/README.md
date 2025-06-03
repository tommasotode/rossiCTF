# Indecifrabile (`indecifrabile`)

La challenge consiste in un binario, compilato da un file `c++`.

Questo binario ha molte fonti di distrazione inutili, ma sostanzialmente l'unica parte importante è l'array di stringhe contenente la flag codificata in **esadecimale**, e divisa in blocchetti da due caratteri esadecimali (equivalente di un byte).

Essendo scritto in `c++`, l'eseguibile è un po' scomodo da reversare, ma con un po' di pazienza o con qualsiasi tool (es. `strings` con i parametri corretti), si possono tirare fuori i blocchetti in hex e recuperare la flag codificata.

A questo punto basterà riportarli da `hex` ad `ascii`, e concatenarli in ordine, e avremo ottenuto la flag.

Flag: `rossiCTF{W4iT_h3X_1s_r3vErs4bL3_?!??!!_6fecf1}`