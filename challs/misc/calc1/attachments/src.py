import resource
resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
resource.setrlimit(resource.RLIMIT_CPU, (3, 3))
resource.setrlimit(resource.RLIMIT_FSIZE, (0, 0))
resource.setrlimit(resource.RLIMIT_NPROC, (1, 1))
resource.setrlimit(resource.RLIMIT_AS, (64 * 1024 ** 2, 64 * 1024 ** 2))

from sympy.parsing.sympy_parser import parse_expr
parse_globals = {}
exec("from sympy import *", parse_globals)

print("Ciao, sono la PyCalcolatrice 1.0!")
print('Scrivi qui le tue espressioni da calcolare o usa "exit" per uscire')

while 2 + 2 == 4:
  try: i = input(">>> ")
  except KeyboardInterrupt as e: print(); continue
  except EOFError as e: print(); break

  if not i.strip(): continue
  if i == "exit": break

  try:
    print(parse_expr(i, transformations="all", global_dict=parse_globals))
  except BaseException as e:
    print(f"{type(e).__name__}{f': {e}' if e.args else ''}")
