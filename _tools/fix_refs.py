"""After rbxm2lua: point catalog / docs at the new .lua files for every pack that is no longer an .rbxm."""
import os
import re
import sys

ref = sys.argv[1]
games = os.path.join(ref, 'Games')
rx = re.compile(r'((?:[\w\-]+/)?(?:ui|audio|animations|materials)/[^`"\n|]*?|map/(?:lighting|materials))(?:\.rbxm|\.lua|/init\.lua)(?![\w/])')
changed = 0
for slug in os.listdir(games):
    g = os.path.join(games, slug)
    for fn in ('catalog.jsonl', 'ASSETS.md', 'README.md', 'reference.md', 'coverage.json', 'metrics.json'):
        p = os.path.join(g, fn)
        if not os.path.exists(p):
            continue
        t = open(p, encoding='utf-8').read()

        def sub(m):
            path = m.group(1)
            local = path.split('/', 1)[1] if path.startswith(slug + '/') else path
            if os.path.exists(os.path.join(g, local + '.lua')):
                return m.group(1) + '.lua'
            if os.path.exists(os.path.join(g, local, 'init.lua')):
                return m.group(1) + '/init.lua'
            return m.group(1) + '.rbxm'
        t2 = rx.sub(sub, t)
        if t2 != t:
            open(p, 'w', encoding='utf-8', newline='\n').write(t2)
            changed += 1
print(changed, 'files updated')
