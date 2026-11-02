#!/usr/bin/env python3
"""rbxdump: unpack Roblox binary place/model files (.rbxl / .rbxm) into readable folders.

    python rbxdump.py <file-or-folder> [...] --out <dir>

Per file it writes:
    README.md      overview: services, scripts, UI roots, remotes, flags
    tree.txt       instance hierarchy (repeated siblings collapsed)
    scripts/       every Script / LocalScript / ModuleScript as .luau
    scripts.txt    script index (class, lines, enabled, duplicate sources)
    ui.txt         every ScreenGui / SurfaceGui / BillboardGui with layout props
    remotes.txt    RemoteEvent / RemoteFunction / Bindable paths
    assets.txt     asset ids referenced by properties, grouped by property
    flags.txt      backdoor / obfuscation / external-code scan of all scripts
    props.jsonl    full properties of non-geometry instances (one JSON per line)
"""
import argparse
import collections
import hashlib
import json
import os
import re
import shutil
import struct
import sys

import lz4.block

try:
    from compression import zstd as _zstd  # Python 3.14+

    def _zstd_decompress(b):
        return _zstd.decompress(b)
except ImportError:
    import zstandard

    def _zstd_decompress(b):
        return zstandard.ZstdDecompressor().decompress(b, max_output_size=1 << 31)

MAGIC = b'<roblox!\x89\xff\r\n\x1a\n'
ZSTD_MAGIC = b'\x28\xb5\x2f\xfd'

SCRIPT_CLASSES = {'Script', 'LocalScript', 'ModuleScript'}
LAYER_CLASSES = {'ScreenGui', 'SurfaceGui', 'BillboardGui'}
REMOTE_CLASSES = {'RemoteEvent', 'RemoteFunction', 'UnreliableRemoteEvent',
                  'BindableEvent', 'BindableFunction'}
# Classes that are numerous map geometry: only cheap property types are decoded for them.
BULK_CLASSES = {
    'Part', 'MeshPart', 'UnionOperation', 'IntersectOperation', 'NegateOperation',
    'PartOperation', 'WedgePart', 'CornerWedgePart', 'TrussPart', 'Seat', 'VehicleSeat',
    'SpawnLocation', 'Weld', 'WeldConstraint', 'Motor6D', 'ManualWeld', 'Snap', 'Glue',
    'Attachment', 'Decal', 'Texture', 'SpecialMesh', 'BlockMesh', 'CylinderMesh',
    'SurfaceAppearance', 'Bone', 'WrapLayer', 'WrapTarget', 'FileMesh', 'MaterialVariant',
}
CHEAP_TYPES = {0x01, 0x02, 0x03, 0x12, 0x13, 0x1C, 0x22}
# Properties that hold binary blobs, not text.
BLOB_PROPS = {'PhysicsData', 'MeshData', 'ChildData', 'PhysicalConfigData', 'AttributesSerialize',
              'Tags', 'SmoothGrid', 'PhysicsGrid', 'MaterialColors', 'ModelMeshData',
              'InitialSize', 'MeshContent', 'CollisionGroupData', 'ScriptGuid', 'HistoryId',
              'UniqueId', 'SerializedDefaultAttributes', 'PackageId'}


# ---------------------------------------------------------------- low level

class Reader:
    __slots__ = ('d', 'p')

    def __init__(self, d):
        self.d = d
        self.p = 0

    def take(self, n):
        if self.p + n > len(self.d):
            raise EOFError(f'need {n} bytes at {self.p}, have {len(self.d) - self.p}')
        b = self.d[self.p:self.p + n]
        self.p += n
        return b

    def u8(self):
        return self.take(1)[0]

    def u16(self):
        return struct.unpack('<H', self.take(2))[0]

    def u32(self):
        return struct.unpack('<I', self.take(4))[0]

    def string(self):
        return self.take(self.u32())


def _deinterleave(buf, n, w):
    out = bytearray(n * w)
    for j in range(w):
        out[j::w] = buf[j * n:(j + 1) * n]
    return bytes(out)


def _unzig(x):
    return (x >> 1) ^ -(x & 1)


def read_i32s(r, n):
    raw = struct.unpack(f'>{n}I', _deinterleave(r.take(4 * n), n, 4))
    return [_unzig(x) for x in raw]


def read_u32s(r, n):
    return list(struct.unpack(f'>{n}I', _deinterleave(r.take(4 * n), n, 4)))


def read_f32s(r, n):
    raw = struct.unpack(f'>{n}I', _deinterleave(r.take(4 * n), n, 4))
    rot = [((x >> 1) | ((x & 1) << 31)) for x in raw]
    return list(struct.unpack(f'>{n}f', struct.pack(f'>{n}I', *rot)))


def read_i64s(r, n):
    raw = struct.unpack(f'>{n}Q', _deinterleave(r.take(8 * n), n, 8))
    return [_unzig(x) for x in raw]


def read_refs(r, n):
    out, acc = [], 0
    for v in read_i32s(r, n):
        acc += v
        out.append(acc)
    return out


def read_cframes(r, n):
    rots = []
    for _ in range(n):
        rid = r.u8()
        rots.append(struct.unpack('<9f', r.take(36)) if rid == 0 else rid)
    xs, ys, zs = read_f32s(r, n), read_f32s(r, n), read_f32s(r, n)
    return [{'pos': (xs[i], ys[i], zs[i]), 'rot': rots[i]} for i in range(n)]


def read_values(r, t, n, sstrs):
    if t == 0x01:  # String / ProtectedString / BinaryString / ContentId
        return [r.string() for _ in range(n)]
    if t == 0x02:
        return [b != 0 for b in r.take(n)]
    if t == 0x03:
        return read_i32s(r, n)
    if t == 0x04:
        return read_f32s(r, n)
    if t == 0x05:
        return list(struct.unpack(f'<{n}d', r.take(8 * n)))
    if t == 0x06:  # UDim
        s, o = read_f32s(r, n), read_i32s(r, n)
        return list(zip(s, o))
    if t == 0x07:  # UDim2
        sx, sy, ox, oy = read_f32s(r, n), read_f32s(r, n), read_i32s(r, n), read_i32s(r, n)
        return [((sx[i], ox[i]), (sy[i], oy[i])) for i in range(n)]
    if t == 0x08:  # Ray
        return [struct.unpack('<6f', r.take(24)) for _ in range(n)]
    if t in (0x09, 0x0A):  # Faces / Axes
        return list(r.take(n))
    if t == 0x0B:  # BrickColor
        return read_u32s(r, n)
    if t in (0x0C, 0x0E):  # Color3 / Vector3
        a, b, c = read_f32s(r, n), read_f32s(r, n), read_f32s(r, n)
        return list(zip(a, b, c))
    if t == 0x0D:  # Vector2
        a, b = read_f32s(r, n), read_f32s(r, n)
        return list(zip(a, b))
    if t == 0x10:
        return read_cframes(r, n)
    if t == 0x12:  # Enum
        return read_u32s(r, n)
    if t == 0x13:  # Referent
        return read_refs(r, n)
    if t == 0x14:  # Vector3int16
        return [struct.unpack('<3h', r.take(6)) for _ in range(n)]
    if t == 0x15:  # NumberSequence
        out = []
        for _ in range(n):
            k = r.u32()
            out.append([struct.unpack('<3f', r.take(12)) for _ in range(k)])
        return out
    if t == 0x16:  # ColorSequence
        out = []
        for _ in range(n):
            k = r.u32()
            out.append([struct.unpack('<5f', r.take(20)) for _ in range(k)])
        return out
    if t == 0x17:  # NumberRange
        return [struct.unpack('<2f', r.take(8)) for _ in range(n)]
    if t == 0x18:  # Rect
        a, b, c, d = (read_f32s(r, n) for _ in range(4))
        return list(zip(a, b, c, d))
    if t == 0x19:  # PhysicalProperties
        out = []
        for _ in range(n):
            flag = r.u8()
            if flag == 0:
                out.append(None)
            else:
                if flag & 1:
                    v = struct.unpack('<5f', r.take(20))
                    if flag & 2:
                        v += struct.unpack('<f', r.take(4))
                else:
                    v = None
                out.append(v)
        return out
    if t == 0x1A:  # Color3uint8
        a, b, c = r.take(n), r.take(n), r.take(n)
        return [(a[i] / 255, b[i] / 255, c[i] / 255) for i in range(n)]
    if t == 0x1B:
        return read_i64s(r, n)
    if t == 0x1C:  # SharedString
        return [sstrs[i] if i < len(sstrs) else b'' for i in read_u32s(r, n)]
    if t == 0x1E:  # OptionalCFrame
        r.u8()
        cfs = read_cframes(r, n)
        r.u8()
        has = [b != 0 for b in r.take(n)]
        return [cfs[i] if has[i] else None for i in range(n)]
    if t == 0x1F:  # UniqueId
        r.take(16 * n)
        return [None] * n
    if t == 0x20:  # Font
        out = []
        for _ in range(n):
            fam = r.string()
            weight = r.u16()
            style = r.u8()
            r.string()  # cached face id
            out.append({'family': fam.decode('utf-8', 'replace'), 'weight': weight, 'style': style})
        return out
    if t == 0x21:  # SecurityCapabilities
        r.take(8 * n)
        return [None] * n
    if t == 0x22:  # Content (uri | object)
        kinds = read_i32s(r, n)
        uris = [r.string() for _ in range(r.u32())]
        out, ui = [], 0
        for k in kinds:
            if k == 1 and ui < len(uris):
                out.append(uris[ui])
                ui += 1
            else:
                out.append(b'')
        return out
    raise ValueError(f'unknown property type 0x{t:02x}')


# ---------------------------------------------------------------- attributes

def decode_attributes(blob):
    """Decode AttributesSerialize. Stops quietly at an unknown type."""
    out = {}
    if not blob or len(blob) < 4:
        return out
    r = Reader(blob)
    try:
        count = r.u32()
        for _ in range(count):
            key = r.string().decode('utf-8', 'replace')
            t = r.u8()
            if t == 0x02:
                v = r.string().decode('utf-8', 'replace')
            elif t == 0x03:
                v = r.u8() != 0
            elif t == 0x05:
                v = struct.unpack('<f', r.take(4))[0]
            elif t == 0x06:
                v = struct.unpack('<d', r.take(8))[0]
            elif t == 0x09:
                v = struct.unpack('<fi', r.take(8))
            elif t == 0x0A:
                v = struct.unpack('<fifi', r.take(16))
            elif t == 0x0E:
                v = ('BrickColor', r.u32())
            elif t == 0x0F:
                v = ('Color3',) + struct.unpack('<3f', r.take(12))
            elif t == 0x10:
                v = ('Vector2',) + struct.unpack('<2f', r.take(8))
            elif t == 0x11:
                v = ('Vector3',) + struct.unpack('<3f', r.take(12))
            elif t == 0x14:
                pos = struct.unpack('<3f', r.take(12))
                if r.u8() == 0:
                    r.take(36)
                v = ('CFrame',) + pos
            elif t == 0x15:
                v = ('Enum', r.string().decode('utf-8', 'replace'), r.u32())
            elif t == 0x17:
                v = ('NumberSequence', [struct.unpack('<3f', r.take(12)) for _ in range(r.u32())])
            elif t == 0x19:
                v = ('ColorSequence', [struct.unpack('<5f', r.take(20)) for _ in range(r.u32())])
            elif t == 0x1B:
                v = ('NumberRange',) + struct.unpack('<2f', r.take(8))
            elif t == 0x1C:
                v = ('Rect',) + struct.unpack('<4f', r.take(16))
            elif t == 0x21:
                w, s = r.u16(), r.u8()
                fam = r.string().decode('utf-8', 'replace')
                r.string()
                v = ('Font', fam, w, s)
            else:
                out[key] = f'<unknown attr type 0x{t:02x}>'
                break
            out[key] = v
    except EOFError:
        pass
    return out


# ---------------------------------------------------------------- model

class ClassInfo:
    __slots__ = ('name', 'refs', 'cols', 'types', 'raw', 'is_service')

    def __init__(self, name, refs, is_service=False):
        self.name = name
        self.refs = refs
        self.cols = {}
        self.types = {}
        self.raw = {}  # prop name -> (type id, PROP payload, offset of the values); used by rbxpack
        self.is_service = is_service


class Inst:
    __slots__ = ('ref', 'ci', 'idx', 'parent', 'children', '_seg')

    def __init__(self, ref, ci, idx):
        self.ref = ref
        self.ci = ci
        self.idx = idx
        self.parent = None
        self.children = []
        self._seg = None

    @property
    def cls(self):
        return self.ci.name

    def get(self, prop, default=None):
        col = self.ci.cols.get(prop)
        return default if col is None else col[self.idx]

    @property
    def name(self):
        v = self.get('Name', b'')
        return v.decode('utf-8', 'replace') if isinstance(v, bytes) else str(v)


class Place:
    def __init__(self, path):
        self.path = path
        self.meta = {}
        self.classes = {}
        self.insts = {}
        self.roots = []
        self.warnings = []
        self.version = 0
        self.sstr_entries = []  # (md5 hash, bytes) in file order
        self._sstrs = []
        self._parse(open(path, 'rb').read())

    def ensure_col(self, ci, pname):
        """Decode a column that was skipped at load time (heavy types on map geometry)."""
        if pname in ci.cols:
            return ci.cols[pname]
        raw = ci.raw.get(pname)
        if raw is None:
            return None
        t, payload, off = raw
        r = Reader(payload)
        r.p = off
        try:
            ci.cols[pname] = read_values(r, t, len(ci.refs), self._sstrs)
        except Exception:
            return None
        return ci.cols[pname]

    def _parse(self, data):
        if not data.startswith(MAGIC):
            if data.lstrip()[:8].lower().startswith(b'<roblox'):
                raise ValueError('XML format (.rbxlx/.rbxmx) is not supported by this tool')
            raise ValueError('not a Roblox binary file')
        self.version, _, _ = struct.unpack_from('<HII', data, 14)
        p = 32
        sstrs = []
        prnt = None
        props = []
        while p + 16 <= len(data):
            tag = data[p:p + 4]
            clen, ulen, _ = struct.unpack_from('<III', data, p + 4)
            p += 16
            if clen == 0:
                payload = data[p:p + ulen]
                p += ulen
            else:
                raw = data[p:p + clen]
                p += clen
                if raw[:4] == ZSTD_MAGIC:
                    payload = _zstd_decompress(raw)
                else:
                    payload = lz4.block.decompress(raw, uncompressed_size=ulen)
            name = tag.rstrip(b'\0').decode('ascii', 'replace')
            r = Reader(payload)
            if name == 'META':
                for _ in range(r.u32()):
                    k = r.string().decode('utf-8', 'replace')
                    self.meta[k] = r.string().decode('utf-8', 'replace')
            elif name == 'SSTR':
                r.u32()
                for _ in range(r.u32()):
                    h = r.take(16)
                    s = r.string()
                    sstrs.append(s)
                    self.sstr_entries.append((h, s))
            elif name == 'INST':
                cid = r.u32()
                cname = r.string().decode('utf-8', 'replace')
                fmt = r.u8()
                n = r.u32()
                self.classes[cid] = ClassInfo(cname, read_refs(r, n), fmt == 1)
            elif name == 'PROP':
                props.append(payload)
            elif name == 'PRNT':
                prnt = payload
            elif name == 'END':
                break

        for payload in props:
            r = Reader(payload)
            cid = r.u32()
            pname = r.string().decode('utf-8', 'replace')
            t = r.u8()
            ci = self.classes.get(cid)
            if ci is None:
                continue
            ci.raw[pname] = (t, payload, r.p)
            ci.types[pname] = t
            if ci.name in BULK_CLASSES and t not in CHEAP_TYPES:
                continue
            try:
                vals = read_values(r, t, len(ci.refs), sstrs)
            except Exception as e:  # one bad column must not sink the whole file
                self.warnings.append(f'{ci.name}.{pname} (type 0x{t:02x}): {e}')
                continue
            ci.cols[pname] = vals

        self._sstrs = sstrs
        for ci in self.classes.values():
            for i, ref in enumerate(ci.refs):
                self.insts[ref] = Inst(ref, ci, i)

        if prnt is not None:
            r = Reader(prnt)
            r.u8()
            n = r.u32()
            kids, pars = read_refs(r, n), read_refs(r, n)
            for c, pr in zip(kids, pars):
                ci = self.insts.get(c)
                if ci is None:
                    continue
                pi = self.insts.get(pr)
                if pi is None:
                    self.roots.append(ci)
                else:
                    ci.parent = pi
                    pi.children.append(ci)
        else:
            self.roots = list(self.insts.values())

    # ------------------------------------------------------------ helpers

    def walk(self, start=None):
        stack = list(reversed(start if start is not None else self.roots))
        while stack:
            i = stack.pop()
            yield i
            stack.extend(reversed(i.children))

    @staticmethod
    def ancestors(inst):
        out = []
        p = inst.parent
        while p is not None:
            out.append(p)
            p = p.parent
        return out[::-1]

    def full_name(self, inst):
        return '.'.join([a.name for a in self.ancestors(inst)] + [inst.name])

    def root_of(self, inst):
        a = self.ancestors(inst)
        return a[0] if a else inst


# ---------------------------------------------------------------- formatting

_BAD = re.compile(r'[<>:"/\\|?*\x00-\x1f]')
_RESERVED = {'CON', 'PRN', 'AUX', 'NUL', *(f'COM{i}' for i in range(1, 10)),
             *(f'LPT{i}' for i in range(1, 10))}


def safe(name, limit=60):
    s = _BAD.sub('_', name).strip().rstrip('.')
    if not s:
        s = '_'
    if s.split('.')[0].upper() in _RESERVED:
        s = '_' + s
    return s[:limit]


def lp(p):
    p = os.path.abspath(p)
    if os.name == 'nt' and not p.startswith('\\\\?\\'):
        return '\\\\?\\' + p
    return p


def seg(inst):
    """Unique, filesystem-safe path segment for an instance among its siblings."""
    if inst._seg is None:
        sibs = inst.parent.children if inst.parent else [inst]
        seen = collections.Counter()
        for s in sibs:
            base = safe(s.name)
            seen[base.lower()] += 1
            k = seen[base.lower()]
            s._seg = base if k == 1 else f'{base}~{k}'
    return inst._seg


def g(x):
    return f'{x:.3g}' if isinstance(x, float) else str(x)


def fmt_udim2(v):
    (sx, ox), (sy, oy) = v
    return f'{{{g(sx)},{ox}}},{{{g(sy)},{oy}}}'


def fmt_color(v):
    try:
        return '#%02x%02x%02x' % tuple(max(0, min(255, round(c * 255))) for c in v[:3])
    except Exception:
        return str(v)


def text(v, limit=None):
    if isinstance(v, bytes):
        v = v.decode('utf-8', 'replace')
    v = str(v).replace('\r', '').replace('\n', '\\n')
    if limit and len(v) > limit:
        v = v[:limit] + '...'
    return v


def jsonable(v):
    if isinstance(v, bytes):
        try:
            s = v.decode('utf-8')
            if len(s) > 4000:
                return f'<text {len(s)} chars>'
            return s
        except UnicodeDecodeError:
            return f'<bytes {len(v)}>'
    if isinstance(v, float):
        return round(v, 4)
    if isinstance(v, (list, tuple)):
        return [jsonable(x) for x in v]
    if isinstance(v, dict):
        return {k: jsonable(x) for k, x in v.items()}
    return v


ASSET_RE = re.compile(rb'(?:rbxassetid://|[?&]id=)(\d{3,})', re.I)
LUA_EXT = {'Script': '.server.lua', 'LocalScript': '.client.lua', 'ModuleScript': '.lua'}


def script_kind(inst):
    if inst.cls == 'Script':
        rc = inst.get('RunContext', 0)
        return {1: 'server', 2: 'client', 3: 'plugin'}.get(rc, 'server')
    return {'LocalScript': 'client', 'ModuleScript': 'module'}[inst.cls]


def script_enabled(inst):
    if inst.cls == 'ModuleScript':
        return True
    if 'Disabled' in inst.ci.cols:
        return not inst.get('Disabled')
    if 'Enabled' in inst.ci.cols:
        return bool(inst.get('Enabled'))
    return True


# ---------------------------------------------------------------- scanning

FLAG_RULES = [
    ('HIGH', 'require() of an asset id: loads code from the Creator Store at runtime',
     re.compile(r'\brequire\s*\(\s*\d{5,}\s*\)')),
    ('HIGH', 'require() of a hex number (asset id written to hide it)',
     re.compile(r'\brequire\s*\(\s*0[xX][0-9a-fA-F]+')),
    ('MED', 'getfenv()[...] call: reaches a global by computed name (can hide require / loadstring)',
     re.compile(r'\bgetfenv\s*\(\s*\d?\s*\)\s*\[')),
    ('HIGH', 'reversed "require" / "loadstring" / "getfenv" string',
     re.compile(r'eriuqer|gnirtsdaol|vnefteg')),
    ('HIGH', 'loadstring: runs code built from a string',
     re.compile(r'\bloadstring\s*\(')),
    ('HIGH', 'LoadStringEnabled toggled from code',
     re.compile(r'LoadStringEnabled')),
    ('HIGH', 'Discord webhook URL (data sent outside Roblox)',
     re.compile(r'discord(?:app)?\.com/api/webhooks', re.I)),
    ('HIGH', 'code hidden far right of the line (whitespace padding)',
     re.compile(r'^[ \t]{150,}\S', re.M)),
    ('MED', 'getfenv / setfenv (environment tampering, common in backdoors)',
     re.compile(r'\b[gs]etfenv\s*\(')),
    ('MED', 'string.char with a long number list (hidden text)',
     re.compile(r'string\.char\s*\(\s*\d+(?:\s*,\s*\d+){8,}')),
    ('MED', 'InsertService:LoadAsset (pulls models at runtime)',
     re.compile(r'LoadAsset(?:Version)?\s*\(')),
    ('MED', 'HttpService request (calls an outside server)',
     re.compile(r'\b(?:PostAsync|GetAsync|RequestAsync)\s*\(')),
    ('INFO', 'exploit-executor API (getgenv / hookfunction / syn.*)',
     re.compile(r'\b(?:getgenv|hookfunction|hookmetamethod|identifyexecutor|syn\.request)\b')),
]
OBF_REQUIRE = re.compile(r'\brequire\s*\(([^\n]{0,160})')
SUS_NAMES = re.compile(r'(?i)vaccine|virus|infect|backdoor|anti.?lag|fix.?lag|spread|ripull|^\s*$')
DECOMP_RE = re.compile(r'(?i)decompiled|decompiler|unluau|konstant|oracle|medal|synapse x|saveinstance|'
                       r'script hash:|bytecode')
URL_RE = re.compile(r'https?://[^\s"\'\)\]]+')
MONEY_RES = [
    re.compile(r'(?:PromptGamePassPurchase|UserOwnsGamePassAsync|PromptProductPurchase|PromptPurchase|'
               r'GetProductInfo|PromptPremiumPurchase)\s*\([^)\n]*?(\d{6,})'),
    re.compile(r'(?i)\b\w*(?:game ?pass|pass|product|devproduct)\w*\s*[=:]\s*(\d{6,})'),
    re.compile(r'(?i)\[\s*(\d{6,})\s*\]\s*=\s*(?:function|\{)'),
]
PLACE_RES = [re.compile(r'(?:Teleport\w*)\s*\(\s*(\d{6,})')]


_LONG_OPEN = re.compile(r'\[(=*)\[')
_ESC_RUN = re.compile(r'(?:\\\d{1,3}){24,}')


def strip_comments(src):
    """Drop Lua comments, keep strings and newlines so line numbers stay valid."""
    out = []
    i, n = 0, len(src)
    while i < n:
        c = src[i]
        if c == '-' and src.startswith('--', i):
            m = _LONG_OPEN.match(src, i + 2)
            if m:
                close = ']' + m.group(1) + ']'
                k = src.find(close, m.end())
                k = n if k < 0 else k + len(close)
                out.append('\n' * src.count('\n', i, k))
            else:
                k = src.find('\n', i)
                k = n if k < 0 else k
            i = k
            continue
        if c in '"\'`':
            j = i + 1
            while j < n and src[j] != c and src[j] != '\n':
                j += 2 if src[j] == '\\' else 1
            out.append(src[i:j + 1])
            i = j + 1
            continue
        if c == '[':
            m = _LONG_OPEN.match(src, i)
            if m:
                close = ']' + m.group(1) + ']'
                k = src.find(close, m.end())
                k = n if k < 0 else k + len(close)
                out.append(src[i:k])
                i = k
                continue
        j = i + 1
        while j < n and src[j] not in '-"\'`[':
            j += 1
        out.append(src[i:j])
        i = j
    return ''.join(out)


def scan_source(raw):
    src = strip_comments(raw)
    hits = []
    for level, why, rx in FLAG_RULES:
        if why.startswith('HttpService') and 'HttpService' not in src:
            continue  # DataStore:GetAsync uses the same method name
        for m in rx.finditer(src):
            line = src.count('\n', 0, m.start()) + 1
            hits.append((level, why, line))
    for m in _ESC_RUN.finditer(src):
        bs = bytes(v for v in (int(x) for x in re.findall(r'\\(\d{1,3})', m.group(0))) if v < 256)
        if bs and sum(1 for b in bs if 32 <= b < 127) / len(bs) > 0.8:  # hidden ASCII, not emoji
            line = src.count('\n', 0, m.start()) + 1
            hits.append(('HIGH', f'escaped-byte string hiding text: "{text(bs, 60)}"', line))
    for m in OBF_REQUIRE.finditer(src):
        arg = m.group(1)
        arg = re.sub(r'(["\'`]).*?\1', '""', arg)  # literal names like "reverse" are fine
        arg = re.sub(r'WaitForChild\s*\([^,)]*,\s*\d+', 'WaitForChild(', arg)  # timeouts
        if re.search(r'tonumber|0x[0-9a-fA-F]{4,}|reverse|string\.char|getfenv|\b\d{5,}\b', arg) \
                and not re.match(r'\s*(?:\d{5,}|0[xX])', arg) and not re.match(r'\s*["\'`]', arg):
            line = src.count('\n', 0, m.start()) + 1
            hits.append(('HIGH', 'require() with a computed / hidden argument', line))
    for i, ln in enumerate(src.split('\n'), 1):
        if len(ln) > 3000:
            hits.append(('MED', f'very long line ({len(ln)} chars, possible obfuscation)', i))
    # collapse duplicates per rule, keep first lines
    grouped = collections.OrderedDict()
    for level, why, line in hits:
        grouped.setdefault((level, why), []).append(line)
    return [(lv, why, lines) for (lv, why), lines in grouped.items()]


# ---------------------------------------------------------------- dumping

UI_PROPS = {
    'ScreenGui': ['Enabled', 'DisplayOrder', 'ResetOnSpawn', 'IgnoreGuiInset', 'ZIndexBehavior'],
    'SurfaceGui': ['Enabled', 'Face', 'PixelsPerStud', 'SizingMode', 'Adornee', 'AlwaysOnTop'],
    'BillboardGui': ['Enabled', 'Size', 'StudsOffset', 'MaxDistance', 'AlwaysOnTop', 'Adornee'],
    'UICorner': ['CornerRadius'],
    'UIStroke': ['Thickness', 'Color', 'Transparency', 'ApplyStrokeMode'],
    'UIGradient': ['Color', 'Rotation', 'Transparency'],
    'UIListLayout': ['FillDirection', 'Padding', 'HorizontalAlignment', 'VerticalAlignment', 'SortOrder'],
    'UIGridLayout': ['CellSize', 'CellPadding', 'FillDirectionMaxCells'],
    'UIPadding': ['PaddingTop', 'PaddingBottom', 'PaddingLeft', 'PaddingRight'],
    'UIAspectRatioConstraint': ['AspectRatio'],
    'UIScale': ['Scale'],
    'UITextSizeConstraint': ['MaxTextSize', 'MinTextSize'],
    'UIPageLayout': ['Animated', 'Circular', 'EasingStyle', 'TweenTime'],
    'ViewportFrame': ['Ambient', 'LightColor'],
}
VALUE_CLASSES = {'StringValue', 'IntValue', 'NumberValue', 'BoolValue', 'ObjectValue',
                 'Color3Value', 'Vector3Value', 'CFrameValue', 'BrickColorValue', 'RayValue'}


def fmt_prop(inst, prop, place):
    v = inst.get(prop)
    t = inst.ci.types.get(prop)
    if v is None:
        return None
    if t == 0x07:
        return fmt_udim2(v)
    if t == 0x06:
        return f'{{{g(v[0])},{v[1]}}}'
    if t in (0x0C, 0x1A):
        return fmt_color(v)
    if t == 0x16:
        return '[' + ' '.join(f'{g(k[0])}:{fmt_color(k[1:4])}' for k in v) + ']'
    if t == 0x15:
        return '[' + ' '.join(f'{g(k[0])}:{g(k[1])}' for k in v) + ']'
    if t == 0x13:
        tgt = place.insts.get(v)
        return place.full_name(tgt) if tgt else 'nil'
    if t in (0x0D, 0x0E):
        return '(' + ','.join(g(x) for x in v) + ')'
    if t == 0x01:
        return '"' + text(v, 70) + '"'
    if isinstance(v, float):
        return g(v)
    return str(v)


def gui_line(inst, place):
    parts = [f'{inst.cls} "{inst.name}"']
    c = inst.ci.cols
    if 'Size' in c and inst.ci.types.get('Size') == 0x07:
        parts.append('size=' + fmt_udim2(inst.get('Size')))
    if 'Position' in c and inst.ci.types.get('Position') == 0x07:
        parts.append('pos=' + fmt_udim2(inst.get('Position')))
    ap = inst.get('AnchorPoint')
    if ap and tuple(ap) != (0.0, 0.0):
        parts.append('anchor=(' + ','.join(g(x) for x in ap) + ')')
    if 'Visible' in c and not inst.get('Visible'):
        parts.append('HIDDEN')
    if 'BackgroundTransparency' in c:
        bt = inst.get('BackgroundTransparency')
        if bt >= 0.999:
            parts.append('nobg')
        else:
            parts.append('bg=' + fmt_color(inst.get('BackgroundColor3', (1, 1, 1)))
                         + ('' if bt <= 0.001 else f'@{g(bt)}'))
    z = inst.get('ZIndex')
    if z not in (None, 1):
        parts.append(f'z={z}')
    rot = inst.get('Rotation')
    if rot:
        parts.append(f'rot={g(rot)}')
    if 'Text' in c and inst.ci.types.get('Text') == 0x01:
        parts.append('text="' + text(inst.get('Text'), 60) + '"')
        ff = inst.get('FontFace')
        if isinstance(ff, dict):
            fam = ff['family'].rsplit('/', 1)[-1].replace('.json', '')
            parts.append(f'font={fam}/{ff["weight"]}')
        if inst.get('TextScaled'):
            parts.append('scaled')
        else:
            ts = inst.get('TextSize')
            if ts:
                parts.append(f'ts={g(ts)}')
        tc = inst.get('TextColor3')
        if tc:
            parts.append('tc=' + fmt_color(tc))
    if 'Image' in c:
        im = inst.get('Image')
        if im:
            parts.append('img=' + text(im, 70))
            ic = inst.get('ImageColor3')
            if ic and fmt_color(ic) != '#ffffff':
                parts.append('imgcol=' + fmt_color(ic))
            it = inst.get('ImageTransparency')
            if it:
                parts.append(f'imgT={g(it)}')
    for prop in UI_PROPS.get(inst.cls, []):
        if prop in c:
            s = fmt_prop(inst, prop, place)
            if s is not None:
                parts.append(f'{prop}={s}')
    if inst.cls in VALUE_CLASSES:
        s = fmt_prop(inst, 'Value', place)
        if s is not None:
            parts.append(f'Value={s}')
    attrs = decode_attributes(inst.get('AttributesSerialize'))
    if attrs:
        parts.append('attrs=' + text(json.dumps(jsonable(attrs), ensure_ascii=False), 120))
    return '  '.join(parts)


def descendant_counts(place):
    counts = {}
    for inst in place.walk():
        pass
    # post-order count without recursion
    order = list(place.walk())
    for inst in reversed(order):
        counts[inst.ref] = 1 + sum(counts[c.ref] for c in inst.children)
    return counts


def write_tree(f, roots, place, counts, script_paths, max_same=3, line_fn=None):
    stack = [(r, 0) for r in reversed(roots)]
    pending = []
    while stack:
        inst, depth = stack.pop()
        if inst is None:  # collapsed marker
            f.write(depth)
            continue
        ind = '  ' * depth
        if line_fn:
            line = line_fn(inst)
        else:
            line = f'{inst.cls} "{inst.name}"'
            n = counts[inst.ref] - 1
            if n >= 20 and inst.cls not in SCRIPT_CLASSES:
                line += f'  ({n} descendants)'
        if inst.cls in SCRIPT_CLASSES:
            line += f'  -> {script_paths.get(inst.ref, "?")}'
            if not script_enabled(inst):
                line += '  [disabled]'
        f.write(ind + line + '\n')
        kids = inst.children
        groups = collections.Counter((c.cls, c.name) for c in kids)
        seen = collections.Counter()
        push = []
        for c in kids:
            key = (c.cls, c.name)
            seen[key] += 1
            if groups[key] > max_same + 1 and seen[key] > max_same:
                if seen[key] == max_same + 1:
                    push.append((None, f'{ind}  ... +{groups[key] - max_same} more {c.cls} "{c.name}"\n'))
                continue
            push.append((c, depth + 1))
        stack.extend(reversed(push))
    del pending


def dump(path, out_root):
    place = Place(path)
    stem = os.path.splitext(os.path.basename(path))[0]
    out = os.path.join(out_root, safe(stem, 80))
    os.makedirs(lp(out), exist_ok=True)
    for entry in os.listdir(lp(out)):  # clear old output but keep the folder (it may be open)
        if entry == 'ANALYSIS.md':  # hand-written notes survive re-runs
            continue
        fp = os.path.join(lp(out), entry)
        shutil.rmtree(fp) if os.path.isdir(fp) else os.remove(fp)

    def w(name):
        return open(lp(os.path.join(out, name)), 'w', encoding='utf-8', newline='\n')

    counts = descendant_counts(place)
    all_insts = list(place.walk())
    class_count = collections.Counter(i.cls for i in all_insts)

    # ---- scripts
    scripts = [i for i in all_insts if i.cls in SCRIPT_CLASSES]
    script_paths = {}
    src_hash = collections.defaultdict(list)
    script_rows = []
    flags = []
    money_ids = collections.defaultdict(set)
    place_ids = collections.defaultdict(set)
    urls = collections.defaultdict(set)
    decomp = 0
    empty = 0
    saved_by_exploit = 0
    total_lines = 0
    for s in scripts:
        rel = '/'.join([seg(a) for a in place.ancestors(s)] + [seg(s) + LUA_EXT[s.cls]])
        rel = 'scripts/' + rel
        script_paths[s.ref] = rel
        src = s.get('Source', b'') or b''
        fp = lp(os.path.join(out, rel))
        os.makedirs(os.path.dirname(fp), exist_ok=True)
        with open(fp, 'wb') as fh:
            fh.write(src)
        txt = src.decode('utf-8', 'replace')
        lines = txt.count('\n') + (1 if txt and not txt.endswith('\n') else 0)
        total_lines += lines
        h = hashlib.md5(src).hexdigest()
        if src.strip():
            src_hash[h].append(rel)
        else:
            empty += 1
        if DECOMP_RE.search(txt[:600]):
            decomp += 1
        if 'saveinstance' in txt[:400].lower():
            saved_by_exploit += 1
        linked = s.get('LinkedSource', b'') or b''
        script_rows.append((rel, s.cls, script_kind(s), lines, script_enabled(s), h,
                            linked.decode('utf-8', 'replace') if isinstance(linked, bytes) else ''))
        for lv, why, lns in scan_source(txt):
            flags.append((lv, rel, why, lns))
        if SUS_NAMES.search(s.name):
            flags.append(('MED', rel, f'suspicious script name "{s.name}"', []))
        if linked:
            flags.append(('MED', rel, f'LinkedSource set ({text(linked, 80)}): code lives outside the file', []))
        for rx in MONEY_RES:
            for m in rx.finditer(txt):
                money_ids[m.group(1)].add(rel)
        if 'MarketplaceService' in txt:  # table entries like ['Super VIP'] = 1048321311
            for m in re.finditer(r'(?:\]|\w)\s*=\s*(\d{7,})\b', strip_comments(txt)):
                money_ids[m.group(1)].add(rel)
        for rx in PLACE_RES:
            for m in rx.finditer(txt):
                place_ids[m.group(1)].add(rel)
        for m in URL_RE.finditer(txt):
            u = m.group(0)
            if not re.search(r'roblox\.com/(?:asset|library|catalog|games|users|groups)|rbxcdn|create\.roblox\.com/docs', u):
                urls[u].add(rel)

    dup_of = {}
    for h, rels in src_hash.items():
        if len(rels) > 1:
            for r_ in rels[1:]:
                dup_of[r_] = rels[0]

    with w('scripts.txt') as f:
        f.write(f'{len(scripts)} scripts, {total_lines} lines\n')
        f.write('kind     lines  enabled  path\n')
        for rel, cls, kind, lines, en, h, linked in sorted(script_rows, key=lambda x: x[0]):
            extra = f'   (same source as {dup_of[rel]})' if rel in dup_of else ''
            if linked:
                extra += f'   LinkedSource={linked}'
            f.write(f'{kind:<8} {lines:>5}  {"yes" if en else "NO ":<7}  {rel}{extra}\n')

    # ---- tree
    with w('tree.txt') as f:
        write_tree(f, place.roots, place, counts, script_paths)

    # ---- UI
    gui_roots = []
    sg = [r for r in place.roots if r.cls == 'StarterGui']
    for r in sg:
        gui_roots.extend(r.children)
    covered = {i.ref for r in gui_roots for i in place.walk([r])}
    for i in all_insts:
        if i.cls in LAYER_CLASSES and i.ref not in covered:
            anc = place.ancestors(i)
            if any(a.cls in LAYER_CLASSES for a in anc):
                continue
            gui_roots.append(i)
            covered.update(x.ref for x in place.walk([i]))
    with w('ui.txt') as f:
        f.write('Legend: size/pos = {scaleX,offsetX},{scaleY,offsetY}; HIDDEN = Visible false; '
                'nobg = BackgroundTransparency 1; scripts point to files under scripts/\n')
        # group billboard/surface guis with identical names under the same parent kind
        seen_sig = collections.Counter()
        for r in gui_roots:
            sig = (r.cls, r.name, place.root_of(r).name)
            seen_sig[sig] += 1
            if r.cls in ('BillboardGui', 'SurfaceGui') and seen_sig[sig] > 2:
                continue
            f.write(f'\n==== {place.full_name(r)}  ({counts[r.ref] - 1} descendants)\n')
            write_tree(f, [r], place, counts, script_paths, max_same=4,
                       line_fn=lambda i: gui_line(i, place))
        extra = {k: v for k, v in seen_sig.items() if v > 2 and k[0] in ('BillboardGui', 'SurfaceGui')}
        if extra:
            f.write('\n==== repeated world GUIs (only the first two were printed)\n')
            for (cls, name, root), n in extra.items():
                f.write(f'{cls} "{name}" under {root}: {n} copies\n')

    # ---- remotes
    remotes = [i for i in all_insts if i.cls in REMOTE_CLASSES]
    with w('remotes.txt') as f:
        f.write(f'{len(remotes)} remotes / bindables\n')
        for i in remotes:
            f.write(f'{i.cls:<22} {place.full_name(i)}\n')

    # ---- assets
    assets = collections.defaultdict(collections.Counter)
    for ci in place.classes.values():
        for pname, t in ci.types.items():
            if t not in (0x01, 0x1C, 0x22) or pname in ('Source', 'Name') or pname in BLOB_PROPS:
                continue
            for v in ci.cols.get(pname, ()):
                if v:
                    for m in ASSET_RE.finditer(v):
                        assets[f'{ci.name}.{pname}'][m.group(1).decode()] += 1
    with w('assets.txt') as f:
        uniq = set(a for c in assets.values() for a in c)
        f.write(f'{len(uniq)} unique asset ids referenced by properties\n')
        for key in sorted(assets, key=lambda k: -sum(assets[k].values())):
            c = assets[key]
            f.write(f'\n[{key}]  {len(c)} unique, {sum(c.values())} uses\n')
            for aid, n in c.most_common(300):
                f.write(f'  {aid}  x{n}\n')
            if len(c) > 300:
                f.write(f'  ... {len(c) - 300} more\n')

    # ---- flags
    order = {'HIGH': 0, 'MED': 1, 'INFO': 2}
    flags.sort(key=lambda x: (order[x[0]], x[1]))
    sus_inst = [i for i in all_insts if i.cls not in SCRIPT_CLASSES and SUS_NAMES.search(i.name)
                and i.name.strip()]
    with w('flags.txt') as f:
        f.write('Automatic scan. HIGH = review before publishing; MED = check what it does; '
                'INFO = context.\n\n')
        if not flags:
            f.write('No script flags.\n')
        for lv, rel, why, lns in flags:
            ln = (' lines ' + ','.join(map(str, lns[:8])) + (' ...' if len(lns) > 8 else '')) if lns else ''
            f.write(f'[{lv}] {rel}{ln}\n       {why}\n')
        if sus_inst:
            f.write('\nInstances with suspicious names:\n')
            for i in sus_inst[:50]:
                f.write(f'  {i.cls} {place.full_name(i)}\n')
        if money_ids:
            f.write('\nMonetization ids found in code (gamepass / product). Replace with your own:\n')
            for aid, rels in sorted(money_ids.items()):
                f.write(f'  {aid}  in {", ".join(sorted(rels)[:4])}{" ..." if len(rels) > 4 else ""}\n')
        if place_ids:
            f.write('\nTeleport place ids in code:\n')
            for aid, rels in sorted(place_ids.items()):
                f.write(f'  {aid}  in {", ".join(sorted(rels)[:4])}\n')
        if urls:
            f.write('\nOutside URLs in code:\n')
            for u, rels in sorted(urls.items()):
                f.write(f'  {u}  in {", ".join(sorted(rels)[:3])}\n')

    # ---- props
    with w('props.jsonl') as f:
        for i in all_insts:
            if i.cls in BULK_CLASSES:
                continue
            props = {}
            for pname in i.ci.cols:
                if pname in ('Source',):
                    continue
                v = i.get(pname)
                if pname == 'AttributesSerialize':
                    a = decode_attributes(v)
                    if a:
                        props['@attributes'] = jsonable(a)
                    continue
                if pname == 'Tags':
                    if v:
                        props['@tags'] = [t.decode('utf-8', 'replace') for t in v.split(b'\0') if t]
                    continue
                if pname in BLOB_PROPS:
                    continue
                if i.ci.types.get(pname) == 0x13:
                    tgt = place.insts.get(v)
                    v = place.full_name(tgt) if tgt else None
                props[pname] = jsonable(v)
            f.write(json.dumps({'path': place.full_name(i), 'class': i.cls, 'props': props},
                               ensure_ascii=False) + '\n')

    # ---- README
    by_root = collections.defaultdict(lambda: collections.Counter())
    for i in all_insts:
        if i.cls in SCRIPT_CLASSES:
            by_root[place.root_of(i).cls][script_kind(i)] += 1
    server_scripts = sum(c['server'] for c in by_root.values())
    client_scripts = sum(c['client'] for c in by_root.values())
    hi = sum(1 for x in flags if x[0] == 'HIGH')
    md = sum(1 for x in flags if x[0] == 'MED')
    sss = [r for r in place.roots if r.cls == 'ServerScriptService']
    sss_scripts = sum(1 for r in sss for i in place.walk([r]) if i.cls in SCRIPT_CLASSES)
    notes = []
    if scripts and empty == len(scripts):
        notes.append('all script sources empty (structure + UI only)')
    elif empty > len(scripts) * 0.3:
        notes.append(f'{empty} empty scripts')
    if saved_by_exploit:
        notes.append(f'{saved_by_exploit} scripts saved by an exploit saveinstance')
    elif decomp:
        notes.append(f'{decomp} scripts decompiled')
    if client_scripts > 5 and sss_scripts == 0:
        notes.append('ServerScriptService has no code')
    stolen_hint = bool(notes)

    summary = {
        'file': os.path.basename(path), 'instances': len(all_insts), 'classes': len(class_count),
        'scripts': len(scripts), 'lines': total_lines, 'server': server_scripts,
        'client': client_scripts, 'modules': sum(c['module'] for c in by_root.values()),
        'sss_scripts': sss_scripts, 'gui_roots': len([r for r in gui_roots if r.cls == 'ScreenGui']),
        'remotes': len(remotes), 'assets': len({a for c in assets.values() for a in c}),
        'high': hi, 'med': md, 'decompiled': decomp, 'stolen_hint': stolen_hint,
        'money_ids': len(money_ids), 'warnings': len(place.warnings), 'out': out,
        'notes': '; '.join(notes), 'empty': empty,
    }

    with w('README.md') as f:
        f.write(f'# {stem}\n\n')
        f.write(f'Source: `{path}`  \n')
        f.write(f'{len(all_insts)} instances, {len(class_count)} classes, '
                f'{len(scripts)} scripts ({total_lines} lines), {len(remotes)} remotes, '
                f'{summary["assets"]} asset ids\n\n')
        if place.meta:
            f.write('META: ' + ', '.join(f'{k}={v}' for k, v in place.meta.items()) + '\n\n')
        f.write('## Top level\n\n| Service / root | Class | Descendants | Scripts (server/client/module) |\n'
                '|---|---|---:|---|\n')
        hidden = 0
        for r in place.roots:
            if counts[r.ref] == 1 and r.cls not in SCRIPT_CLASSES and r.cls != 'Model':
                hidden += 1
                continue
            c = by_root.get(r.cls, collections.Counter()) if r.cls != 'Model' else collections.Counter()
            sc = f'{c["server"]}/{c["client"]}/{c["module"]}' if c else ''
            f.write(f'| {r.name} | {r.cls} | {counts[r.ref] - 1} | {sc} |\n')
        if hidden:
            f.write(f'\n({hidden} empty services not listed)\n')
        f.write('\n## Key containers\n\n')
        for svc in ('ServerScriptService', 'ServerStorage', 'ReplicatedStorage', 'ReplicatedFirst',
                    'StarterPlayer', 'StarterGui', 'StarterPack', 'Workspace'):
            for r in place.roots:
                if r.cls != svc:
                    continue
                kids = r.children
                if svc == 'StarterPlayer':
                    kids = [k2 for k in kids for k2 in ([k] + k.children)]
                f.write(f'**{r.name}** ({len(r.children)} children)\n\n')
                shown = kids[:60]
                for k in shown:
                    n = counts[k.ref] - 1
                    tag = f' -> `{script_paths[k.ref]}`' if k.ref in script_paths else ''
                    f.write(f'- {k.cls} `{k.name}`' + (f' ({n})' if n else '') + tag + '\n')
                if len(kids) > 60:
                    f.write(f'- ... {len(kids) - 60} more\n')
                f.write('\n')
        f.write('## UI roots\n\n')
        for r in gui_roots:
            if r.cls in ('BillboardGui', 'SurfaceGui'):
                continue
            en = r.get('Enabled')
            f.write(f'- {r.cls} `{r.name}` ({counts[r.ref] - 1} descendants)'
                    + ('' if en in (None, True) else ' [disabled]') + '\n')
        nworld = sum(1 for r in gui_roots if r.cls in ('BillboardGui', 'SurfaceGui'))
        if nworld:
            f.write(f'- plus {nworld} BillboardGui/SurfaceGui in the world (see ui.txt)\n')
        f.write('\n## Largest scripts\n\n')
        for rel, cls, kind, lines, en, h, linked in sorted(script_rows, key=lambda x: -x[3])[:20]:
            f.write(f'- {lines} lines, {kind}: `{rel}`' + ('' if en else ' [disabled]') + '\n')
        f.write('\n## Scan\n\n')
        f.write(f'- Flags: {hi} HIGH, {md} MED (details in flags.txt)\n')
        f.write(f'- Monetization ids in code: {len(money_ids)}\n')
        f.write(f'- Scripts with decompiler headers: {decomp}; empty scripts: {empty}\n')
        for n_ in notes:
            f.write(f'- {n_}\n')
        if saved_by_exploit or decomp:
            f.write('- Decompiled code comes from a copy of a live game: server-only code was never '
                    'sent to the client, so anything here that looks like server code was rebuilt or '
                    'added by whoever packaged the file\n')
        if place.warnings:
            f.write(f'- Parser skipped {len(place.warnings)} property columns: '
                    + '; '.join(place.warnings[:5]) + '\n')
        f.write('\n## Most common classes\n\n')
        for cls, n in class_count.most_common(25):
            f.write(f'- {cls}: {n}\n')
    return summary


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('inputs', nargs='+')
    ap.add_argument('--out', required=True)
    a = ap.parse_args()
    files = []
    for p in a.inputs:
        if os.path.isdir(p):
            files += [os.path.join(p, n) for n in sorted(os.listdir(p))
                      if n.lower().endswith(('.rbxl', '.rbxm'))]
        else:
            files.append(p)
    os.makedirs(a.out, exist_ok=True)
    rows = []
    for fp in files:
        try:
            s = dump(fp, a.out)
            rows.append(s)
            print(f'OK   {os.path.basename(fp)}: {s["instances"]} inst, {s["scripts"]} scripts, '
                  f'{s["lines"]} lines, {s["high"]} HIGH flags', flush=True)
        except Exception as e:
            import traceback
            traceback.print_exc()
            print(f'FAIL {os.path.basename(fp)}: {e}', flush=True)
    if len(rows) > 1:
        with open(os.path.join(a.out, 'INDEX.md'), 'w', encoding='utf-8') as f:
            f.write('# Unpacked places\n\n| File | Instances | Scripts | Lines | Server/Client/Module | '
                    'ScreenGuis | Remotes | HIGH/MED flags | Pay ids | Notes |\n'
                    '|---|---:|---:|---:|---|---:|---:|---|---:|---|\n')
            for s in rows:
                note = s['notes']
                f.write(f'| [{s["file"]}]({os.path.basename(s["out"])}/README.md) | {s["instances"]} | '
                        f'{s["scripts"]} | {s["lines"]} | {s["server"]}/{s["client"]}/{s["modules"]} | '
                        f'{s["gui_roots"]} | {s["remotes"]} | {s["high"]}/{s["med"]} | {s["money_ids"]} | '
                        f'{note} |\n')


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')
    sys.setrecursionlimit(10000)
    main()
