-- Traînées : achat, équipement, et la traînée elle-même derrière le personnage. Le multiplicateur de speed de la traînée équipée
-- est l'attribut TrailMult du joueur (lu par SpeedServer). Les attributs Trail / Trails sont chargés et sauvegardés par PetServer.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local system = ReplicatedStorage:WaitForChild("TrailSystem")
local TrailConfig = require(system:WaitForChild("TrailConfig"))
local buyRemote, equipRemote, openShop = system:WaitForChild("Buy"), system:WaitForChild("Equip"), system:WaitForChild("OpenShop")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

local function notify(player, text) notifyRemote:FireClient(player, text) end

-- la traînée : un ruban large derrière le buste, deux fins derrière les pieds, des étincelles pour les plus belles
local function clear(character)
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	for _, child in root:GetChildren() do
		if child.Name == "SpeedTrail" then child:Destroy() end
	end
end
local function ribbon(root, info, top, bottom, lifetime, widthStart)
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Name, a1.Name = "SpeedTrail", "SpeedTrail"
	a0.Position, a1.Position = top, bottom
	a0.Parent, a1.Parent = root, root
	local trail = Instance.new("Trail")
	trail.Name = "SpeedTrail"
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Color = info.Sequence or ColorSequence.new(info.Color, info.Color:Lerp(Color3.new(1, 1, 1), 0.35))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(0.6, 0.45), NumberSequenceKeypoint.new(1, 1)})
	trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, widthStart), NumberSequenceKeypoint.new(1, 0)})
	trail.Lifetime = lifetime
	trail.MinLength = 0.05
	trail.FaceCamera = true
	trail.LightEmission = info.Neon and 1 or 0.45
	trail.LightInfluence = 0
	trail.Parent = root
end
local function apply(player)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	clear(character)
	local info = TrailConfig.Trails[player:GetAttribute("Trail") or 0]
	if not info then return end
	ribbon(root, info, Vector3.new(0, 1.1, 0.4), Vector3.new(0, -1.1, 0.4), 0.75, 1)
	ribbon(root, info, Vector3.new(-0.7, -2.4, 0.2), Vector3.new(-0.7, -2.9, 0.2), 0.45, 1)
	ribbon(root, info, Vector3.new(0.7, -2.4, 0.2), Vector3.new(0.7, -2.9, 0.2), 0.45, 1)
	if info.Mist then -- Soul Trail : une brume fantôme cyan et violette traîne derrière le joueur et retombe
		local mist = Instance.new("ParticleEmitter")
		mist.Name = "SpeedTrail"
		mist.Texture = "rbxasset://textures/particles/smoke_main.dds"
		mist.Color = ColorSequence.new(Color3.fromRGB(120, 255, 230), Color3.fromRGB(130, 80, 230))
		mist.LightEmission, mist.LightInfluence = 0.7, 0
		mist.Rate = 10
		mist.Lifetime = NumberRange.new(0.8, 1.3)
		mist.Speed = NumberRange.new(0.3, 1)
		mist.SpreadAngle = Vector2.new(180, 180)
		mist.Acceleration = Vector3.new(0, -1.5, 0)
		mist.Rotation, mist.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-40, 40)
		mist.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 2.4)})
		mist.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1)})
		mist.Parent = root
	end
	if info.Sparkle then
		local sparkle = Instance.new("ParticleEmitter")
		sparkle.Name = "SpeedTrail"
		sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		sparkle.Color = info.Sequence or ColorSequence.new(info.Color)
		sparkle.LightEmission = 1
		sparkle.Rate = 14
		sparkle.Lifetime = NumberRange.new(0.5, 0.9)
		sparkle.Speed = NumberRange.new(0.5, 2)
		sparkle.SpreadAngle = Vector2.new(180, 180)
		sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.5), NumberSequenceKeypoint.new(1, 0)})
		sparkle.Parent = root
	end
end

local function refresh(player)
	player:SetAttribute("TrailMult", TrailConfig.Mult(player:GetAttribute("Trail")))
	apply(player)
end

local function onPlayer(player)
	player:GetAttributeChangedSignal("Trail"):Connect(function() refresh(player) end)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("HumanoidRootPart", 10)
		apply(player)
	end)
	refresh(player)
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end

local function give(player, index)
	local owned = TrailConfig.Owned(player:GetAttribute("Trails"))
	owned[index] = true
	local list = {}
	for i in owned do table.insert(list, i) end
	table.sort(list)
	player:SetAttribute("Trails", table.concat(list, ","))
	player:SetAttribute("Trail", index) -- une traînée achetée est équipée tout de suite
end

-- achat en Robux : le produit de chaque traînée (TrailConfig ... ProductId) donne la traînée
local Purchases = require(game:GetService("ServerScriptService"):WaitForChild("Purchases"))
for index, info in TrailConfig.Trails do
	Purchases.register(info.ProductId, function(player)
		if player:GetAttribute("Trails") == nil then return false end -- pas encore chargé
		give(player, index)
		notify(player, info.Name .. " unlocked! x" .. info.Mult .. " speed on the treadmill")
		return true
	end)
end

buyRemote.OnServerEvent:Connect(function(player, index, withRobux)
	local info = type(index) == "number" and TrailConfig.Trails[index]
	if not info or player:GetAttribute("Trails") == nil then return end
	if TrailConfig.Owned(player:GetAttribute("Trails"))[index] then return end
	if withRobux == true then
		if info.ProductId == 0 then notify(player, "Robux trails are coming soon!") else MarketplaceService:PromptProductPurchase(player, info.ProductId) end
		return
	end
	local money = player:GetAttribute("Money") or 0
	if money < info.Price then
		notify(player, "Not enough money! You need " .. EggConfig.FormatMoney(info.Price))
		return
	end
	player:SetAttribute("Money", money - info.Price)
	give(player, index)
	notify(player, info.Name .. " unlocked! x" .. info.Mult .. " speed on the treadmill")
end)

-- équiper ; la même une deuxième fois : l'enlever
equipRemote.OnServerEvent:Connect(function(player, index)
	if type(index) ~= "number" or not TrailConfig.Owned(player:GetAttribute("Trails"))[index] then return end
	player:SetAttribute("Trail", player:GetAttribute("Trail") == index and 0 or index)
end)

-- stand TRAILS (l'ancien stand de vente) : le panneau affiche TRAILS. Plus d'invite : la boutique s'ouvre en marchant
-- dans son cercle ShopZone (voir ShopClient)
local stand = workspace:FindFirstChild("Sell shopa")
if stand then
	for _, d in stand:GetDescendants() do
		if d:IsA("TextLabel") and string.upper(d.Text) == "SELL" then d.Text = "TRAILS" end
	end
end

