--!nocheck
-- rbxm2lua: turn non-model .rbxm packs (UI, audio, animations, lighting, materials) into Lua builder modules.
--
--   lune run rbxm2lua.luau <game-dir> [--keep]
--
-- Converts every .rbxm (or an older generated .lua) under <game-dir>/{ui,audio,animations} plus map/lighting and
-- materials packs. Each output is a ModuleScript-style file:
--     local build = require(path.to.module)
--     local gui = build()                 -- returns the root (or a list when the pack has several roots)
--     gui.Parent = player.PlayerGui
-- Only properties that differ from the engine default are written. Scripts inside packs are
-- skipped (their source lives in source/scripts). The .rbxm is deleted unless --keep is given.
local fs = require("@lune/fs")
local process = require("@lune/process")
local roblox = require("@lune/roblox")
local serde = require("@lune/serde")

local luau = require("@lune/luau")
local db = roblox.getReflectionDatabase()
local ENV = { Enum = roblox.Enum, math = math, string = string, table = table, typeof = typeof }
for _, k in { "Instance", "UDim2", "UDim", "Vector2", "Vector3", "Color3", "CFrame", "ColorSequence",
	"ColorSequenceKeypoint", "NumberSequence", "NumberSequenceKeypoint", "NumberRange", "Rect", "Font",
	"BrickColor", "PhysicalProperties", "Faces", "Axes", "Content" } do
	local ok, v = pcall(function()
		return roblox[k]
	end)
	if ok and v ~= nil then
		ENV[k] = v
	end
end
local gameDir = process.args[1]
local keep = table.find(process.args, "--keep") ~= nil

local SKIP_PROPS = {
	Parent = true, Name = true, ClassName = true, Archivable = true, UniqueId = true, HistoryId = true,
	SourceAssetId = true, Capabilities = true, Sandboxed = true, DefinesCapabilities = true,
	RootLocalizationTable = true, NextSelectionUp = true, NextSelectionDown = true, NextSelectionLeft = true,
	NextSelectionRight = true, SelectionImageObject = true, Localize = false,
	Text = false, -- written explicitly below (kept even when empty-ish)
}
local SKIP_CLASSES = { Script = true, LocalScript = true, ModuleScript = true }

local propCache = {}
local function propsOf(className)
	if propCache[className] then
		return propCache[className]
	end
	local list, defaults = {}, {}
	local cls = db:GetClass(className)
	if cls then
		for k, v in cls.DefaultProperties do
			defaults[k] = v
		end
	end
	local okNew, fresh = pcall(roblox.Instance.new, className)
	local seen = {}
	while cls do
		for name, p in cls.Properties do
			if not seen[name] and not SKIP_PROPS[name] then
				seen[name] = true
				local bad = p.Scriptability ~= "ReadWrite"
				for _, t in p.Tags do
					if t == "Hidden" or t == "Deprecated" or t == "NotScriptable" or t == "ReadOnly" then
						bad = true
					end
				end
				if not bad then
					table.insert(list, { name = name, type = p.Datatype })
					if okNew then
						local okV, dv = pcall(function()
							return fresh[name]
						end)
						if okV and dv ~= nil then
							defaults[name] = dv
						end
					end
				end
			end
		end
		cls = cls.Superclass and db:GetClass(cls.Superclass) or nil
	end
	table.sort(list, function(a, b)
		return a.name < b.name
	end)
	propCache[className] = { list = list, defaults = defaults }
	return propCache[className]
end

local function num(n)
	if n ~= n then
		return "0/0"
	end
	if n == math.huge then
		return "math.huge"
	elseif n == -math.huge then
		return "-math.huge"
	end
	if n == math.floor(n) and math.abs(n) < 1e15 then
		return string.format("%d", n)
	end
	local s = string.format("%.7f", n):gsub("0+$", ""):gsub("%.$", "")
	if s == "-0" then
		s = "0"
	end
	return s
end

local function str(s)
	return (string.format("%q", s):gsub("\\\n", "\\n"))
end

local unknownTypes = {}

local function fmt(v)
	local t = typeof(v)
	if t == "string" then
		return str(v)
	elseif t == "number" then
		return num(v)
	elseif t == "boolean" then
		return tostring(v)
	elseif t == "EnumItem" then
		return tostring(v)
	elseif t == "UDim2" then
		if v.X.Offset == 0 and v.Y.Offset == 0 then
			return ("UDim2.fromScale(%s, %s)"):format(num(v.X.Scale), num(v.Y.Scale))
		elseif v.X.Scale == 0 and v.Y.Scale == 0 then
			return ("UDim2.fromOffset(%s, %s)"):format(num(v.X.Offset), num(v.Y.Offset))
		end
		return ("UDim2.new(%s, %s, %s, %s)"):format(num(v.X.Scale), num(v.X.Offset), num(v.Y.Scale), num(v.Y.Offset))
	elseif t == "UDim" then
		return ("UDim.new(%s, %s)"):format(num(v.Scale), num(v.Offset))
	elseif t == "Vector2" then
		return ("Vector2.new(%s, %s)"):format(num(v.X), num(v.Y))
	elseif t == "Vector3" then
		return ("Vector3.new(%s, %s, %s)"):format(num(v.X), num(v.Y), num(v.Z))
	elseif t == "Color3" then
		return ("Color3.fromRGB(%d, %d, %d)"):format(
			math.clamp(math.round(v.R * 255), 0, 255),
			math.clamp(math.round(v.G * 255), 0, 255),
			math.clamp(math.round(v.B * 255), 0, 255)
		)
	elseif t == "CFrame" then
		local c = { v:GetComponents() }
		local identityRot = c[4] == 1 and c[5] == 0 and c[6] == 0 and c[7] == 0 and c[8] == 1 and c[9] == 0
			and c[10] == 0 and c[11] == 0 and c[12] == 1
		if identityRot then
			return ("CFrame.new(%s, %s, %s)"):format(num(c[1]), num(c[2]), num(c[3]))
		end
		for i, x in c do
			c[i] = num(x)
		end
		return "CFrame.new(" .. table.concat(c, ", ") .. ")"
	elseif t == "ColorSequence" then
		local k = {}
		for _, p in v.Keypoints do
			table.insert(k, ("ColorSequenceKeypoint.new(%s, %s)"):format(num(p.Time), fmt(p.Value)))
		end
		return "ColorSequence.new({ " .. table.concat(k, ", ") .. " })"
	elseif t == "NumberSequence" then
		local k = {}
		for _, p in v.Keypoints do
			if p.Envelope ~= 0 then
				table.insert(k, ("NumberSequenceKeypoint.new(%s, %s, %s)"):format(num(p.Time), num(p.Value), num(p.Envelope)))
			else
				table.insert(k, ("NumberSequenceKeypoint.new(%s, %s)"):format(num(p.Time), num(p.Value)))
			end
		end
		return "NumberSequence.new({ " .. table.concat(k, ", ") .. " })"
	elseif t == "NumberRange" then
		return ("NumberRange.new(%s, %s)"):format(num(v.Min), num(v.Max))
	elseif t == "Rect" then
		return ("Rect.new(%s, %s, %s, %s)"):format(num(v.Min.X), num(v.Min.Y), num(v.Max.X), num(v.Max.Y))
	elseif t == "Font" then
		return ("Font.new(%s, %s, %s)"):format(str(v.Family), tostring(v.Weight), tostring(v.Style))
	elseif t == "BrickColor" then
		return ("BrickColor.new(%s)"):format(str(v.Name))
	elseif t == "PhysicalProperties" then
		return ("PhysicalProperties.new(%s, %s, %s, %s, %s)"):format(
			num(v.Density), num(v.Friction), num(v.Elasticity), num(v.FrictionWeight), num(v.ElasticityWeight))
	elseif t == "Faces" or t == "Axes" then
		local names = {}
		for _, n in { "Top", "Bottom", "Left", "Right", "Back", "Front", "X", "Y", "Z" } do
			local ok, has = pcall(function()
				return v[n]
			end)
			if ok and has then
				table.insert(names, "Enum." .. (t == "Faces" and "NormalId" or "Axis") .. "." .. n)
			end
		end
		return t .. ".new(" .. table.concat(names, ", ") .. ")"
	elseif t == "Content" then
		local ok, uri = pcall(function()
			return v.Uri
		end)
		if ok and uri then
			return "Content.fromUri(" .. str(uri) .. ")"
		end
		return nil
	end
	unknownTypes[t] = true
	return nil
end

local function equal(a, b)
	if typeof(a) == "EnumItem" and type(b) == "number" then
		return a.Value == b
	end
	if typeof(a) ~= typeof(b) then
		return false
	end
	if typeof(a) == "EnumItem" then
		return tostring(a) == tostring(b)
	end
	if typeof(a) ~= "string" and type(a) ~= "number" and typeof(a) ~= "boolean" then
		local fa, fb = fmt(a), fmt(b)
		if fa and fb then
			return fa == fb
		end
	end
	if type(a) == "number" then
		return math.abs(a - b) < 1e-6
	end
	local ok, r = pcall(function()
		return a == b
	end)
	return ok and r
end

local LIMIT = 185000 -- Studio refuses Source strings of 200k+ chars, so bigger builders are split

local HELPER = [[
local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end]]

-- one line per instance: I[n] = new(Class, parent, Name, {props}, {attrs}, {tags}), indented by depth
local function instanceLines(roots)
	local ids, order, depth, refs, asFolder = {}, {}, {}, {}, {}
	local function hasContent(inst)
		for _, d in inst:GetDescendants() do
			if not SKIP_CLASSES[d.ClassName] then
				return true
			end
		end
		return false
	end
	local function collect(inst, d)
		if SKIP_CLASSES[inst.ClassName] then
			-- the code lives in source/scripts; keep what the script holds under a Folder of the same name
			if not hasContent(inst) then
				return
			end
			asFolder[inst] = inst.ClassName
		end
		table.insert(order, inst)
		ids[inst] = #order
		depth[inst] = d
		for _, c in inst:GetChildren() do
			collect(c, d + 1)
		end
	end
	for _, r in roots do
		collect(r, 0)
	end
	local lines = {}
	for idx, inst in order do
		if asFolder[inst] then
			local parent = inst.Parent and ids[inst.Parent]
			local ind = string.rep("\t", 1 + math.min(depth[inst], 12))
			table.insert(lines, ("%sI[%d] = new(\"Folder\", %s, %s) -- was a %s (code in source/scripts)"):format(
				ind, idx, parent and ("I[%d]"):format(parent) or "nil", str(inst.Name), asFolder[inst]))
			continue
		end
		local info = propsOf(inst.ClassName)
		local props = {}
		for _, p in info.list do
			local ok, v = pcall(function()
				return inst[p.name]
			end)
			if ok and v ~= nil then
				if typeof(v) == "Instance" then
					if ids[v] then
						table.insert(refs, ("I[%d].%s = I[%d]"):format(idx, p.name, ids[v]))
					end
				elseif not equal(v, info.defaults[p.name]) then
					local f = fmt(v)
					if f then
						table.insert(props, p.name .. " = " .. f)
					end
				end
			end
		end
		local attrs, tags = {}, {}
		local okA, a = pcall(function()
			return inst:GetAttributes()
		end)
		if okA then
			local names = {}
			for k in a do
				table.insert(names, k)
			end
			table.sort(names)
			for _, k in names do
				local f = k:sub(1, 3) ~= "RBX" and fmt(a[k]) or nil
				if f then
					table.insert(attrs, "[" .. str(k) .. "] = " .. f)
				end
			end
		end
		local okT, t = pcall(function()
			return inst:GetTags()
		end)
		if okT then
			for _, tg in t do
				table.insert(tags, str(tg))
			end
		end
		local parent = inst.Parent and ids[inst.Parent]
		local args = { str(inst.ClassName), parent and ("I[%d]"):format(parent) or "nil", str(inst.Name) }
		if #props > 0 or #attrs > 0 or #tags > 0 then
			table.insert(args, #props > 0 and ("{ " .. table.concat(props, ", ") .. " }") or "nil")
		end
		if #attrs > 0 or #tags > 0 then
			table.insert(args, #attrs > 0 and ("{ " .. table.concat(attrs, ", ") .. " }") or "nil")
		end
		if #tags > 0 then
			table.insert(args, "{ " .. table.concat(tags, ", ") .. " }")
		end
		local ind = string.rep("\t", 1 + math.min(depth[inst], 12))
		table.insert(lines, ("%sI[%d] = new(%s)"):format(ind, idx, table.concat(args, ", ")))
	end
	local rootIdx = {}
	for _, r in roots do
		if ids[r] then
			table.insert(rootIdx, ("I[%d]"):format(ids[r]))
		end
	end
	local ret = #rootIdx == 1 and rootIdx[1] or ("{ " .. table.concat(rootIdx, ", ") .. " }")
	return lines, refs, ret, #order
end

-- returns { [relative file] = code }, instance count
local function convert(roots, header, baseName)
	local lines, refs, ret, n = instanceLines(roots)
	local refBlock = #refs > 0 and ("\t" .. table.concat(refs, "\n\t") .. "\n") or ""
	local single = table.concat({
		header, "", HELPER, "", "local function build()", "\tlocal I = {}", table.concat(lines, "\n"),
		refBlock .. "\treturn " .. ret, "end", "", "return build", "",
	}, "\n")
	if #single <= LIMIT then
		return { [baseName .. ".lua"] = single }, n
	end
	-- split: <base>/init.lua + <base>/PartNN.lua (Rojo layout: ModuleScript with ModuleScript children)
	local files, parts, cur, size = {}, {}, {}, 0
	for _, l in lines do
		if size + #l > LIMIT - 4000 and #cur > 0 then
			table.insert(parts, cur)
			cur, size = {}, 0
		end
		table.insert(cur, l)
		size += #l + 1
	end
	table.insert(parts, cur)
	local names = {}
	for i, chunk in parts do
		local nm = ("Part%02d"):format(i)
		table.insert(names, "script." .. nm)
		files[baseName .. "/" .. nm .. ".lua"] = table.concat({
			("-- Part %d of %d of %s (see init.lua)"):format(i, #parts, baseName), "",
			"return function(I, new)", table.concat(chunk, "\n"), "end", "",
		}, "\n")
	end
	files[baseName .. "/init.lua"] = table.concat({
		header,
		"-- Large pack: split into ModuleScript children (Rojo layout). In Studio make init.lua a ModuleScript",
		"-- and put each PartNN.lua inside it as a ModuleScript named PartNN.", "",
		HELPER, "", "local parts = { " .. table.concat(names, ", ") .. " }", "",
		"local function build()", "\tlocal I = {}", "\tfor _, part in parts do", "\t\trequire(part)(I, new)", "\tend",
		refBlock .. "\treturn " .. ret, "end", "", "return build", "",
	}, "\n")
	return files, n
end

-- run the generated files in Lune to prove they rebuild the pack
local function validate(files, baseName, rel)
	local env = table.clone(ENV)
	local single = files[baseName .. ".lua"]
	local fn
	if single then
		fn = luau.load(single, { debugName = rel, environment = env })
	else
		local scriptT, loaded = {}, {}
		for path, code in files do
			local nm = path:match("/(Part%d+)%.lua$")
			if nm then
				local marker = { name = nm }
				scriptT[nm] = marker
				loaded[marker] = luau.load(code, { debugName = rel .. "/" .. nm, environment = table.clone(ENV) })()
			end
		end
		env.script = scriptT
		env.require = function(m)
			return loaded[m]
		end
		fn = luau.load(files[baseName .. "/init.lua"], { debugName = rel, environment = env })
	end
	local built = fn()()
	assert(built ~= nil, "build() returned nil")
end

local KIND_NOTE = {
	ui = "UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)",
	audio = "Audio pack: require(this)() returns the Sound / SoundGroup instances; parent them where you need them",
	animations = "Animation pack: require(this)() returns the KeyframeSequence / Animation instances",
	lighting = "Lighting pack: for _, o in require(this)() do o.Parent = game.Lighting end (Lighting properties are in Environment.lua)",
	materials = "Material pack: parent the returned MaterialVariants to game.MaterialService",
}

local function walk(dir, kind, acc)
	if not fs.isDir(dir) then
		return
	end
	for _, name in fs.readDir(dir) do
		local p = dir .. "/" .. name
		if fs.isDir(p) then
			if not fs.isFile(p .. "/init.lua") then -- already split output
				walk(p, kind, acc)
			end
		elseif name:sub(-5) == ".rbxm" then
			table.insert(acc, { path = p, kind = kind, ext = ".rbxm" })
		elseif name:sub(-4) == ".lua" and name ~= "AnimationIds.lua" and name ~= "Sounds.lua" then
			table.insert(acc, { path = p, kind = kind, ext = ".lua" })
		end
	end
end

local jobs = {}
walk(gameDir .. "/ui", "ui", jobs)
walk(gameDir .. "/audio", "audio", jobs)
walk(gameDir .. "/animations", "animations", jobs)
walk(gameDir .. "/materials", "materials", jobs)
for _, pair in { { "lighting", "lighting" }, { "materials", "materials" } } do
	for _, ext in { ".rbxm", ".lua" } do
		local p = gameDir .. "/map/" .. pair[1] .. ext
		if fs.isFile(p) then
			table.insert(jobs, { path = p, kind = pair[2], ext = ext })
		end
	end
end

local done, failed, skipped, instances, split = 0, 0, 0, 0, 0
for _, job in jobs do
	local ok, err = pcall(function()
		local roots
		if job.ext == ".rbxm" then
			roots = roblox.deserializeModel(fs.readFile(job.path))
		else
			local src = fs.readFile(job.path)
			if not src:find("by _tools/rbxm2lua.luau", 1, true) or src:find("\nlocal function new(", 1, true) then
				skipped += 1
				return -- not a generated builder, or already in the compact format
			end
			local built = luau.load(src, { debugName = job.path, environment = table.clone(ENV) })()()
			roots = typeof(built) == "Instance" and { built } or built
		end
		local base = job.path:sub(1, -(#job.ext + 1))
		local rel = base:sub(#gameDir + 2)
		local header = ("-- Generated from %s.rbxm by _tools/rbxm2lua.luau\n-- %s"):format(rel, KIND_NOTE[job.kind])
		local baseName = base:match("([^/]+)$")
		local dir = base:sub(1, #base - #baseName)
		local files, n = convert(roots, header, baseName)
		validate(files, baseName, rel)
		for name, code in files do
			local full = dir .. name
			local sub = full:match("^(.*)/[^/]+$")
			if sub and not fs.isDir(sub) then
				fs.writeDir(sub)
			end
			fs.writeFile(full, code)
		end
		if not files[baseName .. ".lua"] then
			split += 1
			if fs.isFile(base .. ".lua") then
				fs.removeFile(base .. ".lua")
			end
		end
		if job.ext == ".rbxm" and not keep then
			fs.removeFile(job.path)
		end
		instances += n
		done += 1
	end)
	if not ok then
		failed += 1
		print("FAIL " .. job.path .. ": " .. tostring(err))
	end
end
local unk = {}
for k in unknownTypes do
	table.insert(unk, k)
end
print(("%s: %d converted (%d split), %d failed, %d skipped, %d instances%s"):format(
	gameDir, done, split, failed, skipped, instances, #unk > 0 and (", skipped types: " .. table.concat(unk, ",")) or ""))
