import resource
resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
resource.setrlimit(resource.RLIMIT_CPU, (1, 1))
resource.setrlimit(resource.RLIMIT_FSIZE, (0, 0))
resource.setrlimit(resource.RLIMIT_NPROC, (1, 1))
resource.setrlimit(resource.RLIMIT_AS, (16 * 1024 ** 2, 16 * 1024 ** 2))

print("Ciao, sono la PyCalcolatrice 2.0!")
print('Scrivi qui le tue espressioni da calcolare o usa "exit" per uscire')

while 2 + 2 == 4:
  try: i = input(">>> ")
  except KeyboardInterrupt as e: print(); continue
  except EOFError as e: print(); break

  if not i.strip(): continue
  if i == "exit": break

  try:
    if '"' in i or "'" in i:
      raise SyntaxError("a chi mai possono servire le virgolette in matematica??")

    if "[" in i or "]" in i or "{" in i or "}" in i:
      raise NotImplementedError("per ora funzionano solo le parentesi tonde")

    print(eval(i, {"__builtins__": {}}, None))

  except BaseException as e:
    print(f"{type(e).__name__}{f': {e}' if e.args else ''}")
