-- Marteau : un outil dans la case 1 de la barre. Le joueur le sort et le range quand il veut (remote Toggle) ;
-- sorti, il casse les œufs (attribut HammerOut, lu par EggZoneServer). On achète le marteau suivant au stand HAMMERS.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local system = ReplicatedStorage:WaitForChild("HammerSystem")
local HammerConfig = require(system:WaitForChild("HammerConfig"))
local models = system:WaitForChild("Models")
local toggleRemote = system:WaitForChild("Toggle")
local buyRemote = system:WaitForChild("Buy")
local equipRemote = system:WaitForChild("Equip")
local openShop = system:WaitForChild("OpenShop")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

-- prise en main : le bras tient le bas du manche, le marteau penche vers l'arrière, la tête au-dessus de l'épaule
-- (attributs HammerGrip / BatGrip du Workspace : pour essayer une autre prise sans toucher au script)
-- Prise mesurée en jeu : le manche est droit (penché de 16° vers l'arrière, pas de côté) et la tête frappe vers l'avant.
local STRAIGHT = CFrame.fromOrientation(math.rad(-1.28), math.rad(-88.86), math.rad(-0.92))
local GRIP = workspace:GetAttribute("HammerGrip") or CFrame.new(-0.009, -0.363, -0.031) * STRAIGHT
local BAT_GRIP = workspace:GetAttribute("BatGrip") or CFrame.new(-0.009, -0.3, -0.031) * STRAIGHT
local BAT_COOLDOWN = 0.75 -- secondes entre deux coups de batte
local BAT_REACH = 15       -- portée du coup (studs)

local function tierOf(player) return math.clamp(player:GetAttribute("EquippedHammer") or player:GetAttribute("Hammer") or 1, 1, #HammerConfig.Tiers) end
-- marteaux possédés : attribut "OwnedHammers" = "1,4,9" (chargé et sauvegardé par PetServer). Chaque marteau s'achète à part :
-- acheter le dernier ne donne PAS ceux d'avant. "Hammer" = le meilleur possédé (gardé pour les autres scripts).
local function ownedSet(player)
	local set = {[1] = true}
	for n in string.gmatch(player:GetAttribute("OwnedHammers") or "", "%d+") do set[tonumber(n)] = true end
	return set
end
local function setOwned(player, set)
	local list, best = {}, 1
	for tier in set do table.insert(list, tier) best = math.max(best, tier) end
	table.sort(list)
	player:SetAttribute("OwnedHammers", table.concat(list, ","))
	player:SetAttribute("Hammer", best)
end

local function buildTool(tier)
	local info = HammerConfig.Get(tier)
	local template = models:FindFirstChild("Tier" .. tier)
	local tool = Instance.new("Tool")
	tool.Name = "Hammer"
	tool.CanBeDropped = false
	tool.RequiresHandle = true
	tool.ToolTip = info.Name
	tool.Grip = GRIP
	tool:SetAttribute("Hammer", tier)
	local copy = template:Clone()
	for _, part in copy:GetChildren() do part.Parent = tool end -- la pièce Handle et tout ce qui y est soudé
	copy:Destroy()
	return tool
end

local function buildBat()
	local tool = Instance.new("Tool")
	tool.Name = "Bat"
	tool.CanBeDropped = false
	tool.RequiresHandle = true
	tool.ToolTip = "Bat"
	tool.Grip = BAT_GRIP
	tool:SetAttribute("Bat", true)
	local copy = models:WaitForChild("Bat"):Clone()
	for _, part in copy:GetChildren() do part.Parent = tool end
	copy:Destroy()
	return tool
end

local function findTool(player, name)
	name = name or "Hammer"
	local character = player.Character
	local backpack = player:FindFirstChildOfClass("Backpack")
	return (character and character:FindFirstChild(name)) or (backpack and backpack:FindFirstChild(name))
end

-- donne (ou redonne) le marteau du joueur ; sorti si "equip"
local function give(player, equip)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not humanoid or not backpack then return end
	local old = findTool(player)
	if old then old:Destroy() end
	local tool = buildTool(tierOf(player))
	tool.Parent = backpack
	if not findTool(player, "Bat") then buildBat().Parent = backpack end -- la batte : case 2 de la barre
	if equip then humanoid:EquipTool(tool) end
end

local function refreshState(player)
	local character = player.Character
	local out = character ~= nil and character:FindFirstChild("Hammer") ~= nil
	if (player:GetAttribute("HammerOut") or false) ~= out then player:SetAttribute("HammerOut", out or nil) end
	player:SetAttribute("HammerDamage", HammerConfig.Get(tierOf(player)).Damage)
end

local function onCharacter(player, character)
	character:WaitForChild("Humanoid", 10)
	local waited = 0
	while player:GetAttribute("Hammer") == nil and waited < 10 do waited += task.wait(0.2) end -- chargé par PetServer
	if player.Character ~= character then return end
	if not player:GetAttribute("EquippedHammer") then
		player:SetAttribute("EquippedHammer", player:GetAttribute("Hammer") or 1)
	end
	give(player, true)
	character.ChildAdded:Connect(function() refreshState(player) end)
	character.ChildRemoved:Connect(function() refreshState(player) end)
	refreshState(player)
end

-- animal porté au-dessus de la tête (attribut Carrying, EggZoneServer) : les deux mains le tiennent, on range le marteau
-- (et tout autre outil) ; il ressort tout seul quand on n'en porte plus
local function carrying(player) return (player:GetAttribute("Carrying") or 0) > 0 end
local stowed = {} -- [player] = nom de l'outil rangé pour porter ("Hammer" / "Bat")
local function onCarryChanged(player)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if carrying(player) then
		local tool = character:FindFirstChildOfClass("Tool")
		if tool then
			if tool.Name == "Hammer" or tool.Name == "Bat" then stowed[player] = stowed[player] or tool.Name end
			humanoid:UnequipTools()
		end
	else
		local name = stowed[player]
		stowed[player] = nil
		if name and humanoid.Health > 0 and not character:FindFirstChildOfClass("Tool") then
			local tool = findTool(player, name)
			if tool then humanoid:EquipTool(tool) end
		end
	end
end
Players.PlayerRemoving:Connect(function(player) stowed[player] = nil end)

local function onPlayer(player)
	player:GetAttributeChangedSignal("Carrying"):Connect(function() onCarryChanged(player) end)
	player.CharacterAdded:Connect(function(character)
		stowed[player] = nil
		-- un outil sorti pendant qu'on porte (case de la barre, inventaire...) est rangé aussitôt
		character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") and carrying(player) then task.defer(onCarryChanged, player) end
		end)
	end)
	player.CharacterAdded:Connect(function(character) onCharacter(player, character) end)
	if player.Character then task.spawn(onCharacter, player, player.Character) end
	player:GetAttributeChangedSignal("EquippedHammer"):Connect(function()
		local held = player.Character and player.Character:FindFirstChild("Hammer") ~= nil
		if findTool(player) then give(player, held) end
		refreshState(player)
	end)
	player:GetAttributeChangedSignal("Hammer"):Connect(function()
		local held = player.Character and player.Character:FindFirstChild("Hammer") ~= nil
		if findTool(player) then give(player, held) end -- nouveau marteau : le modèle change
		refreshState(player)
	end)
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end

-- cases 1 et 2 de la barre : sortir / ranger le marteau ou la batte
toggleRemote.OnServerEvent:Connect(function(player, which)
	local name = which == "Bat" and "Bat" or "Hammer"
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end
	if carrying(player) then return end -- les mains tiennent l'animal
	if character:FindFirstChild(name) then
		humanoid:UnequipTools()
	else
		local tool = findTool(player, name)
		if not tool then
			give(player, name == "Hammer")
			tool = findTool(player, name)
		end
		if tool then
			humanoid:UnequipTools() -- un seul objet en main : l'animal tenu est rangé quand on sort le marteau
			humanoid:EquipTool(tool)
		end
	end
end)

-- batte : un coup envoie valser le joueur le plus proche devant soi (jamais dans la safe zone)
local function inSafeZone(position)
	local safe = workspace:FindFirstChild("safe zone")
	if not safe then return false end
	local rel = safe.CFrame:PointToObjectSpace(position)
	return math.abs(rel.X) <= safe.Size.X / 2 and math.abs(rel.Z) <= safe.Size.Z / 2
end
local knockRemote = system:WaitForChild("Knock")
local lastBat = {}
Players.PlayerRemoving:Connect(function(player) lastBat[player] = nil end)
system:WaitForChild("BatHit").OnServerEvent:Connect(function(player)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root or not character:FindFirstChild("Bat") then return end
	local now = os.clock()
	if now - (lastBat[player] or 0) < BAT_COOLDOWN - 0.1 then return end
	lastBat[player] = now
	if inSafeZone(root.Position) then return end
	local best, bestDistance
	for _, other in Players:GetPlayers() do
		local otherRoot = other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart")
		local otherHumanoid = otherRoot and other.Character:FindFirstChildOfClass("Humanoid")
		if otherRoot and otherHumanoid and otherHumanoid.Health > 0 and not inSafeZone(otherRoot.Position) then
			local offset = otherRoot.Position - root.Position
			local distance = offset.Magnitude
			local facing = distance < 5 or root.CFrame.LookVector:Dot(offset.Unit) > -0.25 -- devant soi (cône large : on touche facilement)
			if distance <= BAT_REACH and facing and (not bestDistance or distance < bestDistance) then best, bestDistance = other, distance end
		end
	end
	if not best then return end
	local otherRoot = best.Character.HumanoidRootPart
	local away = Vector3.new(otherRoot.Position.X - root.Position.X, 0, otherRoot.Position.Z - root.Position.Z)
	away = away.Magnitude > 0.1 and away.Unit or root.CFrame.LookVector
	-- touché : il lâche ce qu'il tient. L'animal (ou l'œuf) porté au-dessus de la tête tombe au sol devant lui (on peut le reprendre),
	-- un animal de l'inventaire tenu en main est rangé.
	local victim, victimHumanoid = best, best.Character:FindFirstChildOfClass("Humanoid")
	local held = best.Character:FindFirstChildOfClass("Tool")
	if held and held:GetAttribute("PetId") and victimHumanoid then victimHumanoid:UnequipTools() end
	if (victim:GetAttribute("Carrying") or 0) > 0 then
		-- posé au sol là où il a été tapé (et pas perdu : DropCarried, c'est quand le gardien reprend l'œuf)
		game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("PlaceCarried"):Fire(victim)
		notifyRemote:FireClient(victim, "You got hit! You dropped what you were carrying!")
	end
	-- le personnage d'un joueur est simulé chez lui : c'est son client qui applique l'élan
	knockRemote:FireClient(best, away * 62 + Vector3.new(0, 38, 0))
	knockRemote:FireAllClients(nil, otherRoot.Position) -- étincelles du choc, pour tout le monde
end)

-- achat : n'importe quel marteau qu'on n'a pas encore (pas besoin d'acheter le précédent). On n'obtient QUE celui-là.
buyRemote.OnServerEvent:Connect(function(player, wanted, withRobux)
	local tier = player:GetAttribute("Hammer")
	if not tier then return end
	if wanted == true or withRobux == true then -- bouton Robux de la boutique : pas encore de produit
		notifyRemote:FireClient(player, "Robux hammers are coming soon!")
		return
	end
	wanted = type(wanted) == "number" and math.floor(wanted) or tier + 1 -- ancien client : le suivant
	local owned = ownedSet(player)
	if owned[wanted] then
		notifyRemote:FireClient(player, "You already own this hammer!")
		return
	end
	local nextInfo = HammerConfig.Tiers[wanted]
	if not nextInfo then
		notifyRemote:FireClient(player, "You already have the best hammer!")
		return
	end
	local money = player:GetAttribute("Money") or 0
	if money < nextInfo.Price then
		notifyRemote:FireClient(player, "Not enough money! You need " .. EggConfig.FormatMoney(nextInfo.Price))
		return
	end
	player:SetAttribute("Money", money - nextInfo.Price)
	owned[wanted] = true
	setOwned(player, owned)
	player:SetAttribute("EquippedHammer", wanted)
	notifyRemote:FireClient(player, nextInfo.Name .. " unlocked!")
end)

-- équiper un marteau déjà possédé
equipRemote.OnServerEvent:Connect(function(player, tier)
	if type(tier) ~= "number" then return end
	tier = math.floor(tier)
	if not ownedSet(player)[tier] then return end
	player:SetAttribute("EquippedHammer", tier)
end)

-- (plus d'invite sur le stand : la boutique s'ouvre en marchant dans son cercle ShopZone, voir ShopClient)
