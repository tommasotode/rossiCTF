# PyCalcolatrice 2.0 (`calc2`)

Alberto si aspettava che il professore provasse a rompergli la calcolatrice, ma non che ci riuscisse effettivamente! Appena ha scoperto che non funzionava più, non si è voluto arrendere e ha reinstallato subito tutto quanto (la prossima verifica è domani!), ma ha sfruttato l'occasione per creare una nuova calcolatrice molto più sicura di quella di prima (sacrificando un po' del tempo per studiare), a cui può connettersi con `nc <TODO: IP e porta>`. Aiuta di nuovo il professore, impedendo ad Alberto di imbrogliare!

## Istruzioni per creare la `chroot` jail

- Crea un utente `calc2` con UID 10001, o comunque ragionevole per un utente né di sistema (<1000), né di login (~1000): `sudo useradd -d / -M -s /sbin/nologin -u 10001 -U calc2`;
- Copia `/bin/python3`: `mkdir root/bin/ && cp /bin/python3 root/bin/`;
- Controlla le librerie richieste con `ldd /bin/python3` e copiale; dovrebbero essere `libm`, `libexpat`, `libz`, `libc` e `ld`: `mkdir -p root/lib{/x86_64-linux-gnu,64}/ && cp /lib/x86_64-linux-gnu/lib{m.so.6,expat.so.1,z.so.1,c.so.6} root/lib/x86_64-linux-gnu/ && cp /lib64/ld-linux-x86-64.so.2 root/lib64/` (le versioni potrebbero essere diverse);
- Esegui `python3 -c "import os; print(os.__file__)"` per trovare la directory dei moduli della stdlib (dovrebbe essere `/usr/local/lib/python3.<versione>/` o `/usr/lib/python3.<versione>/`), che chiamerò `$stdlib_dir`;
- Esegui `./main` finché non vengono fuori _solo_ i due `print` e l'`input`, sistemando gli errori di volta in volta; dovrebbero servire, nell'ordine, questi moduli:
  - `encodings`: `mkdir -p root/$stdlib_dir/ && cp -r $stdlib_dir/encodings/ root/$stdlib_dir/`;
  - `codecs`: `cp $stdlib_dir/codecs.py root/$stdlib_dir/`;
  - `io`: `cp $stdlib_dir/io.py root/$stdlib_dir/`;
  - `abc`: `cp $stdlib_dir/abc.py root/$stdlib_dir/`;
  - `site`: `touch root/$stdlib_dir/site.py` (sì, va bene vuoto);
  - `resource`: dovrebbe essere `mkdir root/$stdlib_dir/lib-dynload/ && cp $stdlib_dir/lib-dynload/resource.cpython-3<versione>-x86_64-linux-gnu.so root/$stdlib_dir/lib-dynload/`;
  - `os` (per togliere il warning sul `prefix`): `touch root/$stdlib_dir/os.py` (sì, va bene vuoto).
