local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TARGET_USER_ID = 10270273034
local TOOL_NAME = "Waverider" -- remplace par celui que tu veux ;D

local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local function GiveFlyingCarpetPermanent(player)
	if player.UserId ~= TARGET_USER_ID then return end

	-- Attendre que le channel de données du joueur soit prêt
	local playerChannel = Synchronizer:Wait(player)
	if not playerChannel then
		warn("FlyingCarpetGive: Player data channel not found for", player.Name)
		return
	end

	local tool = ItemsFolder:FindFirstChild(TOOL_NAME)
	if not tool or not tool:IsA("Tool") then
		warn("FlyingCarpetGive: Tool '" .. TOOL_NAME .. "' not found in Items folder.")
		return
	end

	-- Donner l'item en permanent (même logique que givepernamentitem)
	local alreadyOwned = playerChannel:Get(string.format("Items.%s", TOOL_NAME))
	if not alreadyOwned then
		playerChannel:InsertOnDictionary("Items", TOOL_NAME, true)
		playerChannel:Set(string.format("AutoBuy.%s", TOOL_NAME), true)
		print("FlyingCarpetGive: Flying Carpet ajouté en permanent pour", player.Name)
	else
		print("FlyingCarpetGive: " .. player.Name .. " possède déjà le Flying Carpet en permanent.")
	end

	-- Donner l'item au backpack s'il ne l'a pas déjà
	local backpack = player:WaitForChild("Backpack", 10)
	local character = player.Character

	local hasInBackpack = backpack and backpack:FindFirstChild(TOOL_NAME)
	local hasInCharacter = character and character:FindFirstChild(TOOL_NAME)

	if not hasInBackpack and not hasInCharacter then
		local toolClone = tool:Clone()
		-- Désactiver le RemovalMonitor (Flying Carpet est dans BlockedTools dans givepernamentitem)
		for _, obj in ipairs(toolClone:GetDescendants()) do
			if obj:IsA("Script") or obj:IsA("LocalScript") then
				if obj.Name == "RemovalMonitor" then
					obj.Disabled = true
				else
					obj.Enabled = true
				end
			end
		end
		toolClone.Parent = backpack or player:WaitForChild("Backpack")
		print("FlyingCarpetGive: Flying Carpet donné à", player.Name)
	end
end

-- Connexion aux nouveaux joueurs
Players.PlayerAdded:Connect(GiveFlyingCarpetPermanent)

-- Si le joueur est déjà connecté au moment où le script démarre
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(GiveFlyingCarpetPermanent, player)
end
