"""Write References/index.html: an offline, filterable gallery of every screenshot and model preview.

    python -I build_viewer.py <references-dir>

Run after build_catalog.py (it reuses the thumbnails and the UI-type rules).
"""
import json
import os
import sys
import urllib.parse

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_catalog as bc  # noqa: E402  (module-level REF comes from sys.argv[1])

REF = bc.REF


def u(p):
    return urllib.parse.quote(os.path.relpath(p, REF).replace('\\', '/'))


def main():
    games, shots, models = [], [], []
    for slug in sorted(os.listdir(bc.GAMES_DIR)):
        if slug not in bc.BY_SLUG:
            continue
        g = bc.BY_SLUG[slug]
        s, m = bc.collect_shots(slug)
        gi = len(games)
        games.append({'slug': slug, 'title': g['title'], 'genre': g['genre'], 'cat': g['category'],
                      'page': u(os.path.join(bc.GAMES_DIR, slug, 'README.md')), 'n': len(s), 'm': len(m)})
        for x in s:
            shots.append({'g': gi, 't': x['type'], 'gui': x['gui'], 'p': x['panel'], 'th': u(x['thumb']),
                          'img': u(x['crop'] or x['full']), 'full': u(x['full']), 'w': x['weight']})
        for x in m:
            models.append({'g': gi, 'name': x.get('name', ''), 'tags': x.get('tags') or [], 'th': u(x['thumb']),
                           'img': u(x['img']),
                           'file': u(os.path.join(bc.GAMES_DIR, x['file'])) if x.get('file') else ''})
    shots.sort(key=lambda x: -x['w'])
    for x in shots:
        del x['w']
    data = json.dumps({'games': games, 'shots': shots, 'models': models, 'cats': bc.CAT_ORDER,
                       'types': [t for t, _ in bc.UI_TYPES] + ['Other']}, ensure_ascii=False, separators=(',', ':'))
    html = TEMPLATE.replace('/*DATA*/', data.replace('</', '<\\/'))
    with open(os.path.join(REF, 'index.html'), 'w', encoding='utf-8') as f:
        f.write(html)
    print(f'index.html: {len(games)} games, {len(shots)} shots, {len(models)} models')


TEMPLATE = r'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Roblox References</title>
<style>
:root{--bg:#f6f7f9;--panel:#fff;--ink:#16181d;--muted:#5d6472;--line:#dde1e7;--accent:#2f6fec;--chip:#eef1f5}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){--bg:#111317;--panel:#1a1d23;--ink:#e8eaee;--muted:#9aa2b1;--line:#2a2f38;--accent:#6b9bff;--chip:#232831}}
:root[data-theme="dark"]{--bg:#111317;--panel:#1a1d23;--ink:#e8eaee;--muted:#9aa2b1;--line:#2a2f38;--accent:#6b9bff;--chip:#232831}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);font:14px/1.45 system-ui,-apple-system,"Segoe UI",sans-serif}
header{position:sticky;top:0;z-index:5;background:var(--bg);border-bottom:1px solid var(--line);padding:12px 16px}
h1{font-size:18px;margin:0 0 8px}h1 small{color:var(--muted);font-weight:400;font-size:13px;margin-left:8px}
.row{display:flex;flex-wrap:wrap;gap:6px;align-items:center;margin-top:6px}
input[type=search]{flex:1 1 260px;min-width:0;padding:8px 10px;border:1px solid var(--line);border-radius:8px;background:var(--panel);color:var(--ink);font:inherit}
select{padding:7px 8px;border:1px solid var(--line);border-radius:8px;background:var(--panel);color:var(--ink);font:inherit;max-width:100%}
.tab,.chip{border:1px solid var(--line);background:var(--chip);color:var(--ink);border-radius:999px;padding:5px 11px;cursor:pointer;font:inherit;font-size:13px}
.tab[aria-pressed=true],.chip[aria-pressed=true]{background:var(--accent);border-color:var(--accent);color:#fff}
main{padding:16px}.count{color:var(--muted);margin:0 0 10px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(230px,1fr));gap:12px}
.card{background:var(--panel);border:1px solid var(--line);border-radius:10px;overflow:hidden;cursor:zoom-in;display:flex;flex-direction:column}
.card img{width:100%;aspect-ratio:16/10;object-fit:contain;background:#2b2f36;display:block}
.card .cap{padding:7px 9px;font-size:12px;color:var(--muted)}.card .cap b{color:var(--ink);display:block;font-size:13px}
.games{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:10px}
.game{background:var(--panel);border:1px solid var(--line);border-radius:10px;padding:10px 12px}
.game a{color:var(--ink);font-weight:600;text-decoration:none}.game a:hover{color:var(--accent)}.game p{margin:4px 0 0;color:var(--muted);font-size:12px}
#lb{position:fixed;inset:0;background:rgba(0,0,0,.86);display:none;flex-direction:column;align-items:center;justify-content:center;z-index:10;padding:16px}
#lb.on{display:flex}#lb img{max-width:100%;max-height:82vh;border-radius:6px}#lb .meta{color:#ddd;margin-top:10px;text-align:center;font-size:13px}
#lb a{color:#9cc0ff}#more{margin:16px auto;display:block}
@media (max-width:520px){.grid{grid-template-columns:repeat(auto-fill,minmax(150px,1fr))}}
</style>
</head>
<body>
<header>
<h1>Roblox References <small id="stats"></small></h1>
<div class="row" role="tablist">
<button class="tab" data-view="shots" aria-pressed="true">UI screenshots</button>
<button class="tab" data-view="models" aria-pressed="false">Models</button>
<button class="tab" data-view="games" aria-pressed="false">Games</button>
<a class="tab" href="Scripts/README.md" style="text-decoration:none">Scripts</a>
<a class="tab" href="README.md" style="text-decoration:none">README</a>
</div>
<div class="row">
<input type="search" id="q" placeholder="Search game, screen, panel or model name...">
<select id="game"><option value="">All games</option></select>
<select id="type"><option value="">All UI types</option></select>
</div>
<div class="row" id="cats"></div>
</header>
<main>
<p class="count" id="count"></p>
<div id="out"></div>
<button class="tab" id="more">Show more</button>
</main>
<div id="lb" role="dialog" aria-modal="true"><img alt=""><div class="meta"></div></div>
<script>
const D=/*DATA*/;
const S={view:'shots',q:'',game:'',type:'',cat:'',limit:120};
const $=s=>document.querySelector(s);
const esc=s=>String(s).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
$('#stats').textContent=`${D.games.length} games · ${D.shots.length} screenshots · ${D.models.length} models`;
D.games.map((g,i)=>[g.title,i]).sort().forEach(([t,i])=>$('#game').insertAdjacentHTML('beforeend',`<option value="${i}">${esc(t)}</option>`));
D.types.forEach(t=>$('#type').insertAdjacentHTML('beforeend',`<option>${esc(t)}</option>`));
const cats=$('#cats');cats.insertAdjacentHTML('beforeend','<button class="chip" data-cat="" aria-pressed="true">All genres</button>');
D.cats.forEach(c=>cats.insertAdjacentHTML('beforeend',`<button class="chip" data-cat="${esc(c)}" aria-pressed="false">${esc(c)}</button>`));
function match(g,txt){
  if(S.cat&&g.cat!==S.cat)return false;
  if(S.game!==''&&D.games.indexOf(g)!==+S.game)return false;
  return !S.q||(g.title+' '+txt).toLowerCase().includes(S.q);
}
function render(){
  let html='',n=0,total=0;
  $('#type').style.display=S.view==='shots'?'':'none';
  if(S.view==='games'){
    const list=D.games.filter(g=>match(g,g.genre));total=list.length;
    html='<div class="games">'+list.map(g=>`<div class="game"><a href="${g.page}">${esc(g.title)}</a><p>${esc(g.cat)} · ${esc(g.genre)}</p><p>${g.n} screenshots · ${g.m} models</p></div>`).join('')+'</div>';
    $('#more').style.display='none';
  }else{
    const src=S.view==='shots'?D.shots:D.models;
    const list=src.filter(x=>{const g=D.games[x.g];
      if(S.view==='shots'&&S.type&&x.t!==S.type)return false;
      return match(g,S.view==='shots'?`${x.gui} ${x.p} ${x.t}`:`${x.name} ${x.tags.join(' ')}`)});
    total=list.length;
    html='<div class="grid">'+list.slice(0,S.limit).map((x,i)=>{const g=D.games[x.g];
      const cap=S.view==='shots'?`<b>${esc(g.title)}</b>${esc(x.gui)}${x.p?' › '+esc(x.p):''}<br>${esc(x.t)}`:`<b>${esc(x.name)}</b>${esc(g.title)}<br>${esc(x.tags.join(', '))}`;
      return `<div class="card" data-i="${src.indexOf(x)}" tabindex="0"><img loading="lazy" src="${x.th}" alt=""><div class="cap">${cap}</div></div>`}).join('')+'</div>';
    $('#more').style.display=total>S.limit?'':'none';
  }
  $('#count').textContent=`${total} result${total===1?'':'s'}`;
  $('#out').innerHTML=html;
}
document.addEventListener('click',e=>{
  const t=e.target.closest('.tab[data-view]');if(t){document.querySelectorAll('.tab[data-view]').forEach(b=>b.setAttribute('aria-pressed',b===t));S.view=t.dataset.view;S.limit=120;render();return}
  const c=e.target.closest('.chip');if(c){cats.querySelectorAll('.chip').forEach(b=>b.setAttribute('aria-pressed',b===c));S.cat=c.dataset.cat;S.limit=120;render();return}
  const k=e.target.closest('.card');if(k){open(+k.dataset.i);return}
  if(e.target.id==='lb'||e.target.closest('#lb img'))$('#lb').classList.remove('on');
});
document.addEventListener('keydown',e=>{if(e.key==='Escape')$('#lb').classList.remove('on');if(e.key==='Enter'&&e.target.classList.contains('card'))open(+e.target.dataset.i)});
function open(i){
  const shots=S.view==='shots',x=(shots?D.shots:D.models)[i],g=D.games[x.g];
  $('#lb img').src=x.img;
  $('#lb .meta').innerHTML=shots?`<b>${esc(g.title)}</b> — ${esc(x.gui)}${x.p?' › '+esc(x.p):''} · <a href="${x.full}" target="_blank">full frame</a> · <a href="${g.page}">game page</a>`
    :`<b>${esc(x.name)}</b> — ${esc(g.title)} · <a href="${x.file}">.rbxm</a> · <a href="${g.page}">game page</a>`;
  $('#lb').classList.add('on');
}
$('#more').onclick=()=>{S.limit+=240;render()};
$('#q').oninput=e=>{S.q=e.target.value.trim().toLowerCase();S.limit=120;render()};
$('#game').onchange=e=>{S.game=e.target.value;S.limit=120;render()};
$('#type').onchange=e=>{S.type=e.target.value;S.limit=120;render()};
render();
</script>
</body>
</html>
'''

if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    main()
