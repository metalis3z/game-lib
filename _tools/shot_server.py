"""Screenshot receiver for the Studio capture pass.

    python -I shot_server.py <references-dir> [port]

Studio (plugin context) calls CaptureService:CaptureScreenshot, which writes a PNG into
%LOCALAPPDATA%\\Roblox\\tmp-capture-storage, then POSTs /shot {slug, file}. This server waits
for that new PNG, converts it to JPEG and stores it as Games/<slug>/screenshots/<file>.jpg.
GET /module returns the Luau capture module so Studio can install it.
"""
import http.server
import json
import os
import sys
import threading
import time

from PIL import Image

CAP_DIR = os.path.join(os.environ['LOCALAPPDATA'], 'Roblox', 'tmp-capture-storage')
REF = sys.argv[1]
PORT = int(sys.argv[2]) if len(sys.argv) > 2 else 8891
HERE = os.path.dirname(os.path.abspath(__file__))
lock = threading.Lock()
state = {'seen': set(os.listdir(CAP_DIR)) if os.path.isdir(CAP_DIR) else set()}
log = open(os.path.join(HERE, 'shots.log'), 'a', encoding='utf-8')


def wait_new(timeout=15):
    t0 = time.time()
    while time.time() - t0 < timeout:
        names = set(os.listdir(CAP_DIR))
        new = [n for n in names - state['seen']]
        if new:
            new.sort(key=lambda n: os.path.getmtime(os.path.join(CAP_DIR, n)))
            fp = os.path.join(CAP_DIR, new[-1])
            # wait until the file is fully written
            last = -1
            for _ in range(50):
                sz = os.path.getsize(fp)
                if sz == last and sz > 0:
                    break
                last = sz
                time.sleep(0.05)
            state['seen'] |= set(new)
            return fp
        time.sleep(0.05)
    return None


class H(http.server.BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def _send(self, code, body, ctype='application/json'):
        b = body.encode('utf-8') if isinstance(body, str) else body
        self.send_response(code)
        self.send_header('Content-Type', ctype)
        self.send_header('Content-Length', str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def do_GET(self):
        if self.path.startswith('/module'):
            self._send(200, open(os.path.join(HERE, 'RefShot.luau'), encoding='utf-8').read(), 'text/plain')
        elif self.path.startswith('/models'):
            self._send(200, open(os.path.join(HERE, '_shots', 'models.json'), encoding='utf-8').read())
        elif self.path.startswith('/games'):
            d = os.path.join(HERE, '_shots')
            self._send(200, json.dumps(sorted(n[:-5] for n in os.listdir(d) if n.endswith('.rbxm'))))
        else:
            self._send(404, '{}')

    def do_POST(self):
        n = int(self.headers.get('Content-Length', 0))
        body = json.loads(self.rfile.read(n) or b'{}')
        if self.path.startswith('/shot'):
            with lock:
                fp = wait_new()
                if not fp:
                    log.write(f'MISS {body}\n')
                    log.flush()
                    return self._send(200, json.dumps({'ok': False, 'err': 'no capture file'}))
                out_dir = os.path.join(REF, 'Games', body['slug'], 'screenshots', body['dir']) if body.get('dir') else \
                    os.path.join(REF, 'Games', body['slug'], 'screenshots')
                os.makedirs(out_dir, exist_ok=True)
                out = os.path.join(out_dir, body['file'] + '.jpg')
                im = Image.open(fp).convert('RGB')
                im.save(out, 'JPEG', quality=88, optimize=True)
                rect = body.get('rect')
                if rect and body.get('vw'):
                    k = im.width / float(body['vw'])
                    pad = 14
                    x0, y0 = max(0, int(rect[0] * k) - pad), max(0, int(rect[1] * k) - pad)
                    x1, y1 = min(im.width, int(rect[2] * k) + pad), min(im.height, int(rect[3] * k) + pad)
                    if x1 - x0 > 24 and y1 - y0 > 24 and (x1 - x0) * (y1 - y0) < 0.7 * im.width * im.height:
                        cdir = os.path.join(out_dir, 'crops')
                        os.makedirs(cdir, exist_ok=True)
                        im.crop((x0, y0, x1, y1)).save(os.path.join(cdir, body['file'] + '.jpg'), 'JPEG',
                                                        quality=90, optimize=True)
                os.remove(fp)
                log.write(f'OK   {body["slug"]}/{body["file"]} {im.size}\n')
                log.flush()
                return self._send(200, json.dumps({'ok': True, 'size': im.size}))
        if self.path.startswith('/log'):
            log.write(f'LOG  {json.dumps(body, ensure_ascii=False)}\n')
            log.flush()
            meta_dir = os.path.join(REF, 'Games', body['slug'], 'screenshots')
            os.makedirs(meta_dir, exist_ok=True)
            with open(os.path.join(meta_dir, '_shots.json'), 'w', encoding='utf-8') as f:
                json.dump(body, f, indent=1, ensure_ascii=False)
            return self._send(200, '{"ok":true}')
        self._send(404, '{}')


if __name__ == '__main__':
    print(f'listening on 127.0.0.1:{PORT}', flush=True)
    http.server.ThreadingHTTPServer(('127.0.0.1', PORT), H).serve_forever()
