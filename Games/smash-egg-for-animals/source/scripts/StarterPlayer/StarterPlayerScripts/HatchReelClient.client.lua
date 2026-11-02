-- Défilement d'éclosion : quand un œuf de zone se casse, tous les animaux qu'il peut donner SORTENT DE L'ŒUF l'un après l'autre,
-- en silhouette noire (comme dans l'Index avant de les avoir) : chacun sort tout petit du bas, grossit, puis rétrécit et redescend.
-- Ça va très vite au début puis ralentit ; le dernier est l'animal obtenu : il prend ses couleurs et le vrai animal le remplace.
-- Le serveur (EggZoneServer) envoie à tout le monde : HatchReel(clé de l'œuf, animal obtenu, durée, sol de l'œuf, hauteur de l'œuf, taille finale).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local Portrait = require(eggSystem:WaitForChild("PetPortrait"))
local petTemplates = eggSystem:WaitForChild("Pets")
local reelRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("HatchReel")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local FAST_TIME = 0.5     -- début du défilement à pleine vitesse ; ensuite il ralentit jusqu'à la fin
local MAX_DISTANCE = 220  -- plus loin, on ne joue pas l'animation
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
	new("UIStroke", {Thickness = 3, Color = BLACK}, l)
	return l
end
local function sound(anchor, id, speed, volume)
	local snd = new("Sound", {SoundId = id, PlaybackSpeed = speed or 1, Volume = volume or 0.5, RollOffMaxDistance = 120, RollOffMinDistance = 15}, anchor)
	snd:Play()
	game:GetService("Debris"):AddItem(snd, 2)
end

-- copie d'un animal pour le défilement : aucune collision, toute noire grâce à un Highlight qu'on enlève à la révélation
local function silhouette(petName)
	local template = petTemplates:FindFirstChild(petName)
	if not template or not template.PrimaryPart then return nil end
	local model = template:Clone()
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored, d.CanCollide, d.CanTouch, d.CanQuery, d.CastShadow = true, false, false, false, false
		elseif d:IsA("Script") or d:IsA("LocalScript") then
			d:Destroy()
		end
	end
	local highlight = new("Highlight", {FillColor = BLACK, FillTransparency = 0, OutlineColor = WHITE, OutlineTransparency = 0.6,
		DepthMode = Enum.HighlightDepthMode.Occluded}, model)
	local _, bounds = model:GetBoundingBox()
	return {Model = model, Highlight = highlight, BaseScale = model:GetScale(), Height = math.max(bounds.Y, 0.5),
		Ground = model:GetAttribute("GroundOffset") or 1}
end

reelRemote.OnClientEvent:Connect(function(eggKey, result, duration, floor, eggHeight, finalSize)
	local info = Config.Eggs[eggKey]
	if not info or typeof(floor) ~= "Vector3" then return end
	local camera = workspace.CurrentCamera
	local root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local near = (camera and (camera.CFrame.Position - floor).Magnitude <= MAX_DISTANCE) or (root and (root.Position - floor).Magnitude <= MAX_DISTANCE)
	if not near then return end
	duration = tonumber(duration) or 3
	eggHeight = tonumber(eggHeight) or 3
	finalSize = tonumber(finalSize) or 1
	local colors = Portrait.RarityColors[info.Rarity] or Portrait.RarityColors.Common

	local folder = new("Folder", {Name = "HatchReel"}, workspace)
	local anchor = new("Part", {Name = "Anchor", Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false, Transparency = 1,
		Size = Vector3.one * 0.2, Position = floor}, folder)

	-- halo de lumière au pied de l'œuf : un disque de rayons qui tourne + une lumière de la couleur de la rareté
	local glow = new("BillboardGui", {Size = UDim2.fromScale(eggHeight * 3.2, eggHeight * 3.2), StudsOffsetWorldSpace = Vector3.new(0, eggHeight * 0.9, 0),
		LightInfluence = 0, MaxDistance = MAX_DISTANCE, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, anchor)
	local rays = Portrait.rays(glow, colors[1], 0.45, 1)
	rays.Position, rays.Size = UDim2.fromScale(0.5, 0.5), UDim2.fromScale(1, 1)
	new("PointLight", {Color = colors[1], Range = 6 + eggHeight * 1.5, Brightness = 1, Shadows = false}, anchor)

	-- étiquette au-dessus : "???" pendant le défilement, puis le nom, la rareté et la chance
	local tag = new("BillboardGui", {Size = UDim2.fromScale(9, 2.6), StudsOffsetWorldSpace = Vector3.new(0, eggHeight * 2.4 + 1.5, 0),
		LightInfluence = 0, MaxDistance = MAX_DISTANCE, AlwaysOnTop = true}, anchor)
	local pop = new("UIScale", {Scale = 0.4}, tag)
	local nameLabel = text(tag, {Text = "???", Size = UDim2.fromScale(1, 0.62)})
	local subLabel = text(tag, {Text = info.Name, Position = UDim2.fromScale(0.1, 0.62), Size = UDim2.fromScale(0.8, 0.38),
		TextColor3 = info.Royal and Color3.fromRGB(255, 225, 110) or WHITE})
	TweenService:Create(pop, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

	-- une silhouette par animal de l'œuf, préparée à l'avance
	local pets, names = {}, {}
	for _, entry in info.Pets do
		local pet = silhouette(entry.Pet)
		if pet then
			pets[entry.Pet] = pet
			table.insert(names, entry.Pet)
		end
	end
	if not pets[result] then folder:Destroy() return end

	-- programme : très rapide au début, puis chaque animal reste de plus en plus longtemps ; le dernier est le résultat
	local slots, t, last = {}, 0, nil
	local function slotLength(at)
		local k = math.clamp((at - FAST_TIME) / math.max(duration - FAST_TIME, 0.1), 0, 1)
		return 0.08 + k * k * 0.62
	end
	while true do
		local length = slotLength(t)
		if t + length >= duration - 0.6 then break end
		local pick
		repeat pick = names[math.random(#names)] until pick ~= last or #names == 1
		table.insert(slots, {Pet = pick, Start = t, Length = length})
		last, t = pick, t + length
	end
	if slots[#slots] and slots[#slots].Pet == result and #names > 1 then -- le résultat ne passe pas juste avant de tomber
		repeat slots[#slots].Pet = names[math.random(#names)] until slots[#slots].Pet ~= result
	end
	table.insert(slots, {Pet = result, Start = t, Length = duration - t, Final = true})

	-- taille "normale" d'une silhouette pendant le défilement : à peu près 1,5 fois l'œuf ; le résultat prend sa vraie taille
	local function place(pet, scale, lift, spin)
		local targetScale = pet.BaseScale * math.max(scale, 0.02)
		if math.abs(pet.Model:GetScale() - targetScale) > 1e-3 then pet.Model:ScaleTo(targetScale) end
		local k = targetScale / pet.BaseScale
		pet.Model:PivotTo(CFrame.new(floor + Vector3.new(0, pet.Ground * k + lift, 0)) * CFrame.Angles(0, spin, 0))
	end
	local function reelScale(pet) return eggHeight * 1.5 / pet.Height end

	local start = os.clock()
	local index = 0
	local shown
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local now = os.clock() - start
		rays.Rotation = (now * 50) % 360
		while slots[index + 1] and now >= slots[index + 1].Start do
			index += 1
			sound(anchor, TICK, 0.9 + math.min(index * 0.02, 0.5), 0.35)
		end
		local slot = slots[index]
		if not slot then return end
		local pet = pets[slot.Pet]
		if shown and shown ~= pet then shown.Model.Parent = nil end
		shown = pet
		if pet.Model.Parent ~= folder then pet.Model.Parent = folder end
		local p = math.clamp((now - slot.Start) / slot.Length, 0, 1)
		local base = reelScale(pet)
		local spin = now * 2.2
		local scale, lift
		if slot.Final then
			-- il sort de l'œuf et grandit jusqu'à sa vraie taille
			local k = 1 - (1 - math.min(p / 0.55, 1)) ^ 3
			scale = base * 0.12 + (finalSize - base * 0.12) * k
			lift = eggHeight * 0.35 * (1 - k)
			spin = now * 2.2 * (1 - k)
		elseif p < 0.45 then
			-- il sort tout petit du bas de l'œuf et grossit en montant
			local k = 1 - (1 - p / 0.45) ^ 2
			scale = base * (0.12 + 0.98 * k)
			lift = eggHeight * (0.35 + 0.45 * k)
		else
			-- puis il rétrécit et rentre dans l'œuf
			local k = ((p - 0.45) / 0.55) ^ 2
			scale = base * (1.1 - 0.95 * k)
			lift = eggHeight * (0.8 - 0.45 * k)
		end
		place(pet, scale, lift, spin)
	end)

	task.wait(duration - 0.3)
	-- révélation : la silhouette prend ses couleurs, le halo flashe, le nom s'affiche
	local final = pets[result]
	TweenService:Create(final.Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 1, OutlineTransparency = 1}):Play()
	TweenService:Create(glow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(eggHeight * 5, eggHeight * 5)}):Play()
	sound(anchor, REVEAL, 1.15, 0.7)
	local petInfo = Config.Pets[result]
	local chance
	for _, entry in info.Pets do if entry.Pet == result then chance = entry.Chance end end
	nameLabel.Text = petInfo and petInfo.Name or result
	subLabel.Text = (petInfo and petInfo.Rarity or "") .. (chance and ("  ·  " .. Config.FormatChance(chance)) or "")
	subLabel.TextColor3 = WHITE
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(colors[1]:Lerp(WHITE, 0.3), colors[1])}, nameLabel)
	pop.Scale = 1.25
	TweenService:Create(pop, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.wait(0.3)
	-- le serveur pose le vrai animal maintenant : la copie disparaît, l'étiquette reste encore un peu
	conn:Disconnect()
	for _, pet in pets do pet.Model:Destroy() end
	TweenService:Create(rays, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
	task.wait(1.6)
	local out = TweenService:Create(pop, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
	out:Play()
	out.Completed:Wait()
	folder:Destroy()
end)
