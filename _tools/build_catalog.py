"""Write the reference catalog: README.md, UI-GALLERY.md, MODELS.md, STYLE.md and Games/<slug>/README.md.

    python -I build_catalog.py <references-dir>

Inputs: Games/<slug>/{metrics.json, catalog.jsonl, screenshots/, source/}, Scripts/ (curated),
_tools/_shots/models.json. Thumbnails go to Games/<slug>/screenshots/thumbs/.
"""
import collections
import hashlib
import json
import os
import re
import sys
import urllib.parse

from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from games import GAMES  # noqa: E402

REF = sys.argv[1]
GAMES_DIR = os.path.join(REF, 'Games')
HERE = os.path.dirname(os.path.abspath(__file__))
BY_SLUG = {v[0]: {'slug': v[0], 'title': v[1], 'genre': v[2], 'category': v[3], 'file': k + ('.rbxm' if 'pack' in v[2] and 'model' in v[2] and k.startswith(('100 ', 'Forest', 'TRADE')) else '.rbxl')}
           for k, v in GAMES.items()}
CAT_ORDER = ['Brainrot', 'Simulator', 'RNG', 'Tycoon', 'Horror', 'Shooter', 'Fighting', 'Obby', 'Party',
             'Roleplay', 'Social', 'Driving', 'Sandbox', 'System', 'Model Pack']
CAT_EMOJI = {'Brainrot': '🧠', 'Simulator': '⛏️', 'RNG': '🎲', 'Tycoon': '🏭', 'Horror': '👻', 'Shooter': '🔫',
             'Fighting': '🥊', 'Obby': '🧗', 'Party': '🎉', 'Roleplay': '🏙️', 'Social': '💬', 'Driving': '🚗',
             'Sandbox': '🧱', 'System': '⚙️', 'Model Pack': '📦'}

UI_TYPES = [
    ('Shop & Robux store', r'shop|store|robux|gamepass|pass(es)?\b|product|buy|purchase|merchant|offer|bundle|deal|premium|vip|starter'),
    ('Inventory / backpack / pets', r'inventor|backpack|bag\b|pets?\b|storage|hotbar|equip|loadout|items?\b|collection'),
    ('Index / codex / glossary', r'index|codex|glossary|bestiary|catalog|album'),
    ('Rewards, daily, spin, codes', r'reward|daily|gift|spin|wheel|calendar|codes?\b|redeem|chest|streak|playtime|claim|offline'),
    ('Quests & progression', r'quest|mission|task|achiev|battlepass|season|level|xp\b|progress|rebirth|ascen|prestige|upgrade'),
    ('Trading', r'trade|trading'),
    ('Settings & menus', r'setting|option|menu|pause|lobby|play\b|title|main ?menu|credits?'),
    ('Popups, notifications, prompts', r'popup|notif|toast|prompt|confirm|warning|alert|message|announce|dialog|hint|tip'),
    ('Loading & intro', r'loading|intro|splash|transition|fade'),
    ('Leaderboards & stats', r'leader|ranking|stats?\b|scoreboard|top\d*'),
    ('End of round, death, results', r'death|dead|respawn|result|victory|defeat|win|lose|gameover|end'),
    ('Crafting, fusing, machines', r'craft|fuse|fusion|machine|forge|merge|evolve|mutat|enchant'),
    ('Admin panels', r'admin|panel|cmd|command|console|mod\b'),
    ('HUD & currency', r'hud|main|top|bottom|left|right|currency|coins?|cash|money|gems?|health|stamina|bar'),
    ('Character / avatar / emotes', r'avatar|outfit|emote|character|skin|customi'),
    ('Map vote / teams / matchmaking', r'vote|team|queue|match|lobby|round|timer|countdown|duel'),
]
UI_RES = [(t, re.compile(p, re.I)) for t, p in UI_TYPES]


def rel(path, start=REF):
    return os.path.relpath(path, start).replace('\\', '/')


def link(path, start=REF):
    return urllib.parse.quote(rel(path, start))


def load_json(p, default=None):
    try:
        return json.load(open(p, encoding='utf-8'))
    except Exception:
        return default


def words(s):
    return re.sub(r'([a-z])([A-Z])', r'\1 \2', s or '')


def ui_type(gui, panel):
    txt = f'{words(panel)} {words(gui)}'
    last = words(panel.split('.')[-1]) if panel else words(gui)
    for t, rx in UI_RES:  # the panel's own name decides first
        if rx.search(last):
            return t
    for t, rx in UI_RES:
        if rx.search(txt):
            return t
    return 'Other'


def thumb(src, dst, w=480):
    if os.path.exists(dst) and os.path.getmtime(dst) >= os.path.getmtime(src):
        return
    im = Image.open(src).convert('RGB')
    if im.width > w:
        im = im.resize((w, int(im.height * w / im.width)), Image.LANCZOS)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    im.save(dst, 'JPEG', quality=82, optimize=True)


def collect_shots(slug):
    sdir = os.path.join(GAMES_DIR, slug, 'screenshots')
    meta = load_json(os.path.join(sdir, '_shots.json'), {}) or {}
    shots, seen = [], set()
    for s in meta.get('shots', []):
        full = os.path.join(sdir, s['file'] + '.jpg')
        if not os.path.exists(full):
            continue
        h = hashlib.md5(open(full, 'rb').read()).hexdigest()
        if h in seen:  # identical frame (duplicate GUI copies)
            continue
        seen.add(h)
        crop = os.path.join(sdir, 'crops', s['file'] + '.jpg')
        best = crop if os.path.exists(crop) else full
        th = os.path.join(sdir, 'thumbs', s['file'] + '.jpg')
        thumb(best, th)
        panel = s.get('panel', '')
        if panel.startswith(s.get('gui', '') + '.'):
            panel = panel[len(s.get('gui', '')) + 1:]
        s['panel'] = panel
        shots.append({'file': s['file'], 'gui': s.get('gui', ''), 'panel': panel,
                      'full': full, 'crop': crop if os.path.exists(crop) else None, 'thumb': th,
                      'type': ui_type(s.get('gui', ''), s.get('panel', '')),
                      'weight': os.path.getsize(best)})
    models = []
    mdir = os.path.join(sdir, 'models')
    mm = (load_json(os.path.join(HERE, '_shots', 'models.json'), {}) or {}).get(slug, [])
    by_n = {m['n']: m for m in mm}
    if os.path.isdir(mdir):
        for fn in sorted(os.listdir(mdir)):
            if not fn.endswith('.jpg'):
                continue
            n = int(fn.split('_', 1)[0])
            info = by_n.get(n, {})
            th = os.path.join(sdir, 'thumbs', 'models', fn)
            thumb(os.path.join(mdir, fn), th, 360)
            models.append({'img': os.path.join(mdir, fn), 'thumb': th, **info})
    return shots, models


def cover(shots):
    pref = ['Shop & Robux store', 'Inventory / backpack / pets', 'Rewards, daily, spin, codes', 'Index / codex / glossary']
    for t in pref:
        c = [s for s in shots if s['type'] == t and s['crop']]
        if c:
            return max(c, key=lambda s: s['weight'])
    return max(shots, key=lambda s: s['weight']) if shots else None


def gallery(items, cols, start, cap=lambda s: s['file'], target=lambda s: s['full'], img=lambda s: s['thumb']):
    out = ['<table>']
    w = 100 // cols
    for i in range(0, len(items), cols):
        out.append('<tr>')
        for s in items[i:i + cols]:
            out.append(f'<td width="{w}%" valign="top"><a href="{link(target(s), start)}"><img src="{link(img(s), start)}" '
                       f'width="100%"></a><br><sub>{cap(s)}</sub></td>')
        out.append('</tr>')
    out.append('</table>')
    return '\n'.join(out)


def flags_summary(slug):
    p = os.path.join(GAMES_DIR, slug, 'source', 'flags.txt')
    if not os.path.exists(p):
        return 0, 0, []
    t = open(p, encoding='utf-8', errors='replace').read()
    high = re.findall(r'^\[HIGH\] (\S.*?) lines', t, re.M)
    med = re.findall(r'^\[MED\]', t, re.M)
    return len(high), len(med), high[:8]


def scripts_for(slug, catalog):
    rows = [r for r in catalog if r['game'] == slug and not r['dup_of'] and not r['high_flag']
            and not r['obfuscated']]
    best = {}
    for r in rows:
        for c, s in r['cats'].items():
            best.setdefault(c, []).append((s + r['quality'], r))
    out = {}
    for c, lst in best.items():
        lst.sort(key=lambda x: -x[0])
        out[c] = [r for _, r in lst[:5]]
    return out


CAT_TITLES = {}


def game_readme(g, shots, models, metrics, catalog, curated):
    slug = g['slug']
    gdir = os.path.join(GAMES_DIR, slug)
    ui = metrics.get('ui', {}) or {}
    src_readme = os.path.join(gdir, 'source', 'README.md')
    nscripts = nlines = 0
    if os.path.exists(src_readme):
        m = re.search(r'(\d+) scripts \((\d+) lines\)', open(src_readme, encoding='utf-8').read())
        if m:
            nscripts, nlines = int(m.group(1)), int(m.group(2))
    packs = metrics.get('packs', {}) or {}
    high, med, high_list = flags_summary(slug)
    L = [f'# {g["title"]}', '',
         f'> {CAT_EMOJI.get(g["category"], "")} **{g["category"]}** · {g["genre"]} · source file `{metrics.get("source_file", "")}`', '',
         f'[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · '
         f'[Scripts](source/scripts/) · [Code analysis](source/README.md)', '']
    c = cover(shots)
    if c:
        L += [f'<img src="{link(c["crop"] or c["full"], gdir)}" width="70%">', '']
    L += ['## At a glance', '', '| | |', '|---|---|',
          f'| Provenance | {metrics.get("provenance", "?")} |',
          f'| Screens | {ui.get("screen_guis", 0)} ScreenGuis, {ui.get("gui_objects", 0)} GUI objects → **{len(shots)} screenshots** |',
          f'| Models (.rbxm) | {packs.get("model", 0)} models, {packs.get("model-set", 0)} model sets, {packs.get("vfx", 0)} VFX sets |',
          f'| Lua builders (.lua) | {packs.get("ui", 0) + packs.get("ui-kit", 0)} UI screens, '
          f'{packs.get("animations", 0) + packs.get("keyframes", 0)} animation packs, {packs.get("audio", 0)} audio packs |',
          f'| Code | {nscripts} scripts, {nlines:,} lines |',
          f'| Asset ids | {metrics.get("animation_ids", 0)} animations, {metrics.get("sound_ids", 0)} sounds |',
          f'| Safety scan | {high} HIGH / {med} MED flags ([flags.txt](source/flags.txt)) |', '']
    fonts = list((ui.get('fonts') or {}).items())[:5]
    if fonts:
        L += ['**Fonts:** ' + ', '.join(f'`{k}`×{v}' for k, v in fonts), '']
    if shots:
        L += ['## UI screenshots', '',
              'Captured in Studio from the place\'s own ScreenGuis (scripts stripped). Each panel was opened on its own; '
              'click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.', '']
        by_t = collections.defaultdict(list)
        for s in shots:
            by_t[s['type']].append(s)
        order = [t for t, _ in UI_TYPES] + ['Other']
        for t in order:
            if t not in by_t:
                continue
            L += [f'### {t}', '', gallery(by_t[t], 3, gdir,
                                         cap=lambda s: f'<b>{s["gui"]}</b>{" › " + s["panel"] if s["panel"] else ""}'), '']
    if models:
        L += ['## Model previews', '', gallery(models, 4, gdir, cap=lambda m: f'<b>{m.get("name", "")}</b><br>'
                                                f'<code>{m.get("file", "").split("/", 1)[-1]}</code>',
                                                target=lambda m: os.path.join(GAMES_DIR, m['file']) if m.get('file') else m['img']), '']
    sc = scripts_for(slug, catalog)
    if sc:
        L += ['## Notable scripts', '', 'Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).', '',
              '| Topic | Scripts |', '|---|---|']
        for cat in CAT_TITLES:
            if cat in sc:
                cells = '<br>'.join(f'[`{r["name"]}`]({link(os.path.join(gdir, "source", "scripts", r["path"]), gdir)}) '
                                    f'<sub>{r["lines"]} lines</sub>' for r in sc[cat])
                L.append(f'| {CAT_TITLES[cat]} | {cells} |')
        L.append('')
    mine = [c for c in curated if c['game'] == slug]
    if mine:
        L += ['### In the curated script library', '']
        L += [f'- [{c["title"]}]({link(c["path"], gdir)}) — {c["desc"]}' for c in mine]
        L.append('')
    if high_list:
        L += ['## ⚠️ Safety', '', 'HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:', '']
        L += [f'- `{h}`' for h in high_list]
        L.append('')
    L += ['## Folders', '', '| Folder | What |', '|---|---|',
          '| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |',
          '| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |',
          '| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |',
          '| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |',
          '| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |',
          '| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |', '']
    open(os.path.join(gdir, 'README.md'), 'w', encoding='utf-8').write('\n'.join(L))


def load_curated():
    """Merge Scripts/curated/*.json (one per topic) into Scripts/curated.json; keep entries whose file exists."""
    out = []
    sdir = os.path.join(REF, 'Scripts')
    cdir = os.path.join(sdir, 'curated')
    idx = []
    if os.path.isdir(cdir):
        for fn in sorted(os.listdir(cdir)):
            if fn.endswith('.json'):
                idx += load_json(os.path.join(cdir, fn), []) or []
    else:
        idx = load_json(os.path.join(sdir, 'curated.json'), []) or []
    for c in idx:
        c['path'] = os.path.join(sdir, c['file'].replace('/', os.sep))
        if os.path.exists(c['path']):
            out.append(c)
    with open(os.path.join(sdir, 'curated.json'), 'w', encoding='utf-8') as f:
        json.dump([{k: v for k, v in c.items() if k != 'path'} for c in out], f, indent=1, ensure_ascii=False)
    return out


def write_scripts_readme(curated, summary):
    sdir = os.path.join(REF, 'Scripts')
    folders = sorted(d for d in os.listdir(sdir) if re.match(r'^\d\d-', d))
    by_folder = collections.defaultdict(list)
    for c in curated:
        by_folder[c['file'].split('/')[0]].append(c)
    n_pat = sum(1 for c in curated if '/_patterns/' in c['file'])
    titles = {GAMES_T: t for GAMES_T, t in ((v[0], v[1]) for v in GAMES.values())}
    L = ['# 📜 Script library', '', '[⬅ Back to the catalog](../README.md)', '',
         f'**{len(curated)} curated `.lua` files** in {len(folders)} topics: {len(curated) - n_pat} real scripts copied from the games '
         f'(code unchanged, a header says where each came from) and {n_pat} clean `_patterns/` modules written from the best techniques. '
         'Every folder has its own README with reuse notes. Nothing flagged as a backdoor, decompiled or obfuscated was copied.', '',
         '- `Libraries/` — clean copies of the open-source modules the games ship (see the table at the bottom).',
         '- `catalog.jsonl` — every one of the ~10k scored scripts across all games (game, path, topics, score), for searching.',
         '- The full code of every game is in `Games/<game>/source/scripts/`.', '',
         '| # | Topic | Files | Patterns |', '|---|---|---:|---:|']
    for d in folders:
        items = by_folder.get(d, [])
        pats = sum(1 for c in items if '/_patterns/' in c['file'])
        L.append(f'| {d[:2]} | [{d[3:].replace("-", " ")}]({urllib.parse.quote(d)}/README.md) | {len(items)} | {pats} |')
    L.append('')
    for d in folders:
        items = by_folder.get(d, [])
        if not items:
            continue
        items.sort(key=lambda c: (0 if '/_patterns/' in c['file'] else 1, c['title'].lower()))
        L += [f'## {d[3:].replace("-", " ")}', '', f'[Folder README]({urllib.parse.quote(d)}/README.md)', '',
              '| File | From | What it does |', '|---|---|---|']
        for c in items:
            name = c['file'].split('/', 1)[1]
            src = 'pattern' if c['game'] == 'pattern' else f'[{titles.get(c["game"], c["game"])}](../Games/{c["game"]}/README.md)'
            desc = c.get('desc', '').replace('|', '\\|').replace('\n', ' ')
            L.append(f'| [`{name}`]({urllib.parse.quote(c["file"])}) — {c["title"]} | {src} | {desc} |')
        L.append('')
    libs = load_json(os.path.join(sdir, 'libraries.json'), {}) or {}
    if libs:
        L += ['## Libraries', '', 'Open-source modules found in the games. One clean copy each (the largest version found).', '',
              '| Library | Used by | Copied from |', '|---|---:|---|']
        for k, v in sorted(libs.items(), key=lambda kv: (not kv[1].get('clean', True), -len(kv[1]['games']))):
            if v.get('clean', True):
                L.append(f'| [`{k}`](Libraries/{urllib.parse.quote(k)}/) | {len(v["games"])} games | `{v["copied_from"]}` |')
            else:
                L.append(f'| `{k}` | {len(v["games"])} games | not copied: only decompiled copies found, get it from {v["get_it_from"]} |')
        L.append('')
    open(os.path.join(sdir, 'README.md'), 'w', encoding='utf-8').write('\n'.join(L))


def main():
    global CAT_TITLES
    summary = load_json(os.path.join(REF, 'Scripts', '_summary.json'), {}) or {}
    CAT_TITLES = {k: v['title'] for k, v in summary.items()}
    catalog = []
    cp = os.path.join(REF, 'Scripts', 'catalog.jsonl')
    if os.path.exists(cp):
        catalog = [json.loads(line) for line in open(cp, encoding='utf-8')]
    curated = load_curated()
    games = []
    for slug in sorted(os.listdir(GAMES_DIR)):
        gdir = os.path.join(GAMES_DIR, slug)
        if not os.path.isdir(gdir) or slug not in BY_SLUG:
            continue
        g = dict(BY_SLUG[slug])
        metrics = load_json(os.path.join(gdir, 'metrics.json'), {}) or {}
        # the extractor's README becomes ASSETS.md
        old = os.path.join(gdir, 'README.md')
        assets = os.path.join(gdir, 'ASSETS.md')
        if os.path.exists(old) and not os.path.exists(assets) and                 open(old, encoding='utf-8').read().find('## What is here') >= 0:
            os.replace(old, assets)
        shots, models = collect_shots(slug)
        game_readme(g, shots, models, metrics, catalog, curated)
        g.update(metrics=metrics, shots=shots, models=models, cover=cover(shots))
        games.append(g)
        print(f'{slug}: {len(shots)} shots, {len(models)} models', flush=True)
    write_main(games, curated, summary)
    write_scripts_readme(curated, summary)
    write_ui_gallery(games)
    write_models(games)
    write_style(games)


def badge(label, value, color):
    return (f'<img src="https://img.shields.io/badge/{urllib.parse.quote(label)}-{urllib.parse.quote(str(value))}-{color}'
            f'?style=for-the-badge">')


def write_main(games, curated, summary):
    n_shots = sum(len(g['shots']) for g in games)
    n_models = sum(len(g['models']) for g in games)
    n_scripts = sum((g['metrics'].get('ui') and 0) or 0 for g in games)
    total_scripts = 0
    for g in games:
        p = os.path.join(GAMES_DIR, g['slug'], 'source', 'README.md')
        if os.path.exists(p):
            m = re.search(r'(\d+) scripts \((\d+) lines\)', open(p, encoding='utf-8').read())
            if m:
                total_scripts += int(m.group(1))
    L = ['<div align="center">', '', '# 🧱 Godspeed Roblox References', '',
         '### UI, models, assets and scripts from every place file in Downloads, unpacked and screenshotted', '',
         ' '.join([badge('games', len(games), '2ea44f'), badge('UI screenshots', n_shots, '1f6feb'),
                   badge('model previews', n_models, 'a371f7'), badge('scripts', f'{total_scripts:,}', 'f0883e'),
                   badge('curated lua', len(curated), 'd29922')]), '',
         '[Games](#-games) · [UI gallery by type](UI-GALLERY.md) · [Model previews](MODELS.md) · '
         '[Script library](Scripts/README.md) · [UI style numbers](STYLE.md) · [How it was made](#-how-it-was-made)', '',
         '</div>', '', '---', '',
         '## 📸 Gallery', '', 'One cover screen per game (the richest shop / inventory / reward panel). Click for the game page.', '']
    with_cover = [g for g in games if g['cover']]
    order = {c: i for i, c in enumerate(CAT_ORDER)}
    with_cover.sort(key=lambda g: (order.get(g['category'], 99), g['title']))
    L.append(gallery(with_cover, 3, REF, cap=lambda g: f'<b>{g["title"]}</b> — {g["genre"]}',
                     target=lambda g: os.path.join(GAMES_DIR, g['slug'], 'README.md'),
                     img=lambda g: g['cover']['thumb']))
    L += ['', '---', '', '## 🎮 Games', '',
          'Every place file, grouped by genre. *Screens* = screenshots taken, *Models* = .rbxm model packs, '
          '*Scripts* = scripts in `source/`. ⚠️ = HIGH safety flags (backdoor-like code) — read the game page first.', '']
    by_cat = collections.defaultdict(list)
    for g in games:
        by_cat[g['category']].append(g)
    for cat in CAT_ORDER:
        if cat not in by_cat:
            continue
        L += [f'### {CAT_EMOJI.get(cat, "")} {cat}', '',
              '| Game | Genre | Screens | UI packs | Models | Scripts | Highlights |', '|---|---|---:|---:|---:|---:|---|']
        for g in sorted(by_cat[cat], key=lambda g: g['title']):
            m = g['metrics']
            packs = m.get('packs', {}) or {}
            p = os.path.join(GAMES_DIR, g['slug'], 'source', 'README.md')
            ns = '?'
            if os.path.exists(p):
                mm = re.search(r'(\d+) scripts \((\d+) lines\)', open(p, encoding='utf-8').read())
                ns = mm.group(1) if mm else '?'
            high, _, _ = flags_summary(g['slug'])
            types = collections.Counter(s['type'] for s in g['shots'])
            hl = ', '.join(t.split(' ')[0] for t, _ in types.most_common(4))
            name = f'[{g["title"]}](Games/{g["slug"]}/README.md)' + (' ⚠️' if high else '')
            L.append(f'| {name} | {g["genre"]} | {len(g["shots"])} | {packs.get("ui", 0)} | '
                     f'{packs.get("model", 0) + packs.get("model-set", 0)} | {ns} | {hl} |')
        L.append('')
    L += ['---', '', '## 📜 Script library', '',
          f'[`Scripts/`](Scripts/README.md) holds hand-picked `.lua` files from all games, sorted by topic, plus '
          f'clean copies of the open-source libraries the games ship ([`Scripts/Libraries`](Scripts/Libraries/)).', '',
          '| Topic | Curated | Candidates scanned |', '|---|---:|---:|']
    cur_by = collections.Counter(c['category'] for c in curated)
    for k, v in summary.items():
        L.append(f'| {v["title"]} | {cur_by.get(k, 0)} | {v["pool"]} |')
    L += ['', '---', '', '## 🛠 How it was made', '',
          '1. **Unpack** — `_tools/rbxdump.py` reads each binary `.rbxl/.rbxm` (LZ4 / ZSTD chunks) and writes every script, '
          'the instance tree, UI layout, remotes, asset ids and a safety scan to `Games/<game>/source/`.',
          '2. **Export** — `_tools/extract_library.py` cuts models and the map into script-free `.rbxm` packs; `_tools/rbxm2lua.luau` turns '
          'every non-model pack (UI, audio, animations, lighting, materials) into a Lua builder and `_tools/json2lua.py` turns the id lists into Lua tables. All scripts are `.lua`.',
          '3. **Screenshot** — `_tools/make_screens.py` packs every ScreenGui; `_tools/RefShot.luau` runs inside Roblox Studio, '
          'opens each screen and hidden / off-screen panel one at a time and captures it with `CaptureService`; '
          '`_tools/shot_server.py` saves the frames and panel crops. Models are previewed the same way on a baseplate.',
          '4. **Scripts** — `_tools/classify_scripts.py` scores all scripts by topic; the best were reviewed by hand into `Scripts/`.',
          '5. **Catalog** — `_tools/build_catalog.py` writes these pages.', '',
          '> These files come from shared / leaked places. Use them as **study references**: rebuild UI in your own style, '
          're-upload animations and audio you have rights to, and never ship code flagged HIGH without reading it.', '']
    open(os.path.join(REF, 'README.md'), 'w', encoding='utf-8').write('\n'.join(L))


def write_ui_gallery(games):
    by_t = collections.defaultdict(list)
    for g in games:
        for s in g['shots']:
            if s['panel'] or s['type'] != 'Other':
                by_t[s['type']].append((g, s))
    L = ['# 🖼️ UI gallery by type', '', '[⬅ Back](README.md)', '',
         'Every captured panel from every game, grouped by what the screen is for. Click a thumbnail for the full frame.', '']
    order = [t for t, _ in UI_TYPES] + ['Other']
    L += [' · '.join(f'[{t} ({len(by_t[t])})](#{re.sub(r"[^a-z0-9 -]", "", t.lower()).replace(" ", "-")})'
                     for t in order if by_t[t]), '']
    for t in order:
        items = by_t[t]
        if not items:
            continue
        items.sort(key=lambda gs: -gs[1]['weight'])
        L += [f'## {t}', '']
        L.append(gallery([dict(s, g=g) for g, s in items], 4, REF,
                         cap=lambda s: f'<b>{s["g"]["title"]}</b><br>{s["gui"]}{" › " + s["panel"] if s["panel"] else ""}'))
        L.append('')
    open(os.path.join(REF, 'UI-GALLERY.md'), 'w', encoding='utf-8').write('\n'.join(L))


def write_models(games):
    L = ['# 🧊 Model previews', '', '[⬅ Back](README.md)', '',
         'Up to 14 hand-picked-by-score models per game (pets, characters, weapons, vehicles, buildings, props, VFX), '
         'rendered in Studio. Click to open the `.rbxm` (drag it into Studio to insert).', '']
    for g in games:
        if not g['models']:
            continue
        L += [f'## [{g["title"]}](Games/{g["slug"]}/README.md)', '',
              gallery(g['models'], 5, REF, cap=lambda m: f'<b>{m.get("name", "")}</b><br><sub>{", ".join(m.get("tags") or [])}</sub>',
                      target=lambda m: os.path.join(GAMES_DIR, m['file']) if m.get('file') else m['img']), '']
    open(os.path.join(REF, 'MODELS.md'), 'w', encoding='utf-8').write('\n'.join(L))


def write_style(games):
    L = ['# 🎨 UI style numbers', '', '[⬅ Back](README.md)', '',
         'Measured from each place\'s GUI objects. Use these as targets when matching a genre\'s look. '
         'Per-game details (colours, strokes, corner radii, lighting) are in each game\'s `reference.md`.', '',
         '| Game | GUI objects | Top fonts | UIStroke / 100 | UICorner / 100 | UIGradient / 100 | Images / 100 | TextScaled |',
         '|---|---:|---|---:|---:|---:|---:|---:|']
    rows = []
    for g in games:
        ui = g['metrics'].get('ui') or {}
        n = ui.get('gui_objects') or 0
        if n < 50:
            continue
        cl = ui.get('classes') or {}
        per = lambda k: round(100 * cl.get(k, 0) / n, 1)  # noqa: E731
        fonts = ', '.join(list((ui.get('fonts') or {}).keys())[:3])
        ts = ui.get('text_scaled_share') or ui.get('textscaled_share') or ''
        rows.append((n, f'| [{g["title"]}](Games/{g["slug"]}/reference.md) | {n} | {fonts} | {per("UIStroke")} | '
                        f'{per("UICorner")} | {per("UIGradient")} | {per("ImageLabel") + per("ImageButton")} | {ts} |'))
    rows.sort(key=lambda r: -r[0])
    L += [r for _, r in rows]
    open(os.path.join(REF, 'STYLE.md'), 'w', encoding='utf-8').write('\n'.join(L) + '\n')


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
