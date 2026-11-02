"""Re-export the non-model packs (ui, audio, animations, map lighting / materials) as .rbxm so rbxm2lua can
convert them again. Models are left alone.

    python -I regen_packs.py <downloads-dir> <references-dir>
"""
import concurrent.futures as cf
import json
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import extract_library  # noqa: E402
from games import GAMES  # noqa: E402

KEEP_LUA = {'AnimationIds.lua', 'Sounds.lua', 'Environment.lua'}


def clear_generated(folder):
    """Remove generated builders (single files and split folders) but keep the id lists."""
    if not os.path.isdir(folder):
        return
    for root, dirs, files in os.walk(folder, topdown=False):
        for fn in files:
            if fn.endswith('.lua') and fn not in KEEP_LUA:
                os.remove(os.path.join(root, fn))
        for d in dirs:
            p = os.path.join(root, d)
            if not os.listdir(p):
                os.rmdir(p)


def work(fp, ref):
    sys.setrecursionlimit(10000)
    stem = os.path.splitext(os.path.basename(fp))[0]
    slug, title, genre, _ = GAMES[stem]
    extract_library.GAMES[stem] = (slug, title, genre)
    tmp = os.path.join(ref, '_regen')
    try:
        extract_library.run(fp, tmp, os.path.join(tmp, '_none'))
    except Exception:
        import traceback
        return slug, traceback.format_exc()
    src, dst = os.path.join(tmp, slug), os.path.join(ref, 'Games', slug)
    for sub in ('ui', 'audio', 'animations'):
        clear_generated(os.path.join(dst, sub))
        s = os.path.join(src, sub)
        for root, _, files in os.walk(s):
            for fn in files:
                if fn.endswith('.rbxm'):
                    a = os.path.join(root, fn)
                    b = os.path.join(dst, os.path.relpath(a, src))
                    os.makedirs(os.path.dirname(b), exist_ok=True)
                    shutil.copy(a, b)
    for fn in ('lighting', 'materials'):
        old = os.path.join(dst, 'map', fn + '.lua')
        if os.path.exists(old):
            os.remove(old)
        if os.path.isdir(os.path.join(dst, 'map', fn)):
            shutil.rmtree(os.path.join(dst, 'map', fn))
        a = os.path.join(src, 'map', fn + '.rbxm')
        if os.path.exists(a):
            shutil.copy(a, os.path.join(dst, 'map', fn + '.rbxm'))
    shutil.rmtree(src, ignore_errors=True)
    return slug, None


def main():
    src, ref = sys.argv[1], sys.argv[2]
    st = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_stage1.json'), encoding='utf-8'))
    files = sorted((os.path.join(src, n) for n in st['unique']), key=os.path.getsize, reverse=True)
    with cf.ProcessPoolExecutor(max_workers=6) as ex:
        for fu in cf.as_completed([ex.submit(work, f, ref) for f in files]):
            slug, err = fu.result()
            print(f'FAIL {slug}\n{err}' if err else f'OK   {slug}', flush=True)
    shutil.rmtree(os.path.join(ref, '_regen'), ignore_errors=True)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
