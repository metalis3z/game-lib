"""List remotes a client calls that have no server handler. Arg: <unpacked place>/scripts (needs ReplicatedStorage/Shared/Remotes.luau built with the Networking package)."""
import collections
import os
import re
import sys

root = sys.argv[1]  # .../scripts
remotes_file = os.path.join(root, 'ReplicatedStorage', 'Shared', 'Remotes.luau')

defs = []  # (ns, name, kind)
ns = None
for line in open(remotes_file, encoding='utf-8', errors='replace'):
    m = re.match(r'\s*t\.(\w+)\s*=', line)
    if m:
        ns = m.group(1)
    m = re.search(r'(\w+)\s*=\s*Networking\.(remoteFunction|remoteEvent|unreliableRemoteEvent)\("(\w+)"', line)
    if m and ns:
        defs.append((ns, m.group(3), m.group(2)))

server_txt, client_files = [], {}
for dp, _, fns in os.walk(root):
    for fn in fns:
        if not fn.endswith('.luau'):
            continue
        p = os.path.join(dp, fn)
        rel = os.path.relpath(p, root).replace('\\', '/')
        txt = open(p, encoding='utf-8', errors='replace').read()
        if rel.startswith('ServerScriptService/'):
            server_txt.append(txt)
        else:
            client_files[rel] = txt
server = '\n'.join(server_txt)

# aliases like: local EggWorld = Remotes.EggWorld
alias = collections.defaultdict(set)
for m in re.finditer(r'local\s+(\w+)\s*=\s*Remotes\.(\w+)\b', server):
    alias[m.group(2)].add(m.group(1))

name_count = collections.Counter(n for _, n, _ in defs)
unbound = collections.defaultdict(list)
bound = 0
for ns_, name, kind in defs:
    names = {ns_} | alias[ns_]
    pat = r'(?:' + '|'.join(map(re.escape, names)) + r')\.' + re.escape(name) + r'\.OnServer(?:Invoke|Event)'
    if re.search(pat, server):
        bound += 1
        continue
    callers = []
    cpat = re.compile(r'\.' + re.escape(name) + r'\s*:\s*(InvokeServer|FireServer)')
    for rel, txt in client_files.items():
        if cpat.search(txt):
            callers.append(rel)
    if callers:
        unbound[ns_].append((name, kind, callers, name_count[name] > 1))

total_calls = sum(len(v) for v in unbound.values())
print(f'{len(defs)} remotes defined, {bound} handled by server, {total_calls} called by client with no handler\n')
for ns_ in sorted(unbound, key=lambda k: -len(unbound[k])):
    print(f'## {ns_} ({len(unbound[ns_])})')
    for name, kind, callers, amb in unbound[ns_]:
        kind_s = 'fn ' if kind == 'remoteFunction' else 'evt'
        files = ', '.join(sorted({c.rsplit('/', 1)[-1].split('.')[0] for c in callers})[:4])
        print(f'  {kind_s} {name}{" (name shared)" if amb else ""}  <- {files}')
