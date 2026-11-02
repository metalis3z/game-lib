#!/usr/bin/env python3
"""build_docs: write INDEX.md, QUALITY.md and README.md for an asset library made by extract_library.py.

    python -I build_docs.py D:\\Rodev\\asset-library
"""
import collections
import json
import os
import statistics
import sys

# Games measured for the benchmark medians: finished, commercial-looking UIs.
# Small frameworks and very old places are listed but not used for the medians.
BENCH_MIN_GUI = 500


def med(vals):
    vals = [v for v in vals if isinstance(v, (int, float))]
    return round(statistics.median(vals), 2) if vals else None


def rng(vals):
    vals = sorted(v for v in vals if isinstance(v, (int, float)))
    if not vals:
        return '-'
    return f'{round(vals[0], 2)} - {round(vals[-1], 2)} (median {round(statistics.median(vals), 2)})'


def top(d, n=4):
    return ', '.join(f'{k} ({v})' for k, v in list(d.items())[:n]) if d else '-'


def sw(d, n=6):
    return ' '.join(f'`{k}`' for k in list(d.keys())[:n]) if d else '-'


def main(lib):
    metrics = json.load(open(os.path.join(lib, 'metrics.json'), encoding='utf-8'))
    cat = [json.loads(line) for line in open(os.path.join(lib, 'catalog.jsonl'), encoding='utf-8')]
    files = [e for e in cat if e.get('file')]
    by_game = collections.defaultdict(list)
    for e in files:
        by_game[e['game']].append(e)
    bench = [m for m in metrics if (m['ui'].get('gui_objects') or 0) >= BENCH_MIN_GUI]

    # ------------------------------------------------------------ INDEX.md
    L = ['# Asset library index', '',
         f'{len(metrics)} games, {len(files)} pack files, {sum(m["kb"] for m in metrics) // 1024} MB. '
         'Every pack is a binary `.rbxm` with scripts removed. Search `catalog.jsonl` (one JSON per pack) or run '
         '`python -I D:\\Rodev\\.claude\\skills\\roblox-template-library\\scripts\\find_pack.py <words>`.', '',
         '| Game | Genre | Source | UI packs | GUI objects | Models | Model sets | Loose VFX sets | KeyframeSeq | Map parts | Core size (studs) | Lighting |',
         '|---|---|---|---:|---:|---:|---:|---:|---:|---:|---|---|']
    for m in metrics:
        g = by_game[m['slug']]
        k = collections.Counter(e['kind'] for e in g)
        size = 'x'.join(str(v) for v in m['map'].get('extent_studs') or []) or '-'
        src = 'leak/copy' if 'copy' in m['provenance'] else 'full source'
        L.append(f'| [{m["title"]}]({m["slug"]}/README.md) | {m["genre"]} | {src} | {k["ui"] + k["ui-kit"]} | '
                 f'{m["ui"].get("gui_objects", 0)} | {k["model"]} | {k["model-set"]} | {k["vfx"]} | '
                 f'{m["keyframe_sequences"]} | {m["map"].get("parts", 0)} | {size} | '
                 f'{m["lighting"].get("Technology", "-")} |')
    L += ['', '## Models by tag', '', '| Tag | Packs | Games with the most |', '|---|---:|---|']
    tag_games = collections.defaultdict(collections.Counter)
    for e in files:
        for t in e['tags']:
            tag_games[t][e['game']] += 1
    for t, gc in sorted(tag_games.items(), key=lambda kv: -sum(kv[1].values())):
        L.append(f'| {t} | {sum(gc.values())} | {top(dict(gc.most_common(4)))} |')
    open(os.path.join(lib, 'INDEX.md'), 'w', encoding='utf-8').write('\n'.join(L) + '\n')

    # ------------------------------------------------------------ QUALITY.md
    Q = ['# Quality benchmarks', '',
         'Measured from the 17 places. "Benchmark" rows use the games with at least '
         f'{BENCH_MIN_GUI} GUI objects ({", ".join(m["title"] for m in bench)}). '
         'Per-game detail: `<game>/reference.md` and `<game>/metrics.json`.', '',
         '## 1. UI construction', '',
         '| Game | ScreenGuis | GUI objects | Scale-only sizes | TextScaled | UIStroke /100 | UIGradient /100 | '
         'UICorner /100 | AspectRatio /100 | ImageLabel /100 | Fonts |',
         '|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|']
    for m in metrics:
        u = m['ui']
        if not u.get('gui_objects'):
            continue
        sm = u.get('size_mode', {})
        tot = sum(sm.values()) or 1
        p = u.get('per_100_objects', {})
        Q.append(f'| {m["title"]} | {u.get("screen_guis")} | {u.get("gui_objects")} | '
                 f'{round(100 * sm.get("scale", 0) / tot)}% | {round(100 * (u.get("text_scaled_share") or 0))}% | '
                 f'{p.get("UIStroke")} | {p.get("UIGradient")} | {p.get("UICorner")} | '
                 f'{p.get("UIAspectRatioConstraint")} | {p.get("ImageLabel")} | {top(u.get("fonts", {}), 3)} |')

    def bm(key, sub=None):
        vals = []
        for m in bench:
            u = m['ui']
            if sub:
                vals.append(u.get(key, {}).get(sub))
            else:
                vals.append(u.get(key))
        return rng(vals)

    scale_share = [100 * m['ui']['size_mode'].get('scale', 0) / (sum(m['ui']['size_mode'].values()) or 1)
                   for m in bench]
    Q += ['', '**Benchmark (commercial UIs):**', '',
          f'- Scale-only sizes: {rng(scale_share)} %',
          f'- TextScaled share: {bm("text_scaled_share")}',
          f'- UIStroke per 100 GUI objects: {bm("per_100_objects", "UIStroke")}',
          f'- UIGradient per 100: {bm("per_100_objects", "UIGradient")}',
          f'- UICorner per 100: {bm("per_100_objects", "UICorner")}',
          f'- UIAspectRatioConstraint per 100: {bm("per_100_objects", "UIAspectRatioConstraint")}',
          f'- ImageLabel per 100: {bm("per_100_objects", "ImageLabel")} (art-heavy UIs are image-built, not flat frames)',
          f'- Unique UI images per game: {bm("unique_images")}', '']

    fonts = collections.Counter()
    font_games = collections.Counter()
    for m in metrics:
        for f, n in m['ui'].get('fonts', {}).items():
            fonts[f] += n
            font_games[f] += 1
    Q += ['## 2. Fonts', '', '| Font (family + weight) | Uses | Games |', '|---|---:|---:|']
    for f, n in fonts.most_common(25):
        Q.append(f'| {f} | {n} | {font_games[f]} |')

    strokes = collections.Counter()
    corners = collections.Counter()
    for m in metrics:
        for k, v in m['ui'].get('stroke_thickness', {}).items():
            strokes[k] += v
        for k, v in m['ui'].get('corner_radius', {}).items():
            corners[k] += v
    Q += ['', '## 3. Strokes and corners', '',
          'Stroke thickness (`px` = FixedSize, `scaled` = StrokeSizingMode ScaledSize, a fraction of the element):', '',
          ', '.join(f'`{k}` ×{v}' for k, v in strokes.most_common(14)), '',
          'Corner radius (`{scale,offset}`; `{1,0}` = pill/circle):', '',
          ', '.join(f'`{k}` ×{v}' for k, v in corners.most_common(14)), '',
          '## 4. Palettes', '', '| Game | Panel colours | Text colours | Stroke colours |', '|---|---|---|---|']
    for m in metrics:
        u = m['ui']
        if u.get('gui_objects'):
            Q.append(f'| {m["title"]} | {sw(u.get("background_colors", {}), 7)} | {sw(u.get("text_colors", {}), 4)} | '
                     f'{sw(u.get("stroke_colors", {}), 4)} |')

    Q += ['', '## 5. Maps and builds', '',
          '| Game | Parts | MeshPart share | Unions | Lights | Emitters | Beams+Trails | World GUIs | Prompts | '
          'Core size (studs) | Top materials |', '|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|']
    for m in metrics:
        mp = m['map']
        if not mp.get('parts'):
            continue
        share = round(100 * mp['meshparts'] / mp['parts']) if mp['parts'] else 0
        size = 'x'.join(str(v) for v in mp.get('extent_studs') or []) or '-'
        Q.append(f'| {m["title"]} | {mp["parts"]} | {share}% | {mp["unions"]} | {mp["lights"]} | {mp["emitters"]} | '
                 f'{mp["beams_trails"]} | {mp["world_guis"]} | {mp["prompts"]} | {size} | '
                 f'{top(mp.get("materials", {}), 3)} |')

    Q += ['', '## 6. Lighting and post-processing', '',
          '| Game | Technology | Brightness | Time | Ambient | Outdoor | EnvDiffuse | EnvSpecular | Exposure | '
          'Shadow softness | Post effects (enabled values) |', '|---|---|---:|---|---|---|---:|---:|---:|---:|---|']
    keys = {'Atmosphere': ('Density', 'Haze', 'Glare'), 'BloomEffect': ('Intensity', 'Size', 'Threshold'),
            'ColorCorrectionEffect': ('Brightness', 'Contrast', 'Saturation', 'TintColor'),
            'SunRaysEffect': ('Intensity', 'Spread'), 'BlurEffect': ('Size',), 'DepthOfFieldEffect': ('FarIntensity',)}
    post_vals = collections.defaultdict(list)
    for m in metrics:
        Lg = m['lighting']
        if not Lg:
            continue
        eff = []
        for p in m['post']:
            if p['class'] in keys and p['props'].get('Enabled', True):
                kv = {k: p['props'].get(k) for k in keys[p['class']] if k in p['props']}
                eff.append(p['class'].replace('Effect', '') + ' ' + ' '.join(f'{k[:4]}={v}' for k, v in kv.items()))
                if m in bench or True:
                    for k, v in kv.items():
                        post_vals[(p['class'], k)].append(v)
        Q.append(f'| {m["title"]} | {Lg.get("Technology", "-")} | {Lg.get("Brightness", "-")} | '
                 f'{Lg.get("TimeOfDay", "-")} | `{Lg.get("Ambient", "-")}` | `{Lg.get("OutdoorAmbient", "-")}` | '
                 f'{Lg.get("EnvironmentDiffuseScale", "-")} | {Lg.get("EnvironmentSpecularScale", "-")} | '
                 f'{Lg.get("ExposureCompensation", "-")} | {Lg.get("ShadowSoftness", "-")} | '
                 f'{"; ".join(eff) or "-"} |')
    Q += ['', '**Observed ranges for enabled post effects:**', '']
    for (cls, k), vals in sorted(post_vals.items()):
        if all(isinstance(v, (int, float)) for v in vals):
            Q.append(f'- {cls}.{k}: {rng(vals)} across {len(vals)}')
    techs = collections.Counter(m['lighting'].get('Technology') for m in metrics if m['lighting'])
    Q += ['', f'Technology used: {dict(techs)}', '']

    Q += ['## 7. Model library', '', '| Game | Models | Sets | Median instances / model | Median parts / model | '
          'MeshPart-heavy models | Characters | VFX | Tools+weapons |', '|---|---:|---:|---:|---:|---:|---:|---:|---:|']
    for m in metrics:
        g = [e for e in by_game[m['slug']] if e['kind'] == 'model']
        if not g:
            continue
        sets = sum(1 for e in by_game[m['slug']] if e['kind'] == 'model-set')
        meshy = sum(1 for e in g if e['parts'] and e['meshparts'] / e['parts'] >= 0.5)
        tagc = collections.Counter(t for e in g for t in e['tags'])
        Q.append(f'| {m["title"]} | {len(g)} | {sets} | {med([e["instances"] for e in g])} | '
                 f'{med([e["parts"] for e in g])} | {meshy} | {tagc["character"]} | {tagc["vfx"]} | '
                 f'{tagc["tool"] + tagc["weapon"]} |')
    Q += ['', '## 8. Lobbies, spawns and hubs', '',
          'Workspace folders or models named lobby, hub or spawn, measured as a whole (40+ parts). The matching '
          'packs are under `<game>/models/Workspace/...` with the same path.', '',
          '| Game | Path in the place | Parts | Instances | MeshParts | Emitters | Lights | World GUIs | Sounds | '
          'Size (studs) |', '|---|---|---:|---:|---:|---:|---:|---:|---:|---|']
    zones = [(m['title'], z) for m in metrics for z in m['map'].get('lobby_zones', [])]
    zones.sort(key=lambda t: -t[1]['parts'])
    for title, z in zones[:20]:
        size = 'x'.join(str(v) for v in z['size']) if z.get('size') else '-'
        Q.append(f'| {title} | `{z["path"]}` | {z["parts"]} | {z["instances"]} | {z["meshparts"]} | '
                 f'{z["emitters"]} | {z["lights"]} | {z["guis"]} | {z["sounds"]} | {size} |')
    open(os.path.join(lib, 'QUALITY.md'), 'w', encoding='utf-8').write('\n'.join(Q) + '\n')
    print('wrote INDEX.md and QUALITY.md')


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main(sys.argv[1])
