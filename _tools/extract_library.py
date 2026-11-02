#!/usr/bin/env python3
"""extract_library: split Roblox places into a reusable asset library.

    python -I extract_library.py <file-or-folder> [...] --out D:\\Rodev\\asset-library

Per game it writes ui/, map/, models/, animations/, audio/ packs as .rbxm (scripts removed),
plus catalog.jsonl, metrics.json, README.md and reference.md. A top-level INDEX.md and a
merged catalog.jsonl cover every game.
"""
import argparse
import collections
import hashlib
import json
import os
import re
import statistics
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import rbxdump  # noqa: E402
import rbxpack  # noqa: E402
from rbxdump import decode_attributes, fmt_color, lp, safe, seg  # noqa: E402

# --------------------------------------------------------------- game list

GAMES = {
    '+1 Drill & Mine': ('drill-and-mine', '+1 Drill & Mine', 'incremental simulator (+1 speed, mining, drills)'),
    '+1 Shrink Keyboard Escape': ('shrink-keyboard-escape', '+1 Shrink Keyboard Escape', 'obby / escape (+1 size)'),
    'BIG Paintball! Classic 🔫-1': ('big-paintball', 'BIG Paintball! Classic', 'arena FPS'),
    'Bee20Sim(1)': ('bee-swarm-sim', 'Bee Swarm Simulator (remake)', 'collecting simulator'),
    'Bite By Night For Slbr Boosters !': ('bite-by-night', 'Bite By Night', 'asymmetric horror (killer vs survivors)'),
    'Build20Raft20Sail': ('build-a-raft', 'Build a Raft & Sail', 'building / survival'),
    'Driving_Empire%20(1)': ('driving-empire', 'Driving Empire', 'open-world driving'),
    'JJS paid 10k, by slbr devloppement team': ('jujutsu-shenanigans', 'Jujutsu Shenanigans', 'anime battlegrounds (fighting)'),
    'One Piece - The Age Of Pirates': ('one-piece-age-of-pirates', 'One Piece: The Age Of Pirates', 'anime RPG'),
    'paidAnimal Hospitial DECOMP': ('animal-hospital', 'Animal Hospital', 'roleplay / tycoon'),
    'Pick20Side': ('pick-a-side', 'Pick a Side', 'party / team minigames'),
    'TheDustyTrip': ('dusty-trip', 'The Dusty Trip (framework)', 'driving survival framework'),
    'TRADE SYSTEM V1 +1 SPEED MADE BY SLBR': ('trade-system', 'Trade System V1', 'system module (trading UI + service)'),
    'VIP +1 NEEDOH ESCAPE BY RBU': ('needoh-escape', '+1 NeeDoh Escape', 'obby / escape (+1 speed)'),
    'VIP - Keyboard20Trading%20V2 (1)': ('keyboard-trading', 'Keyboard Trading V2', 'trading simulator'),
    'VIP - Steal an Egg (Beta) (1)': ('steal-an-egg', 'Steal an Egg', 'steal / tycoon (eggs, pets, plots)'),
    '🔥 Pyxx Pass The Bomb (Tower)': ('pass-the-bomb', 'Pass The Bomb (Tower)', 'party elimination'),
    # D:\Rodev\raw-game, added 2026-10-30
    'Doors Fully Scripted Game (1)': ('doors', 'Doors (fully scripted)', 'horror / room escape'),
    'Drive For Brainrots - With AP- SLBR BOOSTER': ('drive-for-brainrots', 'Drive For Brainrots',
                                                    'driving / brainrot collecting simulator'),
    'FIXED! GAG2 credit - quartz games studio': ('grow-a-garden-2', 'Grow a Garden 2 (GAG2)',
                                                 'farming / garden simulator'),
    'Mine A Brainrot SLBR BOOSTER': ('mine-a-brainrot', 'Mine A Brainrot', 'mining / brainrot simulator'),
    'New MM2 Leak': ('murder-mystery-2', 'Murder Mystery 2', 'social deduction (murderer vs sheriff)'),
    'Punching Simulator Fully scripted': ('punching-simulator', 'Punching Simulator', 'training simulator'),
    'ScooterObby%20(1)': ('scooter-obby', 'Scooter Obby', 'obby (scooter)'),
    'Shattered Aether Map': ('shattered-aether-map', 'Shattered Aether (map)', 'map / environment pack'),
    'Steal a badr (Kaizou scameur !!!)': ('steal-a-brainrot', 'Steal a Brainrot', 'steal / tycoon (brainrots, plots)'),
    'Vergil': ('vergil', 'Vergil (character kit)', 'character / ability kit'),
    'Zombie Outbreak Survival': ('zombie-outbreak-survival', 'Zombie Outbreak Survival', 'wave survival shooter'),
    # file is named Evade, but the place is a brainrot steal game (lucky blocks, trader, mutations, fishing)
    '[💎]Evade only for vip new version': ('evade', '"Evade" (brainrot game)',
                                          'steal / tycoon (brainrots, lucky blocks; file named Evade)'),
    '🧀 I Backrooms Exploration By Fares': ('backrooms-exploration', 'Backrooms Exploration', 'horror exploration'),
    # Downloads\need_unpack, added 2026-10-31
    '100 weapons models made by mtsowiks': ('weapons-pack-100', '100 Weapons Models (mtsowiks)',
                                            'model pack (weapons)'),
    'Forest Pack Made By slbr - Booster': ('forest-pack', 'Forest Pack (slbr)', 'model pack (nature / forest)'),
    'SLBR - Booster - Tower Of Hell': ('tower-of-hell', 'Tower Of Hell', 'obby (procedural tower)'),
    'SLBR - RIVALS MODDED - BOOSTER': ('rivals-modded', 'RIVALS (modded)', 'arena FPS (duels)'),
    'THE_RAKE_KILL_TEST_ORIGINAL (1)': ('the-rake', 'The Rake (kill test)', 'horror survival (monster)'),
    'Work_at_a_pizza_place': ('work-at-a-pizza-place', 'Work at a Pizza Place', 'roleplay / job simulator'),
    'paid_gore_game_leaked': ('gore-game', 'Gore game (leak)', 'combat / gore physics'),
    # Downloads\need_unpack, added 2026-11-01. GAG2 and SAE are newer versions of games already in the library:
    # they are extracted to a staging folder and merged into grow-a-garden-2 / steal-an-egg.
    'Grow A Garden 2 -': ('grow-a-garden-2', 'Grow a Garden 2 (GAG2)', 'farming / garden simulator'),
    'SLBR- VIP - SAE LATEST': ('steal-an-egg', 'Steal an Egg', 'steal / tycoon (eggs, pets, plots)'),
    'VIP - SLBR - Catalogue Avatar Creator': ('catalogue-avatar-creator', 'Catalogue Avatar Creator',
                                              'avatar editor / catalog browser'),
}

# --------------------------------------------------------------- class groups

BASEPART = {'Part', 'MeshPart', 'UnionOperation', 'IntersectOperation', 'NegateOperation', 'PartOperation',
            'WedgePart', 'CornerWedgePart', 'TrussPart', 'Seat', 'VehicleSeat', 'SpawnLocation',
            'SkateboardPlatform', 'FlagStand'}
MESHY = {'MeshPart', 'UnionOperation', 'IntersectOperation', 'NegateOperation', 'PartOperation'}
UNIT = {'Model', 'Tool', 'HopperBin', 'Accessory', 'Accoutrement', 'Hat', 'Actor', 'WorldModel'}
CONTAINER = {'Folder', 'Configuration', 'StarterPlayerScripts', 'StarterCharacterScripts'}
GUI_ROOTS = {'ScreenGui', 'SurfaceGui', 'BillboardGui', 'Frame', 'ImageLabel', 'ImageButton', 'TextLabel',
             'TextButton', 'TextBox', 'ScrollingFrame', 'ViewportFrame', 'CanvasGroup', 'VideoFrame'}
GUI_OBJECTS = GUI_ROOTS - {'ScreenGui', 'SurfaceGui', 'BillboardGui'}
VFX = {'Attachment', 'ParticleEmitter', 'Beam', 'Trail', 'Fire', 'Smoke', 'Sparkles', 'PointLight',
       'SpotLight', 'SurfaceLight', 'Highlight', 'Explosion'}
LIGHTS = {'PointLight', 'SpotLight', 'SurfaceLight'}
SOUNDS = {'Sound', 'SoundGroup'}
SCRIPTS = {'Script', 'LocalScript', 'ModuleScript'}
MODEL_SERVICES = ['ReplicatedStorage', 'ServerStorage', 'ServerScriptService', 'ReplicatedFirst', 'StarterPack',
                  'StarterPlayer', 'Lighting', 'Workspace']
# code-only classes: a leftover subtree made only of these is not an asset (code lives in _unpacked)
LOGIC_ONLY = {'Script', 'LocalScript', 'ModuleScript', 'RemoteEvent', 'RemoteFunction', 'UnreliableRemoteEvent',
              'BindableEvent', 'BindableFunction', 'Folder', 'Configuration', 'StarterPlayerScripts',
              'StarterCharacterScripts'}
LEFTOVER_SKIP_SERVICES = {'InsertService'}  # only an InsertionHash value
TERRAIN_MIN_BYTES = 64  # an empty Terrain still stores a few header bytes
POST = {'Atmosphere', 'BloomEffect', 'ColorCorrectionEffect', 'SunRaysEffect', 'DepthOfFieldEffect',
        'BlurEffect', 'Sky', 'Clouds', 'ColorGradingEffect'}

MATERIALS = {256: 'Plastic', 272: 'SmoothPlastic', 288: 'Neon', 512: 'Wood', 528: 'WoodPlanks', 784: 'Marble',
             788: 'Basalt', 800: 'Slate', 804: 'CrackedLava', 816: 'Concrete', 820: 'Limestone', 832: 'Granite',
             836: 'Pavement', 848: 'Brick', 864: 'Pebble', 880: 'Cobblestone', 896: 'Rock', 912: 'Sandstone',
             1040: 'CorrodedMetal', 1056: 'DiamondPlate', 1072: 'Foil', 1088: 'Metal', 1280: 'Grass',
             1284: 'LeafyGrass', 1296: 'Sand', 1312: 'Fabric', 1328: 'Snow', 1344: 'Mud', 1360: 'Asphalt',
             1376: 'Ground', 1392: 'Salt', 1536: 'Ice', 1552: 'Glacier', 1568: 'Glass', 1584: 'ForceField',
             1792: 'Air', 2048: 'Water'}
TECHNOLOGY = {0: 'Legacy', 1: 'Voxel', 2: 'Compatibility', 3: 'ShadowMap', 4: 'Future', 5: 'Unified'}

TAG_WORDS = {
    'pet': 'pet pets companion companions brainrot brainrots assetmodels bee bees',
    'collectible': 'collectible collectibles keycap keycaps candy candys coin coins gem gems rarityitems '
                   'rarityitemsoriginals luckyblock luckyblocks relic relics ore ores crate crates chest chests',
    'cutscene': 'cutscene cutscenes cutscenesfolder cutsceneassets',
    'ability': 'moves move resources skill skills ability abilities domain domains kjeffects emote emotes',
    'decoration': 'decorations decoration decor deco props prop landscaping streetlights',
    'interior': 'rooms room furniture interior',
    'road': 'road roads street streets',
    'portal': 'portal portals teleport teleports tp',
    'egg': 'egg eggs incubator',
    'weapon': 'gun guns weapon weapons sword swords bat bats katana axe blade knife blaster rifle pistol',
    'tool': 'tool tools gear gears item items pickaxe drill drills shovel',
    'vehicle': 'car cars vehicle vehicles truck trucks boat boats raft bike bikes kart plane jet heli',
    'character': 'npc npcs character characters rig rigs dummy dummies monster monsters boss bosses enemy '
                 'enemies animatronic animatronics killer killers survivor survivors guard guards',
    'vfx': 'vfx fx effect effects particle particles aura auras trail trails explosion hit impact',
    'building': 'house houses building buildings shop shops base bases plot plots tower structure structures '
                'stand stands booth',
    'nature': 'tree trees rock rocks bush bushes grass flower flowers plant plants cloud clouds crystal crystals',
    'map': 'map maps lobby arena level levels world worlds area areas zone zones island islands stage stages',
    'sign': 'billboard billboards sign signs board boards leaderboard leaderboards',
    'accessory': 'accessory accessories hat hats wings cosmetic cosmetics skin skins hair',
    'treadmill': 'treadmill treadmills',
    'keyboard': 'keyboard keyboards key keys',
}
TAG_WORDS['backup'] = 'rejects backup backups old unused test remove deprecated temp archive'
TAG_INDEX = {w: tag for tag, words in TAG_WORDS.items() for w in words.split()}
UI_TAG_WORDS = {
    'shop': 'shop shops store robux gamepass gamepasses product products buy purchase market',
    'hud': 'hud main mainhud gui gameui ui topbar hotbar bottomui stats',
    'inventory': 'inventory backpack bag storage pets',
    'index': 'index codex collection',
    'settings': 'settings options',
    'popup': 'popup popups prompt prompts notification notifications message messages alert',
    'reward': 'reward rewards daily gift gifts freegift offline spin',
    'trade': 'trade trading',
    'loading': 'loading intro',
    'leaderboard': 'leaderboard leaderboards lb',
    'rebirth': 'rebirth rebirths ascension',
    'upgrade': 'upgrade upgrades',
    'quest': 'quest quests questline',
    'backup': TAG_WORDS['backup'],
}
UI_TAG_INDEX = {w: tag for tag, words in UI_TAG_WORDS.items() for w in words.split()}


def words_of(path):
    parts = re.split(r'[^A-Za-z0-9]+', re.sub(r'([a-z])([A-Z])', r'\1 \2', path))
    return [p.lower() for p in parts if p]


def tags_for(path, stats, kind='model'):
    if kind in ('ui', 'ui-kit'):
        # only the screen's own name and its folder: service names ("StarterGui") would tag everything "hud"
        segs = [s for s in path.split('.') if s and s not in KNOWN_SERVICES and s != 'StarterGui/* (every GUI)']
        words = [w for s in segs[-2:] for w in words_of(s)]
        tags = {UI_TAG_INDEX[w] for w in words if w in UI_TAG_INDEX}
        if any(w in TAG_INDEX and TAG_INDEX[w] == 'backup' for w in words_of(path)):
            tags.add('backup')
        return sorted(tags)
    tags = {TAG_INDEX[w] for w in words_of(path) if w in TAG_INDEX}
    if stats['classes'].get('Tool'):
        tags.add('tool')
    if stats['classes'].get('Humanoid') or stats['classes'].get('AnimationController'):
        tags.add('character')
    if stats['emitters'] >= 3 and stats['parts'] <= 10:
        tags.add('vfx')
    if stats['classes'].get('Accessory'):
        tags.add('accessory')
    return sorted(tags)


# --------------------------------------------------------------- geometry

AXES = [(1, 0, 0), (0, 1, 0), (0, 0, 1), (-1, 0, 0), (0, -1, 0), (0, 0, -1)]


def rot_matrix(rot):
    if isinstance(rot, tuple):
        return rot
    n = rot - 1
    x, y = AXES[n // 6], AXES[n % 6]
    z = (x[1] * y[2] - x[2] * y[1], x[2] * y[0] - x[0] * y[2], x[0] * y[1] - x[1] * y[0])
    return (x[0], y[0], z[0], x[1], y[1], z[1], x[2], y[2], z[2])


class Geo:
    """Lazy per-class access to CFrame and size of parts."""

    def __init__(self, place):
        self.place = place

    def box(self, inst):
        ci = inst.ci
        cfs = self.place.ensure_col(ci, 'CFrame')
        sizes = self.place.ensure_col(ci, 'size') or self.place.ensure_col(ci, 'Size')
        if not cfs or not sizes:
            return None
        cf, sz = cfs[inst.idx], sizes[inst.idx]
        if not isinstance(cf, dict) or not isinstance(sz, tuple):
            return None
        r = rot_matrix(cf['rot'])
        hx, hy, hz = sz[0] / 2, sz[1] / 2, sz[2] / 2
        ex = abs(r[0]) * hx + abs(r[1]) * hy + abs(r[2]) * hz
        ey = abs(r[3]) * hx + abs(r[4]) * hy + abs(r[5]) * hz
        ez = abs(r[6]) * hx + abs(r[7]) * hy + abs(r[8]) * hz
        px, py, pz = cf['pos']
        return (px - ex, py - ey, pz - ez, px + ex, py + ey, pz + ez)


def merge_box(a, b):
    if a is None:
        return b
    if b is None:
        return a
    return (min(a[0], b[0]), min(a[1], b[1]), min(a[2], b[2]), max(a[3], b[3]), max(a[4], b[4]), max(a[5], b[5]))


# --------------------------------------------------------------- helpers

def txt(v):
    return v.decode('utf-8', 'replace') if isinstance(v, bytes) else v


def get(place, inst, prop):
    col = place.ensure_col(inst.ci, prop)
    return None if col is None else col[inst.idx]


def plain(v):
    if isinstance(v, bytes):
        return txt(v)
    if isinstance(v, float):
        return round(v, 4)
    if isinstance(v, (list, tuple)):
        return [plain(x) for x in v]
    if isinstance(v, dict):
        return {k: plain(x) for k, x in v.items()}
    return v


def props_json(place, inst, keep=None):
    out = {}
    for pname, t in inst.ci.types.items():
        if keep is not None and pname not in keep:
            continue
        if pname in rbxdump.BLOB_PROPS or pname in ('UniqueId', 'HistoryId', 'SourceAssetId'):
            continue
        v = get(place, inst, pname)
        if v is None:
            continue
        if t in (0x0C, 0x1A):
            v = fmt_color(v)
        elif t == 0x13:
            tgt = place.insts.get(v)
            v = place.full_name(tgt) if tgt else None
        out[pname] = plain(v)
    a = decode_attributes(get(place, inst, 'AttributesSerialize'))
    if a:
        out['@attributes'] = plain(a)
    return out


ASSET_RE = re.compile(rb'(?:rbxassetid://|[?&]id=)(\d{3,})', re.I)


def subtree_stats(place, insts, geo):
    classes = collections.Counter(i.cls for i in insts)
    box, meshes, images = None, set(), set()
    for i in insts:
        if i.cls in BASEPART:
            box = merge_box(box, geo.box(i))
        for pname in ('MeshId', 'MeshContent', 'TextureID', 'Texture', 'Image', 'ColorMap'):
            v = i.get(pname)
            if isinstance(v, bytes) and v:
                for m in ASSET_RE.finditer(v):
                    (meshes if pname.startswith('Mesh') else images).add(m.group(1).decode())
    parts = sum(n for c, n in classes.items() if c in BASEPART)
    return {
        'classes': classes,
        'instances': len(insts),
        'parts': parts,
        'meshparts': classes.get('MeshPart', 0),
        'unions': sum(classes.get(c, 0) for c in MESHY if c != 'MeshPart'),
        'emitters': classes.get('ParticleEmitter', 0) + classes.get('Beam', 0) + classes.get('Trail', 0),
        'lights': sum(classes.get(c, 0) for c in LIGHTS),
        'sounds': classes.get('Sound', 0),
        'guis': sum(n for c, n in classes.items() if c in GUI_ROOTS),
        'box': box,
        'mesh_ids': len(meshes),
        'image_ids': len(images),
    }


KNOWN_SERVICES = {'Workspace', 'ReplicatedStorage', 'ServerStorage', 'ServerScriptService', 'StarterGui',
                  'StarterPack', 'StarterPlayer', 'StarterPlayerScripts', 'StarterCharacterScripts',
                  'ReplicatedFirst', 'Lighting', 'SoundService', 'Teams', 'Chat', 'TextChatService',
                  'MaterialService'}
GROUP_MIN = 6  # siblings sharing a base name at or above this count become one set pack


def service_roots(place):
    """Map role -> list of instances acting as that service.

    Normal places: the real services. Kits saved as one Model/Folder whose children are named
    after services (e.g. a "+1 Speed V1 Kit" model) get those children as stand-ins."""
    roles = collections.defaultdict(list)
    for r in place.roots:
        if r.cls in KNOWN_SERVICES:
            roles[r.cls].append(r)
        elif r.cls in ('Model', 'Folder'):
            named = [c for c in r.children if c.name in KNOWN_SERVICES]
            if len(named) >= 3:
                for c in named:
                    roles[c.name].append(c)
    if not roles:
        # model file (.rbxm pack) with no services: treat its roots as storage so every model gets a pack
        for r in place.roots:
            roles['ReplicatedStorage'].append(r)
    return roles


def role_lookup(place):
    roles = service_roots(place)
    owner = {inst.ref: role for role, insts in roles.items() for inst in insts}

    def role_of(inst):
        cur = inst
        while cur is not None:
            if cur.ref in owner:
                return owner[cur.ref]
            cur = cur.parent
        return None
    return roles, role_of


def base_name(name):
    return re.sub(r'[\s_\-]*\(?\d+\)?$', '', name).strip().lower() or name.lower()


# --------------------------------------------------------------- exporter

class Exporter:
    def __init__(self, place, game_dir, slug, unpacked_dir):
        self.place = place
        self.dir = game_dir
        self.slug = slug
        self.unpacked = unpacked_dir
        self.packer = rbxpack.Packer(place)
        self.geo = Geo(place)
        self.catalog = []
        self.hashes = {}
        self.bytes_written = 0
        self.files = 0
        self.scripts_removed = 0
        self.roles, self.role_of = role_lookup(place)
        # model packs keep one file per model instead of sample + set
        self.group_min = GROUP_MIN if any(r.cls in KNOWN_SERVICES for r in place.roots) else 10 ** 9
        self.role_roots = {i.ref for insts in self.roles.values() for i in insts}
        self.covered = set()  # refs of every instance that is inside a pack (or a script that was removed)

    def chain(self, inst):
        """Ancestors from the service (or stand-in service) down to the parent."""
        out = []
        cur = inst.parent
        while cur is not None:
            out.append(cur)
            if cur.ref in self.role_roots:
                break
            cur = cur.parent
        return out[::-1]

    def rel_dir(self, inst):
        return '/'.join(seg(a) for a in self.chain(inst))

    def write(self, kind, rel, roots, source=None, extra=None, built=None):
        roots = [r for r in roots if r is not None]
        if not roots:
            return None
        data, exported, removed = built or self.packer.build(roots)
        if not exported:
            return None
        self.covered.update(i.ref for i in exported)
        self.covered.update(i.ref for i in removed)
        stats = subtree_stats(self.place, exported, self.geo)
        h = hashlib.md5(data).hexdigest()
        src = source or (self.place.full_name(roots[0]) if len(roots) == 1 else
                         f'{self.place.full_name(roots[0].parent) if roots[0].parent else "(root)"}/*')
        entry = {
            'game': self.slug, 'kind': kind, 'file': f'{self.slug}/{rel}', 'source': src,
            'class': roots[0].cls if len(roots) == 1 else f'{len(roots)} roots',
            'instances': stats['instances'], 'parts': stats['parts'], 'meshparts': stats['meshparts'],
            'unions': stats['unions'], 'emitters': stats['emitters'], 'lights': stats['lights'],
            'sounds': stats['sounds'], 'guis': stats['guis'], 'mesh_ids': stats['mesh_ids'],
            'image_ids': stats['image_ids'], 'scripts_removed': len(removed),
            'size': [round(stats['box'][3 + k] - stats['box'][k], 1) for k in range(3)] if stats['box'] else None,
            'tags': tags_for(src, stats, kind), 'kb': round(len(data) / 1024, 1),
        }
        if removed:
            entry['scripts_at'] = 'source/scripts/' + \
                '/'.join(seg(a) for a in self.place.ancestors(roots[0])) + '/'
        if extra:
            entry.update(extra)
        if h in self.hashes:
            entry['dup_of'] = self.hashes[h]
            entry['file'] = None
        else:
            self.hashes[h] = entry['file']
            fp = lp(os.path.join(self.dir, rel))
            os.makedirs(os.path.dirname(fp), exist_ok=True)
            with open(fp, 'wb') as f:
                f.write(data)
            self.bytes_written += len(data)
            self.files += 1
            self.scripts_removed += len(removed)
        self.catalog.append(entry)
        return entry

    # ---------------- UI
    def export_ui(self):
        p = self.place
        n = 0
        guis = [c for root in self.roles.get('StarterGui', []) for c in root.children if c.cls in GUI_ROOTS]
        for c in guis:  # single screens first, so a one-screen kit is the duplicate, not the screen
            self.write('ui', f'ui/StarterGui/{seg(c)}.rbxm', [c])
            n += 1
        if guis:
            self.write('ui-kit', 'ui/_StarterGui-all.rbxm', guis, source='StarterGui/* (every GUI)')
        # GUIs kept inside folders in StarterGui (one pack per GUI, folder path kept)
        for root in self.roles.get('StarterGui', []):
            stack = [c for c in root.children if c.cls in CONTAINER]
            while stack:
                cont = stack.pop()
                for c in cont.children:
                    if c.cls in GUI_ROOTS:
                        self.write('ui', f'ui/{self.rel_dir(c)}/{seg(c)}.rbxm', [c])
                        n += 1
                    elif c.cls in CONTAINER:
                        stack.append(c)
        # GUI templates stored elsewhere (not attached to a part in the world)
        for inst in p.walk():
            if inst.cls not in GUI_ROOTS or inst.parent is None or inst.ref in self.role_roots:
                continue
            role = self.role_of(inst)
            if role in ('StarterGui', 'Workspace') or (role is None and p.root_of(inst).cls in (
                    'StarterGui', 'Workspace', 'CoreGui', 'Players')):
                continue
            par = inst.parent
            if par.cls in GUI_ROOTS or par.cls in BASEPART or par.cls == 'Attachment':
                continue
            chain = self.chain(inst)
            if any(a.cls in GUI_ROOTS or (a.cls in UNIT and a.ref not in self.role_roots) for a in chain[1:]):
                continue
            self.write('ui', f'ui/{self.rel_dir(inst)}/{seg(inst)}.rbxm', [inst])
            n += 1
        return n

    # ---------------- map
    def export_map(self):
        p = self.place
        info = {}
        for role, insts in self.roles.items():
            for root in insts:
                self._map_root(role, root, info)
        with open(lp(os.path.join(self.dir, 'map', 'environment.json')), 'w', encoding='utf-8') as f:
            json.dump(info, f, indent=1, ensure_ascii=False, default=str)
        return info

    def _map_root(self, role, root, info):
        p = self.place
        if True:
            if role == 'Workspace':
                kids = [c for c in root.children if c.cls not in ('Terrain', 'Camera')]
                self.write('map', 'map/workspace.rbxm', kids, source='Workspace/* (whole map, no terrain)')
                info['workspace'] = props_json(p, root, keep={
                    'Gravity', 'StreamingEnabled', 'StreamingMinRadius', 'StreamingTargetRadius',
                    'FallenPartsDestroyHeight', 'SignalBehavior', 'GlobalWind', 'AirDensity'})
                for c in root.children:
                    if c.cls == 'Terrain':
                        grid = c.get('SmoothGrid') or b''
                        t = props_json(p, c)
                        t.pop('MaterialColors', None)
                        t['voxel_data_bytes'] = len(grid)
                        info['terrain'] = t
                        if len(grid) > TERRAIN_MIN_BYTES:
                            self.export_terrain(root, c)
                            t['file'] = 'map/terrain.rbxl'
            elif role == 'Lighting':
                kids = list(root.children)
                self.write('lighting', 'map/lighting.rbxm', kids, source='Lighting/* (sky + post effects)')
                if root.cls != 'Lighting':
                    info['lighting'] = {}
                    info['lighting_note'] = (f'"{root.name}" is a {root.cls} standing in for Lighting in a kit: '
                                             'it carries no Lighting properties, only the effects inside it')
                else:
                    info['lighting'] = props_json(p, root)
                tech = info['lighting'].get('Technology')
                if isinstance(tech, int):
                    info['lighting']['Technology'] = TECHNOLOGY.get(tech, tech)
                info['lighting_children'] = [
                    {'class': c.cls, 'name': c.name, 'props': props_json(p, c)} for c in kids if c.cls in POST]
            elif role == 'SoundService':
                if root.children:
                    self.write('audio', 'audio/soundservice.rbxm', list(root.children), source='SoundService/*')
                info['soundservice'] = props_json(p, root, keep={'AmbientReverb', 'DistanceFactor',
                                                                   'RolloffScale', 'DopplerScale'})
            elif role == 'Teams' and root.children:
                info['teams'] = [{'name': c.name, 'color': c.get('TeamColor')} for c in root.children]
            elif role == 'MaterialService':
                if root.children:
                    self.write('materials', 'map/materials.rbxm', list(root.children), source='MaterialService/*')
                info['materialservice'] = props_json(p, root)
                info['material_variants'] = [
                    {'name': v.name, 'path': p.full_name(v), 'base': MATERIALS.get(v.get('BaseMaterial'),
                                                                                   v.get('BaseMaterial'))}
                    for v in p.walk(list(root.children)) if v.cls == 'MaterialVariant']

    def export_terrain(self, ws, terrain):
        """Terrain cannot go in a .rbxm, so write a place with only Workspace.Terrain and MaterialService."""
        p = self.place
        roots = [ws] + [r for r in self.roles.get('MaterialService', []) if r.cls == 'MaterialService']
        old = rbxpack.NEVER_EXPORT
        rbxpack.NEVER_EXPORT = {'Camera'}
        try:
            built = self.packer.build(roots, skip=lambda i: i.parent is not None and i.parent.ref == ws.ref
                                      and i.ref != terrain.ref)
        finally:
            rbxpack.NEVER_EXPORT = old
        data, exported, removed = built
        # only Terrain counts as covered here; the services and materials are covered by their own packs
        built = (data, [i for i in exported if i.ref == terrain.ref], [])
        self.write('terrain', 'map/terrain.rbxl', [terrain], source='Workspace.Terrain (voxels, open as a place)',
                   built=built, extra={'voxel_data_bytes': len(terrain.get('SmoothGrid') or b'')})

    # ---------------- leftovers: anything no other pack picked up
    def export_leftovers(self):
        p = self.place
        roots = {r.ref for r in p.roots}
        skip_root = {r.ref for r in p.roots if r.cls in LEFTOVER_SKIP_SERVICES}
        groups = collections.OrderedDict()
        for inst in p.walk():
            if inst.ref in self.covered or inst.ref in roots or inst.ref in self.role_roots:
                continue
            if inst.cls in ('Terrain', 'Camera') or p.root_of(inst).ref in skip_root:
                continue
            par = inst.parent
            if not (par is None or par.ref in self.covered or par.ref in roots or par.ref in self.role_roots
                    or par.cls in ('Camera', 'Terrain')):  # Clouds, attachments under Terrain
                continue  # inside another leftover that is packed whole
            if all(d.cls in LOGIC_ONLY for d in p.walk([inst])):
                continue  # code, remotes or empty folders only
            groups.setdefault(par.ref if par else None, (par, []))[1].append(inst)
        n = 0
        for par, insts in groups.values():
            path = '/'.join(seg(a) for a in (p.ancestors(insts[0]))) or '_root'
            src = f'{p.full_name(par)}/* (not in any other pack)' if par else '(root)/*'
            if self.write('other', f'models/{path}/_other.rbxm', insts, source=src):
                n += 1
        return n

    def coverage(self):
        """Every instance of the place is either packed, code, or listed here as not exported."""
        p = self.place
        roots = {r.ref for r in p.roots}
        total, packed, code, services, missing = 0, 0, 0, 0, collections.Counter()
        for inst in p.walk():
            total += 1
            if inst.ref in roots or inst.ref in self.role_roots:
                services += 1
            elif inst.ref in self.covered:
                packed += 1
            elif inst.cls in LOGIC_ONLY:
                code += 1
            else:
                missing[f'{p.root_of(inst).cls}.{inst.cls}'] += 1
        return {'instances': total, 'packed': packed, 'services': services,
                'code_or_empty_folders_not_packed': code, 'not_packed': dict(missing.most_common()),
                'note': 'not_packed should hold only Terrain/Camera and InsertService.InsertionHash; '
                        'Terrain voxels are in map/terrain.rbxl when the place has terrain'}

    # ---------------- models
    def is_container_model(self, inst):
        if inst.cls != 'Model':
            return False
        kids = inst.children
        if any(k.cls in BASEPART for k in kids):
            return False
        units = sum(1 for k in kids if k.cls in UNIT or k.cls in BASEPART)
        return units >= 3

    def export_models(self):
        p = self.place
        count = 0
        model_roots = [(role, r) for role in MODEL_SERVICES + ['StarterPlayerScripts', 'StarterCharacterScripts']
                       for r in self.roles.get(role, [])]
        for role, root in model_roots:
            stack = [(root, [seg(root)])]
            while stack:
                cont, path = stack.pop()
                loose, vfx, snd, anim, units = [], [], [], [], []
                for c in cont.children:
                    if c.cls in ('Terrain', 'Camera'):
                        continue
                    if c.cls in SCRIPTS:
                        if c.children:  # data modules often hold models; the script itself is not exported
                            stack.append((c, path + [seg(c)]))
                        continue
                    if c.cls in CONTAINER or self.is_container_model(c):
                        stack.append((c, path + [seg(c)]))
                    elif c.cls in GUI_ROOTS:
                        continue  # exported as UI
                    elif c.cls in UNIT or c.cls in MESHY or (c.cls in BASEPART and c.children):
                        units.append(c)
                    elif c.cls in BASEPART:
                        loose.append(c)
                    elif c.cls in VFX:
                        vfx.append(c)
                    elif c.cls in SOUNDS:
                        snd.append(c)
                    elif c.cls in ('Animation', 'KeyframeSequence'):
                        anim.append(c)
                base = 'models/' + '/'.join(path)
                groups = collections.OrderedDict()
                for u in units:
                    groups.setdefault((u.cls, base_name(u.name)), []).append(u)
                for members in groups.values():
                    if len(members) >= self.group_min:
                        # many copies of one asset (keycaps, platforms, trees): one sample + one set
                        first = members[0]
                        if self.write('model', f'{base}/{seg(first)}.rbxm', [first],
                                      extra={'set_size': len(members)}):
                            count += 1
                        self.write('model-set', f'{base}/{seg(first)}__x{len(members)}.rbxm', members,
                                   source=f'{p.full_name(cont)}/{first.name} x{len(members)}')
                    else:
                        for u in members:
                            if self.write('model', f'{base}/{seg(u)}.rbxm', [u]):
                                count += 1
                if loose and role != 'Workspace':
                    self.write('parts', f'{base}/_parts.rbxm', loose)
                if vfx:
                    self.write('vfx', f'{base}/_vfx.rbxm', vfx)
                if snd:
                    self.write('audio', f'{base}/_sounds.rbxm', snd)
                if anim:
                    self.write('animations', f'{base}/_animations.rbxm', anim)
        return count

    # ---------------- animations + audio catalogs
    def export_anims_audio(self):
        p = self.place
        kfs, anims, sounds = [], [], []
        for inst in p.walk():
            if inst.cls == 'KeyframeSequence':
                kfs.append(inst)
            elif inst.cls == 'Animation':
                aid = txt(inst.get('AnimationId') or b'')
                if aid:
                    anims.append({'name': inst.name, 'path': p.full_name(inst), 'id': aid})
            elif inst.cls == 'Sound':
                sid = txt(inst.get('SoundId') or b'')
                if sid:
                    sounds.append({'name': inst.name, 'path': p.full_name(inst), 'id': sid,
                                   'volume': plain(inst.get('Volume')), 'looped': inst.get('Looped'),
                                   'speed': plain(inst.get('PlaybackSpeed'))})
        for k in kfs:
            path = '/'.join(seg(a) for a in p.ancestors(k))
            self.write('keyframes', f'animations/{path}/{seg(k)}.rbxm', [k],
                       extra={'keyframes': sum(1 for d in p.walk([k]) if d.cls == 'Keyframe')})
        os.makedirs(lp(os.path.join(self.dir, 'animations')), exist_ok=True)
        os.makedirs(lp(os.path.join(self.dir, 'audio')), exist_ok=True)
        with open(lp(os.path.join(self.dir, 'animations', 'animation-ids.json')), 'w', encoding='utf-8') as f:
            json.dump(anims, f, indent=1, ensure_ascii=False)
        with open(lp(os.path.join(self.dir, 'audio', 'sounds.json')), 'w', encoding='utf-8') as f:
            json.dump(sounds, f, indent=1, ensure_ascii=False)
        return len(kfs), len(anims), len(sounds)


# --------------------------------------------------------------- metrics

FONT_ASSETS = {  # Roblox-owned font family assets, names from the Creator Store
    '12187365977': 'Rubik', '12187375716': 'Finger Paint', '12187371840': 'Silkscreen',
    '12187376739': 'Noto Serif SC', '12187361378': 'Hind Siliguri', '12187365769': 'Libre Baskerville',
    '11322590111': 'Fuzzy Bubbles', '12187361116': 'Hind', '11702779409': 'Poppins',
    '12187369639': 'Noto Serif JP', '16658221428': 'Builder Sans',
}


def font_name(ff):
    if not isinstance(ff, dict):
        return None
    fam = ff['family']
    m = re.search(r'families/([^/.]+)\.json', fam)
    aid = re.search(r'(\d{6,})', fam)
    if m:
        name = m.group(1)
    elif aid:
        name = FONT_ASSETS.get(aid.group(1), f'font asset {aid.group(1)}')
    else:
        name = fam
    w = {100: 'Thin', 200: 'ExtraLight', 300: 'Light', 400: 'Regular', 500: 'Medium', 600: 'SemiBold',
         700: 'Bold', 800: 'ExtraBold', 900: 'Heavy'}.get(ff['weight'], str(ff['weight']))
    return f'{name} {w}'


def ui_metrics(place):
    roles, role_of = role_lookup(place)
    gui_insts = []
    for root in roles.get('StarterGui', []):
        gui_insts.extend(i for c in root.children for i in place.walk([c]))
    # Templates the client can show (ReplicatedStorage, ReplicatedFirst, StarterPlayer). ServerStorage is left
    # out: it tends to hold backups and other templates' leftovers (Drill & Mine keeps a whole second UI there).
    client_roles = ('ReplicatedStorage', 'ReplicatedFirst', 'StarterPlayer', 'StarterPlayerScripts',
                    'StarterCharacterScripts')
    for inst in place.walk():
        if inst.cls in ('ScreenGui', 'BillboardGui', 'SurfaceGui') and role_of(inst) in client_roles:
            if not any(a.cls in GUI_ROOTS for a in place.ancestors(inst)):
                gui_insts.extend(place.walk([inst]))
    cls = collections.Counter(i.cls for i in gui_insts)
    fonts, bg, tc, stroke, imgcol = (collections.Counter() for _ in range(5))
    corners, thick, textsize = collections.Counter(), collections.Counter(), collections.Counter()
    size_mode = collections.Counter()
    scaled = 0
    texts = 0
    images = set()
    for i in gui_insts:
        if i.cls in GUI_OBJECTS:
            s = i.get('Size')
            if isinstance(s, tuple) and len(s) == 2:
                (sx, ox), (sy, oy) = s
                has_s = abs(sx) > 1e-6 or abs(sy) > 1e-6
                has_o = ox != 0 or oy != 0
                size_mode['scale' if has_s and not has_o else 'offset' if has_o and not has_s
                          else 'mixed' if has_s else 'zero'] += 1
            bt = i.get('BackgroundTransparency')
            if isinstance(bt, float) and bt < 0.99:
                bg[fmt_color(i.get('BackgroundColor3', (1, 1, 1)))] += 1
            im = i.get('Image')
            if isinstance(im, bytes) and im:
                for m in ASSET_RE.finditer(im):
                    images.add(m.group(1).decode())
                ic = i.get('ImageColor3')
                if ic is not None and fmt_color(ic) != '#ffffff':
                    imgcol[fmt_color(ic)] += 1
        if 'Text' in i.ci.cols and i.cls in ('TextLabel', 'TextButton', 'TextBox'):
            texts += 1
            fn = font_name(i.get('FontFace'))
            if fn:
                fonts[fn] += 1
            tc[fmt_color(i.get('TextColor3', (0, 0, 0)))] += 1
            if i.get('TextScaled'):
                scaled += 1
            else:
                ts = i.get('TextSize')
                if isinstance(ts, float):
                    textsize[int(round(ts))] += 1
        if i.cls == 'UICorner':
            cr = i.get('CornerRadius') or i.get('TopLeftRadius')  # newer files store one radius per corner
            if isinstance(cr, tuple):
                corners[f'{{{round(cr[0], 3)},{cr[1]}}}'] += 1
        if i.cls == 'UIStroke':
            th = i.get('Thickness')
            if isinstance(th, float):
                mode = 'scaled' if i.get('StrokeSizingMode') == 1 else 'px'
                thick[f'{round(th, 2)} {mode}'] += 1
            c = i.get('Color')
            if c is not None:
                stroke[fmt_color(c)] += 1
    total_obj = sum(n for c, n in cls.items() if c in GUI_OBJECTS)
    return {
        'gui_objects': total_obj,
        'screen_guis': cls.get('ScreenGui', 0),
        'classes': dict(cls.most_common(30)),
        'fonts': dict(fonts.most_common(12)),
        'background_colors': dict(bg.most_common(16)),
        'text_colors': dict(tc.most_common(10)),
        'stroke_colors': dict(stroke.most_common(10)),
        'image_tints': dict(imgcol.most_common(10)),
        'corner_radius': dict(corners.most_common(10)),
        'stroke_thickness': {str(k): v for k, v in thick.most_common(10)},
        'text_size_px': {str(k): v for k, v in textsize.most_common(10)},
        'text_scaled_share': round(scaled / texts, 2) if texts else None,
        'size_mode': dict(size_mode),
        'unique_images': len(images),
        'per_100_objects': {k: round(100 * cls.get(k, 0) / total_obj, 1) if total_obj else 0 for k in (
            'UICorner', 'UIStroke', 'UIGradient', 'UIAspectRatioConstraint', 'UIListLayout', 'UIGridLayout',
            'UIPadding', 'UIScale', 'UITextSizeConstraint', 'ImageLabel', 'ImageButton', 'TextButton')},
    }


def map_metrics(place, geo):
    roots = role_lookup(place)[0].get('Workspace', [])
    if not roots:
        return {}
    insts = [i for ws in roots for c in ws.children if c.cls not in ('Camera',) for i in place.walk([c])]
    cls = collections.Counter(i.cls for i in insts)
    mats, colors = collections.Counter(), collections.Counter()
    box = None
    anchored = 0
    centers = []
    for i in insts:
        if i.cls in BASEPART:
            m = get(place, i, 'Material')
            if isinstance(m, int):
                mats[MATERIALS.get(m, f'Material{m}')] += 1
            c = get(place, i, 'Color3uint8')
            if c is not None:
                colors[fmt_color(c)] += 1
            if i.get('Anchored'):
                anchored += 1
            b = geo.box(i)
            if b and max(abs(x) for x in b) < 1e5:
                box = merge_box(box, b)
                centers.append(((b[0] + b[3]) / 2, (b[1] + b[4]) / 2, (b[2] + b[5]) / 2))
    zones = []  # lobby / hub / spawn areas measured as a whole
    for ws in roots:
        stack = [(c, 1) for c in ws.children]
        while stack:
            inst, depth = stack.pop()
            if inst.cls not in ('Folder', 'Model'):
                continue
            if set(words_of(inst.name)) & {'lobby', 'hub', 'spawn'}:
                st = subtree_stats(place, list(place.walk([inst])), geo)
                if st['parts'] >= 40:
                    zones.append({'path': place.full_name(inst), 'parts': st['parts'],
                                  'instances': st['instances'], 'meshparts': st['meshparts'],
                                  'emitters': st['emitters'], 'lights': st['lights'], 'guis': st['guis'],
                                  'sounds': st['sounds'],
                                  'size': [round(st['box'][3 + k] - st['box'][k]) for k in range(3)]
                                  if st['box'] else None})
                    continue
            if depth < 3:
                stack.extend((c, depth + 1) for c in inst.children)
    parts = sum(n for c, n in cls.items() if c in BASEPART)
    core = None
    if len(centers) >= 20:  # 2nd..98th percentile of part centres: the playable core, without far-off stages
        core = []
        for k in range(3):
            vals = sorted(c[k] for c in centers)
            core.append(round(vals[int(len(vals) * 0.98) - 1] - vals[int(len(vals) * 0.02)]))
    return {
        'instances': len(insts),
        'parts': parts,
        'meshparts': cls.get('MeshPart', 0),
        'unions': sum(cls.get(c, 0) for c in MESHY if c != 'MeshPart'),
        'anchored_share': round(anchored / parts, 2) if parts else None,
        'textures_decals': cls.get('Texture', 0) + cls.get('Decal', 0),
        'surface_appearances': cls.get('SurfaceAppearance', 0),
        'lights': sum(cls.get(c, 0) for c in LIGHTS),
        'emitters': cls.get('ParticleEmitter', 0),
        'beams_trails': cls.get('Beam', 0) + cls.get('Trail', 0),
        'sounds': cls.get('Sound', 0),
        'prompts': cls.get('ProximityPrompt', 0),
        'world_guis': cls.get('BillboardGui', 0) + cls.get('SurfaceGui', 0),
        'humanoids': cls.get('Humanoid', 0),
        'materials': dict(mats.most_common(12)),
        'part_colors': dict(colors.most_common(14)),
        'lobby_zones': zones,
        'extent_studs': core,
        'extent_all_studs': [round(box[3 + k] - box[k]) for k in range(3)] if box else None,
        'top_classes': dict(cls.most_common(15)),
    }


# --------------------------------------------------------------- per-game docs

def provenance(unpacked_dir):
    readme = os.path.join(unpacked_dir, 'README.md')
    if not os.path.exists(readme):
        return 'unknown'
    t = open(readme, encoding='utf-8').read()
    m = re.search(r'decompiler headers: (\d+); empty scripts: (\d+)', t)
    dec, empty = (int(m.group(1)), int(m.group(2))) if m else (0, 0)
    if 'saved by an exploit saveinstance' in t or dec > 20:
        return 'copy of a live game (saveinstance / decompiled client code)'
    if 'all script sources empty' in t:
        return 'copy of a live game (structure only, no code)'
    return 'template with full source'


def swatches(d, n=8):
    return ' '.join(f'`{k}`×{v}' for k, v in list(d.items())[:n]) or 'none'


def write_game_docs(gdir, slug, title, genre, src_file, prov, exp, uim, mm, env, counts, unpacked_rel):
    cat = exp.catalog
    by_kind = collections.Counter(e['kind'] for e in cat)
    uniq = [e for e in cat if e.get('file')]
    tags = collections.Counter(t for e in uniq for t in e['tags'])
    L = env.get('lighting', {})
    lines = [f'# {title}', '',
             f'- Genre: {genre}', f'- Source file: `{src_file}`', f'- Provenance: {prov}',
             f'- Code + analysis: `{unpacked_rel}` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)',
             f'- Packs written: {exp.files} files, {exp.bytes_written // 1024} KB '
             f'({len(cat) - len(uniq)} duplicates skipped, {exp.scripts_removed} scripts removed)', '',
             '## What is here', '',
             '| Folder | Packs | Notes |', '|---|---:|---|',
             f'| `ui/` | {by_kind["ui"] + by_kind["ui-kit"]} | `_StarterGui-all.rbxm` = every StarterGui screen in one insert |',
             f'| `map/` | {by_kind["map"] + by_kind["lighting"]} | `workspace.rbxm` (no terrain), `lighting.rbxm`, `environment.json` |',
             f'| `models/` | {by_kind["model"]} models, {by_kind["parts"]} part sets, {by_kind["vfx"]} vfx sets | mirrors the source tree |',
             f'| `animations/` | {by_kind["keyframes"] + by_kind["animations"]} | KeyframeSequences can be re-uploaded as your own animations; `animation-ids.json` lists {counts[1]} Animation ids |',
             f'| `audio/` | {by_kind["audio"]} | `sounds.json` lists {counts[2]} Sound ids |', '',
             '## Model tags', '', ', '.join(f'{t} ({n})' for t, n in tags.most_common()) or 'none', '',
             '## Biggest models', '', '| File | Instances | Parts | Mesh | Size (studs) | Tags |', '|---|---:|---:|---:|---|---|']
    for e in sorted((e for e in uniq if e['kind'] == 'model'), key=lambda e: -e['instances'])[:25]:
        size = 'x'.join(str(round(s)) for s in e['size']) if e['size'] else ''
        lines.append(f'| `{e["file"].split("/", 1)[1]}` | {e["instances"]} | {e["parts"]} | {e["meshparts"]} | '
                     f'{size} | {", ".join(e["tags"])} |')
    lines += ['', '## UI screens', '', '| Pack | Objects | Images |', '|---|---:|---:|']
    for e in sorted((e for e in uniq if e['kind'] == 'ui'), key=lambda e: -e['guis'])[:40]:
        lines.append(f'| `{e["file"].split("/", 1)[1]}` | {e["guis"]} | {e["image_ids"]} |')
    with open(lp(os.path.join(gdir, 'README.md')), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines) + '\n')

    post = env.get('lighting_children', [])
    eff = []
    for c in post:
        pr = c['props']
        keep = {k: pr[k] for k in pr if k in (
            'Density', 'Offset', 'Color', 'Decay', 'Glare', 'Haze', 'Intensity', 'Size', 'Threshold', 'Brightness',
            'Contrast', 'Saturation', 'TintColor', 'Spread', 'FarIntensity', 'FocusDistance', 'InFocusRadius',
            'NearIntensity', 'StarCount', 'CelestialBodiesShown', 'SunAngularSize', 'Cover', 'Enabled')}
        eff.append(f'- **{c["class"]}** `{c["name"]}`: ' + ', '.join(f'{k}={v}' for k, v in keep.items()))
    ref = [f'# {title}: quality reference', '',
           'Numbers measured from the place file. Use them as targets when building something in this genre.', '',
           '## UI', '',
           f'- {uim.get("screen_guis", 0)} ScreenGuis, {uim.get("gui_objects", 0)} GUI objects, '
           f'{uim.get("unique_images", 0)} unique images',
           f'- Fonts: {swatches(uim.get("fonts", {}), 6)}',
           f'- Panel colours: {swatches(uim.get("background_colors", {}), 10)}',
           f'- Text colours: {swatches(uim.get("text_colors", {}), 6)}',
           f'- Stroke colours: {swatches(uim.get("stroke_colors", {}), 6)}; thickness {swatches(uim.get("stroke_thickness", {}), 5)}',
           f'- Corner radius: {swatches(uim.get("corner_radius", {}), 6)}',
           f'- Size mode: {uim.get("size_mode")}; TextScaled share {uim.get("text_scaled_share")}; '
           f'text sizes {swatches(uim.get("text_size_px", {}), 6)}',
           f'- Per 100 GUI objects: ' + ', '.join(f'{k} {v}' for k, v in uim.get('per_100_objects', {}).items()), '',
           '## Map', '',
           f'- {mm.get("instances", 0)} instances, {mm.get("parts", 0)} parts '
           f'({mm.get("meshparts", 0)} MeshParts, {mm.get("unions", 0)} unions); core extent '
           f'{mm.get("extent_studs")} studs (X, Y, Z; 2nd-98th percentile), everything {mm.get("extent_all_studs")}',
           f'- Lights {mm.get("lights", 0)}, particle emitters {mm.get("emitters", 0)}, beams/trails '
           f'{mm.get("beams_trails", 0)}, textures/decals {mm.get("textures_decals", 0)}, '
           f'SurfaceAppearance {mm.get("surface_appearances", 0)}, world GUIs {mm.get("world_guis", 0)}, '
           f'prompts {mm.get("prompts", 0)}, sounds {mm.get("sounds", 0)}',
           f'- Materials: {swatches(mm.get("materials", {}), 10)}',
           f'- Part colours: {swatches(mm.get("part_colors", {}), 12)}',
           f'- Terrain voxel data: {env.get("terrain", {}).get("voxel_data_bytes", 0)} bytes', '',
           '## Lighting', '',
           ('- No Lighting properties in this file (' + env.get('lighting_note', 'old place or kit') +
            '). Borrow a preset from another game.') if not L else
           '- ' + ', '.join(f'{k}={L[k]}' for k in (
               'Technology', 'Brightness', 'TimeOfDay', 'ClockTime', 'Ambient', 'OutdoorAmbient', 'ColorShift_Top',
               'EnvironmentDiffuseScale', 'EnvironmentSpecularScale', 'ExposureCompensation', 'GlobalShadows',
               'ShadowSoftness', 'FogEnd', 'FogColor', 'GeographicLatitude') if k in L)]
    ref += eff or ['- no post effects']
    with open(lp(os.path.join(gdir, 'reference.md')), 'w', encoding='utf-8') as f:
        f.write('\n'.join(ref) + '\n')


# --------------------------------------------------------------- main

def run(path, out_root, unpacked_root):
    stem = os.path.splitext(os.path.basename(path))[0]
    slug, title, genre = GAMES.get(stem, (safe(stem).lower().replace(' ', '-'), stem, 'unknown'))
    gdir = os.path.join(out_root, slug)
    if os.path.isdir(lp(gdir)):
        import shutil
        shutil.rmtree(lp(gdir))
    os.makedirs(lp(os.path.join(gdir, 'map')), exist_ok=True)
    t0 = time.time()
    place = rbxdump.Place(path)
    unpacked_dir = os.path.join(unpacked_root, safe(stem, 80))
    exp = Exporter(place, gdir, slug, unpacked_dir)
    n_ui = exp.export_ui()
    env = exp.export_map()
    n_models = exp.export_models()
    counts = exp.export_anims_audio()
    n_other = exp.export_leftovers()
    cov = exp.coverage()
    with open(lp(os.path.join(gdir, 'coverage.json')), 'w', encoding='utf-8') as f:
        json.dump(cov, f, indent=1, ensure_ascii=False)
    uim = ui_metrics(place)
    mm = map_metrics(place, exp.geo)
    prov = provenance(unpacked_dir)
    metrics = {'slug': slug, 'title': title, 'genre': genre, 'provenance': prov, 'ui': uim, 'map': mm,
               'lighting': env.get('lighting', {}), 'post': env.get('lighting_children', []),
               'terrain': env.get('terrain', {}), 'workspace': env.get('workspace', {}),
               'packs': collections.Counter(e['kind'] for e in exp.catalog), 'coverage': cov,
               'keyframe_sequences': counts[0], 'animation_ids': counts[1], 'sound_ids': counts[2],
               'files': exp.files, 'kb': exp.bytes_written // 1024}
    with open(lp(os.path.join(gdir, 'metrics.json')), 'w', encoding='utf-8') as f:
        json.dump(metrics, f, indent=1, ensure_ascii=False, default=str)
    with open(lp(os.path.join(gdir, 'catalog.jsonl')), 'w', encoding='utf-8') as f:
        for e in exp.catalog:
            f.write(json.dumps(e, ensure_ascii=False) + '\n')
    unpacked_rel = 'source/'
    write_game_docs(gdir, slug, title, genre, os.path.basename(path), prov, exp, uim, mm, env, counts,
                    unpacked_rel)
    if exp.packer.dropped:
        with open(lp(os.path.join(gdir, 'dropped-properties.txt')), 'w', encoding='utf-8') as f:
            for k, v in exp.packer.dropped.items():
                f.write(f'{k}: {v}\n')
    print(f'OK   {slug}: {exp.files} files, {exp.bytes_written // 1024} KB, ui {n_ui}, models {n_models}, '
          f'kfs {counts[0]}, other {n_other}, not packed {cov["not_packed"]}, dropped cols {len(exp.packer.dropped)}, '
          f'{time.time() - t0:.0f}s', flush=True)
    return metrics, exp.catalog


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('inputs', nargs='+')
    ap.add_argument('--out', required=True)
    ap.add_argument('--unpacked', default=r'D:\Rodev\template\_unpacked')
    a = ap.parse_args()
    files = []
    for p in a.inputs:
        if os.path.isdir(p):
            files += [os.path.join(p, n) for n in sorted(os.listdir(p)) if n.lower().endswith(('.rbxl', '.rbxm'))]
        else:
            files.append(p)
    os.makedirs(a.out, exist_ok=True)
    all_metrics, all_cat = [], []
    for fp in files:
        try:
            m, c = run(fp, a.out, a.unpacked)
            all_metrics.append(m)
            all_cat.extend(c)
        except Exception:
            import traceback
            traceback.print_exc()
            print(f'FAIL {os.path.basename(fp)}', flush=True)
    if len(files) > 1:
        with open(os.path.join(a.out, 'catalog.jsonl'), 'w', encoding='utf-8') as f:
            for e in all_cat:
                f.write(json.dumps(e, ensure_ascii=False) + '\n')
        with open(os.path.join(a.out, 'metrics.json'), 'w', encoding='utf-8') as f:
            json.dump(all_metrics, f, indent=1, ensure_ascii=False, default=str)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')
    main()
