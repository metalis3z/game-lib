"""Rename every unpacked script from .luau to .lua and fix the paths in the index files."""
import os
import re
import sys

ref = sys.argv[1]
n = 0
for slug in os.listdir(os.path.join(ref, 'Games')):
    src = os.path.join(ref, 'Games', slug, 'source')
    if not os.path.isdir(src):
        continue
    for root, _, files in os.walk(os.path.join(src, 'scripts')):
        for fn in files:
            if fn.endswith('.luau'):
                a = os.path.join(root, fn)
                b = a[:-5] + '.lua'
                if os.path.exists(b):  # name clash: keep both
                    b = a[:-5] + '~luau.lua'
                os.replace(a, b)
                n += 1
    for fn in os.listdir(src):
        if fn.endswith(('.txt', '.md', '.json', '.jsonl')):
            p = os.path.join(src, fn)
            t = open(p, encoding='utf-8', errors='replace').read()
            t2 = re.sub(r'\.luau\b', '.lua', t)
            if t2 != t:
                open(p, 'w', encoding='utf-8', newline='\n').write(t2)
    for fn in ('catalog.jsonl', 'ASSETS.md', 'README.md', 'reference.md'):
        p = os.path.join(ref, 'Games', slug, fn)
        if os.path.exists(p):
            t = open(p, encoding='utf-8').read()
            t2 = re.sub(r'\.luau\b', '.lua', t)
            if t2 != t:
                open(p, 'w', encoding='utf-8', newline='\n').write(t2)
p = os.path.join(ref, 'Scripts', 'catalog.jsonl')
t = open(p, encoding='utf-8').read()
open(p, 'w', encoding='utf-8', newline='\n').write(re.sub(r'\.luau\b', '.lua', t))
print(n, 'scripts renamed')
