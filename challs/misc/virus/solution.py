from collections import deque


def string_editing(N, M, X, S, E):
  l, r = deque(S[:X]), deque(S[X:])

  for c in E:
    try:
      match c:
        case '>': l.append(r.popleft())
        case '<': r.appendleft(l.pop())
        case '.': l.pop()
        case _: l.append(c)
    except IndexError: pass

  return ''.join(l) + ''.join(r)


# N, M, X = map(int, input().split())
# S, E = input(), input()
# print(string_editing(N, M, X, S, E))
