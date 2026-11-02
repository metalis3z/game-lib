"""rbxpack: cut subtrees out of a parsed place (rbxdump.Place) and write them as binary .rbxm.

Property columns are copied losslessly: each column is split into per-instance raw values
once, then re-joined for the chosen instances. Referents and shared strings are remapped.
Script / LocalScript instances are dropped by default (their children are kept and moved up
one level), so a pack can be inserted into Studio without running anything.
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import lz4.block  # noqa: E402

import rbxdump  # noqa: E402
from rbxdump import MAGIC, Reader, _deinterleave, read_i32s, read_refs, read_u32s  # noqa: E402

# interleaved arrays, one width per array
GROUPS = {0x03: [4], 0x04: [4], 0x06: [4, 4], 0x07: [4, 4, 4, 4], 0x0B: [4], 0x0C: [4, 4, 4],
          0x0D: [4, 4], 0x0E: [4, 4, 4], 0x12: [4], 0x18: [4, 4, 4, 4], 0x1A: [1, 1, 1], 0x1B: [8]}
# plain little-endian values with a fixed width
FIXED = {0x02: 1, 0x05: 8, 0x08: 24, 0x09: 1, 0x0A: 1, 0x14: 6, 0x17: 8}
# UniqueId, SecurityCapabilities and unknown types fall back to engine defaults
SKIP_TYPES = {0x1F, 0x21, 0x23}
SKIP_PROPS = {'UniqueId', 'HistoryId'}
SCRIPT_CLASSES = {'Script', 'LocalScript'}
NEVER_EXPORT = {'Terrain', 'Camera'}


def _interleave(buf, m, w):
    out = bytearray(m * w)
    for j in range(w):
        out[j * m:(j + 1) * m] = buf[j::w]
    return bytes(out)


def _zig(v):
    return ((v << 1) ^ (v >> 31)) & 0xFFFFFFFF


def enc_i32s(vals):
    m = len(vals)
    return _interleave(struct.pack(f'>{m}I', *[_zig(v) for v in vals]), m, 4)


def enc_u32s(vals):
    m = len(vals)
    return _interleave(struct.pack(f'>{m}I', *vals), m, 4)


def enc_refs(vals):
    out, prev = [], 0
    for v in vals:
        out.append(v - prev)
        prev = v
    return enc_i32s(out)


def _string(b):
    return struct.pack('<I', len(b)) + b


class Col:
    __slots__ = ('t', 'kind', 'a', 'b', 'c')

    def __init__(self, t, kind, a=None, b=None, c=None):
        self.t, self.kind, self.a, self.b, self.c = t, kind, a, b, c


def _rot_spans(r, n):
    spans = []
    for _ in range(n):
        s = r.p
        if r.u8() == 0:
            r.take(36)
        spans.append((s, r.p))
    return spans


def split_column(t, payload, off, n):
    """Split one PROP column into per-instance pieces. Raises if the layout does not fit exactly."""
    r = Reader(payload)
    r.p = off
    if t in GROUPS:
        ws = GROUPS[t]
        col = Col(t, 'groups', ws, [_deinterleave(r.take(n * w), n, w) for w in ws])
    elif t in FIXED:
        w = FIXED[t]
        col = Col(t, 'fixed', w, r.take(n * w))
    elif t in (0x01, 0x15, 0x16, 0x19, 0x20):
        spans = []
        for _ in range(n):
            s = r.p
            if t == 0x01:
                r.take(r.u32())
            elif t == 0x15:
                r.take(12 * r.u32())
            elif t == 0x16:
                r.take(20 * r.u32())
            elif t == 0x19:
                flag = r.u8()
                if flag & 1:
                    r.take(20)
                    if flag & 2:
                        r.take(4)
            else:  # Font
                r.take(r.u32())
                r.take(3)
                r.take(r.u32())
            spans.append((s, r.p))
        col = Col(t, 'var', payload, spans)
    elif t == 0x13:
        col = Col(t, 'ref', read_refs(r, n))
    elif t == 0x1C:
        col = Col(t, 'sstr', read_u32s(r, n))
    elif t == 0x10:
        spans = _rot_spans(r, n)
        col = Col(t, 'cframe', payload, spans, [_deinterleave(r.take(n * 4), n, 4) for _ in range(3)])
    elif t == 0x1E:
        if r.u8() != 0x10:
            raise ValueError('OptionalCFrame without CFrame header')
        spans = _rot_spans(r, n)
        groups = [_deinterleave(r.take(n * 4), n, 4) for _ in range(3)]
        if r.u8() != 0x02:
            raise ValueError('OptionalCFrame without bool header')
        col = Col(t, 'optcf', payload, spans, (groups, r.take(n)))
    elif t == 0x22:
        kinds = read_i32s(r, n)
        uris = [r.string() for _ in range(r.u32())]
        objs = read_refs(r, r.u32())
        r.take(4 * r.u32())  # external objects are not kept
        vals, ui, oi = [], 0, 0
        for k in kinds:
            if k == 1 and ui < len(uris):
                vals.append(('uri', uris[ui]))
                ui += 1
            elif k == 2 and oi < len(objs):
                vals.append(('obj', objs[oi]))
                oi += 1
            else:
                vals.append(None)
        col = Col(t, 'content', vals)
    else:
        raise ValueError(f'unsupported type 0x{t:02x}')
    if r.p != len(payload):
        raise ValueError(f'type 0x{t:02x}: {len(payload) - r.p} bytes left over')
    return col


def join_column(col, idxs, refmap, sstr_map):
    k = col.kind
    m = len(idxs)
    if k == 'groups':
        return b''.join(_interleave(b''.join(buf[i * w:(i + 1) * w] for i in idxs), m, w)
                        for w, buf in zip(col.a, col.b))
    if k == 'fixed':
        w, buf = col.a, col.b
        return b''.join(buf[i * w:(i + 1) * w] for i in idxs)
    if k == 'var':
        pl, spans = col.a, col.b
        return b''.join(pl[spans[i][0]:spans[i][1]] for i in idxs)
    if k == 'ref':
        return enc_refs([refmap.get(col.a[i], -1) for i in idxs])
    if k == 'sstr':
        return enc_u32s([sstr_map(col.a[i]) for i in idxs])
    if k in ('cframe', 'optcf'):
        pl, spans = col.a, col.b
        groups = col.c if k == 'cframe' else col.c[0]
        body = b''.join(pl[spans[i][0]:spans[i][1]] for i in idxs)
        body += b''.join(_interleave(b''.join(g[i * 4:(i + 1) * 4] for i in idxs), m, 4) for g in groups)
        if k == 'cframe':
            return body
        return b'\x10' + body + b'\x02' + bytes(col.c[1][i] for i in idxs)
    if k == 'content':
        kinds, uris, objs = [], [], []
        for i in idxs:
            v = col.a[i]
            if v is not None and v[0] == 'uri':
                kinds.append(1)
                uris.append(v[1])
            elif v is not None and v[0] == 'obj' and v[1] in refmap:
                kinds.append(2)
                objs.append(refmap[v[1]])
            else:
                kinds.append(0)
        out = enc_i32s(kinds) + struct.pack('<I', len(uris)) + b''.join(_string(u) for u in uris)
        out += struct.pack('<I', len(objs)) + enc_refs(objs) + struct.pack('<I', 0)
        return out
    raise ValueError(k)


class Packer:
    def __init__(self, place):
        self.place = place
        self.cache = {}  # (class id(obj), prop) -> Col or None
        self.dropped = {}  # 'Class.Prop (0xNN)' -> reason

    def column(self, ci, pname):
        key = (id(ci), pname)
        if key not in self.cache:
            t, payload, off = ci.raw[pname]
            col = None
            if t not in SKIP_TYPES and pname not in SKIP_PROPS:
                try:
                    col = split_column(t, payload, off, len(ci.refs))
                except Exception as e:
                    self.dropped[f'{ci.name}.{pname} (0x{t:02x})'] = str(e)
            self.cache[key] = col
        return self.cache[key]

    def collect(self, roots, strip_scripts=True, skip=None):
        """DFS order list of (inst, new_parent_ref or -1); scripts are dropped, children kept."""
        order, removed = [], []
        stack = [(r, -1) for r in reversed(roots)]
        while stack:
            inst, parent = stack.pop()
            if inst.cls in NEVER_EXPORT or (skip is not None and skip(inst)):
                continue
            if strip_scripts and inst.cls in SCRIPT_CLASSES:
                removed.append(inst)
                stack.extend((c, parent) for c in reversed(inst.children))
                continue
            order.append((inst, parent))
            stack.extend((c, inst.ref) for c in reversed(inst.children))
        return order, removed

    def build(self, roots, strip_scripts=True, skip=None):
        """Return (rbxm bytes, list of exported Inst, list of removed scripts)."""
        order, removed = self.collect(roots, strip_scripts, skip)
        refmap = {inst.ref: i for i, (inst, _) in enumerate(order)}
        by_class, class_order = {}, []
        for inst, _ in order:
            if inst.ci.name not in by_class:
                by_class[inst.ci.name] = []
                class_order.append(inst.ci)
            by_class[inst.ci.name].append(inst)

        sstr_entries = self.place.sstr_entries
        new_sstr, sstr_index = [], {}

        def sstr_map(old):
            if old not in sstr_index:
                sstr_index[old] = len(new_sstr)
                new_sstr.append(sstr_entries[old] if old < len(sstr_entries) else (b'\0' * 16, b''))
            return sstr_index[old]

        inst_chunks, prop_chunks = [], []
        for cid, ci in enumerate(class_order):
            members = by_class[ci.name]
            # instances of one class name can come from one ClassInfo only within a place
            idxs = [inst.idx for inst in members]
            refs = [refmap[inst.ref] for inst in members]
            inst_chunks.append(struct.pack('<I', cid) + _string(ci.name.encode()) + b'\x00'
                               + struct.pack('<I', len(members)) + enc_refs(refs))
            for pname in ci.raw:
                col = self.column(ci, pname)
                if col is None:
                    continue
                data = join_column(col, idxs, refmap, sstr_map)
                prop_chunks.append(struct.pack('<I', cid) + _string(pname.encode()) + bytes([col.t]) + data)

        kids = list(range(len(order)))
        parents = [refmap.get(p, -1) if p != -1 else -1 for _, p in order]
        prnt = b'\x00' + struct.pack('<I', len(order)) + enc_refs(kids) + enc_refs(parents)

        out = bytearray(MAGIC + struct.pack('<HII', 0, len(class_order), len(order)) + b'\0' * 8)

        def chunk(name, payload, compress=True):
            tag = name.encode().ljust(4, b'\0')
            if compress and payload:
                comp = lz4.block.compress(payload, store_size=False)
                if len(comp) < len(payload):
                    out.extend(tag + struct.pack('<III', len(comp), len(payload), 0) + comp)
                    return
            out.extend(tag + struct.pack('<III', 0, len(payload), 0) + payload)

        chunk('META', struct.pack('<I', 1) + _string(b'ExplicitAutoJoints') + _string(b'true'))
        if new_sstr:
            chunk('SSTR', struct.pack('<II', 0, len(new_sstr))
                  + b''.join(h + _string(s) for h, s in new_sstr))
        for c in inst_chunks:
            chunk('INST', c)
        for c in prop_chunks:
            chunk('PROP', c)
        chunk('PRNT', prnt)
        chunk('END', b'</roblox>', compress=False)
        return bytes(out), [inst for inst, _ in order], removed
