"""Sort every unpacked script into reference categories and copy the best candidates out as .lua.

    python -I classify_scripts.py <references-dir>

Writes <ref>/Scripts/:
    catalog.jsonl          every non-boilerplate script with its categories and score
    _candidates/<cat>/     top candidates per category, each with a header (game, path, why)
    Libraries/<lib>/       one copy of each well-known open-source module found in the games
    libraries.json         which games ship which library
Scripts flagged HIGH by the rbxdump scan (backdoors, loadstring, webhooks), decompiled
sources and obfuscated files are never copied.
"""
import collections
import hashlib
import json
import os
import re
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from games import GAMES  # noqa: E402
from rbxdump import DECOMP_RE, scan_source, strip_comments  # noqa: E402

SLUG_INFO = {v[0]: v for v in GAMES.values()}

BOILER_PARTS = {'PlayerModule', 'CameraModule', 'ControlModule', 'ChatScript', 'BubbleChat', 'ChatModules',
                'ClientChatModules', 'ChatServiceRunner', 'RbxCharacterSounds', 'ChatMain', 'MessageCreatorModules',
                'CommandModules', 'DefaultChatSystemChatEvents', 'PlayerScriptsLoader', 'ChatInstallVerifier',
                'Adonis_Loader', 'HDAdmin', 'HD Admin', "Kohl's Admin", 'Kohl\'s Admin Commands V2', 'Basic Admin',
                'Nexus Admin', 'NexusAdmin', 'Adonis', 'MainModule', 'Freecam', 'RbxCameraUI'}
BOILER_NAMES = {'Animate', 'Health', 'Sound', 'ChatScript', 'BubbleChat', 'Freecam', 'PlayerModule',
                'RbxCharacterSounds', 'PlayerScriptsLoader', 'CameraModule', 'ControlModule'}

LIBS = {
    'Knit': r'^Knit(Server|Client)?$', 'Promise': r'^Promise$', 'Signal': r'^(Good)?Signal$',
    'Janitor': r'^Janitor$', 'Maid': r'^Maid$', 'Trove': r'^Trove$', 'ProfileService': r'^ProfileService$',
    'ProfileStore': r'^ProfileStore$', 'DataStore2': r'^DataStore2$', 'Spring': r'^Spring$', 'spr': r'^spr$',
    'Flipper': r'^Flipper$', 'Fusion': r'^Fusion$', 'Roact': r'^Roact$', 'React': r'^React$', 'Iris': r'^Iris$',
    'TopbarPlus': r'^(Icon|TopbarPlus)$', 'Cmdr': r'^Cmdr(Client)?$', 'ZonePlus': r'^Zone(Plus)?$',
    'FastCast': r'^FastCast(Redux)?$', 'PartCache': r'^PartCache$', 'RaycastHitbox': r'^RaycastHitbox(V4)?$',
    'CameraShaker': r'^CameraShaker$', 'BezierTweens': r'^BezierTweens$', 'TableUtil': r'^TableUtil$',
    'ReplicaService': r'^Replica(Service|Controller)$', 'ByteNet': r'^ByteNet$', 'BridgeNet': r'^BridgeNet2?$',
    'Red': r'^Red$', 'Sift': r'^Sift$', 'Comm': r'^Comm$', 'Component': r'^Component$', 'Timer': r'^Timer$',
    'Streamable': r'^Streamable$', 'Input': r'^Input$', 'EnumList': r'^EnumList$', 'Option': r'^Option$',
    'Satchel': r'^Satchel$', 'SmartBone': r'^SmartBone$', 'Shake': r'^Shake$', 'Tween+': r'^TweenPlus$',
    'Octree': r'^Octree$', 'SimplePath': r'^SimplePath$', 'Lightning': r'^LightningBolt$',
    'MadworkMaid': r'^MadworkMaid$', 'MadworkScriptSignal': r'^MadworkScriptSignal$', 'Rodux': r'^Rodux$',
    'Charm': r'^Charm$', 'Vide': r'^vide$', 'Blink': r'^Blink$', 'Zap': r'^Zap$', 'Warp': r'^Warp$',
    'Leaderboard': r'^LeaderboardService$', 'ShimmerModule': r'^Shimmer$', 'TextPlus': r'^TextPlus$',
    'RichText': r'^RichText$', 'TypeWriter': r'^Type ?[Ww]riter$', 'NumberFormatter': r'^(Number)?(Formatter|Abbreviat\w*)$',
}
LIB_RES = {k: re.compile(v) for k, v in LIBS.items()}

TWEEN = r'TweenService|TweenInfo\.new|:Create\(|\bspr\.target|Spring|lerp|Lerp|RenderStepped|Heartbeat'
GUI = r'UDim2|UIScale|ImageTransparency|TextTransparency|BackgroundTransparency|AbsoluteSize|GuiObject|' \
      r'PlayerGui|TextButton|ImageButton|Frame\b|UIGradient|UIStroke'

# category -> (title, required regex list (all must match), weighted bonus patterns, name regex)
CATS = {
    'ui-animation': ('UI animation (tweens, hover / click, pop-ins, springs)', [TWEEN, GUI], [
        (r'MouseEnter|MouseLeave', 3), (r'MouseButton1Down|MouseButton1Up|Activated', 2), (r'UIScale', 3),
        (r'TweenInfo\.new', 2), (r'Enum\.EasingStyle\.(Back|Elastic|Bounce|Quint|Exponential)', 3),
        (r'UIGradient', 2), (r'\.Rotation', 2), (r'MaxVisibleGraphemes', 4), (r'[Hh]over', 3),
        (r'[Bb]ounce|[Pp]op|[Ww]iggle|[Ss]hake|[Pp]ulse|[Ss]himmer|[Ss]hine', 3), (r'[Ss]pring', 3),
    ], r'(?i)anim|tween|hover|button|fx|effect|shimmer|spring|pop|bounce|typewriter|gradient|transition|fade'),
    'ui-framework': ('UI controllers / window managers / menus', [GUI], [
        (r'(?i)open|close|toggle', 1), (r'(?i)menu|window|frame[s]?\b|panel|page|tab', 2),
        (r'(?i)currentOpen|opened|isOpen|activeMenu|openFrame', 4), (r'require\(', 1),
    ], r'(?i)ui(controller|manager|handler|service)?$|menu|window|interface|guiservice|frames?handler|hud|tabs?'),
    'notifications': ('Notifications, toasts, popups, prompts', [GUI], [
        (r'(?i)notif|toast|popup|announce|message|alert|prompt', 4), (r'Debris|task\.delay', 1),
    ], r'(?i)notif|toast|popup|announce|alert|prompt|message'),
    'loading-screen': ('Loading / intro screens', [GUI], [
        (r'ContentProvider|PreloadAsync', 5), (r'ReplicatedFirst|RemoveDefaultLoadingScreen', 5),
        (r'(?i)loading|intro', 3),
    ], r'(?i)load|intro|splash'),
    'camera-cutscene': ('Camera, cutscenes, screen shake', [r'CurrentCamera|Camera'], [
        (r'CameraType\.Scriptable', 4), (r'(?i)cutscene|shake|FieldOfView|Bobbing|sway', 4), (r'CFrame', 1),
    ], r'(?i)camera|cutscene|shake|cinematic|bobb|sway|fov'),
    'vfx': ('VFX, particles, beams, hit effects', [r'ParticleEmitter|Beam|Trail|Emit\(|Highlight|Explosion'], [
        (r':Emit\(', 4), (r'(?i)vfx|effect|aura|impact|hit', 3), (r'Debris', 1), (r'TweenService', 1),
    ], r'(?i)vfx|fx|effect|particle|aura|impact|explosion|trail'),
    'data-saving': ('DataStore / player data', [r'DataStore|ProfileService|ProfileStore|DataStore2'], [
        (r'UpdateAsync|SetAsync|GetAsync', 3), (r'BindToClose|PlayerRemoving', 3), (r'session|lock', 2),
    ], r'(?i)data|save|profile|store'),
    'monetization': ('Monetization (dev products, game passes, receipts)', [r'MarketplaceService'], [
        (r'ProcessReceipt', 6), (r'UserOwnsGamePassAsync', 3), (r'PromptProductPurchase|PromptGamePassPurchase', 3),
        (r'(?i)gift', 2),
    ], r'(?i)market|purchase|shop|store|product|gamepass|robux|monet|receipt'),
    'rng-gacha': ('RNG, eggs, gacha, rarity rolls, pets', [r'(?i)rarit|chance|weight|roll|hatch|luck'], [
        (r'math\.random|Random\.new|NextNumber|NextInteger', 3), (r'(?i)egg|pet|hatch|gacha|crate|spin|wheel', 3),
        (r'(?i)weight', 3), (r'(?i)pity|luck', 3),
    ], r'(?i)egg|pet|hatch|roll|rng|gacha|crate|spin|wheel|rarit|luck'),
    'trading': ('Trading systems', [r'(?i)trade'], [(r'(?i)offer|accept|decline|ready|confirm', 3)],
                r'(?i)trade|trading'),
    'combat': ('Combat, weapons, hitboxes, abilities', [r'(?i)damage|hitbox|TakeDamage|Raycast|ability|skill|combo'], [
        (r'TakeDamage', 3), (r'(?i)hitbox|GetPartBoundsInBox|GetPartsInPart', 4), (r'(?i)combo|cooldown|stun|block|parry', 3),
        (r'workspace:Raycast|RaycastParams', 2),
    ], r'(?i)combat|weapon|gun|sword|hitbox|ability|skill|attack|damage|melee|projectile'),
    'npc-ai': ('NPC / AI / monsters', [r'PathfindingService|MoveTo\(|Humanoid'], [
        (r'PathfindingService|ComputeAsync', 5), (r'(?i)chase|patrol|target|aggro|killer|monster|npc|enemy', 3),
    ], r'(?i)npc|ai\b|monster|enemy|killer|mob|boss|path'),
    'movement': ('Character movement (sprint, dash, double jump, slide)', [r'Humanoid|WalkSpeed|JumpPower|UserInputService|ContextActionService'], [
        (r'WalkSpeed', 2), (r'(?i)sprint|dash|double ?jump|slide|stamina|crouch|climb|wallrun|vault', 5),
        (r'LinearVelocity|BodyVelocity|AssemblyLinearVelocity|ApplyImpulse', 3),
    ], r'(?i)sprint|run|dash|jump|slide|stamina|crouch|movement|climb'),
    'tycoon-plots': ('Tycoon / plots / bases / building', [r'(?i)plot|tycoon|base|dropper|conveyor|build'], [
        (r'(?i)dropper|conveyor|collector|button', 3), (r'(?i)plot|owner|claim', 3), (r'(?i)place|grid|snap', 2),
    ], r'(?i)tycoon|plot|base|build|dropper|conveyor|placement'),
    'leaderboards': ('Leaderboards & stats', [r'OrderedDataStore|leaderstats'], [
        (r'GetSortedAsync', 5), (r'leaderstats', 2)], r'(?i)leaderboard|lb|leaderstats|top'),
    'admin': ('Admin panels & commands', [r'(?i)admin|command|cmd'], [
        (r'(?i)kick|ban|announce|give', 2), (r'(?i)permission|rank', 2)], r'(?i)admin|cmd|command'),
    'sound-music': ('Sound & music', [r'Sound|SoundService'], [
        (r'(?i)music|playlist|soundtrack|volume', 3), (r'SoundGroup|PlaybackSpeed', 2)], r'(?i)music|sound|audio|sfx'),
    'daily-rewards-quests': ('Daily rewards, quests, codes, playtime', [r'(?i)daily|quest|reward|code|playtime|streak'], [
        (r'os\.time|DateTime|os\.date', 3), (r'(?i)claim|redeem', 3)], r'(?i)daily|quest|reward|code|playtime|streak|mission'),
    'utility': ('Utility modules (number format, signals, tables, timers)', [r'return\s+\w+\s*$|^return\s'], [
        (r'(?i)abbreviat|suffix|format|comma', 3), (r'(?i)signal|connect|fire', 1), (r'(?i)deepcopy|clone|merge', 2),
    ], r'(?i)util|format|abbrev|signal|maid|janitor|promise|table|math|string|number|timer'),
}
CAT_RES = {k: ([re.compile(r) for r in req], [(re.compile(p), w) for p, w in bon], re.compile(nm))
           for k, (t, req, bon, nm) in CATS.items()}

MAX_CANDIDATES = 45


def lua_name(rel):
    base = os.path.basename(rel)
    for ext in ('.server.luau', '.client.luau', '.luau', '.server.lua', '.client.lua', '.lua'):
        if base.endswith(ext):
            return base[:-len(ext)], ext
    return base, ''


def main():
    ref = sys.argv[1]
    games_dir = os.path.join(ref, 'Games')
    out = os.path.join(ref, 'Scripts')
    if os.path.isdir(os.path.join(out, '_candidates')):
        shutil.rmtree(os.path.join(out, '_candidates'))
    if os.path.isdir(os.path.join(out, 'Libraries')):
        shutil.rmtree(os.path.join(out, 'Libraries'))
    os.makedirs(out, exist_ok=True)
    rows, seen_hash = [], {}
    libs = collections.defaultdict(list)
    for slug in sorted(os.listdir(games_dir)):
        sdir = os.path.join(games_dir, slug, 'source', 'scripts')
        if not os.path.isdir(sdir):
            continue
        for root, _, files in os.walk(sdir):
            for fn in files:
                fp = os.path.join(root, fn)
                rel = os.path.relpath(fp, sdir).replace('\\', '/')
                name, ext = lua_name(rel)
                parts = set(rel.split('/'))
                raw = open(fp, 'rb').read()
                if not raw.strip():
                    continue
                txt = raw.decode('utf-8', 'replace')
                for lib, rx in LIB_RES.items():
                    if rx.match(name) and len(txt) > 300:
                        libs[lib].append({'game': slug, 'path': rel, 'bytes': len(raw), 'file': fp})
                if parts & BOILER_PARTS or name in BOILER_NAMES or '_Index' in parts or 'Packages' in parts:
                    continue
                lines = txt.count('\n') + 1
                if lines < 8:
                    continue
                h = hashlib.md5(raw).hexdigest()
                decomp = bool(DECOMP_RE.search(txt[:600]))
                longest = max((len(x) for x in txt.split('\n')), default=0)
                flags = scan_source(txt)
                high = any(lv == 'HIGH' for lv, _, _ in flags)
                body = strip_comments(txt)
                comments = len(txt) - len(body)
                cats = {}
                for cat, (req, bon, nm) in CAT_RES.items():
                    if not all(r.search(body) for r in req):
                        continue
                    s = 0
                    for rx, w in bon:
                        k = len(rx.findall(body))
                        if k:
                            s += w * min(k, 6) ** 0.5
                    if nm.search(name):
                        s += 6
                    if s >= 8:
                        cats[cat] = round(s, 1)
                if not cats:
                    continue
                dup = seen_hash.get(h)
                if not dup:
                    seen_hash[h] = f'{slug}/{rel}'
                quality = 0.0
                if 25 <= lines <= 900:
                    quality += 3
                elif lines > 900:
                    quality += 1
                if comments > 0.03 * len(txt):
                    quality += 2
                if re.search(r'--!strict|: \w+\)|export type', txt):
                    quality += 1
                if decomp:
                    quality -= 6
                if longest > 1500:
                    quality -= 8
                rows.append({'game': slug, 'path': rel, 'name': name, 'kind': ext.strip('.').split('.')[0] or 'module',
                             'lines': lines, 'cats': cats, 'quality': quality, 'decompiled': decomp,
                             'obfuscated': longest > 1500, 'high_flag': high, 'dup_of': dup, 'md5': h,
                             'file': fp})
    with open(os.path.join(out, 'catalog.jsonl'), 'w', encoding='utf-8') as f:
        for r in rows:
            f.write(json.dumps({k: v for k, v in r.items() if k != 'file'}, ensure_ascii=False) + '\n')

    # candidates per category: unique, clean, best score, at most 4 per game
    summary = {}
    for cat, (title, *_r) in CATS.items():
        pool = [r for r in rows if cat in r['cats'] and not r['dup_of'] and not r['high_flag']
                and not r['decompiled'] and not r['obfuscated']]
        pool.sort(key=lambda r: -(r['cats'][cat] + r['quality'] + 0.3 * len(r['cats'])))
        per_game, picked = collections.Counter(), []
        for r in pool:
            if per_game[r['game']] >= 4:
                continue
            per_game[r['game']] += 1
            picked.append(r)
            if len(picked) >= MAX_CANDIDATES:
                break
        cdir = os.path.join(out, '_candidates', cat)
        os.makedirs(cdir, exist_ok=True)
        for i, r in enumerate(picked, 1):
            title_g = SLUG_INFO.get(r['game'], (r['game'], r['game']))[1]
            dst = os.path.join(cdir, f'{i:02d}__{r["game"]}__{re.sub(r"[^A-Za-z0-9_-]+", "_", r["name"])[:50]}.lua')
            with open(dst, 'w', encoding='utf-8', newline='\n') as f:
                f.write(f'-- Reference copy for study. Game: {title_g} ({r["game"]})\n')
                f.write(f'-- Original: {r["path"]}  ({r["kind"]}, {r["lines"]} lines)\n')
                f.write(f'-- Categories: {", ".join(f"{k} {v}" for k, v in sorted(r["cats"].items(), key=lambda x: -x[1]))}\n\n')
                f.write(open(r['file'], encoding='utf-8', errors='replace').read())
        summary[cat] = {'title': title, 'pool': len(pool), 'candidates': len(picked)}

    # libraries: keep the largest copy of each
    libinfo = {}
    for lib, items in sorted(libs.items()):
        items.sort(key=lambda x: -x['bytes'])
        best = items[0]
        ldir = os.path.join(out, 'Libraries', lib)
        os.makedirs(ldir, exist_ok=True)
        name, ext = lua_name(best['path'])
        shutil.copy(best['file'], os.path.join(ldir, name + '.lua'))
        kids = os.path.join(os.path.dirname(best['file']), name)
        if os.path.isdir(kids):
            shutil.copytree(kids, os.path.join(ldir, name), dirs_exist_ok=True)
            for root, _, files in os.walk(os.path.join(ldir, name)):
                for fn in files:
                    if fn.endswith(('.luau', '.lua')):
                        n2, _ = lua_name(fn)
                        os.replace(os.path.join(root, fn), os.path.join(root, n2 + '.lua'))
        libinfo[lib] = {'copied_from': f'{best["game"]}/{best["path"]}',
                        'games': sorted({i['game'] for i in items})}
    with open(os.path.join(out, 'libraries.json'), 'w', encoding='utf-8') as f:
        json.dump(libinfo, f, indent=1, ensure_ascii=False)
    with open(os.path.join(out, '_summary.json'), 'w', encoding='utf-8') as f:
        json.dump(summary, f, indent=1, ensure_ascii=False)
    print(len(rows), 'categorised scripts')
    for k, v in summary.items():
        print(f'{k:22s} pool {v["pool"]:5d}  candidates {v["candidates"]}')
    print('libraries:', ', '.join(f'{k}({len(v["games"])})' for k, v in libinfo.items()))


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
