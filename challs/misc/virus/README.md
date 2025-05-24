# Stringus (`virus`)

Mentre Alberto stava navigando nel dark web, per cercare un problema difficilissimo da mettere in questa gara, ha preso un ransomware, che ha cifrato tutti i dati sul suo computer, tra cui i testi degli altri problemi.

Questo virus si chiama Stringus ed è un po' particolare, perché per cifrare un file lo mette in una matrioska di 256 file system cifrati con GPG e ci affianca un problema di programmazione legato alle stringhe; all'interno di ogni file system c'è un input per il problema, mentre l'hash SHA-256 (come stringa esadecimale) dell'output corrispondente è la password per decifrare il file system successivo (nota: il virus è un po' egocentrico e come prima password usa sempre il proprio nome...).

Aiuta Alberto a recuperare ~~la flag~~ i problemi della gara! Questo è il problema lasciato da Stringus:

> ## String editing (`stred`)
>
> Hai un testo `S`, formato da `N` caratteri, che deve essere modificato con `M` operazioni. Il cursore inizia dalla posizione `X` (prima del carattere all'indice `X`, o alla fine della stringa se `X = N`) e per ogni carattere nella stringa delle modifiche `E` compie una di queste operazioni:
>
> - Se il carattere è `>`, si sposta a destra nel testo (equivalente a premere la freccia destra sulla tastiera);
> - Se il carattere è `<`, si sposta a sinistra nel testo (equivalente a premere la freccia sinistra sulla tastiera);
> - Se il carattere è `.`, cancella nel testo il carattere a sinistra (equivalente a premere Backspace sulla tastiera);
> - Altrimenti inserisce il carattere nel testo (equivalente a premerlo sulla tastiera).
>
> Come diventa il testo dopo le modifiche?
>
> ### Input
>
> L'input è costituito da 3 righe:
> - La prima contiene `N`, `M` e `X`, rispettivamente la lunghezza di `S`, la lunghezza di `E` e l'indice iniziale del cursore;
> - La seconda contiene `S`, il testo da modificare;
> - La terza contiene `E`, la sequenza di istruzioni che determina come modificare il testo.
>
> ### Output
>
> L'output è la stringa ottenuta dopo l'applicazione delle modifiche.
>
> ### Assunzioni
>
> - 0 ≤ `N` ≤ 10 000 000.
> - 0 ≤ `M` ≤ 10 000 000.
> - 0 ≤ `X` ≤ `N`.
> - `S[i]` è una lettera maiuscola o minuscola, una cifra o uno spazio per ogni `i = 0...N-1`.
> - `E[i]` è uno dei caratteri validi per `S`, oppure `'>'`, `'<'` o `'.'` per ogni `i = 0...M-1`.
>
> ### Matrioske
>
> A mano a mano che apri gli zip, i testi diventeranno sempre più lunghi e le modifiche saranno sempre di più, quindi se ci tieni ai tuoi file devi sviluppare una soluzione efficiente. La difficoltà degli input cresce a step e ogni blocco costituisce di fatto un subtask:
> - **Subtask 1 (4 input):** Casi di esempio.
> - **Subtask 2 (124 input):** `N` ≤ 100, `M` ≤ 200.
> - **Subtask 3 (64 input):** `N` ≤ 1 000, `M` ≤ 2 000.
> - **Subtask 4 (32 input):** `N` ≤ 10 000, `M` ≤ 20 000.
> - **Subtask 5 (16 input):** `N` ≤ 100 000, `M` ≤ 200 000.
> - **Subtask 6 (8 input):** `N` ≤ 1 000 000, `M` ≤ 2 000 000.
> - **Subtask 7 (8 input):** Nessuna limitazione aggiuntiva.
>
> ### Esempi di input/output
>
> <table>
>   <thead>
>     <tr>
>       <th><code>input</code></th>
>       <th><code>output</code></th>
>     </tr>
>   </thead>
>   <tbody>
>     <tr>
>       <th>
>         <pre><code>2 2 2<br>sh<br>.u</code></pre>
>       </th>
>       <th>
>         <pre><code>su</code></pre>
>       </th>
>     </tr>
>     <tr>
>       <th>
>         <pre><code>5 5 2<br>Abc d<br>f0>..</code></pre>
>       </th>
>       <th>
>         <pre><code>Abf d</code></pre>
>       </th>
>     </tr>
>     <tr>
>       <th>
>         <pre><code>10 10 6<br>RiCeRcArLo<br><......P ></code></pre>
>       </th>
>       <th>
>         <pre><code>P cArLo</code></pre>
>       </th>
>     </tr>
>     <tr>
>       <th>
>         <pre><code>10 10 3<br>Stringus42<br>...V>r>>..</code></pre>
>       </th>
>       <th>
>         <pre><code>Virus42</code></pre>
>       </th>
>     </tr>
>   </tbody>
> </table>
