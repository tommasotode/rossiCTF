#!/usr/bin/env python
from subprocess import run, DEVNULL
from os import remove, rename, rmdir
from glob import glob
from hashlib import sha256
from stred import string_editing


def sh(*command: str): run(command, stdout=DEVNULL, stderr=DEVNULL, check=True)


password = "Stringus"

while True:
  sh("gpg", "-d", "--batch", "--passphrase", password, "-o", "squashed", "flag" if password == "Stringus" else "inner")
  sh("unsquashfs", "-d", "extracted", "squashed")
  remove("squashed")
  extracted = glob("extracted/")
  inner = next(f for f in glob("extracted/*") if f != "extracted/input.txt")
  if inner == "extracted/flag.txt": break

  rename(inner, "inner")

  with open("extracted/input.txt") as i:
    NMX, S, E = i
    password = sha256(bytes(string_editing(*map(int, NMX[:-1].split(" ")), S[:-1], E[:-1]), "utf-8")).hexdigest()
    print(password)

  remove("extracted/input.txt")
  rmdir("extracted")

remove("inner")
with open("extracted/flag.txt") as f: print("FLAG:", f.read())
