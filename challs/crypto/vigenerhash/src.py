import hashlib

key = "lirililarilaisbetterthantralalerotralala"
with open('challs/crypto/vigenerhash/secret.txt', "w") as f:
    for c in key:
        sha = hashlib.sha512(c.encode())
        digest = sha.hexdigest()
        f.write(digest + "\n")