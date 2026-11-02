"""Pack every screen of a place into one script-free .rbxm for the screenshot pass.

    python -I make_screens.py <downloads-dir> <out-dir> [stem ...]

Roots: every ScreenGui not inside another ScreenGui, plus loose GUI templates (a Frame /
ImageLabel / CanvasGroup... sitting in a Folder or service, with 15+ descendants), which the
Studio side wraps in a ScreenGui. A sidecar <slug>.json lists the roots in pack order.
"""
import concurrent.futures as cf
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import rbxdump  # noqa: E402
import rbxpack  # noqa: E402
from games import GAMES  # noqa: E402

GUI_OBJ = {'Frame', 'ImageLabel', 'ImageButton', 'TextLabel', 'TextButton', 'ScrollingFrame',
           'CanvasGroup', 'ViewportFrame', 'TextBox'}
SKIP_SERVICES = {'CoreGui', 'Chat', 'TextChatService', 'Players'}
SKIP_NAMES = {'Chat', 'BubbleChat', 'Freecam', 'RbxCameraUI'}


def count(inst):
    n, st = 0, list(inst.children)
    while st:
        c = st.pop()
        n += 1
        st.extend(c.children)
    return n


def work(fp, out):
    sys.setrecursionlimit(10000)
    stem = os.path.splitext(os.path.basename(fp))[0]
    slug = GAMES[stem][0]
    place = rbxdump.Place(fp)
    roots, meta = [], []

    def visit(children, parent_cls, in_gui, service):
        for c in children:
            svc = service or c.name
            if svc in SKIP_SERVICES:
                continue
            if c.cls == 'ScreenGui' and not in_gui:
                if c.name not in SKIP_NAMES and count(c) > 0:
                    roots.append(c)
                    meta.append({'name': c.name, 'path': place.full_name(c), 'kind': 'ScreenGui',
                                 'descendants': count(c)})
                continue
            if c.cls in GUI_OBJ and not in_gui and parent_cls not in GUI_OBJ \
                    and parent_cls not in ('SurfaceGui', 'BillboardGui', 'ScreenGui'):
                n = count(c)
                if n >= 15:
                    roots.append(c)
                    meta.append({'name': c.name, 'path': place.full_name(c), 'kind': c.cls, 'descendants': n})
                continue
            if c.cls in ('SurfaceGui', 'BillboardGui'):
                continue
            visit(c.children, c.cls, in_gui or c.cls == 'ScreenGui', svc)

    visit(place.roots, 'DataModel', False, None)
    if not roots:
        return stem, slug, 0, None
    data, exported, removed = rbxpack.Packer(place).build(roots)
    with open(os.path.join(out, slug + '.rbxm'), 'wb') as f:
        f.write(data)
    with open(os.path.join(out, slug + '.json'), 'w', encoding='utf-8') as f:
        json.dump(meta, f, indent=1, ensure_ascii=False)
    return stem, slug, len(roots), len(data)


def main():
    src, out = sys.argv[1], sys.argv[2]
    only = set(sys.argv[3:])
    os.makedirs(out, exist_ok=True)
    files = [os.path.join(src, n) for n in sorted(os.listdir(src))
             if n.lower().endswith(('.rbxl', '.rbxm')) and os.path.splitext(n)[0] in GAMES]
    if only:
        files = [f for f in files if os.path.splitext(os.path.basename(f))[0] in only or
                 GAMES[os.path.splitext(os.path.basename(f))[0]][0] in only]
    with cf.ProcessPoolExecutor(max_workers=6) as ex:
        for fu in cf.as_completed([ex.submit(work, f, out) for f in files]):
            try:
                stem, slug, n, size = fu.result()
                print(f'OK   {slug}: {n} roots, {size} bytes', flush=True)
            except Exception as e:  # noqa: BLE001
                print(f'FAIL {e}', flush=True)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
