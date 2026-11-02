"""Stage 1: dedupe the Downloads places and unpack each one with rbxdump (scripts, tree, ui, assets, flags).

    python -I stage1_dump.py <downloads-dir> <references-dir>
"""
import concurrent.futures as cf
import hashlib
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import rbxdump  # noqa: E402

EXTS = ('.rbxl', '.rbxm')


def md5(p):
    h = hashlib.md5()
    with open(p, 'rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


def work(fp, out):
    sys.setrecursionlimit(10000)
    try:
        s = rbxdump.dump(fp, out)
        return fp, {k: v for k, v in s.items() if isinstance(v, (int, str, float))}, None
    except Exception as e:  # noqa: BLE001
        import traceback
        return fp, None, traceback.format_exc()


def main():
    src, ref = sys.argv[1], sys.argv[2]
    out = os.path.join(ref, '_unpacked')
    os.makedirs(out, exist_ok=True)
    files = sorted(os.path.join(src, n) for n in os.listdir(src) if n.lower().endswith(EXTS))
    seen, uniq, dups = {}, [], []
    for fp in files:
        h = md5(fp)
        if h in seen:
            dups.append((os.path.basename(fp), os.path.basename(seen[h])))
        else:
            seen[h] = fp
            uniq.append(fp)
    print(f'{len(files)} files, {len(uniq)} unique', flush=True)
    for a, b in dups:
        print(f'DUP  {a} == {b}', flush=True)
    rows = {}
    big_first = sorted(uniq, key=os.path.getsize, reverse=True)
    with cf.ProcessPoolExecutor(max_workers=6) as ex:
        futs = [ex.submit(work, fp, out) for fp in big_first]
        for fu in cf.as_completed(futs):
            fp, s, err = fu.result()
            name = os.path.basename(fp)
            if err:
                print(f'FAIL {name}\n{err}', flush=True)
            else:
                rows[name] = s
                print(f'OK   {name}: {s.get("instances")} inst, {s.get("scripts")} scripts', flush=True)
    with open(os.path.join(out, '_stage1.json'), 'w', encoding='utf-8') as f:
        json.dump({'unique': [os.path.basename(p) for p in uniq], 'dups': dups, 'rows': rows}, f,
                  indent=1, ensure_ascii=False)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
