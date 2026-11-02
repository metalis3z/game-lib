-- Content Creator Panel — server side.
-- Who: players whose tag in ServerScriptService.TagConfig_Old (the same list TagService uses for the overhead tags) contains
-- "CREATOR". This is NOT admin access: creators only get the actions below, every request is checked here (permission,
-- target, parameters, cooldown), and nothing touches saved data, currency, inventory, eggs, events or progression.
-- Actions: 6 troll commands (Ragdoll, Rocket, Freeze, Disco, Jumpscare, Jail), teleport to a player / a zone / back.
-- Every troll effect is temporary: one physical effect at a time per target, cleaned up on end, death, respawn or leave.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local folder = ReplicatedStorage:WaitForChild("CreatorPanel")
local Config = require(folder:WaitForChild("CreatorConfig"))
local request = folder:WaitForChild("Request")
local event = folder:WaitForChild("Event")
local Tags = require(ServerScriptService:FindFirstChild("TagConfig") or ServerScriptService:WaitForChild("TagConfig_Old"))
local FX = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig")).FxTextures

local rgb = Color3.fromRGB
local function now() return workspace:GetServerTimeNow() end

---------------------------------------------------------------- permissions
local function isCreator(player)
	if typeof(player) ~= "Instance" or not player:IsA("Player") or not player.Parent then return false end
	local name = string.lower(player.Name)
	for user, tag in Tags do
		if type(user) == "string" and type(tag) == "string" and string.lower(user) == name and string.find(string.upper(tag), Config.TagKeyword, 1, true) then
			return true
		end
	end
	return false
end
-- the attribute only shows the panel button; the server never trusts it
local function markCreator(player) player:SetAttribute("IsContentCreator", isCreator(player) or nil) end
Players.PlayerAdded:Connect(markCreator)
for _, p in Players:GetPlayers() do markCreator(p) end

---------------------------------------------------------------- helpers
local function aliveParts(player)
	local character = player and player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not (character and humanoid and root and humanoid.Health > 0 and character:IsDescendantOf(workspace)) then return nil end
	return character, humanoid, root
end
local function notify(player, text, kind)
	if player and player.Parent then event:FireClient(player, "Notice", text, kind or "info") end
end
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local fxFolder = workspace:FindFirstChild("CreatorEffects") or new("Folder", {Name = "CreatorEffects"}, workspace)
local function fxPart(props)
	local p = new("Part", {Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false, TopSurface = Enum.SurfaceType.Smooth,
		BottomSurface = Enum.SurfaceType.Smooth}, nil)
	for k, v in props do p[k] = v end
	p.Parent = props.Parent or fxFolder
	return p
end
local function burst(parent, texture, colors, count, speed, size, life, opts)
	opts = opts or {}
	local e = new("ParticleEmitter", {Texture = texture, Rate = 0, LightEmission = opts.LE or 1, LightInfluence = 0, Drag = opts.Drag or 3,
		Acceleration = opts.Accel or Vector3.zero, Speed = NumberRange.new(speed[1], speed[2]), SpreadAngle = Vector2.new(180, 180),
		Lifetime = NumberRange.new(life[1], life[2]), Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-180, 180), Color = colors,
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.4), NumberSequenceKeypoint.new(0.3, size), NumberSequenceKeypoint.new(1, 0)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, opts.Alpha or 0), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1)})}, parent)
	e:Emit(count)
	return e
end
local function groundBelow(position, ignore)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = ignore
	local hit = workspace:Raycast(position + Vector3.new(0, 2, 0), Vector3.new(0, -80, 0), params)
	return hit and hit.Position
end

---------------------------------------------------------------- effect state (one physical effect per target)
-- active[player] = {Kind, Cleanup, Token} ; visual[player] = same for Disco
local active, visual = {}, {}
local function finish(store, player)
	local state = store[player]
	if not state then return end
	store[player] = nil
	for _, c in state.Connections do c:Disconnect() end
	local ok, err = pcall(state.Cleanup)
	if not ok then warn("[CreatorPanelServer] cleanup failed: " .. tostring(err)) end
end
-- runs setup(character, humanoid, root, state) -> cleanup ; ends after "duration" seconds, or at death / respawn / leave
local function startEffect(store, target, kind, duration, setup)
	local character, humanoid, root = aliveParts(target)
	if not character then return false end
	local state = {Kind = kind, Connections = {}, Cleanup = function() end}
	store[target] = state
	local function stop() if store[target] == state then finish(store, target) end end
	table.insert(state.Connections, humanoid.Died:Connect(stop))
	table.insert(state.Connections, target.CharacterRemoving:Connect(stop))
	table.insert(state.Connections, character.AncestryChanged:Connect(function() if not character:IsDescendantOf(workspace) then stop() end end))
	local ok, cleanup = pcall(setup, character, humanoid, root, state, stop)
	if not ok then
		warn("[CreatorPanelServer] " .. kind .. " failed: " .. tostring(cleanup))
		store[target] = nil
		for _, c in state.Connections do c:Disconnect() end
		return false
	end
	state.Cleanup = cleanup or state.Cleanup
	if duration then task.delay(duration, stop) end
	return true
end
Players.PlayerRemoving:Connect(function(player)
	finish(active, player)
	finish(visual, player)
end)

---------------------------------------------------------------- RAGDOLL (used by Ragdoll and Rocket)
-- R15 avatars here use AnimationConstraints (+ BallSocketConstraints already in the rig): turning the animation joints off makes
-- the body hang on its ball sockets. Older Motor6D rigs get temporary ball sockets. Everything is put back exactly as it was.
local function applyRagdoll(character, humanoid, root)
	local changed, created, collide = {}, {}, {}
	local function hasSocket(a0, a1)
		for _, d in character:GetDescendants() do
			if d:IsA("BallSocketConstraint") and d.Enabled and ((d.Attachment0 == a0 and d.Attachment1 == a1)
				or (d.Attachment0 and d.Attachment1 and d.Attachment0.Parent and d.Attachment1.Parent
					and (d.Attachment0.Parent == a0 or d.Attachment0 == a0) and (d.Attachment1.Parent == a1 or d.Attachment1 == a1))) then
				return true
			end
		end
		return false
	end
	for _, d in character:GetDescendants() do
		if d:FindFirstAncestorWhichIsA("Accessory") or d:FindFirstAncestorWhichIsA("Tool") then continue end
		if d:IsA("AnimationConstraint") and d.Enabled and d.Name ~= "Root" and d.Attachment0 and d.Attachment1 then
			if not hasSocket(d.Attachment0, d.Attachment1) then
				table.insert(created, new("BallSocketConstraint", {Name = "CreatorRagdollSocket", Attachment0 = d.Attachment0, Attachment1 = d.Attachment1,
					LimitsEnabled = true, UpperAngle = 60, TwistLimitsEnabled = true, TwistLowerAngle = -45, TwistUpperAngle = 45}, d.Parent))
			end
			d.Enabled = false
			table.insert(changed, d)
		elseif d:IsA("Motor6D") and d.Enabled and d.Name ~= "RootJoint" and d.Name ~= "Root" and d.Part0 and d.Part1 then
			local a0 = new("Attachment", {Name = "CreatorRagdollA0", CFrame = d.C0}, d.Part0)
			local a1 = new("Attachment", {Name = "CreatorRagdollA1", CFrame = d.C1}, d.Part1)
			local socket = new("BallSocketConstraint", {Name = "CreatorRagdollSocket", Attachment0 = a0, Attachment1 = a1, LimitsEnabled = true, UpperAngle = 60,
				TwistLimitsEnabled = true, TwistLowerAngle = -45, TwistUpperAngle = 45}, d.Part0)
			table.insert(created, a0) table.insert(created, a1) table.insert(created, socket)
			d.Enabled = false
			table.insert(changed, d)
		end
	end
	for _, p in character:GetChildren() do
		if p:IsA("BasePart") and p ~= root and not p.CanCollide then collide[p] = true p.CanCollide = true end
	end
	local requiresNeck = humanoid.RequiresNeck
	humanoid.RequiresNeck = false -- (the neck joint is off for a moment : the humanoid must not think the head fell off)
	character:SetAttribute("CreatorRagdoll", true) -- the target's own client switches its humanoid to Physics (CreatorEffectsClient)
	return function()
		if character.Parent then character:SetAttribute("CreatorRagdoll", nil) end
		for _, d in changed do if d.Parent then d.Enabled = true end end
		for _, o in created do if o.Parent then o:Destroy() end end
		for p in collide do if p.Parent then p.CanCollide = false end end
		if humanoid.Parent then humanoid.RequiresNeck = requiresNeck end
	end
end

local function ragdollFx(root)
	local at = new("Attachment", {}, root)
	burst(at, FX.Star, ColorSequence.new(rgb(255, 255, 255), rgb(180, 140, 255)), 22, {10, 18}, 1.4, {0.5, 0.9})
	burst(at, FX.Glow, ColorSequence.new(rgb(170, 120, 255)), 1, {0, 0}, 9, {0.3, 0.4})
	Debris:AddItem(at, 1.5)
end

---------------------------------------------------------------- COMMANDS
local Commands = {}

Commands.Ragdoll = function(target, creator)
	local cfg = Config.ById.Ragdoll
	return startEffect(active, target, "Ragdoll", cfg.Duration, function(character, humanoid, root)
		ragdollFx(root)
		return applyRagdoll(character, humanoid, root)
	end), "You got RAGDOLLED!"
end

Commands.Freeze = function(target, creator)
	local cfg = Config.ById.Freeze
	return startEffect(active, target, "Freeze", cfg.Duration, function(character, humanoid, root)
		local wasAnchored = root.Anchored
		root.AssemblyLinearVelocity = Vector3.zero
		root.Anchored = true -- (server anchor : the player cannot walk out ; it is put back exactly as it was)
		character:SetAttribute("CreatorFrozen", true) -- client : animations pause
		local cf, size = character:GetBoundingBox()
		local ice = fxPart({Name = "CreatorIce", Size = size + Vector3.new(1.4, 1, 1.4), CFrame = cf, Material = Enum.Material.Ice, Color = rgb(160, 225, 255),
			Transparency = 0.45, Reflectance = 0.2})
		new("SelectionBox", {Adornee = ice, Color3 = rgb(210, 245, 255), LineThickness = 0.06, Transparency = 0.2, SurfaceTransparency = 1}, ice)
		local at = new("Attachment", {}, ice)
		burst(at, FX.Star, ColorSequence.new(rgb(255, 255, 255), rgb(150, 220, 255)), 30, {8, 16}, 1.2, {0.6, 1})
		burst(at, FX.Fog, ColorSequence.new(rgb(220, 245, 255)), 10, {2, 6}, 4, {0.8, 1.2}, {LE = 0.4, Alpha = 0.4})
		local tag = new("BillboardGui", {Name = "CreatorCountdown", Size = UDim2.fromOffset(160, 50), StudsOffsetWorldSpace = Vector3.new(0, size.Y / 2 + 2, 0),
			AlwaysOnTop = true, MaxDistance = 140}, ice)
		tag:SetAttribute("Ends", now() + cfg.Duration)
		tag:SetAttribute("Label", "FROZEN")
		CollectionService:AddTag(tag, "CreatorCountdown")
		return function()
			if character.Parent then character:SetAttribute("CreatorFrozen", nil) end
			if root.Parent then root.Anchored = wasAnchored end
			local shatter = new("Attachment", {}, fxPart({Size = Vector3.one, CFrame = ice.CFrame, Transparency = 1}))
			burst(shatter, FX.Star, ColorSequence.new(rgb(220, 245, 255)), 24, {12, 22}, 1, {0.4, 0.7})
			Debris:AddItem(shatter.Parent, 1.2)
			ice:Destroy()
		end
	end), "You got FROZEN!"
end

Commands.Rocket = function(target, creator)
	local cfg = Config.ById.Rocket
	local rcfg = Config.Rocket
	return startEffect(active, target, "Rocket", nil, function(character, humanoid, root, state, stop)
		-- how high : stop under any ceiling (raycast) so the player never gets stuck
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {character, fxFolder}
		local up = workspace:Raycast(root.Position, Vector3.new(0, rcfg.MaxHeight + 8, 0), params)
		local height = math.clamp(up and (up.Distance - 8) or rcfg.MaxHeight, 0, rcfg.MaxHeight)
		local wasAnchored = root.Anchored
		local start = root.CFrame
		root.AssemblyLinearVelocity = Vector3.zero
		root.Anchored = true
		-- rocket : fire, smoke, glowing trail, light
		local bottom = new("Attachment", {Name = "CreatorRocket", Position = Vector3.new(0, -2.6, 0)}, root)
		local top = new("Attachment", {Name = "CreatorRocketTop", Position = Vector3.new(0, 1, 0)}, root)
		local flame = new("ParticleEmitter", {Texture = FX.Flare, Rate = 90, LightEmission = 1, LightInfluence = 0, Speed = NumberRange.new(14, 22),
			EmissionDirection = Enum.NormalId.Bottom, SpreadAngle = Vector2.new(14, 14), Lifetime = NumberRange.new(0.25, 0.45),
			Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 255, 200)), ColorSequenceKeypoint.new(0.4, rgb(255, 160, 40)), ColorSequenceKeypoint.new(1, rgb(255, 60, 30))}),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.8), NumberSequenceKeypoint.new(1, 0.2)})}, bottom)
		local smoke = new("ParticleEmitter", {Texture = FX.Fog, Rate = 40, LightEmission = 0.1, LightInfluence = 0.6, Speed = NumberRange.new(3, 6),
			EmissionDirection = Enum.NormalId.Bottom, SpreadAngle = Vector2.new(30, 30), Lifetime = NumberRange.new(1, 1.6), Color = ColorSequence.new(rgb(200, 200, 210), rgb(120, 120, 130)),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.5), NumberSequenceKeypoint.new(1, 5)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})}, bottom)
		local trail = new("Trail", {Attachment0 = top, Attachment1 = bottom, Lifetime = 0.7, LightEmission = 1, FaceCamera = true,
			Color = ColorSequence.new(rgb(255, 230, 150), rgb(255, 90, 60)), Transparency = NumberSequence.new(0.1, 1), WidthScale = NumberSequence.new(1, 0.2)}, root)
		local light = new("PointLight", {Name = "CreatorRocketLight", Color = rgb(255, 170, 80), Range = 18, Brightness = 3, Shadows = false}, bottom)
		local launch = new("Attachment", {}, fxPart({Size = Vector3.one, CFrame = start * CFrame.new(0, -2.5, 0), Transparency = 1}))
		burst(launch, FX.Fog, ColorSequence.new(rgb(230, 230, 235)), 18, {6, 14}, 5, {0.8, 1.4}, {LE = 0.1, Alpha = 0.3})
		Debris:AddItem(launch.Parent, 2)
		local function removeRocket()
			for _, o in {flame, smoke, trail, light, bottom, top} do if o.Parent then o:Destroy() end end
		end
		local ragdollCleanup
		local alive = true
		local heartbeat
		local t0 = os.clock()
		heartbeat = RunService.Heartbeat:Connect(function()
			if not alive then return end
			local u = math.clamp((os.clock() - t0) / rcfg.LaunchTime, 0, 1)
			local e = 1 - (1 - u) * (1 - u)
			if root.Parent then
				root.CFrame = start * CFrame.new(math.sin(u * 30) * 0.4 * (1 - u), height * e, 0) * CFrame.Angles(0, u * math.pi * 6, math.sin(u * 22) * 0.2)
			end
			if u >= 1 then
				heartbeat:Disconnect()
				-- explosion (visual only : no damage)
				local at = root.Position
				removeRocket()
				local boomPart = fxPart({Size = Vector3.one, CFrame = CFrame.new(at), Transparency = 1})
				local a = new("Attachment", {}, boomPart)
				burst(a, FX.Flare, ColorSequence.new(rgb(255, 240, 180), rgb(255, 110, 40)), 90, {30, 50}, 2.4, {0.6, 1.1})
				burst(a, FX.Star, ColorSequence.new(rgb(255, 255, 255), rgb(255, 200, 80)), 36, {20, 34}, 2.8, {0.8, 1.3})
				burst(a, FX.Fog, ColorSequence.new(rgb(90, 80, 80), rgb(40, 36, 36)), 26, {8, 18}, 7, {1.2, 2}, {LE = 0, Alpha = 0.2})
				burst(a, FX.Glow, ColorSequence.new(rgb(255, 180, 90)), 1, {0, 0}, 26, {0.3, 0.4})
				local flash = fxPart({Shape = Enum.PartType.Ball, Size = Vector3.one * 3, CFrame = CFrame.new(at), Material = Enum.Material.Neon, Color = rgb(255, 210, 120), Transparency = 0.2})
				TweenService:Create(flash, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {Size = Vector3.one * 22, Transparency = 1}):Play()
				local ring = fxPart({Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.4, 4, 4), CFrame = CFrame.new(at) * CFrame.Angles(0, 0, math.rad(90)),
					Material = Enum.Material.Neon, Color = rgb(255, 150, 60), Transparency = 0.2})
				TweenService:Create(ring, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Size = Vector3.new(0.2, 40, 40), Transparency = 1}):Play()
				local pl = new("PointLight", {Color = rgb(255, 170, 80), Range = 50, Brightness = 4, Shadows = false}, boomPart)
				TweenService:Create(pl, TweenInfo.new(0.8), {Brightness = 0}):Play()
				new("Sound", {SoundId = "rbxassetid://83996729056576", Volume = 1.2, RollOffMinDistance = 40, RollOffMaxDistance = 400, PlayOnRemove = false}, boomPart):Play()
				Debris:AddItem(boomPart, 3) Debris:AddItem(flash, 1) Debris:AddItem(ring, 1)
				-- free fall in ragdoll for 5 s
				if root.Parent then root.Anchored = wasAnchored end
				local character2, humanoid2 = aliveParts(target)
				if character2 == character then
					ragdollCleanup = applyRagdoll(character, humanoid2, root)
					notify(target, "BOOM! You're ragdolled for 5 seconds!", "troll")
				end
				task.delay(cfg.Duration, stop)
			end
		end)
		return function()
			alive = false
			if heartbeat then heartbeat:Disconnect() end
			removeRocket()
			if root.Parent and root.Anchored and not wasAnchored then root.Anchored = false end
			if ragdollCleanup then ragdollCleanup() end
		end
	end), "You've been launched like a ROCKET!"
end

Commands.Disco = function(target, creator)
	local cfg = Config.ById.Disco
	return startEffect(visual, target, "Disco", cfg.Duration, function(character, humanoid, root)
		local head = character:FindFirstChild("Head") or root
		local items = {}
		local highlight = new("Highlight", {Name = "CreatorDisco", Adornee = character, FillColor = rgb(255, 120, 230), FillTransparency = 0.45,
			OutlineColor = rgb(255, 255, 255), OutlineTransparency = 0, DepthMode = Enum.HighlightDepthMode.Occluded}, character)
		CollectionService:AddTag(highlight, "CreatorDisco") -- color cycling on every client (CreatorEffectsClient)
		table.insert(items, highlight)
		-- the disco ball that floats above the head
		local ball = new("Part", {Name = "CreatorDiscoBall", Shape = Enum.PartType.Ball, Size = Vector3.one * 1.6, Material = Enum.Material.Foil, Color = rgb(230, 230, 245),
			Reflectance = 0.5, CanCollide = false, CanQuery = false, CanTouch = false, Massless = true, CastShadow = false}, nil)
		ball.CFrame = head.CFrame * CFrame.new(0, 3.2, 0)
		local weld = new("Weld", {Name = "CreatorDiscoWeld", Part0 = head, Part1 = ball, C0 = CFrame.new(0, 3.2, 0)}, ball)
		ball.Parent = character
		CollectionService:AddTag(weld, "CreatorDiscoBall")
		new("PointLight", {Name = "DiscoLight", Range = 16, Brightness = 3, Color = rgb(255, 120, 230), Shadows = false}, ball)
		table.insert(items, ball)
		local at = new("Attachment", {Name = "CreatorDiscoFx"}, root)
		new("ParticleEmitter", {Texture = FX.Star, Rate = 26, LightEmission = 1, LightInfluence = 0, Speed = NumberRange.new(4, 9), SpreadAngle = Vector2.new(180, 180),
			Lifetime = NumberRange.new(0.8, 1.3), RotSpeed = NumberRange.new(-200, 200), Acceleration = Vector3.new(0, -4, 0),
			Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 90, 90)), ColorSequenceKeypoint.new(0.25, rgb(255, 220, 70)), ColorSequenceKeypoint.new(0.5, rgb(90, 240, 130)),
				ColorSequenceKeypoint.new(0.75, rgb(80, 180, 255)), ColorSequenceKeypoint.new(1, rgb(220, 110, 255))}),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0)})}, at)
		table.insert(items, at)
		local sign = new("BillboardGui", {Name = "CreatorDiscoSign", Size = UDim2.fromOffset(220, 46), StudsOffset = Vector3.new(0, 5.4, 0), AlwaysOnTop = false, MaxDistance = 120}, head)
		local label = new("TextLabel", {Name = "Label", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "🪩 DISCO FEVER 🪩",
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold), TextScaled = true, TextColor3 = rgb(255, 255, 255)}, sign)
		new("UIStroke", {Thickness = 2.5, Color = rgb(0, 0, 0)}, label)
		new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 120, 230)), ColorSequenceKeypoint.new(0.5, rgb(255, 240, 120)), ColorSequenceKeypoint.new(1, rgb(120, 220, 255))})}, label)
		CollectionService:AddTag(sign, "CreatorDiscoSign")
		table.insert(items, sign)
		return function() for _, o in items do if o.Parent then o:Destroy() end end end
	end), "DISCO FEVER! You're the star of the party!"
end

Commands.Jumpscare = function(target, creator)
	local character = aliveParts(target)
	if not character then return false end
	local last = target:GetAttribute("CreatorJumpscareAt")
	if last and os.clock() - last < 4 then return false, nil, "This player was just jumpscared." end
	target:SetAttribute("CreatorJumpscareAt", os.clock())
	event:FireClient(target, "Jumpscare")
	return true, nil
end

-- the cage : bars, frame, neon corners, padlock ; sized from the avatar's real dimensions
local function buildCage(width, depth, height)
	local m = new("Model", {Name = "CreatorJail"}, nil)
	local METAL, DARK, GLOW = rgb(70, 74, 92), rgb(32, 34, 46), rgb(120, 255, 220)
	local function part(name, size, cf, color, o)
		o = o or {}
		local p = new("Part", {Name = name, Size = size, CFrame = cf, Color = color, Anchored = true, CanCollide = o.Collide == true, CanQuery = false, CanTouch = false,
			Material = o.Material or Enum.Material.Metal, Transparency = o.Transparency or 0, CastShadow = o.Shadow ~= false,
			TopSurface = Enum.SurfaceType.Smooth, BottomSurface = Enum.SurfaceType.Smooth, Shape = o.Shape or Enum.PartType.Block}, m)
		if o.Neon then p.Material = Enum.Material.Neon p.CastShadow = false end
		return p
	end
	local w, d, h = width, depth, height
	-- base and roof plates
	part("Floor", Vector3.new(w + 1.2, 0.5, d + 1.2), CFrame.new(0, 0.25, 0), DARK)
	part("FloorGlow", Vector3.new(w + 1.3, 0.12, d + 1.3), CFrame.new(0, 0.52, 0), GLOW, {Neon = true, Transparency = 0.3})
	part("Roof", Vector3.new(w + 1.2, 0.5, d + 1.2), CFrame.new(0, h + 0.25, 0), DARK)
	part("RoofGlow", Vector3.new(w + 1.3, 0.12, d + 1.3), CFrame.new(0, h - 0.02, 0), GLOW, {Neon = true, Transparency = 0.3})
	-- corner posts with neon strips
	for _, sx in {-1, 1} do
		for _, sz in {-1, 1} do
			part("Post", Vector3.new(0.7, h, 0.7), CFrame.new(sx * w / 2, h / 2, sz * d / 2), METAL)
			part("PostGlow", Vector3.new(0.18, h - 0.6, 0.18), CFrame.new(sx * (w / 2 + 0.3), h / 2, sz * (d / 2 + 0.3)), GLOW, {Neon = true})
		end
	end
	-- vertical bars on every side, ~1 stud apart (cylinders), plus a middle cross bar
	local function side(length, cf)
		local count = math.max(2, math.floor(length / 1.0))
		for i = 1, count - 1 do
			local x = -length / 2 + length * i / count
			part("Bar", Vector3.new(h - 0.4, 0.28, 0.28), cf * CFrame.new(x, h / 2, 0) * CFrame.Angles(0, 0, math.rad(90)), METAL, {Shape = Enum.PartType.Cylinder, Material = Enum.Material.DiamondPlate})
		end
		part("Cross", Vector3.new(length, 0.35, 0.35), cf * CFrame.new(0, h * 0.55, 0), METAL)
		-- invisible solid wall : the bars are for looks, this keeps the player inside
		part("Wall", Vector3.new(length, h, 0.4), cf * CFrame.new(0, h / 2, 0), METAL, {Collide = true, Transparency = 1, Shadow = false})
	end
	side(w, CFrame.new(0, 0, d / 2))
	side(w, CFrame.new(0, 0, -d / 2))
	side(d, CFrame.new(w / 2, 0, 0) * CFrame.Angles(0, math.rad(90), 0))
	side(d, CFrame.new(-w / 2, 0, 0) * CFrame.Angles(0, math.rad(90), 0))
	part("Ceiling", Vector3.new(w, 0.4, d), CFrame.new(0, h, 0), METAL, {Collide = true, Transparency = 1, Shadow = false})
	-- padlock on the front
	part("Lock", Vector3.new(1.2, 1, 0.45), CFrame.new(0, h * 0.42, -d / 2 - 0.35), rgb(255, 200, 60), {Material = Enum.Material.Metal})
	part("Shackle", Vector3.new(0.8, 0.8, 0.2), CFrame.new(0, h * 0.42 + 0.75, -d / 2 - 0.35), rgb(200, 200, 215), {Material = Enum.Material.Metal})
	part("Keyhole", Vector3.new(0.22, 0.4, 0.05), CFrame.new(0, h * 0.42 - 0.05, -d / 2 - 0.6), GLOW, {Neon = true})
	m.PrimaryPart = m.Floor
	return m
end

Commands.Jail = function(target, creator)
	local cfg = Config.ById.Jail
	return startEffect(active, target, "Jail", cfg.Duration, function(character, humanoid, root)
		-- real avatar size (scaled avatars included), flat on the ground under the player, turned like the player
		local _, size = character:GetBoundingBox()
		local width = math.clamp(math.max(size.X, size.Z) + 2.4, 4, 16)
		local height = math.clamp(size.Y + 2.2, 6, 24)
		local ground = groundBelow(root.Position, {character, fxFolder}) or (root.Position - Vector3.new(0, humanoid.HipHeight + root.Size.Y / 2, 0))
		local look = root.CFrame.LookVector
		local yaw = math.atan2(-look.X, -look.Z)
		local base = CFrame.new(ground) * CFrame.Angles(0, yaw, 0)
		local cage = buildCage(width, width, height)
		cage:PivotTo(base * CFrame.new(0, -0.5, 0))
		-- the player stands in the middle (nothing anchored : they can still move and jump inside)
		character:PivotTo(base * CFrame.new(0, humanoid.HipHeight + root.Size.Y / 2 + 0.6, 0))
		root.AssemblyLinearVelocity = Vector3.zero
		cage.Parent = fxFolder
		CollectionService:AddTag(cage, "CreatorJail")
		-- drop-in animation of the cage
		local final = cage:GetPivot()
		local t0 = os.clock()
		local drop
		drop = RunService.Heartbeat:Connect(function()
			local u = math.clamp((os.clock() - t0) / 0.25, 0, 1)
			if not cage.Parent then drop:Disconnect() return end
			cage:PivotTo(final * CFrame.new(0, (1 - u) * 6, 0))
			if u >= 1 then drop:Disconnect() end
		end)
		local at = new("Attachment", {}, cage.Floor)
		burst(at, FX.Star, ColorSequence.new(rgb(255, 255, 255), rgb(120, 255, 220)), 26, {8, 16}, 1.1, {0.5, 0.9})
		local tag = new("BillboardGui", {Name = "CreatorCountdown", Size = UDim2.fromOffset(160, 50), StudsOffsetWorldSpace = Vector3.new(0, height + 1.6, 0),
			AlwaysOnTop = true, MaxDistance = 140}, cage.Floor)
		tag:SetAttribute("Ends", now() + cfg.Duration)
		tag:SetAttribute("Label", "JAILED")
		CollectionService:AddTag(tag, "CreatorCountdown")
		return function()
			if drop then drop:Disconnect() end
			if not cage.Parent then return end
			local releaseAt = new("Attachment", {}, fxPart({Size = Vector3.one, CFrame = cage.Floor.CFrame * CFrame.new(0, height / 2, 0), Transparency = 1}))
			burst(releaseAt, FX.Star, ColorSequence.new(rgb(255, 255, 255), rgb(120, 255, 220)), 40, {14, 26}, 1.3, {0.5, 0.9})
			burst(releaseAt, FX.Glow, ColorSequence.new(rgb(120, 255, 220)), 1, {0, 0}, 16, {0.3, 0.4})
			Debris:AddItem(releaseAt.Parent, 1.5)
			cage:Destroy()
		end
	end), "You're in JAIL for 5 seconds!"
end

---------------------------------------------------------------- cooldowns (per creator, per command)
local cooldowns = {} -- [userId] = {[commandId] = end time}
local function cooldownLeft(player, id)
	local list = cooldowns[player.UserId]
	local e = list and list[id]
	return e and math.max(0, e - now()) or 0
end
local function startCooldown(player, id, seconds)
	cooldowns[player.UserId] = cooldowns[player.UserId] or {}
	cooldowns[player.UserId][id] = now() + seconds
	return cooldowns[player.UserId][id]
end

---------------------------------------------------------------- teleports
local lastPosition = {} -- [userId] = CFrame before the last teleport
local lastTeleport = {}
local function canTeleport(creator)
	local character, humanoid, root = aliveParts(creator)
	if not character then return nil, "Your character isn't available." end
	if (creator:GetAttribute("Carrying") or 0) > 0 then return nil, "Drop what you're carrying first." end
	if creator:GetAttribute("InBossArena") then return nil, "You can't teleport during the boss fight." end
	if os.clock() - (lastTeleport[creator] or 0) < Config.TeleportCooldown then return nil, "Slow down!" end
	return character, root
end
local function moveTo(creator, character, root, cf)
	lastPosition[creator.UserId] = root.CFrame
	lastTeleport[creator] = os.clock()
	root.AssemblyLinearVelocity = Vector3.zero
	character:PivotTo(cf)
end
-- a free spot next to the target (not in a wall, not under the map, not inside them)
local function spotNear(targetRoot, ignore)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = ignore
	for _, offset in {Vector3.new(0, 0, 5), Vector3.new(0, 0, -5), Vector3.new(5, 0, 0), Vector3.new(-5, 0, 0)} do
		local want = targetRoot.CFrame:PointToWorldSpace(offset)
		local blocked = workspace:Raycast(targetRoot.Position, want - targetRoot.Position, params)
		if not blocked then
			local ground = workspace:Raycast(want + Vector3.new(0, 4, 0), Vector3.new(0, -30, 0), params)
			if ground then return ground.Position + Vector3.new(0, 3.2, 0) end
		end
	end
	return targetRoot.Position + Vector3.new(0, 7, 0) -- on top of them
end

local function zoneList()
	local list = {}
	local safe = workspace:FindFirstChild("safe zone")
	if safe and safe:IsA("BasePart") then table.insert(list, {Name = "Safe Zone", Rarity = "Spawn", X = safe.Position.X - 1e6, Part = safe}) end
	for _, zone in CollectionService:GetTagged("EggZoneArea") do
		if zone:IsA("BasePart") and zone:IsDescendantOf(workspace) and zone:GetAttribute("ZoneTitle") then
			table.insert(list, {Name = zone:GetAttribute("ZoneTitle"), Rarity = zone:GetAttribute("ZoneRarity") or "", X = zone.Position.X, Part = zone,
				Color1 = zone:GetAttribute("ZoneColor1"), Color2 = zone:GetAttribute("ZoneColor2")})
		end
	end
	table.sort(list, function(a, b) return a.X < b.X end)
	return list
end

---------------------------------------------------------------- requests
local lastRequest = {}
Players.PlayerRemoving:Connect(function(p) lastRequest[p], lastTeleport[p] = nil, nil end)
request.OnServerInvoke = function(player, action, a, b)
	if not isCreator(player) then return {Ok = false, Message = "You are not a content creator."} end
	if type(action) ~= "string" then return {Ok = false, Message = "Invalid request."} end
	local t = os.clock()
	if t - (lastRequest[player] or 0) < 0.2 then return {Ok = false, Message = "Slow down!"} end
	lastRequest[player] = t

	if action == "GetState" then
		local cd = {}
		for _, c in Config.Commands do cd[c.Id] = cooldowns[player.UserId] and cooldowns[player.UserId][c.Id] or 0 end
		local zones = {}
		for _, z in zoneList() do table.insert(zones, {Name = z.Name, Rarity = z.Rarity, Color1 = z.Color1, Color2 = z.Color2}) end
		return {Ok = true, Cooldowns = cd, Zones = zones, HasReturn = lastPosition[player.UserId] ~= nil}

	elseif action == "Troll" then
		local cfg = type(a) == "string" and Config.ById[a]
		if not cfg then return {Ok = false, Message = "Unknown command."} end
		local left = cooldownLeft(player, cfg.Id)
		if left > 0 then return {Ok = false, Message = cfg.Name .. " is recharging (" .. math.ceil(left) .. "s).", CooldownEnd = now() + left} end
		local target = type(b) == "number" and Players:GetPlayerByUserId(b)
		if not target then return {Ok = false, Message = "That player isn't in the server anymore."} end
		if not aliveParts(target) then return {Ok = false, Message = target.DisplayName .. " has no character right now."} end
		if target:GetAttribute("InBossArena") then return {Ok = false, Message = target.DisplayName .. " is in the boss fight."} end
		if cfg.Id ~= "Disco" and cfg.Id ~= "Jumpscare" and active[target] then
			local busyWord = ({Ragdoll = "ragdolled", Rocket = "flying", Freeze = "frozen", Jail = "in jail"})[active[target].Kind] or "busy"
			return {Ok = false, Message = target.DisplayName .. " is already " .. busyWord .. ". Wait a moment!"}
		end
		if cfg.Id == "Disco" and visual[target] then return {Ok = false, Message = target.DisplayName .. " is already dancing!"} end
		local ok, notice, err = Commands[cfg.Id](target, player)
		if not ok then return {Ok = false, Message = err or ("Couldn't use " .. cfg.Name .. " on " .. target.DisplayName .. ".")} end
		if notice then notify(target, notice .. " (by " .. player.DisplayName .. ")", "troll") end
		local cooldownEnd = startCooldown(player, cfg.Id, cfg.Cooldown)
		return {Ok = true, Message = cfg.Name .. " used on " .. target.DisplayName .. "!", CooldownEnd = cooldownEnd}

	elseif action == "TeleportPlayer" then
		local target = type(a) == "number" and Players:GetPlayerByUserId(a)
		if not target or target == player then return {Ok = false, Message = "Pick another player."} end
		local _, _, targetRoot = aliveParts(target)
		if not targetRoot then return {Ok = false, Message = target.DisplayName .. " has no character right now."} end
		if target:GetAttribute("InBossArena") then return {Ok = false, Message = target.DisplayName .. " is in the boss arena."} end
		local character, root = canTeleport(player)
		if not character then return {Ok = false, Message = root} end
		local spot = spotNear(targetRoot, {character, target.Character, fxFolder})
		moveTo(player, character, root, CFrame.lookAt(spot, Vector3.new(targetRoot.Position.X, spot.Y, targetRoot.Position.Z)))
		return {Ok = true, Message = "Teleported to " .. target.DisplayName .. "!", HasReturn = true}

	elseif action == "TeleportZone" then
		if type(a) ~= "string" then return {Ok = false, Message = "Invalid zone."} end
		local zone
		for _, z in zoneList() do if z.Name == a then zone = z break end end
		if not zone then return {Ok = false, Message = "That zone isn't available."} end
		local character, root = canTeleport(player)
		if not character then return {Ok = false, Message = root} end
		local part = zone.Part
		local top = part.CFrame * CFrame.new(0, part.Size.Y / 2, 0)
		local ground = groundBelow(top.Position + Vector3.new(0, 30, 0), {character, fxFolder})
		local spot = (ground or top.Position) + Vector3.new(0, 4, 0)
		moveTo(player, character, root, CFrame.new(spot) * (part.CFrame - part.CFrame.Position))
		return {Ok = true, Message = "Welcome to " .. zone.Name .. "!", HasReturn = true}

	elseif action == "Return" then
		local saved = lastPosition[player.UserId]
		if not saved then return {Ok = false, Message = "No previous position yet."} end
		local character, root = canTeleport(player)
		if not character then return {Ok = false, Message = root} end
		lastPosition[player.UserId] = nil
		lastTeleport[player] = os.clock()
		root.AssemblyLinearVelocity = Vector3.zero
		character:PivotTo(saved + Vector3.new(0, 1, 0))
		return {Ok = true, Message = "Back to your previous position!", HasReturn = false}
	end
	return {Ok = false, Message = "Unknown action."}
end
