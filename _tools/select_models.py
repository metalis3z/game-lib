"""Pick the most interesting model packs of each game for preview renders.

    python -I select_models.py <references-dir> <studio-content-refshots-dir> [per_game]

Writes _tools/_shots/models.json ({slug: [{file, name, tags, ...}]}) and copies each picked
.rbxm to <content>/models/<slug>/<n>.rbxm so Studio can load it with GetObjects.
"""
import collections
import json
import os
import shutil
import sys

GOOD_TAGS = ['pet', 'character', 'weapon', 'vehicle', 'egg', 'collectible', 'accessory', 'vfx', 'tool',
             'building', 'decoration', 'nature', 'sign', 'portal', 'interior', 'treadmill', 'keyboard', 'ability']


def score(e):
    tags = set(e.get('tags') or [])
    if 'backup' in tags or e.get('dup_of') or not e.get('file'):
        return None
    size = e.get('size') or [0, 0, 0]
    big = max(size) if size else 0
    if big <= 0.2 or big > 350:
        return None
    if (e.get('parts', 0) + e.get('meshparts', 0) + e.get('unions', 0)) == 0:
        return None
    s = 0.0
    s += 4 * len(tags & set(GOOD_TAGS[:7]))
    s += 2 * len(tags & set(GOOD_TAGS[7:]))
    s += min(e.get('meshparts', 0), 30) * 0.15 + min(e.get('emitters', 0), 10) * 0.3
    s += min(e.get('instances', 0), 400) / 200
    if e.get('kind') == 'model-set':
        s -= 1
    return s


def main():
    ref, content = sys.argv[1], sys.argv[2]
    per_game = int(sys.argv[3]) if len(sys.argv) > 3 else 14
    games = os.path.join(ref, 'Games')
    out, picked_all = os.path.join(content, 'models'), {}
    if os.path.isdir(out):
        shutil.rmtree(out)
    for slug in sorted(os.listdir(games)):
        cat = os.path.join(games, slug, 'catalog.jsonl')
        if not os.path.exists(cat):
            continue
        rows = []
        for line in open(cat, encoding='utf-8'):
            e = json.loads(line)
            if e['kind'] not in ('model', 'model-set', 'vfx'):
                continue
            s = score(e)
            if s is not None:
                rows.append((s, e))
        rows.sort(key=lambda x: -x[0])
        # diversity: round-robin over the main tag
        buckets = collections.OrderedDict()
        for s, e in rows:
            key = next((t for t in GOOD_TAGS if t in (e.get('tags') or [])), 'other')
            buckets.setdefault(key, []).append(e)
        picked, names = [], set()
        while len(picked) < per_game and any(buckets.values()):
            for key in list(buckets):
                if not buckets[key]:
                    continue
                e = buckets[key].pop(0)
                nm = os.path.basename(e['file']).rsplit('.', 1)[0]
                base = nm.rstrip('0123456789_ -')
                if base in names:
                    continue
                names.add(base)
                picked.append(e)
                if len(picked) >= per_game:
                    break
        if not picked:
            continue
        gdir = os.path.join(out, slug)
        os.makedirs(gdir, exist_ok=True)
        items = []
        for i, e in enumerate(picked, 1):
            src = os.path.join(games, e['file'].replace('/', os.sep))
            if not os.path.exists(src):
                continue
            shutil.copy(src, os.path.join(gdir, f'{i}.rbxm'))
            items.append({'n': i, 'file': e['file'], 'name': os.path.basename(e['file']).rsplit('.', 1)[0],
                          'source': e.get('source'), 'tags': e.get('tags'), 'size': e.get('size'),
                          'instances': e.get('instances'), 'meshparts': e.get('meshparts'),
                          'emitters': e.get('emitters')})
        picked_all[slug] = items
    here = os.path.dirname(os.path.abspath(__file__))
    with open(os.path.join(here, '_shots', 'models.json'), 'w', encoding='utf-8') as f:
        json.dump(picked_all, f, indent=1, ensure_ascii=False)
    print(len(picked_all), 'games,', sum(len(v) for v in picked_all.values()), 'models')


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
