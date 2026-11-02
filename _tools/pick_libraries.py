"""Copy one clean version of each open-source library found in the games into Scripts/Libraries.

    python -I pick_libraries.py <references-dir>

A copy counts as clean when neither the module nor any module under it carries a decompiler /
saveinstance header or a HIGH safety flag. Among clean copies the largest wins. Libraries that
only exist as decompiled copies are listed in libraries.json with "clean": false and not copied.
"""
import json
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from classify_scripts import LIB_RES, lua_name  # noqa: E402
from rbxdump import DECOMP_RE, scan_source  # noqa: E402

OFFICIAL = {
    'Knit': 'github.com/Sleitnick/Knit', 'Promise': 'github.com/evaera/roblox-lua-promise',
    'Signal': 'github.com/stravant/goodsignal or Sleitnick/RbxUtil', 'Janitor': 'github.com/howmanysmall/Janitor',
    'Trove': 'github.com/Sleitnick/RbxUtil', 'Comm': 'github.com/Sleitnick/RbxUtil',
    'Component': 'github.com/Sleitnick/RbxUtil', 'Timer': 'github.com/Sleitnick/RbxUtil',
    'Streamable': 'github.com/Sleitnick/RbxUtil', 'EnumList': 'github.com/Sleitnick/RbxUtil',
    'Option': 'github.com/Sleitnick/RbxUtil', 'Input': 'github.com/Sleitnick/RbxUtil', 'Shake': 'github.com/Sleitnick/RbxUtil',
    'TableUtil': 'github.com/Sleitnick/RbxUtil', 'Spring': 'github.com/Quenty/NevermoreEngine (Spring)',
    'Vide': 'github.com/centau/vide', 'Charm': 'github.com/littensy/charm', 'Warp': 'github.com/imezx/Warp',
    'Satchel': 'github.com/RyanLua/Satchel', 'SimplePath': 'github.com/grayzcale/simplepath',
    'Lightning': 'devforum: LightningBolt module by Quasiduck', 'BezierTweens': 'devforum: BezierTweens',
    'RichText': 'devforum: RichText markup module', 'ShimmerModule': 'devforum: Shimmer module',
}


def dirty(text):
    return bool(DECOMP_RE.search(text[:600])) or 'Saved by' in text[:400] or \
        any(lv == 'HIGH' for lv, _, _ in scan_source(text))


def main():
    ref = sys.argv[1]
    out = os.path.join(ref, 'Scripts', 'Libraries')
    found = {}
    for slug in sorted(os.listdir(os.path.join(ref, 'Games'))):
        sdir = os.path.join(ref, 'Games', slug, 'source', 'scripts')
        for root, _, files in os.walk(sdir):
            for fn in files:
                name, _ = lua_name(fn)
                for lib, rx in LIB_RES.items():
                    if rx.match(name):
                        fp = os.path.join(root, fn)
                        if os.path.getsize(fp) > 300:
                            found.setdefault(lib, []).append((slug, fp, name))
    if os.path.isdir(out):
        shutil.rmtree(out)
    info = {}
    for lib, items in sorted(found.items()):
        clean = []
        for slug, fp, name in items:
            kids = os.path.join(os.path.dirname(fp), name)
            files = [fp] + [os.path.join(r, f) for r, _, fs in os.walk(kids) for f in fs] if os.path.isdir(kids) else [fp]
            if any(dirty(open(f, encoding='utf-8', errors='replace').read()) for f in files):
                continue
            clean.append((sum(os.path.getsize(f) for f in files), slug, fp, name, kids))
        games = sorted({s for s, _, _ in items})
        if not clean:
            info[lib] = {'clean': False, 'games': games, 'get_it_from': OFFICIAL.get(lib, 'its official source')}
            continue
        clean.sort(reverse=True)
        _, slug, fp, name, kids = clean[0]
        ldir = os.path.join(out, lib)
        os.makedirs(ldir, exist_ok=True)
        shutil.copy(fp, os.path.join(ldir, name + '.lua'))
        if os.path.isdir(kids):
            shutil.copytree(kids, os.path.join(ldir, name))
        info[lib] = {'clean': True, 'games': games,
                     'copied_from': f'{slug}/' + os.path.relpath(fp, os.path.join(ref, 'Games', slug, 'source', 'scripts')).replace('\\', '/')}
    with open(os.path.join(ref, 'Scripts', 'libraries.json'), 'w', encoding='utf-8') as f:
        json.dump(info, f, indent=1, ensure_ascii=False)
    ok = [k for k, v in info.items() if v['clean']]
    print(len(ok), 'clean libraries:', ', '.join(ok))
    print('decompiled only (not copied):', ', '.join(k for k, v in info.items() if not v['clean']))


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
