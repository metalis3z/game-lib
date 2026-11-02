"""Turn the per-game data lists (animation ids, sounds, environment) from JSON into Lua modules."""
import json
import os
import re
import sys

IDENT = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')
KEYWORDS = {'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'if', 'in', 'local',
            'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while', 'continue', 'type'}


def lua(v, ind=0):
    pad, pad2 = '\t' * ind, '\t' * (ind + 1)
    if v is None:
        return 'nil'
    if isinstance(v, bool):
        return 'true' if v else 'false'
    if isinstance(v, (int, float)):
        return repr(v) if v == v else '0/0'
    if isinstance(v, str):
        return json.dumps(v, ensure_ascii=False)
    if isinstance(v, list):
        if all(isinstance(x, (int, float)) for x in v) and len(v) <= 12:
            return '{ ' + ', '.join(lua(x) for x in v) + ' }'
        return '{\n' + ''.join(f'{pad2}{lua(x, ind + 1)},\n' for x in v) + pad + '}'
    if isinstance(v, dict):
        out = []
        for k, x in v.items():
            key = k if IDENT.match(k) and k not in KEYWORDS else '[' + json.dumps(k, ensure_ascii=False) + ']'
            out.append(f'{pad2}{key} = {lua(x, ind + 1)},\n')
        return '{\n' + ''.join(out) + pad + '}'
    return json.dumps(str(v))


JOBS = [('animations/animation-ids.json', 'animations/AnimationIds.lua',
         'Every Animation instance in the place: { name, path, id }. Re-upload the KeyframeSequences you have rights to.'),
        ('audio/sounds.json', 'audio/Sounds.lua', 'Every Sound in the place: { name, path, id, volume, looped, speed }.'),
        ('map/environment.json', 'map/Environment.lua',
         'Workspace / Terrain / Lighting settings of the place (enums are raw numbers, colours are {r, g, b}).')]
ref = sys.argv[1]
n = 0
for slug in os.listdir(os.path.join(ref, 'Games')):
    g = os.path.join(ref, 'Games', slug)
    for src, dst, note in JOBS:
        p = os.path.join(g, src)
        if not os.path.exists(p):
            continue
        data = json.load(open(p, encoding='utf-8'))
        with open(os.path.join(g, dst), 'w', encoding='utf-8', newline='\n') as f:
            f.write(f'-- {slug}: {note}\n-- Generated from {src} by _tools/json2lua.py\nreturn {lua(data)}\n')
        os.remove(p)
        n += 1
    for fn in ('ASSETS.md', 'README.md', 'reference.md'):
        p = os.path.join(g, fn)
        if os.path.exists(p):
            t = open(p, encoding='utf-8').read()
            t2 = t.replace('animation-ids.json', 'AnimationIds.lua').replace('sounds.json', 'Sounds.lua') \
                  .replace('environment.json', 'Environment.lua')
            if t2 != t:
                open(p, 'w', encoding='utf-8', newline='\n').write(t2)
print(n, 'files converted')
