--credit to leon games studio
--[[
	================================================================
	 Visualizador de Relaciones de ModuleScripts  ·  v4 (grafo)
	================================================================
	Qué hace:
	  • Encuentra QUIÉN requiere ('require') un ModuleScript en TODO el
	    proyecto, de forma DIRECTA y TRANSITIVA (toda la cadena hacia arriba).
	  • Encuentra QUÉ requiere ese módulo, con el ÁRBOL completo de
	    dependencias hacia abajo (con marca de ciclos y duplicados).
	  • Vista "Salud del proyecto": módulos huérfanos (nadie los requiere),
	    ciclos de dependencia, y ranking de los módulos más requeridos.
	  • Imprime un reporte limpio y pegable en la consola de Output.
	  • Barra de búsqueda tipo "command bar": escribe un nombre y Enter.
	  • Click en cualquier resultado para seleccionarlo en el Explorer.

	Cómo detecta (lo importante, SIN cambios respecto a v2):
	  En lugar de buscar el nombre del módulo como texto (frágil), RESUELVE
	  la ruta real de cada require -- p. ej. require(script.Parent.Modulo),
	  require(game:GetService("ReplicatedStorage").Shared.Net) o por variable
	  (local RS = game:GetService("ReplicatedStorage"); require(RS.Mod)) --
	  hasta la instancia concreta del árbol y la compara con el módulo objetivo.
	  Lo que no se puede resolver de forma estática (rutas dinámicas, índices
	  con variables, asset IDs) se marca como "posible" en vez de confirmado.

	Novedad v3:
	  El proyecto entero se parsea UNA sola vez por análisis y se guarda como
	  grafo dirigido (requiere / requerido-por). Sobre ese grafo se calculan
	  transitivos, ciclos y huérfanos sin volver a leer las fuentes.
	  Además detecta CARGADORES DINÁMICOS: require guardado en variable
	  (local r = require; r(x)) y require en bucle sobre un contenedor
	  (for _, m in Carpeta:GetChildren() do require(m) end). Esas dependencias
	  se atribuyen a todos los ModuleScripts del contenedor y se marcan
	  "(vía loader)" para distinguirlas de los require de ruta fija.

	Novedad v4 (revisión profunda, como un code-review de dependencias):
	  • REQUIRES ROTOS: require cuya ruta es estática pero apunta a una
	    instancia que no existe -> error en runtime. Antes se mezclaban con
	    los "dinámicos"; ahora se separan y se listan con el require exacto.
	  • VIOLACIONES DE FRONTERA: script de cliente/replicado que requiere un
	    módulo en ServerScriptService/ServerStorage. Funciona en Studio pero
	    ROMPE en el cliente real (no ve esas carpetas).
	  • ACOPLAMIENTO: fan-in (Ca), fan-out (Ce) e inestabilidad I=Ce/(Ca+Ce)
	    por módulo; rankings de "god modules" y "frágiles", más la cadena
	    de dependencias más larga.
	  • MUERTO EN CADENA: módulos no alcanzables desde ningún punto de entrada
	    (Script/LocalScript), más allá de los huérfanos directos.
]]

local plugin = plugin
if not plugin then return end

----------------------------------------------------------------------
-- SERVICIOS
----------------------------------------------------------------------
local Selection = game:GetService("Selection")

----------------------------------------------------------------------
-- CONFIGURACIÓN
----------------------------------------------------------------------
local SERVICE_NAMES = {
	"Workspace", "ReplicatedStorage", "ReplicatedFirst",
	"ServerScriptService", "ServerStorage", "StarterPlayer",
	"StarterGui", "StarterPack", "Lighting", "SoundService", "Teams",
}

local TREE_MAX_DEPTH   = 7    -- profundidad máxima del árbol de dependencias
local TREE_MAX_ROWS    = 400  -- tope de filas del árbol (evita explosión visual)
local LIST_CAP         = 200  -- tope de filas en listas largas (transitivos, etc.)
local TOP_REQUIRED_N   = 20   -- cuántos módulos mostrar en "más requeridos"

-- Paleta del tema (oscuro).
local C = {
	bg       = Color3.fromRGB(24, 24, 28),
	panel    = Color3.fromRGB(32, 32, 38),
	row      = Color3.fromRGB(38, 38, 46),
	rowAlt   = Color3.fromRGB(30, 30, 36),
	line     = Color3.fromRGB(45, 45, 55),
	stroke   = Color3.fromRGB(50, 50, 60),
	accent   = Color3.fromRGB(0, 140, 255),
	accentHi = Color3.fromRGB(30, 160, 255),
	text     = Color3.fromRGB(240, 240, 250),
	textDim  = Color3.fromRGB(160, 160, 175),
	textMute = Color3.fromRGB(115, 115, 130),
	ok       = Color3.fromRGB(70, 200, 120),
	maybe    = Color3.fromRGB(230, 180, 60),
	bad      = Color3.fromRGB(235, 90, 90),
	dep      = Color3.fromRGB(120, 180, 255),
	input    = Color3.fromRGB(20, 20, 24),
}

----------------------------------------------------------------------
-- ESTADO DE LA UI (declarado adelante; se asigna en buildUI)
----------------------------------------------------------------------
local widget        -- DockWidgetPluginGui
local infoLabel     -- TextLabel del encabezado
local scrollFrame   -- ScrollingFrame con los resultados
local listLayout    -- UIListLayout del scroll
local searchBox     -- TextBox de búsqueda
local analyzing = false

----------------------------------------------------------------------
-- TOOLBAR
----------------------------------------------------------------------
local toolbar = plugin:CreateToolbar("Relaciones de Módulos")
local button = toolbar:CreateButton(
	"Ver Dependencias",
	"Muestra qué scripts requieren este ModuleScript",
	"rbxassetid://4483345998"
)

local pluginAction = plugin:CreatePluginAction(
	"ModuleDepScanAction",
	"Analizar dependencias del módulo",
	"Analiza qué scripts requieren el ModuleScript seleccionado",
	"",
	true
)

----------------------------------------------------------------------
-- UTILIDADES DE TEXTO / RUTA
----------------------------------------------------------------------
local function escapePattern(s)
	return (s:gsub("([^%w])", "%%%1"))
end

-- Ruta legible: "ReplicatedStorage > Modules > MiModulo (ModuleScript)"
local function getCleanPath(instance)
	local parts = {}
	local cur = instance
	while cur and cur ~= game do
		table.insert(parts, 1, cur.Name)
		cur = cur.Parent
	end
	return table.concat(parts, " > ") .. " (" .. instance.ClassName .. ")"
end

-- Quita comentarios para que 'require' dentro de un comentario no cuente.
local function stripComments(src)
	src = src:gsub("%-%-%[(=*)%[.-%]%1%]", " ")
	src = src:gsub("%-%-[^" .. string.char(10) .. "]*", "")
	return src
end

----------------------------------------------------------------------
-- PARSER DE require(...) Y RESOLUCIÓN DE RUTAS  (intacto desde v2)
----------------------------------------------------------------------
local function extractRequireExpressions(src)
	local exprs = {}
	local len = #src
	local i = 1
	while true do
		local s, e = src:find("require", i, true)
		if not s then break end

		local prevChar = (s > 1) and src:sub(s - 1, s - 1) or ""
		local isWordStart = (prevChar == "") or (not prevChar:match("[%w_]"))

		if isWordStart then
			local j = e + 1
			while j <= len and src:sub(j, j):match("%s") do
				j = j + 1
			end
			if src:sub(j, j) == "(" then
				local depth, k = 0, j
				while k <= len do
					local ch = src:sub(k, k)
					if ch == "(" then
						depth += 1
					elseif ch == ")" then
						depth -= 1
						if depth == 0 then break end
					end
					k += 1
				end
				if depth == 0 then
					table.insert(exprs, src:sub(j + 1, k - 1))
					i = k + 1
				else
					i = e + 1
				end
			else
				i = e + 1
			end
		else
			i = e + 1
		end
	end
	return exprs
end

local function parseAccessors(expr, startIndex)
	local accessors = {}
	local i, len = startIndex, #expr
	while i <= len do
		local c = expr:sub(i, i)
		if c:match("%s") then
			i += 1
		elseif c == "." then
			local id = expr:match("^%.([%a_][%w_]*)", i)
			if not id then return accessors, false end
			i += 1 + #id
			if id == "Parent" then
				table.insert(accessors, { type = "parent" })
			else
				table.insert(accessors, { type = "index", name = id })
			end
		elseif c == ":" then
			local method, arg =
				expr:match([==[^:([%a_][%w_]*)%s*%(%s*["']([^"']*)["'][^%)]*%)]==], i)
			if not method then return accessors, false end
			local consumed =
				expr:match([==[^(:[%a_][%w_]*%s*%(%s*["'][^"']*["'][^%)]*%))]==], i)
			i += #consumed
			if method == "GetService" then
				table.insert(accessors, { type = "getservice", name = arg })
			elseif method == "WaitForChild" or method == "FindFirstChild" then
				table.insert(accessors, { type = "index", name = arg })
			else
				return accessors, false
			end
		elseif c == "[" then
			local arg = expr:match([==[^%[%s*["']([^"']*)["']%s*%]]==], i)
			if not arg then return accessors, false end
			local consumed = expr:match([==[^(%[%s*["'][^"']*["']%s*%])]==], i)
			i += #consumed
			table.insert(accessors, { type = "index", name = arg })
		else
			return accessors, false
		end
	end
	return accessors, true
end

local function resolveExpression(expr, scriptInstance, varMap)
	expr = expr:gsub("^%s+", "")
	local base = expr:match("^[%a_][%w_]*")
	if not base then return nil, false end

	local accessors, complete = parseAccessors(expr, #base + 1)

	local current
	if base == "game" or base == "Game" then
		current = game
	elseif base == "workspace" or base == "Workspace" then
		current = workspace
	elseif base == "script" then
		current = scriptInstance
	elseif varMap and varMap[base] then
		current = varMap[base]
	else
		return nil, false
	end

	for _, acc in ipairs(accessors) do
		if not current then return nil, false end
		if acc.type == "parent" then
			current = current.Parent
		elseif acc.type == "getservice" then
			local ok, svc = pcall(function() return game:GetService(acc.name) end)
			current = ok and svc or nil
		elseif acc.type == "index" then
			local ok, child = pcall(function() return current:FindFirstChild(acc.name) end)
			current = ok and child or nil
		end
	end

	if not complete then
		return nil, false
	end
	return current, true
end

local function buildVariableMap(src, scriptInstance)
	local map = {}
	for name, rhs in src:gmatch("local%s+([%a_][%w_]*)%s*=%s*([^" .. string.char(13) .. string.char(10) .. "]+)") do
		rhs = rhs:gsub("%s*;%s*$", ""):gsub("%s+$", "")
		local inst, ok = resolveExpression(rhs, scriptInstance, map)
		if ok and inst then
			map[name] = inst
		end
	end
	return map
end

local function mentionsName(expr, name)
	if name:match("^[%w_]+$") then
		return expr:find("%f[%w_]" .. escapePattern(name) .. "%f[^%w_]") ~= nil
	else
		return expr:find(escapePattern(name)) ~= nil
	end
end

----------------------------------------------------------------------
-- RECOLECCIÓN DE SCRIPTS
----------------------------------------------------------------------
local function readSource(inst)
	local ok, src = pcall(function() return inst.Source end)
	if ok and type(src) == "string" then
		return src
	end
	return nil
end

local function getContainers()
	local containers = {}
	for _, name in ipairs(SERVICE_NAMES) do
		local ok, svc = pcall(function() return game:GetService(name) end)
		if ok and svc then
			table.insert(containers, svc)
		end
	end
	return containers
end

local function getAllScripts()
	local scripts, seen = {}, {}
	for _, container in ipairs(getContainers()) do
		local ok, descendants = pcall(function() return container:GetDescendants() end)
		if ok then
			for _, d in ipairs(descendants) do
				if not seen[d] and d:IsA("LuaSourceContainer") then
					seen[d] = true
					table.insert(scripts, d)
				end
			end
		end
	end
	return scripts
end

local function sortByPath(list)
	table.sort(list, function(a, b)
		return a:GetFullName() < b:GetFullName()
	end)
end

----------------------------------------------------------------------
-- GRAFO DEL PROYECTO  (núcleo nuevo de v3)
----------------------------------------------------------------------
-- Construye, en UNA pasada, el grafo dirigido de require del proyecto.
--   G.scripts          : todos los LuaSourceContainer
--   G.modules          : todos los ModuleScript
--   G.reqOf[script]     = { ModuleScript, ... }  (qué requiere, resuelto)
--   G.reqBy[module]     = { script, ... }        (quién lo requiere, resuelto)
--   G.unresolvedOf[s]   = nº de require con ruta dinámica
--   G.unresolvedExprs   = { {script=s, expr=texto}, ... }  (para "posibles")
--   G.assetIdOf[s]      = { "123", ... }          (require por assetId)
-- Detecta 'require' guardado en variable:  local v9 = require  ->  v9(...) es require.
local function findRequireAliases(src)
	local set = {}
	for name, nextc in src:gmatch("([%a_][%w_]*)%s*=%s*require([^%w_])") do
		if nextc ~= "(" and nextc ~= "." and nextc ~= ":" and nextc ~= "[" then
			set[name] = true
		end
	end
	return set
end

-- Extrae el argumento de cada llamada fname(...) respetando paréntesis anidados.
-- Generaliza extractRequireExpressions a cualquier nombre (para alias de require).
local function extractCallArgs(src, fname)
	local exprs, len, i = {}, #src, 1
	while true do
		local s, e = src:find(fname, i, true)
		if not s then break end
		local prevChar  = (s > 1) and src:sub(s - 1, s - 1) or ""
		local afterChar = src:sub(e + 1, e + 1)
		local wordStart = (prevChar == "") or (not prevChar:match("[%w_]"))
		local wordEnd   = (afterChar == "") or (not afterChar:match("[%w_]"))
		if wordStart and wordEnd then
			local j = e + 1
			while j <= len and src:sub(j, j):match("%s") do j = j + 1 end
			if src:sub(j, j) == "(" then
				local depth, k = 0, j
				while k <= len do
					local ch = src:sub(k, k)
					if ch == "(" then
						depth += 1
					elseif ch == ")" then
						depth -= 1
						if depth == 0 then break end
					end
					k += 1
				end
				if depth == 0 then
					table.insert(exprs, src:sub(j + 1, k - 1))
					i = k + 1
				else
					i = e + 1
				end
			else
				i = e + 1
			end
		else
			i = e + 1
		end
	end
	return exprs
end

-- Detecta cargadores dinámicos: bucles  for ... in CONT:GetChildren()/GetDescendants()
-- Devuelve  { [nombreVarBucle] = { container = inst, mode = "children"|"descendants" } }
local function findLoopContainers(src, scriptInstance, varMap)
	local map = {}
	-- Por LÍNEA (en Lua '.' cruza saltos de línea y emparejaría un 'for' dentro
	-- de un string con un 'in' lejano). Variables restringidas a identificadores.
	local NL = string.char(10)
	for line in src:gmatch("[^" .. NL .. "]+") do
		local vars, iter = line:match("for%s+([%w_,%s]+)%s+in%s+(.-)%s+do")
		if vars and iter then
			local cexpr, method = iter:match("([%a_][%w_%.]*)%s*:%s*(Get%a+)%s*%(%s*%)")
			if cexpr and (method == "GetChildren" or method == "GetDescendants") then
				local inst, ok = resolveExpression(cexpr, scriptInstance, varMap)
				if ok and inst then
					local mode = (method == "GetDescendants") and "descendants" or "children"
					for name in vars:gmatch("[%a_][%w_]*") do
						map[name] = { container = inst, mode = mode }
					end
				end
			end
		end
	end
	return map
end

local function buildGraph()
	local scripts = getAllScripts()
	local G = {
		scripts = scripts, modules = {},
		reqOf = {}, reqBy = {}, edgeKind = {},
		unresolvedOf = {}, unresolvedExprs = {}, assetIdOf = {},
		brokenOf = {}, brokenAll = {}, nonModuleOf = {},
	}

	for _, s in ipairs(scripts) do
		if s:IsA("ModuleScript") then
			table.insert(G.modules, s)
			G.reqBy[s] = {}
		end
	end

	-- Añade arista requirer -> module (deduplicada) con su tipo ("static"/"bulk").
	local function addEdge(s, m, kind, seen)
		if m == s or not m:IsA("ModuleScript") or seen[m] then return end
		seen[m] = true
		table.insert(G.reqOf[s], m)
		G.reqBy[m] = G.reqBy[m] or {}
		table.insert(G.reqBy[m], s)
		G.edgeKind[s] = G.edgeKind[s] or {}
		G.edgeKind[s][m] = kind
	end

	local count = 0
	for _, s in ipairs(scripts) do
		G.reqOf[s] = {}
		local raw = readSource(s)
		if raw then
			local src     = stripComments(raw)
			local varMap  = buildVariableMap(src, s)
			local aliases = findRequireAliases(src)
			local loops   = findLoopContainers(src, s, varMap)
			local seen    = {}

			-- require(...) más cualquier alias(...)
			local exprs = extractCallArgs(src, "require")
			for alias in pairs(aliases) do
				for _, e2 in ipairs(extractCallArgs(src, alias)) do
					table.insert(exprs, e2)
				end
			end

			local bulkSeen = {}
			for _, expr in ipairs(exprs) do
				local e = expr:gsub("^%s+", ""):gsub("%s+$", "")
				local base = e:match("^([%a_][%w_]*)")
				local num  = e:match("^(%d+)$")
				if base and loops[base] then
					-- require en bucle: depende de TODOS los módulos del contenedor
					local lc = loops[base]
					if not bulkSeen[lc.container] then
						bulkSeen[lc.container] = true
						local kids = (lc.mode == "descendants")
							and lc.container:GetDescendants() or lc.container:GetChildren()
						for _, m in ipairs(kids) do
							if m:IsA("ModuleScript") then addEdge(s, m, "bulk", seen) end
						end
					end
				elseif num then
					G.assetIdOf[s] = G.assetIdOf[s] or {}
					table.insert(G.assetIdOf[s], num)
				else
					local inst, full = resolveExpression(expr, s, varMap)
					if full and inst and inst:IsA("ModuleScript") then
						addEdge(s, inst, "static", seen)
					elseif full and inst then
						-- ruta válida pero no apunta a un ModuleScript (Folder, etc.): se ignora
						G.nonModuleOf[s] = (G.nonModuleOf[s] or 0) + 1
					elseif full and not inst then
						-- ruta ESTÁTICA completa pero la instancia no existe -> require roto
						-- (error de require en runtime; salvo WaitForChild a algo creado dinámicamente)
						G.brokenOf[s] = G.brokenOf[s] or {}
						table.insert(G.brokenOf[s], e)
						table.insert(G.brokenAll, { script = s, expr = e })
					else
						G.unresolvedOf[s] = (G.unresolvedOf[s] or 0) + 1
						table.insert(G.unresolvedExprs, { script = s, expr = e })
					end
				end
			end
		end
		count += 1
		if count % 60 == 0 then task.wait() end
	end

	return G
end

-- Dependientes "posibles": scripts con require dinámico que MENCIONAN el
-- nombre del módulo pero no se pudo resolver la ruta. Excluye los confirmados.
local function possibleDependents(G, target)
	local confirmed = {}
	for _, s in ipairs(G.reqBy[target] or {}) do confirmed[s] = true end
	local set, list = {}, {}
	for _, u in ipairs(G.unresolvedExprs) do
		if u.script ~= target and not confirmed[u.script] and not set[u.script] then
			if mentionsName(u.expr, target.Name) then
				set[u.script] = true
				table.insert(list, u.script)
			end
		end
	end
	return list
end

-- BFS sobre reqBy: TODOS los scripts que dependen del módulo, directa o
-- indirectamente (hacia arriba en el grafo).
local function transitiveDependents(G, target)
	local seen, queue, out, qi = {}, { target }, {}, 1
	while qi <= #queue do
		local cur = queue[qi]; qi += 1
		for _, r in ipairs(G.reqBy[cur] or {}) do
			if not seen[r] and r ~= target then
				seen[r] = true
				table.insert(out, r)
				table.insert(queue, r)
			end
		end
	end
	return out
end

-- BFS sobre reqOf: todos los ModuleScripts de los que depende (hacia abajo).
local function transitiveDependencies(G, target)
	local seen, queue, out, qi = {}, { target }, {}, 1
	while qi <= #queue do
		local cur = queue[qi]; qi += 1
		for _, d in ipairs(G.reqOf[cur] or {}) do
			if not seen[d] and d ~= target then
				seen[d] = true
				table.insert(out, d)
				table.insert(queue, d)
			end
		end
	end
	return out
end

-- Detección de ciclos por DFS con coloreo (back-edges). Devuelve una lista de
-- ciclos; cada ciclo es { módulo, módulo, ... } en orden del lazo.
local function findCycles(G)
	local color = {}   -- nil = blanco, 1 = gris (en pila), 2 = negro
	local stack = {}
	local cycles, seenKey = {}, {}

	local function visit(u)
		color[u] = 1
		stack[#stack + 1] = u
		for _, v in ipairs(G.reqOf[u] or {}) do
			if v:IsA("ModuleScript") then
				if color[v] == 1 then
					-- back-edge: reconstruye el lazo desde v hasta u
					local cyc, started = {}, false
					for _, n in ipairs(stack) do
						if n == v then started = true end
						if started then cyc[#cyc + 1] = n end
					end
					local keyParts = {}
					for _, n in ipairs(cyc) do keyParts[#keyParts + 1] = n:GetFullName() end
					table.sort(keyParts)
					local key = table.concat(keyParts, "|")
					if not seenKey[key] then
						seenKey[key] = true
						cycles[#cycles + 1] = cyc
					end
				elseif not color[v] then
					visit(v)
				end
			end
		end
		color[u] = 2
		stack[#stack] = nil
	end

	for _, m in ipairs(G.modules) do
		if not color[m] then visit(m) end
	end
	return cycles
end

-- Clasifica módulos sin dependientes confirmados.
--   orphans     : nadie los requiere y nadie menciona su nombre  -> probable muerto
--   maybeOrphans: nadie los requiere pero su nombre aparece en un require dinámico
local function classifyOrphans(G)
	local orphans, maybeOrphans = {}, {}
	for _, m in ipairs(G.modules) do
		if #(G.reqBy[m] or {}) == 0 then
			local mentioned = false
			for _, u in ipairs(G.unresolvedExprs) do
				if mentionsName(u.expr, m.Name) then mentioned = true break end
			end
			if mentioned then
				table.insert(maybeOrphans, m)
			else
				table.insert(orphans, m)
			end
		end
	end
	sortByPath(orphans)
	sortByPath(maybeOrphans)
	return orphans, maybeOrphans
end

local function topRequired(G)
	local list = {}
	for _, m in ipairs(G.modules) do
		local n = #(G.reqBy[m] or {})
		if n > 0 then table.insert(list, { module = m, count = n }) end
	end
	table.sort(list, function(a, b)
		if a.count ~= b.count then return a.count > b.count end
		return a.module:GetFullName() < b.module:GetFullName()
	end)
	return list
end

----------------------------------------------------------------------
-- ANÁLISIS AVANZADO  (v4 — todo sobre el grafo, sin re-parsear)
----------------------------------------------------------------------
-- Contenedores server-only: el cliente NO los ve en runtime.
local SERVER_ONLY = { ServerScriptService = true, ServerStorage = true }

-- Servicio raíz (hijo directo de game) que contiene a una instancia.
local function rootServiceName(inst)
	local cur = inst
	while cur.Parent and cur.Parent ~= game do
		cur = cur.Parent
	end
	return cur.Name
end

-- Requires rotos ordenados: ruta estática completa que NO resuelve a instancia.
local function brokenRequires(G)
	local list = {}
	for _, b in ipairs(G.brokenAll) do list[#list + 1] = b end
	table.sort(list, function(a, b)
		if a.script ~= b.script then
			return a.script:GetFullName() < b.script:GetFullName()
		end
		return a.expr < b.expr
	end)
	return list
end

-- Violaciones de frontera: un script que NO es server-only requiere un módulo
-- en ServerScriptService/ServerStorage. Funciona en Studio (árbol completo)
-- pero el cliente no ve esas carpetas -> require nil en runtime.
local function boundaryViolations(G)
	local out = {}
	for _, s in ipairs(G.scripts) do
		local sr = rootServiceName(s)
		if not SERVER_ONLY[sr] then
			for _, m in ipairs(G.reqOf[s] or {}) do
				local tr = rootServiceName(m)
				if SERVER_ONLY[tr] then
					out[#out + 1] = { from = s, to = m, fromRoot = sr, toRoot = tr }
				end
			end
		end
	end
	table.sort(out, function(a, b)
		return a.from:GetFullName() < b.from:GetFullName()
	end)
	return out
end

-- Acoplamiento por módulo: Ca (fan-in / afferent), Ce (fan-out / efferent),
-- inestabilidad I = Ce/(Ca+Ce)  (0 = muy estable, 1 = muy inestable).
local function couplingStats(G)
	local stats = {}
	for _, m in ipairs(G.modules) do
		local ca = #(G.reqBy[m] or {})
		local ce = #(G.reqOf[m] or {})
		local I = (ca + ce > 0) and (ce / (ca + ce)) or 0
		stats[#stats + 1] = { module = m, ca = ca, ce = ce, I = I }
	end
	return stats
end

local function godModules(G)
	local stats = couplingStats(G)
	table.sort(stats, function(a, b)
		if a.ca ~= b.ca then return a.ca > b.ca end
		return a.module:GetFullName() < b.module:GetFullName()
	end)
	return stats
end

local function fragileModules(G)
	local stats = couplingStats(G)
	table.sort(stats, function(a, b)
		if a.ce ~= b.ce then return a.ce > b.ce end
		return a.module:GetFullName() < b.module:GetFullName()
	end)
	return stats
end

-- Cadena de dependencias más profunda (módulos). Memoizado; ignora back-edges
-- para no colgarse en ciclos.
local function longestChain(G)
	local memo, visiting = {}, {}
	local function depthOf(m)
		if memo[m] then return memo[m] end
		if visiting[m] then return 0 end
		visiting[m] = true
		local best = 0
		for _, dep in ipairs(G.reqOf[m] or {}) do
			if dep:IsA("ModuleScript") then
				local d = depthOf(dep)
				if d > best then best = d end
			end
		end
		visiting[m] = nil
		memo[m] = best + 1
		return memo[m]
	end
	local top = { depth = 0, node = nil }
	for _, m in ipairs(G.modules) do
		local d = depthOf(m)
		if d > top.depth then top.depth = d; top.node = m end
	end
	return top
end

-- Módulos vivos: alcanzables desde algún punto de entrada (Script/LocalScript)
-- siguiendo require hacia abajo.
local function liveSet(G)
	local live, queue, qi = {}, {}, 1
	for _, s in ipairs(G.scripts) do
		if not s:IsA("ModuleScript") then queue[#queue + 1] = s end
	end
	while qi <= #queue do
		local cur = queue[qi]; qi += 1
		for _, d in ipairs(G.reqOf[cur] or {}) do
			if not live[d] then
				live[d] = true
				queue[#queue + 1] = d
			end
		end
	end
	return live
end

-- Muerto en cadena: módulos NO vivos pero que SÍ tienen dependientes (los
-- requiere algo que también está muerto). Los huérfanos directos (fan-in 0)
-- se listan aparte en su propia sección.
local function transitiveDead(G)
	local live = liveSet(G)
	local list = {}
	for _, m in ipairs(G.modules) do
		if not live[m] and #(G.reqBy[m] or {}) > 0 then
			list[#list + 1] = m
		end
	end
	sortByPath(list)
	return list
end

----------------------------------------------------------------------
-- REPORTES DE CONSOLA (pegables)
----------------------------------------------------------------------
local function printModuleReport(G, target)
	local confirmed = {}
	for _, s in ipairs(G.reqBy[target] or {}) do confirmed[#confirmed + 1] = s end
	sortByPath(confirmed)
	local possible = possibleDependents(G, target); sortByPath(possible)
	local deps = {}
	for _, d in ipairs(G.reqOf[target] or {}) do deps[#deps + 1] = d end
	sortByPath(deps)
	local transDep = transitiveDependents(G, target); sortByPath(transDep)
	local transReq = transitiveDependencies(G, target); sortByPath(transReq)

	local bar = string.rep("=", 60)
	print(bar)
	print(("[Relaciones de Módulos]  %s"):format(target.Name))
	print("Ruta: " .. getCleanPath(target))
	print(string.rep("-", 60))

	print(("Requerido por (directo, confirmado): %d"):format(#confirmed))
	for _, s in ipairs(confirmed) do
		local kind = G.edgeKind[s] and G.edgeKind[s][target]
		local suf = (kind == "bulk") and "   (vía loader dinámico)" or ""
		print("   • " .. getCleanPath(s) .. suf)
	end

	if #possible > 0 then
		print(("Posibles (ruta dinámica, sin confirmar): %d"):format(#possible))
		for _, s in ipairs(possible) do print("   ? " .. getCleanPath(s)) end
	end

	print(("Dependientes transitivos (total único): %d"):format(#transDep))

	print(("Dependencias directas: %d"):format(#deps))
	for _, s in ipairs(deps) do print("   -> " .. getCleanPath(s)) end

	print(("Dependencias transitivas (total único): %d"):format(#transReq))

	if G.assetIdOf[target] then
		print(("   (este módulo hace require por assetId: %s)"):format(table.concat(G.assetIdOf[target], ", ")))
	end
	if (G.unresolvedOf[target] or 0) > 0 then
		print(("   (%d require[s] con ruta dinámica no resueltos en este módulo)"):format(G.unresolvedOf[target]))
	end
	if G.brokenOf[target] then
		print(("REQUIRES ROTOS en este módulo: %d  (posible ruta rota)"):format(#G.brokenOf[target]))
		for _, ex in ipairs(G.brokenOf[target]) do print("   ✗ require(" .. ex .. ")") end
	end
	do
		local ca, ce = #(G.reqBy[target] or {}), #(G.reqOf[target] or {})
		local I = (ca + ce > 0) and (ce / (ca + ce)) or 0
		print(("Acoplamiento:  fan-in=%d  fan-out=%d  inestabilidad=%.2f"):format(ca, ce, I))
	end
	print(bar)
end

local function printProjectReport(G, cycles, orphans, maybeOrphans, top)
	local bar = string.rep("=", 60)
	print(bar)
	print("[Salud del proyecto]")
	print(("Módulos: %d   ·   Scripts totales: %d"):format(#G.modules, #G.scripts))
	print(("Ciclos: %d   ·   Huérfanos: %d   ·   Posibles huérfanos: %d")
		:format(#cycles, #orphans, #maybeOrphans))
	print(string.rep("-", 60))

	if #cycles > 0 then
		print("CICLOS DE DEPENDENCIA (pueden romper require):")
		for _, cyc in ipairs(cycles) do
			local names = {}
			for _, m in ipairs(cyc) do names[#names + 1] = m.Name end
			names[#names + 1] = cyc[1].Name -- cerrar el lazo
			print("   ↻ " .. table.concat(names, " -> "))
		end
	end

	if #orphans > 0 then
		print(("HUÉRFANOS (nadie los requiere, posible código muerto): %d"):format(#orphans))
		for _, m in ipairs(orphans) do print("   • " .. getCleanPath(m)) end
	end

	if #top > 0 then
		print("MÁS REQUERIDOS:")
		for i = 1, math.min(TOP_REQUIRED_N, #top) do
			print(("   %3dx  %s"):format(top[i].count, top[i].module.Name))
		end
	end

	local broken = brokenRequires(G)
	if #broken > 0 then
		print(("REQUIRES ROTOS (ruta estática → instancia inexistente): %d"):format(#broken))
		for _, b in ipairs(broken) do
			print(("   ✗ %s   require(%s)"):format(b.script:GetFullName(), b.expr))
		end
	end

	local viol = boundaryViolations(G)
	if #viol > 0 then
		print(("VIOLACIONES DE FRONTERA (cliente/replicado → server-only): %d"):format(#viol))
		for _, v in ipairs(viol) do
			print(("   ⚠ %s  [%s] → %s  [%s]"):format(
				v.from:GetFullName(), v.fromRoot, v.to.Name, v.toRoot))
		end
	end

	local gods = godModules(G)
	print("GOD MODULES (mayor fan-in — tocar con cuidado):")
	for i = 1, math.min(TOP_REQUIRED_N, #gods) do
		local g = gods[i]
		if g.ca == 0 then break end
		print(("   %3d in / %3d out  I=%.2f  %s"):format(g.ca, g.ce, g.I, g.module.Name))
	end

	local frag = fragileModules(G)
	print("MÓDULOS FRÁGILES (mayor fan-out):")
	for i = 1, math.min(10, #frag) do
		local f = frag[i]
		if f.ce == 0 then break end
		print(("   %3d out / %3d in  I=%.2f  %s"):format(f.ce, f.ca, f.I, f.module.Name))
	end

	local lc = longestChain(G)
	if lc.node then
		print(("CADENA MÁS LARGA: %d niveles (termina en %s)"):format(lc.depth, lc.node.Name))
	end

	local dead = transitiveDead(G)
	if #dead > 0 then
		print(("MUERTO EN CADENA (solo alcanzable desde huérfanos): %d"):format(#dead))
		for _, m in ipairs(dead) do print("   • " .. getCleanPath(m)) end
	end

	print(bar)
end

----------------------------------------------------------------------
-- UI: FILAS Y RENDER
----------------------------------------------------------------------
local function clearRows()
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child:IsA("GuiObject") then
			child:Destroy()
		end
	end
end

local function updateCanvas()
	task.defer(function()
		if scrollFrame and scrollFrame.Parent then
			scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
		end
	end)
end

-- opts = {
--   message  = bool,                 -- texto informativo, no clickeable
--   section  = bool,                 -- encabezado de sección
--   badge    = "ok"|"maybe"|"bad",   -- punto de color a la izquierda
--   indent   = number,               -- nivel de sangría (árbol)
--   textColor= Color3,               -- color de texto explícito
--   onClick  = fn,
-- }
local function createRow(text, order, opts)
	opts = opts or {}
	local height = opts.message and 46 or (opts.section and 28 or 34)

	local row = Instance.new("TextButton")
	row.Name = "Row"
	row.Size = UDim2.new(1, -6, 0, height)
	row.AutoButtonColor = false
	row.BorderSizePixel = 0
	row.LayoutOrder = order
	row.Text = ""
	row.Active = not (opts.message or opts.section)
	row.Parent = scrollFrame

	if opts.section then
		row.BackgroundColor3 = C.panel
	elseif opts.message then
		row.BackgroundColor3 = C.rowAlt
	else
		row.BackgroundColor3 = C.row
	end

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = row

	if not (opts.message or opts.section) then
		local stroke = Instance.new("UIStroke")
		stroke.Color = C.stroke
		stroke.Thickness = 1
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = row
	end

	local leftPad = 14 + (opts.indent or 0) * 16

	if opts.badge then
		local dot = Instance.new("Frame")
		dot.Size = UDim2.new(0, 8, 0, 8)
		dot.Position = UDim2.new(0, leftPad - 2, 0.5, -4)
		dot.BorderSizePixel = 0
		dot.BackgroundColor3 =
			(opts.badge == "ok") and C.ok
			or (opts.badge == "bad") and C.bad
			or C.maybe
		local dc = Instance.new("UICorner")
		dc.CornerRadius = UDim.new(1, 0)
		dc.Parent = dot
		dot.Parent = row
		leftPad += 16
	end

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, leftPad, 0, 0)
	label.Size = UDim2.new(1, -(leftPad + 12), 1, 0)
	label.Text = text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextSize = 12
	label.Parent = row

	if opts.section then
		label.TextColor3 = opts.textColor or C.textDim
		label.Font = Enum.Font.SourceSansBold
		label.TextSize = 13
	elseif opts.message then
		label.TextColor3 = opts.textColor or C.textMute
		label.Font = Enum.Font.SourceSansItalic
		label.TextSize = 13
		label.TextWrapped = true
	else
		label.TextColor3 = opts.textColor or C.text
		label.Font = Enum.Font.RobotoMono
		label.TextTruncate = Enum.TextTruncate.AtEnd
	end

	if not (opts.message or opts.section) then
		local base = row.BackgroundColor3
		row.MouseEnter:Connect(function() row.BackgroundColor3 = C.panel end)
		row.MouseLeave:Connect(function() row.BackgroundColor3 = base end)
	end
	if opts.onClick then
		row.MouseButton1Click:Connect(opts.onClick)
	end
	return row
end

local function selectInstance(inst)
	return function() Selection:Set({ inst }) end
end

----------------------------------------------------------------------
-- RENDER: VISTA DE MÓDULO
----------------------------------------------------------------------
-- Árbol de dependencias hacia abajo, con marca de ciclos y duplicados.
local function renderDepTree(G, target, nextOrder)
	local rowCount = 0
	local globalShown = {}

	local function rec(node, depth, pathSet)
		if rowCount >= TREE_MAX_ROWS then return end
		local kids = {}
		for _, d in ipairs(G.reqOf[node] or {}) do kids[#kids + 1] = d end
		table.sort(kids, function(a, b) return a.Name < b.Name end)

		for _, dep in ipairs(kids) do
			if rowCount >= TREE_MAX_ROWS then
				createRow("… (árbol truncado)", nextOrder(), { message = true })
				return
			end
			if pathSet[dep] then
				createRow("↻ " .. dep.Name .. "  (ciclo)", nextOrder(),
					{ indent = depth + 1, textColor = C.bad, onClick = selectInstance(dep) })
				rowCount += 1
			elseif globalShown[dep] then
				createRow(dep.Name .. "  (ya listado)", nextOrder(),
					{ indent = depth + 1, textColor = C.textMute, onClick = selectInstance(dep) })
				rowCount += 1
			else
				globalShown[dep] = true
				createRow("→ " .. dep.Name, nextOrder(),
					{ indent = depth + 1, textColor = C.dep, onClick = selectInstance(dep) })
				rowCount += 1
				if depth + 1 < TREE_MAX_DEPTH then
					local nextPath = table.clone(pathSet)
					nextPath[dep] = true
					rec(dep, depth + 1, nextPath)
				end
			end
		end
	end

	rec(target, 0, { [target] = true })
	return rowCount
end

local function renderModule(G, target)
	clearRows()
	local order = 0
	local function nextOrder() order += 1; return order end

	local confirmed = {}
	for _, s in ipairs(G.reqBy[target] or {}) do confirmed[#confirmed + 1] = s end
	sortByPath(confirmed)
	local possible = possibleDependents(G, target); sortByPath(possible)
	local deps = {}
	for _, d in ipairs(G.reqOf[target] or {}) do deps[#deps + 1] = d end
	sortByPath(deps)
	local transDep = transitiveDependents(G, target); sortByPath(transDep)
	local transReq = transitiveDependencies(G, target)

	infoLabel.Text = ("%s  ·  %d directo / %d transitivo  ·  requiere %d (→%d total)")
		:format(target.Name, #confirmed, #transDep, #deps, #transReq)

	-- Requerido por (directo)
	createRow(("Requerido por — directo: %d"):format(#confirmed), nextOrder(), { section = true })
	if #confirmed == 0 then
		createRow("Ningún script lo requiere directamente.", nextOrder(), { message = true })
	else
		for _, s in ipairs(confirmed) do
			local kind = G.edgeKind[s] and G.edgeKind[s][target]
			local txt = getCleanPath(s) .. ((kind == "bulk") and "   (vía loader)" or "")
			createRow(txt, nextOrder(), { badge = "ok", onClick = selectInstance(s) })
		end
	end

	-- Posibles
	if #possible > 0 then
		createRow(("Posibles — ruta dinámica: %d"):format(#possible), nextOrder(), { section = true })
		for _, s in ipairs(possible) do
			createRow(getCleanPath(s) .. "   (posible)", nextOrder(),
				{ badge = "maybe", onClick = selectInstance(s) })
		end
	end

	-- Dependientes transitivos
	createRow(("Dependientes transitivos — total: %d"):format(#transDep), nextOrder(), { section = true })
	if #transDep == 0 then
		createRow("Nadie depende de este módulo (ni en cadena).", nextOrder(), { message = true })
	else
		local shown = math.min(#transDep, LIST_CAP)
		for i = 1, shown do
			createRow(transDep[i].Name, nextOrder(),
				{ indent = 1, textColor = C.textDim, onClick = selectInstance(transDep[i]) })
		end
		if #transDep > shown then
			createRow(("… y %d más"):format(#transDep - shown), nextOrder(), { message = true })
		end
	end

	-- Dependencias directas + árbol
	createRow(("Dependencias directas: %d"):format(#deps), nextOrder(), { section = true })
	if #deps == 0 then
		createRow("Este módulo no requiere ningún otro módulo.", nextOrder(), { message = true })
	else
		for _, d in ipairs(deps) do
			createRow("→ " .. getCleanPath(d), nextOrder(),
				{ textColor = C.dep, onClick = selectInstance(d) })
		end
		createRow("Árbol de dependencias (hacia abajo)", nextOrder(), { section = true })
		renderDepTree(G, target, nextOrder)
	end

	-- Notas
	local notes = {}
	if G.assetIdOf[target] then
		table.insert(notes, ("require por assetId: %s"):format(table.concat(G.assetIdOf[target], ", ")))
	end
	if (G.unresolvedOf[target] or 0) > 0 then
		table.insert(notes, ("%d require dinámico no resuelto en este módulo"):format(G.unresolvedOf[target]))
	end
	if #notes > 0 then
		createRow("Notas: " .. table.concat(notes, "  ·  "), nextOrder(), { message = true })
	end

	-- Acoplamiento de este módulo
	do
		local ca, ce = #confirmed, #deps
		local I = (ca + ce > 0) and (ce / (ca + ce)) or 0
		createRow(("Acoplamiento — fan-in %d · fan-out %d · inestabilidad %.2f"):format(ca, ce, I),
			nextOrder(), { section = true })
	end

	-- Requires rotos en este módulo
	if G.brokenOf[target] then
		createRow(("Requires rotos — posible ruta rota: %d"):format(#G.brokenOf[target]),
			nextOrder(), { section = true, textColor = C.bad })
		for _, ex in ipairs(G.brokenOf[target]) do
			createRow("✗ require(" .. ex .. ")", nextOrder(), { badge = "bad", textColor = C.bad })
		end
	end

	updateCanvas()
end

----------------------------------------------------------------------
-- RENDER: VISTA DE PROYECTO
----------------------------------------------------------------------
local function renderProject(G)
	clearRows()
	local order = 0
	local function nextOrder() order += 1; return order end

	local cycles = findCycles(G)
	local orphans, maybeOrphans = classifyOrphans(G)
	local top = topRequired(G)

	infoLabel.Text = ("Proyecto  ·  %d módulos  ·  %d ciclo(s)  ·  %d huérfano(s)")
		:format(#G.modules, #cycles, #orphans)

	-- Ciclos
	createRow(("Ciclos de dependencia: %d"):format(#cycles), nextOrder(),
		{ section = true, textColor = (#cycles > 0) and C.bad or C.ok })
	if #cycles == 0 then
		createRow("Sin ciclos. 👍", nextOrder(), { message = true })
	else
		for _, cyc in ipairs(cycles) do
			local names = {}
			for _, m in ipairs(cyc) do names[#names + 1] = m.Name end
			names[#names + 1] = cyc[1].Name
			createRow(table.concat(names, "  ↻  "), nextOrder(),
				{ badge = "bad", textColor = C.bad, onClick = selectInstance(cyc[1]) })
		end
	end

	-- Huérfanos
	createRow(("Huérfanos — nadie los requiere: %d"):format(#orphans), nextOrder(), { section = true })
	if #orphans == 0 then
		createRow("No hay módulos huérfanos.", nextOrder(), { message = true })
	else
		local shown = math.min(#orphans, LIST_CAP)
		for i = 1, shown do
			createRow(getCleanPath(orphans[i]), nextOrder(),
				{ badge = "maybe", onClick = selectInstance(orphans[i]) })
		end
		if #orphans > shown then
			createRow(("… y %d más"):format(#orphans - shown), nextOrder(), { message = true })
		end
	end

	if #maybeOrphans > 0 then
		createRow(("Posibles huérfanos — solo referidos dinámicamente: %d"):format(#maybeOrphans),
			nextOrder(), { section = true })
		local shown = math.min(#maybeOrphans, LIST_CAP)
		for i = 1, shown do
			createRow(getCleanPath(maybeOrphans[i]), nextOrder(),
				{ textColor = C.textDim, onClick = selectInstance(maybeOrphans[i]) })
		end
	end

	-- Más requeridos
	createRow("Más requeridos", nextOrder(), { section = true })
	if #top == 0 then
		createRow("Ningún módulo es requerido todavía.", nextOrder(), { message = true })
	else
		for i = 1, math.min(TOP_REQUIRED_N, #top) do
			createRow(("%dx   %s"):format(top[i].count, getCleanPath(top[i].module)), nextOrder(),
				{ onClick = selectInstance(top[i].module) })
		end
	end

	-- Requires rotos
	local broken = brokenRequires(G)
	createRow(("Requires rotos — posible ruta rota: %d"):format(#broken), nextOrder(),
		{ section = true, textColor = (#broken > 0) and C.bad or C.ok })
	if #broken == 0 then
		createRow("Ningún require con ruta estática rota.", nextOrder(), { message = true })
	else
		local shown = math.min(#broken, LIST_CAP)
		for i = 1, shown do
			local b = broken[i]
			createRow(("✗ %s   require(%s)"):format(getCleanPath(b.script), b.expr), nextOrder(),
				{ badge = "bad", textColor = C.bad, onClick = selectInstance(b.script) })
		end
		if #broken > shown then
			createRow(("… y %d más"):format(#broken - shown), nextOrder(), { message = true })
		end
	end

	-- Violaciones de frontera
	local viol = boundaryViolations(G)
	createRow(("Violaciones de frontera — cliente/replicado → server-only: %d"):format(#viol),
		nextOrder(), { section = true, textColor = (#viol > 0) and C.bad or C.ok })
	if #viol == 0 then
		createRow("Sin requires que crucen al server desde el cliente.", nextOrder(), { message = true })
	else
		local shown = math.min(#viol, LIST_CAP)
		for i = 1, shown do
			local v = viol[i]
			createRow(("⚠ %s  [%s] → %s  [%s]"):format(getCleanPath(v.from), v.fromRoot, v.to.Name, v.toRoot),
				nextOrder(), { badge = "bad", textColor = C.maybe, onClick = selectInstance(v.from) })
		end
		if #viol > shown then
			createRow(("… y %d más"):format(#viol - shown), nextOrder(), { message = true })
		end
	end

	-- God modules (mayor fan-in)
	local gods = godModules(G)
	createRow("God modules — mayor fan-in (riesgo al modificarlos)", nextOrder(), { section = true })
	local anyGod = false
	for i = 1, math.min(TOP_REQUIRED_N, #gods) do
		local g = gods[i]
		if g.ca == 0 then break end
		anyGod = true
		createRow(("in %d · out %d · I=%.2f   %s"):format(g.ca, g.ce, g.I, getCleanPath(g.module)),
			nextOrder(), { onClick = selectInstance(g.module) })
	end
	if not anyGod then
		createRow("Ningún módulo tiene dependientes.", nextOrder(), { message = true })
	end

	-- Módulos frágiles (mayor fan-out)
	local frag = fragileModules(G)
	createRow("Módulos frágiles — mayor fan-out", nextOrder(), { section = true })
	local anyFrag = false
	for i = 1, math.min(10, #frag) do
		local f = frag[i]
		if f.ce == 0 then break end
		anyFrag = true
		createRow(("out %d · in %d · I=%.2f   %s"):format(f.ce, f.ca, f.I, getCleanPath(f.module)),
			nextOrder(), { textColor = C.dep, onClick = selectInstance(f.module) })
	end
	if not anyFrag then
		createRow("Ningún módulo requiere a otros.", nextOrder(), { message = true })
	end

	-- Cadena de dependencias más larga
	local lc = longestChain(G)
	if lc.node then
		createRow(("Cadena de dependencias más larga: %d niveles"):format(lc.depth),
			nextOrder(), { section = true })
		createRow("termina en  " .. getCleanPath(lc.node), nextOrder(),
			{ textColor = C.textDim, onClick = selectInstance(lc.node) })
	end

	-- Código muerto transitivo
	local dead = transitiveDead(G)
	createRow(("Muerto en cadena — solo alcanzable desde huérfanos: %d"):format(#dead),
		nextOrder(), { section = true })
	if #dead == 0 then
		createRow("No hay módulos muertos en cadena.", nextOrder(), { message = true })
	else
		local shown = math.min(#dead, LIST_CAP)
		for i = 1, shown do
			createRow(getCleanPath(dead[i]), nextOrder(),
				{ badge = "maybe", textColor = C.textMute, onClick = selectInstance(dead[i]) })
		end
		if #dead > shown then
			createRow(("… y %d más"):format(#dead - shown), nextOrder(), { message = true })
		end
	end

	printProjectReport(G, cycles, orphans, maybeOrphans, top)
	updateCanvas()
end

----------------------------------------------------------------------
-- RESUMEN / OUTLINE DE UN SCRIPT  (estructura: nombres, no código)
----------------------------------------------------------------------
-- Lee el Source y extrae:
--   functions : { name, params, kind ("local"/"field"/"method"/"global"),
--                 line, depth }  -- depth = nivel de anidación por sangría
--   topLocals : { name, line }  -- locales de nivel superior (estado del módulo)
--   returnInfo: { expr, line }  -- qué devuelve el módulo (forma del retorno)
local function extractOutline(src)
	local clean = stripComments(src)
	local NL = string.char(10)
	local functions, topLocals = {}, {}
	local returnInfo
	local lineNo = 0
	for line in (clean .. NL):gmatch("([^" .. NL .. "]*)" .. NL) do
		lineNo += 1
		local lead   = line:match("^[ " .. string.char(9) .. "]*") or ""
		local tabs   = select(2, lead:gsub(string.char(9), ""))
		local spaces = select(2, lead:gsub(" ", ""))
		local depth  = tabs + math.floor(spaces / 4)
		local body   = line:gsub("^%s+", "")

		local name, params

		-- local function NAME(...)
		name, params = body:match("^local%s+function%s+([%w_]+)%s*(%b())")
		if name then
			functions[#functions + 1] =
				{ name = name, params = params, kind = "local", line = lineNo, depth = depth }
		else
			-- function NAME / T.NAME / T:NAME (...)
			name, params = body:match("^function%s+([%w_%.:]+)%s*(%b())")
			if name then
				local kind = name:find(":") and "method"
					or (name:find("%.") and "field" or "global")
				functions[#functions + 1] =
					{ name = name, params = params, kind = kind, line = lineNo, depth = depth }
			else
				-- local NAME = function(...)
				name, params = body:match("^local%s+([%w_]+)%s*=%s*function%s*(%b())")
				if name then
					functions[#functions + 1] =
						{ name = name, params = params, kind = "local", line = lineNo, depth = depth }
				else
					-- NAME = function(...) / T.NAME = function(...) / T:NAME = function(...)
					name, params = body:match("^([%w_%.:]+)%s*=%s*function%s*(%b())")
					if name then
						local kind = name:find(":") and "method"
							or (name:find("%.") and "field" or "global")
						functions[#functions + 1] =
							{ name = name, params = params, kind = kind, line = lineNo, depth = depth }
					end
				end
			end
		end

		-- Locales de nivel superior (sangría 0, no función): estado del módulo.
		if depth == 0 and not body:match("^local%s+function") and not body:match("=%s*function") then
			local names = body:match("^local%s+([%w_][%w_,%s]*)%s*=")
				or body:match("^local%s+([%w_][%w_,%s]*)%s*$")
			if names then
				for nm in names:gmatch("[%w_]+") do
					topLocals[#topLocals + 1] = { name = nm, line = lineNo }
				end
			end
		end

		-- Retorno de nivel superior (forma del módulo).
		if depth == 0 then
			local r = body:match("^return%s+(.-)%s*$")
			if r and r ~= "" then returnInfo = { expr = r, line = lineNo } end
		end
	end
	return functions, topLocals, returnInfo
end

local function kindMark(kind)
	return (kind == "local") and "L"
		or (kind == "method") and ":"
		or (kind == "field") and "."
		or "g"
end

local function printOutlineReport(target, functions, topLocals, returnInfo)
	local bar = string.rep("=", 60)
	print(bar)
	print(("[Resumen del módulo]  %s"):format(target.Name))
	print("Ruta: " .. getCleanPath(target))
	print("Marcas:  L=local function   .=campo de tabla   :=método   g=global")
	print(string.rep("-", 60))

	print(("Locales de nivel superior: %d"):format(#topLocals))
	for _, l in ipairs(topLocals) do
		print(("   • %s   (línea %d)"):format(l.name, l.line))
	end

	print(("Funciones: %d"):format(#functions))
	for _, f in ipairs(functions) do
		local indent = string.rep("   ", math.min(f.depth, 8))
		print(("   [%s] %s%s%s   (línea %d)"):format(kindMark(f.kind), indent, f.name, f.params, f.line))
	end

	if returnInfo then
		local e = returnInfo.expr
		if #e > 60 then e = e:sub(1, 57) .. "..." end
		print(("Retorno: return %s   (línea %d)"):format(e, returnInfo.line))
	end
	print(bar)
end

local function renderOutline(target)
	clearRows()
	local order = 0
	local function nextOrder() order += 1; return order end

	local src = readSource(target)
	if not src then
		infoLabel.Text = "No se pudo leer el Source"
		createRow("Este objeto no tiene un Source legible.", nextOrder(), { message = true })
		updateCanvas()
		return
	end

	local functions, topLocals, returnInfo = extractOutline(src)
	infoLabel.Text = ("%s  ·  %d funciones · %d locales"):format(target.Name, #functions, #topLocals)

	createRow("Resumen de estructura: lista SOLO los nombres de las funciones (con su "
		.. "firma y línea) y los locales de nivel superior — sin imprimir el cuerpo. "
		.. "Marcas: L=local · .=campo · :=método · g=global. El detalle completo se "
		.. "imprime en el Output (pegable).", nextOrder(), { message = true })

	createRow(("Locales de nivel superior: %d"):format(#topLocals), nextOrder(), { section = true })
	if #topLocals == 0 then
		createRow("Sin locales de nivel superior.", nextOrder(), { message = true })
	else
		local shown = math.min(#topLocals, LIST_CAP)
		for i = 1, shown do
			createRow(("• %s   (línea %d)"):format(topLocals[i].name, topLocals[i].line),
				nextOrder(), { indent = 1, textColor = C.textDim })
		end
		if #topLocals > shown then
			createRow(("… y %d más (ver Output)"):format(#topLocals - shown), nextOrder(), { message = true })
		end
	end

	createRow(("Funciones: %d"):format(#functions), nextOrder(), { section = true })
	if #functions == 0 then
		createRow("No se detectaron funciones.", nextOrder(), { message = true })
	else
		local shown = math.min(#functions, LIST_CAP)
		for i = 1, shown do
			local f = functions[i]
			createRow(("[%s] %s%s   (línea %d)"):format(kindMark(f.kind), f.name, f.params, f.line),
				nextOrder(), { indent = math.min(f.depth, 8), textColor = C.dep,
					onClick = selectInstance(target) })
		end
		if #functions > shown then
			createRow(("… y %d más (ver Output)"):format(#functions - shown), nextOrder(), { message = true })
		end
	end

	if returnInfo then
		local e = returnInfo.expr
		if #e > 60 then e = e:sub(1, 57) .. "..." end
		createRow(("Retorno:  return %s   (línea %d)"):format(e, returnInfo.line), nextOrder(), { message = true })
	end

	printOutlineReport(target, functions, topLocals, returnInfo)
	updateCanvas()
end

local function runOutline()
	if not widget then return end
	local sel = Selection:Get()
	if #sel ~= 1 or not sel[1]:IsA("LuaSourceContainer") then
		clearRows()
		infoLabel.Text = "Selecciona 1 script"
		createRow("Selecciona un único ModuleScript (o Script) en el Explorer para ver el resumen de sus funciones y locales.",
			1, { message = true })
		updateCanvas()
		return
	end
	renderOutline(sel[1])
end

----------------------------------------------------------------------
-- CONTROL: ANALIZAR / BUSCAR
----------------------------------------------------------------------
local function runWithGraph(label, renderFn)
	if analyzing then return end
	analyzing = true

	clearRows()
	infoLabel.Text = label
	createRow("Escaneando el proyecto, espera un momento…", 1, { message = true })
	updateCanvas()

	task.spawn(function()
		local ok, err = pcall(function()
			local G = buildGraph()
			renderFn(G)
		end)
		if not ok then
			clearRows()
			infoLabel.Text = "Error durante el análisis"
			createRow("Ocurrió un error: " .. tostring(err), 1, { message = true })
			updateCanvas()
		end
		analyzing = false
	end)
end

local function runAnalysis(target)
	runWithGraph(("Analizando “%s”…"):format(target.Name), function(G)
		renderModule(G, target)
		printModuleReport(G, target)
	end)
end

local function runProjectScan()
	runWithGraph("Escaneando salud del proyecto…", function(G)
		renderProject(G)
	end)
end

local function analyzeSelection()
	if not widget then return end
	local sel = Selection:Get()
	if #sel ~= 1 or not sel[1]:IsA("ModuleScript") then
		clearRows()
		infoLabel.Text = "Selecciona 1 ModuleScript"
		createRow("Selecciona un único ModuleScript en el Explorer, búscalo por nombre arriba, o usa “Salud del proyecto”.",
			1, { message = true })
		updateCanvas()
		return
	end
	runAnalysis(sel[1])
end

local function searchModules(query)
	query = query:lower()
	local matches = {}
	for _, scr in ipairs(getAllScripts()) do
		if scr:IsA("ModuleScript") and scr.Name:lower():find(query, 1, true) then
			table.insert(matches, scr)
		end
	end
	return matches
end

local function runSearch(query)
	query = (query or ""):gsub("^%s+", ""):gsub("%s+$", "")
	if query == "" then
		analyzeSelection()
		return
	end

	local matches = searchModules(query)
	if #matches == 0 then
		clearRows()
		infoLabel.Text = "Sin resultados"
		createRow(("No se encontró ningún ModuleScript que contenga “%s”."):format(query),
			1, { message = true })
		updateCanvas()
	elseif #matches == 1 then
		runAnalysis(matches[1])
	else
		clearRows()
		infoLabel.Text = ("%d módulos encontrados — elige uno"):format(#matches)
		sortByPath(matches)
		for i, m in ipairs(matches) do
			createRow(getCleanPath(m), i, { onClick = function() runAnalysis(m) end })
		end
		updateCanvas()
	end
end

----------------------------------------------------------------------
-- UI: CONSTRUCCIÓN
----------------------------------------------------------------------
local function styleAccentButton(b)
	b.BackgroundColor3 = C.accent
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.SourceSansBold
	b.MouseEnter:Connect(function() b.BackgroundColor3 = C.accentHi end)
	b.MouseLeave:Connect(function() b.BackgroundColor3 = C.accent end)
end

local function styleSecondaryButton(b)
	b.BackgroundColor3 = C.row
	b.TextColor3 = C.text
	b.Font = Enum.Font.SourceSansSemibold
	b.MouseEnter:Connect(function() b.BackgroundColor3 = C.panel end)
	b.MouseLeave:Connect(function() b.BackgroundColor3 = C.row end)
end

local function makeButton(text, size, pos, parent)
	local b = Instance.new("TextButton")
	b.Size = size
	b.Position = pos
	b.Text = text
	b.TextSize = 13
	b.AutoButtonColor = false
	b.BorderSizePixel = 0
	b.Parent = parent
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = b
	return b
end

local function buildUI()
	widget = plugin:CreateDockWidgetPluginGui(
		"ModuleDependencyViewerUI",
		DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 560, 460, 380, 300)
	)
	widget.Title = "Relaciones de Módulos"
	widget.Name = "ModuleDependencyViewerUI"

	local main = Instance.new("Frame")
	main.Size = UDim2.new(1, 0, 1, 0)
	main.BackgroundColor3 = C.bg
	main.BorderSizePixel = 0
	main.Parent = widget

	-- Barra superior
	local top = Instance.new("Frame")
	top.Size = UDim2.new(1, 0, 0, 138)
	top.BackgroundColor3 = C.panel
	top.BorderSizePixel = 0
	top.Parent = main

	local sep = Instance.new("Frame")
	sep.Size = UDim2.new(1, 0, 0, 1)
	sep.Position = UDim2.new(0, 0, 1, -1)
	sep.BackgroundColor3 = C.line
	sep.BorderSizePixel = 0
	sep.Parent = top

	infoLabel = Instance.new("TextLabel")
	infoLabel.Size = UDim2.new(1, -24, 0, 20)
	infoLabel.Position = UDim2.new(0, 12, 0, 8)
	infoLabel.BackgroundTransparency = 1
	infoLabel.Text = "Busca un módulo, selecciónalo, o escanea el proyecto"
	infoLabel.TextColor3 = C.textDim
	infoLabel.TextXAlignment = Enum.TextXAlignment.Left
	infoLabel.TextTruncate = Enum.TextTruncate.AtEnd
	infoLabel.Font = Enum.Font.SourceSansSemibold
	infoLabel.TextSize = 13
	infoLabel.Parent = top

	-- Caja de búsqueda (command bar)
	searchBox = Instance.new("TextBox")
	searchBox.Size = UDim2.new(1, -118, 0, 30)
	searchBox.Position = UDim2.new(0, 12, 0, 34)
	searchBox.BackgroundColor3 = C.input
	searchBox.PlaceholderText = "Buscar módulo por nombre…  (Enter)"
	searchBox.PlaceholderColor3 = C.textMute
	searchBox.Text = ""
	searchBox.TextColor3 = C.text
	searchBox.TextXAlignment = Enum.TextXAlignment.Left
	searchBox.Font = Enum.Font.SourceSans
	searchBox.TextSize = 14
	searchBox.ClearTextOnFocus = false
	searchBox.BorderSizePixel = 0
	searchBox.Parent = top
	local sbPad = Instance.new("UIPadding"); sbPad.PaddingLeft = UDim.new(0, 10); sbPad.Parent = searchBox
	local sbCorner = Instance.new("UICorner"); sbCorner.CornerRadius = UDim.new(0, 6); sbCorner.Parent = searchBox
	local sbStroke = Instance.new("UIStroke"); sbStroke.Color = C.stroke; sbStroke.Parent = searchBox

	local searchBtn = makeButton("Buscar", UDim2.new(0, 94, 0, 30), UDim2.new(1, -106, 0, 34), top)
	styleAccentButton(searchBtn)

	-- Dos acciones lado a lado: selección y proyecto
	local selBtn = makeButton("Analizar selección", UDim2.new(0.5, -16, 0, 28), UDim2.new(0, 12, 0, 70), top)
	styleSecondaryButton(selBtn)

	local projBtn = makeButton("Salud del proyecto", UDim2.new(0.5, -16, 0, 28), UDim2.new(0.5, 4, 0, 70), top)
	styleSecondaryButton(projBtn)

	-- Tercera fila: resumen de estructura del módulo seleccionado
	local outlineBtn = makeButton("Resumen del módulo (funciones)", UDim2.new(1, -24, 0, 28), UDim2.new(0, 12, 0, 104), top)
	styleSecondaryButton(outlineBtn)

	-- Lista de resultados
	scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Size = UDim2.new(1, -24, 1, -150)
	scrollFrame.Position = UDim2.new(0, 12, 0, 148)
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 6
	scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollFrame.Parent = main

	listLayout = Instance.new("UIListLayout")
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 6)
	listLayout.Parent = scrollFrame

	-- Eventos
	searchBtn.MouseButton1Click:Connect(function() runSearch(searchBox.Text) end)
	searchBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then runSearch(searchBox.Text) end
	end)
	selBtn.MouseButton1Click:Connect(analyzeSelection)
	projBtn.MouseButton1Click:Connect(runProjectScan)
	outlineBtn.MouseButton1Click:Connect(runOutline)

	widget:GetPropertyChangedSignal("Enabled"):Connect(function()
		button:SetActive(widget.Enabled)
	end)

	analyzeSelection()
end

----------------------------------------------------------------------
-- ABRIR / CERRAR
----------------------------------------------------------------------
local function togglePlugin()
	if not widget then
		buildUI()
		widget.Enabled = true
	else
		widget.Enabled = not widget.Enabled
	end
	button:SetActive(widget.Enabled)
end

button.Click:Connect(togglePlugin)

pluginAction.Triggered:Connect(function()
	if not widget then
		buildUI()
		widget.Enabled = true
		button:SetActive(true)
	end
	analyzeSelection()
end)

Selection.SelectionChanged:Connect(function()
	if not widget or not widget.Enabled or analyzing then return end
	local sel = Selection:Get()
	if #sel == 1 and sel[1]:IsA("ModuleScript") then
		infoLabel.Text = "Listo para analizar: " .. sel[1].Name
	end
end)

plugin.Unloading:Connect(function()
	if widget then
		widget:Destroy()
	end
end)
