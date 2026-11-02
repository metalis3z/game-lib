"""Stage 2: export ui/map/models/animations/audio packs per game, then move the stage-1 dump in as source/.

    python -I stage2_extract.py <downloads-dir> <references-dir>
"""
import concurrent.futures as cf
import json
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import extract_library  # noqa: E402
from games import GAMES  # noqa: E402
from rbxdump import safe  # noqa: E402


def work(fp, ref):
    sys.setrecursionlimit(10000)
    stem = os.path.splitext(os.path.basename(fp))[0]
    slug, title, genre, cat = GAMES[stem]
    extract_library.GAMES[stem] = (slug, title, genre)
    games = os.path.join(ref, 'Games')
    unpacked = os.path.join(ref, '_unpacked')
    try:
        metrics, catalog = extract_library.run(fp, games, unpacked)
    except Exception:
        import traceback
        return stem, None, traceback.format_exc()
    src = os.path.join(unpacked, safe(stem, 80))
    dst = os.path.join(games, slug, 'source')
    if os.path.isdir(dst):
        shutil.rmtree(dst)
    shutil.move(src, dst)
    metrics['category'] = cat
    metrics['source_file'] = os.path.basename(fp)
    with open(os.path.join(games, slug, 'metrics.json'), 'w', encoding='utf-8') as f:
        json.dump(metrics, f, indent=1, ensure_ascii=False, default=str)
    return stem, len(catalog), None


def main():
    src, ref = sys.argv[1], sys.argv[2]
    st = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_stage1.json'), encoding='utf-8'))
    files = [os.path.join(src, n) for n in st['unique']]
    files.sort(key=os.path.getsize, reverse=True)
    missing = [os.path.splitext(os.path.basename(f))[0] for f in files
               if os.path.splitext(os.path.basename(f))[0] not in GAMES]
    if missing:
        sys.exit(f'no GAMES entry: {missing}')
    with cf.ProcessPoolExecutor(max_workers=6) as ex:
        for fu in cf.as_completed([ex.submit(work, f, ref) for f in files]):
            stem, n, err = fu.result()
            print(f'FAIL {stem}\n{err}' if err else f'OK   {stem}: {n} packs', flush=True)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
