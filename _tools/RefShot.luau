--!nocheck
-- RefShot: screenshot every screen and panel of the packed UIs (rbxasset://refshots/<slug>.rbxm).
-- Runs in Studio's plugin context (edit mode). Each capture is sent to shot_server.py, which saves it.
local CaptureService = game:GetService("CaptureService")
local ContentProvider = game:GetService("ContentProvider")
local Http = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local URL = "http://127.0.0.1:8891/"
local MAX_PER_GUI = 24
local MAX_PER_GAME = 110
local MIN_AREA = 0.04 -- share of the screen a panel must cover

-- neutral backdrop behind every shot (so light and dark UIs both read)
local function backdrop()
	local old = StarterGui:FindFirstChild("RefShotBackdrop")
	if old then
		return
	end
	local g = Instance.new("ScreenGui")
	g.Name = "RefShotBackdrop"
	g.DisplayOrder = -100000
	g.IgnoreGuiInset = true
	local f = Instance.new("Frame")
	f.Size = UDim2.fromScale(1, 1)
	f.BorderSizePixel = 0
	f.BackgroundColor3 = Color3.new(1, 1, 1)
	f.Parent = g
	local grad = Instance.new("UIGradient")
	grad.Rotation = 90
	grad.Color = ColorSequence.new(Color3.fromRGB(78, 84, 96), Color3.fromRGB(40, 43, 50))
	grad.Parent = f
	g.Parent = StarterGui
end

local M = { status = "idle", log = {} }

local function post(path, t)
	local ok, r = pcall(Http.PostAsync, Http, URL .. path, Http:JSONEncode(t))
	return ok and r or nil
end

local function clean(s)
	s = tostring(s):gsub("[^%w%-_]+", "_"):gsub("_+", "_")
	return s:sub(1, 60)
end

local tried = {} -- image ids already requested this session (loaded or failed)

local function preload(root)
	local list, seen = {}, {}
	local all = root:GetDescendants()
	table.insert(all, root)
	for _, d in all do
		if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Image ~= "" then
			local id = d.Image
			if not tried[id] and not seen[id] then
				seen[id] = true
				table.insert(list, id)
			end
		end
	end
	if #list == 0 then
		task.wait(0.05)
		return
	end
	for _, id in list do
		tried[id] = true
	end
	local done = false
	task.spawn(function()
		pcall(ContentProvider.PreloadAsync, ContentProvider, list)
		done = true
	end)
	local t = os.clock()
	while not done and os.clock() - t < 5 do
		task.wait(0.1)
	end
end

local function capture(slug, file, rect, dir)
	local id
	CaptureService:CaptureScreenshot(function(c)
		id = c
	end)
	local t = os.clock()
	while not id and os.clock() - t < 10 do
		task.wait()
	end
	local vp = workspace.CurrentCamera.ViewportSize
	local r = post("shot", { slug = slug, file = file, rect = rect, vw = vp.X, vh = vp.Y, dir = dir })
	return r and r:find('"ok": true') ~= nil or (r and r:find('"ok":true') ~= nil)
end

local function screenArea(gui)
	local s = gui.AbsoluteSize
	return math.max(1, s.X * s.Y)
end

local function overlap(g, gui)
	local p, s = g.AbsolutePosition, g.AbsoluteSize
	local S = gui.AbsoluteSize
	local x0, y0 = math.max(0, p.X), math.max(0, p.Y)
	local x1, y1 = math.min(S.X, p.X + s.X), math.min(S.Y, p.Y + s.Y)
	local a = math.max(0, x1 - x0) * math.max(0, y1 - y0)
	return a / math.max(1, s.X * s.Y)
end

local function drawable(g)
	if g:IsA("TextLabel") or g:IsA("TextButton") or g:IsA("TextBox") then
		if g.Text ~= "" and g.TextTransparency < 1 then
			return true
		end
	end
	if (g:IsA("ImageLabel") or g:IsA("ImageButton")) and g.Image ~= "" and g.ImageTransparency < 1 then
		return true
	end
	return g.BackgroundTransparency < 1
end

local function shownChain(g, gui)
	local x = g
	while x and x ~= gui do
		if x:IsA("GuiObject") and not x.Visible then
			return false
		end
		x = x.Parent
	end
	return true
end

-- how much of the gui is visible on screen right now
local function visibleCount(gui)
	local n = 0
	for _, d in gui:GetDescendants() do
		if d:IsA("GuiObject") and shownChain(d, gui) and drawable(d) then
			local s = d.AbsoluteSize
			if s.X > 2 and s.Y > 2 and overlap(d, gui) > 0.5 then
				n += 1
			end
		end
	end
	return n
end

local function big(g, gui)
	if not g:IsA("GuiObject") then
		return false
	end
	local s = g.AbsoluteSize
	return #g:GetDescendants() >= 4 and (s.X * s.Y) / screenArea(gui) >= MIN_AREA
end

-- temporarily change properties; returns an undo function
local function changer()
	local undo = {}
	local function set(o, k, v)
		if o[k] ~= v then
			table.insert(undo, { o, k, o[k] })
			o[k] = v
		end
	end
	local function restore()
		for i = #undo, 1, -1 do
			local u = undo[i]
			pcall(function()
				u[1][u[2]] = u[3]
			end)
		end
		table.clear(undo)
	end
	return set, restore
end

-- pop-in tweens often leave panels at Scale 0 / fully transparent; open them up for the shot
local function openUp(p, set)
	local list = p:GetDescendants()
	table.insert(list, p)
	for _, d in list do
		if d:IsA("UIScale") and d.Scale < 0.2 then
			set(d, "Scale", 1)
		elseif d:IsA("CanvasGroup") and d.GroupTransparency > 0.8 then
			set(d, "GroupTransparency", 0)
		end
	end
end

-- panels inside a gui: hidden or off-screen containers big enough to be a menu
local function findPanels(gui)
	local out = {}
	local function walk(node, depth)
		for _, c in node:GetChildren() do
			if c:IsA("GuiObject") then
				local hidden = not c.Visible
				local set, restore = changer()
				if hidden then
					set(c, "Visible", true)
				end
				local isBig = big(c, gui)
				local off = isBig and overlap(c, gui) < 0.35
				restore()
				if isBig and (hidden or off) then
					-- a transparent wrapper holding several menus: shoot each menu on its own
					local kids = {}
					for _, k in c:GetChildren() do
						if k:IsA("GuiObject") and big(k, gui) then
							table.insert(kids, k)
						end
					end
					if #kids >= 2 and c.BackgroundTransparency >= 0.95 and not c:IsA("ImageLabel") then
						for _, k in kids do
							table.insert(out, { panel = k, via = c, off = off })
						end
					else
						table.insert(out, { panel = c, off = off })
					end
				elseif depth < 5 then
					walk(c, depth + 1)
				end
			elseif c:IsA("Folder") and depth < 5 then
				walk(c, depth + 1)
			end
		end
	end
	walk(gui, 0)
	return out
end

-- on-screen bounds of a panel and everything visible inside it
local function bounds(p, gui)
	local S = gui.AbsoluteSize
	local x0, y0, x1, y1 = math.huge, math.huge, -math.huge, -math.huge
	local list = p:GetDescendants()
	table.insert(list, p)
	for _, d in list do
		if d:IsA("GuiObject") and shownChain(d, gui) and (d == p or drawable(d)) then
			local a, s = d.AbsolutePosition, d.AbsoluteSize
			if s.X > 1 and s.Y > 1 then
				x0, y0 = math.min(x0, a.X), math.min(y0, a.Y)
				x1, y1 = math.max(x1, a.X + s.X), math.max(y1, a.Y + s.Y)
			end
		end
	end
	if x0 == math.huge then
		return nil
	end
	return { math.max(0, x0), math.max(0, y0), math.min(S.X, x1), math.min(S.Y, y1) }
end

local function relPath(x, gui)
	local parts = {}
	while x and x ~= gui do
		table.insert(parts, 1, x.Name)
		x = x.Parent
	end
	return table.concat(parts, ".")
end

function M.shootGame(slug)
	local ok, roots = pcall(function()
		return game:GetObjects("rbxasset://refshots/" .. slug .. ".rbxm")
	end)
	if not ok then
		post("log", { slug = slug, error = tostring(roots), shots = {} })
		return 0
	end
	for _, c in StarterGui:GetChildren() do
		if c:GetAttribute("RefShot") then
			c:Destroy()
		end
	end
	backdrop()
	local holder = Instance.new("Folder")
	holder.Name = "RefShotHolder"
	holder.Parent = game:GetService("ServerStorage")
	local guis = {}
	for i, r in roots do
		local gui = r
		if not r:IsA("ScreenGui") then
			gui = Instance.new("ScreenGui")
			gui.Name = r.Name
			gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			r.Parent = gui
			if r:IsA("GuiObject") then
				r.AnchorPoint = Vector2.new(0.5, 0.5)
				r.Position = UDim2.fromScale(0.5, 0.5)
				r.Visible = true
			end
			gui:SetAttribute("Template", true)
		end
		gui:SetAttribute("RefShot", true)
		gui:SetAttribute("Order", i)
		gui.Parent = holder
		table.insert(guis, gui)
	end

	local shots, n = {}, 0
	for _, gui in guis do
		if n >= MAX_PER_GAME then
			break
		end
		local set, restore = changer()
		gui.Parent = StarterGui
		gui.Enabled = true
		task.wait(0.15)
		preload(gui)
		task.wait(0.1)
		local base = clean(gui.Name)
		local perGui = 0
		if visibleCount(gui) >= 2 then
			n += 1
			perGui += 1
			local file = string.format("%02d_%s", n, base)
			if capture(slug, file) then
				table.insert(shots, { file = file, gui = gui.Name, panel = "", template = gui:GetAttribute("Template") == true })
			end
		end
		for _, item in findPanels(gui) do
			if n >= MAX_PER_GAME or perGui >= MAX_PER_GUI then
				break
			end
			local p = item.panel
			local x, top = p, p
			while x and x ~= gui do
				if x:IsA("GuiObject") then
					set(x, "Visible", true)
				end
				top = x
				x = x.Parent
			end
			-- hide the rest of the HUD so the panel stands alone
			for _, k in gui:GetChildren() do
				if k ~= top and k:IsA("GuiObject") then
					set(k, "Visible", false)
				end
			end
			if item.via then -- hide the other menus in the same wrapper
				for _, k in item.via:GetChildren() do
					if k ~= p and k:IsA("GuiObject") then
						set(k, "Visible", false)
					end
				end
			end
			if overlap(p, gui) < 0.35 then
				set(p, "AnchorPoint", Vector2.new(0.5, 0.5))
				set(p, "Position", UDim2.fromScale(0.5, 0.5))
			end
			openUp(p, set)
			task.wait(0.1)
			if overlap(p, gui) >= 0.2 then
				preload(p)
				task.wait(0.05)
				n += 1
				perGui += 1
				local rp = relPath(p, gui)
				local file = string.format("%02d_%s__%s", n, base, clean(p.Name))
				if capture(slug, file, bounds(p, gui)) then
					table.insert(shots, { file = file, gui = gui.Name, panel = rp })
				end
			end
			restore()
		end
		restore()
		gui.Parent = holder
	end
	post("log", { slug = slug, shots = shots, viewport = tostring(workspace.CurrentCamera.ViewportSize) })
	holder:Destroy()
	return n
end

-- 3D previews of model packs: rbxasset://refshots/models/<slug>/<n>.rbxm
function M.shootModels(slug, items)
	local bd = StarterGui:FindFirstChild("RefShotBackdrop")
	if bd then
		bd.Enabled = false
	end
	local cam = workspace.CurrentCamera
	cam.CameraType = Enum.CameraType.Scriptable -- Studio's own camera controller overrides CFrame otherwise
	local shots = {}
	for _, it in items do
		local ok, objs = pcall(function()
			return game:GetObjects(("rbxasset://refshots/models/%s/%d.rbxm"):format(slug, it.n))
		end)
		if ok and #objs > 0 then
			local m = Instance.new("Model")
			m.Name = "RefShotModel"
			for _, o in objs do
				pcall(function()
					o.Parent = m
				end)
			end
			for _, d in m:GetDescendants() do
				if d:IsA("BasePart") then
					d.Anchored = true
				elseif d:IsA("Humanoid") then
					d.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				elseif d:IsA("BillboardGui") or d:IsA("ProximityPrompt") then
					pcall(function()
						d.Enabled = false
					end)
				end
			end
			m.Parent = workspace
			-- world-axis bounds of every part
			local function aabb()
				local lo, hi = Vector3.one * math.huge, -Vector3.one * math.huge
				for _, d in m:GetDescendants() do
					if d:IsA("BasePart") and d.Transparency < 1 then
						local c, s = d.CFrame, d.Size / 2
						local ext = Vector3.new(
							math.abs(c.RightVector.X) * s.X + math.abs(c.UpVector.X) * s.Y + math.abs(c.LookVector.X) * s.Z,
							math.abs(c.RightVector.Y) * s.X + math.abs(c.UpVector.Y) * s.Y + math.abs(c.LookVector.Y) * s.Z,
							math.abs(c.RightVector.Z) * s.X + math.abs(c.UpVector.Z) * s.Y + math.abs(c.LookVector.Z) * s.Z)
						lo = lo:Min(c.Position - ext)
						hi = hi:Max(c.Position + ext)
					end
				end
				return lo, hi
			end
			local lo, hi = aabb()
			if lo.X < math.huge and (hi - lo).Magnitude > 0.1 then
				-- sit it on the baseplate at the origin
				local mid = (lo + hi) / 2
				m:PivotTo(m:GetPivot() + Vector3.new(-mid.X, 0.05 - lo.Y, -mid.Z))
				local s2 = hi - lo
				local list = {}
				for _, d in m:GetDescendants() do
					if d:IsA("MeshPart") or d:IsA("SpecialMesh") or d:IsA("Decal") or d:IsA("Texture")
						or d:IsA("SurfaceAppearance") or d:IsA("ParticleEmitter") then
						table.insert(list, d)
					end
				end
				if #list > 0 then
					local done = false
					task.spawn(function()
						pcall(ContentProvider.PreloadAsync, ContentProvider, list)
						done = true
					end)
					local t = os.clock()
					while not done and os.clock() - t < 8 do
						task.wait(0.1)
					end
				end
				local r = s2.Magnitude / 2
				local fov = math.rad(cam.FieldOfView)
				local dist = r / math.sin(fov / 2) * 0.95
				local center = Vector3.new(0, s2.Y / 2, 0)
				local dir = Vector3.new(1, 0.55, 1.15).Unit
				cam.CFrame = CFrame.lookAt(center + dir * dist, center)
				task.wait(0.35)
				local file = string.format("%02d_%s", it.n, clean(it.name))
				if capture(slug, file, nil, "models") then
					table.insert(shots, { file = file, n = it.n })
				end
			end
			m:Destroy()
		end
	end
	if bd then
		bd.Enabled = true
	end
	return shots
end

function M.runModels(all)
	M.status = "models"
	local i = 0
	for slug, items in all do
		M.current = slug
		pcall(M.shootModels, slug, items)
		i += 1
		M.done = i
	end
	M.status = "models done"
end

function M.run(slugs)
	M.status = "running"
	for i, slug in slugs do
		M.current = slug
		local ok, err = pcall(M.shootGame, slug)
		if not ok then
			post("log", { slug = slug, error = tostring(err), shots = {} })
		end
		M.done = i
	end
	M.status = "done"
end

return M
