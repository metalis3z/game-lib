-- Défilement d'éclosion : quand le joueur casse un œuf de zone, tous les animaux de l'œuf défilent au milieu de son écran
-- pendant quelques secondes (silhouettes noires, comme dans l'Index), de plus en plus lentement, puis le résultat se révèle.
-- Le serveur (EggZoneServer) choisit l'animal et envoie : HatchReel(clé de l'œuf, animal obtenu, durée).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local Portrait = require(eggSystem:WaitForChild("PetPortrait"))
local petTemplates = eggSystem:WaitForChild("Pets")
local reelRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("HatchReel")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local FAST_TIME = 0.5     -- début du défilement à pleine vitesse ; ensuite il ralentit jusqu'à la fin
local TICK = "rbxassetid://6586979979"        -- petit "pop" à chaque animal
local REVEAL = "rbxassetid://140323850218372" -- "pop" de la révélation
local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function text(parent, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = FONT, TextScaled = true, TextColor3 = WHITE}, parent)
	for k, v in props do l[k] = v end
	new("UIStroke", {Thickness = 4, Color = BLACK}, l)
	return l
end
local function sound(id, speed, volume)
	local snd = new("Sound", {SoundId = id, PlaybackSpeed = speed or 1, Volume = volume or 0.5}, SoundService)
	snd:Play()
	game:GetService("Debris"):AddItem(snd, 2)
end

local gui = new("ScreenGui", {Name = "HatchReelGui", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 40, ZIndexBehavior = Enum.ZIndexBehavior.Sibling},
	player:WaitForChild("PlayerGui"))

local busy = false
reelRemote.OnClientEvent:Connect(function(eggKey, result, duration)
	local info = Config.Eggs[eggKey]
	if not info or busy then return end
	busy = true
	duration = tonumber(duration) or 3
	local colors = Portrait.RarityColors[info.Rarity] or Portrait.RarityColors.Common

	-- fenêtre : rayons qui tournent, nom de l'œuf, scène, nom de l'animal
	local holder = new("Frame", {Name = "Reel", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.53), Size = UDim2.fromOffset(440, 470), BackgroundTransparency = 1}, gui)
	CollectionService:AddTag(holder, "AutoScale")
	local pop = new("UIScale", {Name = "Pop", Scale = 0.6}, new("Frame", {Name = "Body", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1)}, holder))
	local body = pop.Parent
	local rays = Portrait.rays(body, colors[1], 0.35, 1)
	rays.Position, rays.Size = UDim2.fromScale(0.5, 0.48), UDim2.fromScale(1.15, 1.15)
	local title = text(body, {Text = info.Name, Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.9, 0.11), ZIndex = 5,
		TextColor3 = info.Royal and Color3.fromRGB(255, 225, 110) or WHITE})
	local stage = new("Frame", {Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(0.82, 0.7), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 3}, body)
	local nameLabel = text(body, {Text = "???", Position = UDim2.fromScale(0.05, 0.84), Size = UDim2.fromScale(0.9, 0.1), ZIndex = 5})
	local subLabel = text(body, {Text = "", Position = UDim2.fromScale(0.15, 0.93), Size = UDim2.fromScale(0.7, 0.06), ZIndex = 5})
	TweenService:Create(pop, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

	-- une photo par animal de l'œuf, préparée à l'avance (silhouette noire)
	local views, names = {}, {}
	for _, entry in info.Pets do
		local view = new("ViewportFrame", {AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = BLACK, Visible = false, ZIndex = 4,
			Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY}, stage)
		Portrait.fill(view, petTemplates:FindFirstChild(entry.Pet))
		views[entry.Pet] = view
		table.insert(names, entry.Pet)
	end

	-- programme du défilement : très rapide au début, puis chaque animal reste de plus en plus longtemps ; le dernier est le résultat
	local slots, t, last = {}, 0, nil
	local function slotLength(at)
		local k = math.clamp((at - FAST_TIME) / math.max(duration - FAST_TIME, 0.1), 0, 1)
		return 0.08 + k * k * 0.62
	end
	while true do
		local length = slotLength(t)
		if t + length >= duration - 0.05 then break end
		local pick
		repeat pick = names[math.random(#names)] until pick ~= last or #names == 1
		table.insert(slots, {Pet = pick, Start = t, Length = length})
		last, t = pick, t + length
	end
	if slots[#slots] and slots[#slots].Pet == result and #names > 1 then -- le résultat ne passe pas juste avant de tomber
		repeat slots[#slots].Pet = names[math.random(#names)] until slots[#slots].Pet ~= result
	end
	table.insert(slots, {Pet = result, Start = t, Length = duration - t, Final = true})

	-- animation : il sort tout petit du bas, grossit au centre, puis rétrécit en remontant
	local start = os.clock()
	local index = 0
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local now = os.clock() - start
		rays.Rotation = (now * 40) % 360
		while slots[index + 1] and now >= slots[index + 1].Start do
			if slots[index] and views[slots[index].Pet] then views[slots[index].Pet].Visible = false end
			index += 1
			sound(TICK, 0.9 + math.min(index * 0.02, 0.5), 0.35)
		end
		local slot = slots[index]
		if not slot then return end
		local view = views[slot.Pet]
		if not view then return end
		view.Visible = true
		local p = math.clamp((now - slot.Start) / slot.Length, 0, 1)
		local y, scale
		if slot.Final then
			local k = math.min(p / 0.5, 1)
			k = 1 - (1 - k) ^ 3
			y, scale = 0.95 - 0.45 * k, 0.15 + 0.9 * k
		elseif p < 0.45 then
			local k = p / 0.45
			k = 1 - (1 - k) ^ 2
			y, scale = 0.95 - 0.45 * k, 0.15 + 0.95 * k
		else
			local k = (p - 0.45) / 0.55
			y, scale = 0.5 - 0.35 * k * k, 1.1 - 0.7 * k
		end
		view.Position = UDim2.fromScale(0.5, y)
		view.Size = UDim2.fromScale(0.8 * scale, 0.8 * scale)
	end)

	task.wait(duration)
	conn:Disconnect()
	for pet, view in views do view.Visible = pet == result end
	local final = views[result]
	local petInfo = Config.Pets[result]
	-- révélation : la silhouette prend ses couleurs, flash, nom et rareté
	if final then
		final.Position, final.Size = UDim2.fromScale(0.5, 0.5), UDim2.fromScale(0.85, 0.85)
		TweenService:Create(final, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = WHITE}):Play()
	end
	local flash = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(0.5, 0.5), BackgroundColor3 = WHITE, BackgroundTransparency = 0.1, ZIndex = 6}, body)
	new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, flash)
	TweenService:Create(flash, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1.3, 1.3), BackgroundTransparency = 1}):Play()
	sound(REVEAL, 1.15, 0.7)
	local chance
	for _, entry in info.Pets do if entry.Pet == result then chance = entry.Chance end end
	nameLabel.Text = petInfo and petInfo.Name or result
	subLabel.Text = (petInfo and petInfo.Rarity or "") .. (chance and ("  ·  " .. Config.FormatChance(chance)) or "")
	local gradient = new("UIGradient", {Rotation = 90, Color = ColorSequence.new(colors[1]:Lerp(WHITE, 0.3), colors[1])}, nameLabel)
	pop.Scale = 1.08
	TweenService:Create(pop, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.wait(1.6)
	local out = TweenService:Create(pop, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
	out:Play()
	out.Completed:Wait()
	holder:Destroy()
	busy = false
end)
