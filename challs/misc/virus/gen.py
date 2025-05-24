#!/usr/bin/env python
from typing import Literal
from string import ascii_letters, digits
from datetime import datetime
from random import randint, random, choice
from solution import string_editing
from os import remove, rename
from os.path import getsize
from subprocess import run, DEVNULL
from hashlib import sha256
from shutil import copyfile


sign = Literal[-1, 0, 1]
signs = tuple[sign, ...]
alphabet = ascii_letters + digits + " "
last_file = "flag.txt"
has_input = False
count = 0


def log(msg: str):
  print(f"[{datetime.now().strftime('%H:%M:%S')}] ({count * 100 // 256:3}%) {msg}")


def multigen(count: int, N: int, M_mults: tuple[int, ...], sides: signs, dirs: signs, incs: signs):
  log(f"Called multigen(count={count}, N={N}, M_mults={M_mults}, sides={sides}, dirs={dirs}, incs={incs})")
  curr = lambda t: t[i * len(t) // count]
  for i in range(count): gen(N, N // 10 * curr(M_mults), curr(sides), curr(dirs), curr(incs))


def gen(N: int, M: int, side: sign, dir: sign, inc: sign):
  global has_input
  log(f"Called gen(N={N}, M={M}, side={side}, dir={dir}, inc={inc})")

  X = randint(0, M // 2) if side == -1 else randint(N - M // 2, N) if side == 1 else randint(0, N)
  S = "".join(choice(alphabet) for _ in range(N))
  E = "".join(
    (choice(alphabet) if random() < 0.5 + inc * 0.25 else ".")
    if random() < 0.5
    else ">" if random() < 0.5 + dir * 0.25 else "<"
    for _ in range(M)
  )

  encapsulate(hash(string_editing(N, M, X, S, E)))

  with open("input.txt", "w") as f:
    print(N, M, X, file=f)
    print(S, file=f)
    print(E, file=f)
    has_input = True


def encapsulate(password: str):
  global last_file, count
  log(f"Called encapsulate(password={password!r})")

  new_file = "".join(choice(ascii_letters + digits) for _ in range(8))
  sh("mksquashfs", last_file, "input.txt" if has_input else None, "squashed")

  if has_input:
    log("Removing previous file")
    remove(last_file)

  sh("gpg", "-c", "--batch", "--passphrase", password, "-o", new_file, "squashed")
  log("Removing intermediate squashed file")
  remove("squashed")
  log(f"Current file size is {getsize(new_file) / 1048576:.4f} MB")
  last_file = new_file
  count += 1


def sh(*command: str):
  filtered = [arg for arg in command if arg is not None]
  log(f"Executing: {' '.join(filtered)}")
  run(filtered, stdout=DEVNULL, check=True)


def hash(output: str):
  return sha256(bytes(output, "utf-8")).hexdigest()


log("Starting")
multigen(1, 10_000_000, (10,), (0,), (0,), (-1,))
multigen(2, 5_000_000, (20, 10), (0,), (0,), (-1, 1))
multigen(5, 2_000_000, (25, 10), (0, 1, 1, -1, -1), (0, 1, 1, -1, -1), (1, -1, 1, -1, 1))
multigen(4, 1_000_000, (20, 20, 10, 5), (0,), (0,), (0,))
multigen(2, 500_000, (20, 10), (1,), (1,), (0,))
multigen(2, 200_000, (25, 10), (-1,), (-1,), (0,))
multigen(8, 100_000, (20, 20, 10, 5), (0,), (0,), (-1, 0, 0, 1))
multigen(4, 50_000, (20, 20, 10, 4), (1,), (1,), (-1, 0, 0, 1))
multigen(4, 20_000, (25, 25, 10, 5), (-1,), (-1,), (-1, 0, 0, 1))
multigen(16, 10_000, (20, 20, 10, 5), (0, 1), (0, 0, 1, -1), (-1, 0, 0, 1) * 4)
multigen(8, 5_000, (20, 20, 10, 4), (0,), (1, -1), (-1, 0, 0, 1) * 2)
multigen(8, 2_000, (25, 25, 10, 5), (-1,), (1, -1), (-1, 0, 0, 1) * 2)
multigen(32, 1_000, (20, 20, 10, 5), (0, 1), (0, 0, 1, -1), (-1, 0, 0, 1) * 4)
multigen(16, 500, (20, 20, 10, 4), (0,), (1, -1), (-1, 0, 0, 1) * 2)
multigen(16, 200, (25, 25, 10, 5), (-1,), (1, -1), (-1, 0, 0, 1) * 2)
multigen(64, 100, (20, 20, 10, 5), (0, 1), (0, 0, 1, -1), (-1, 0, 0, 1) * 4)
multigen(32, 50, (20, 20, 10, 4), (0,), (1, -1), (-1, 0, 0, 1) * 2)
multigen(23, 20, (25, 25, 10, 5), (-1,), (1, -1), (-1, 0, 0, 1) * 2)

for i in range(7, -1, -1):
  log(f"Copying manual/input{i}.txt to input.txt")
  copyfile(f"manual/input{i}.txt", "input.txt")
  log(f"Reading manual/output{i}.txt")
  with open(f"manual/output{i}.txt") as f: output = f.read()[:-1]
  encapsulate(hash(output))

encapsulate("Stringus")
log("Deleting last encapsulated input.txt")
remove("input.txt")
log(f"Renaming {last_file} to flag")
rename(last_file, "flag")
log("Done")
