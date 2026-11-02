-- JackpotMachineHandler
-- Gère le ProximityPrompt de SECRET ALEATOIRE pour lancer des secrets aléatoires

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)

-- Attendre que la machine soit bien chargée
local folder = workspace:WaitForChild("Jackpot Machine")
local secretModel = folder:WaitForChild("SECRET ALEATOIRE")

-- Cibler directement la Slot Machine dans SECRET ALEATOIRE
local targetSlotMachine = secretModel:WaitForChild("Slot Machine")

if not targetSlotMachine then
	warn("[JackpotMachineHandler] Slot Machine introuvable dans SECRET ALEATOIRE !")
	return
end

local lever = targetSlotMachine:FindFirstChild("Lever")
local spinny1 = targetSlotMachine:FindFirstChild("Spinny1")
local spinny2 = targetSlotMachine:FindFirstChild("Spinny2")
local spinny3 = targetSlotMachine:FindFirstChild("Spinny3")
local leds = targetSlotMachine:FindFirstChild("LEDs")

-- Cooldown par joueur (anti-spam)
local cooldowns = {}
local COOLDOWN = 3

-- Couleurs de rarety pour les LEDs
local RARITY_COLORS = {
	Common    = Color3.fromRGB(180, 180, 180),
	Uncommon  = Color3.fromRGB(100, 220, 100),
	Rare      = Color3.fromRGB(80, 120, 255),
	Epic      = Color3.fromRGB(180, 80, 255),
	Legendary = Color3.fromRGB(255, 200, 0),
}

-- Animation des rouleaux
local function animateSpinnies(result)
	if not spinny1 or not spinny2 or not spinny3 then return end
	
	for i = 1, 15 do
		spinny1.BrickColor = BrickColor.random()
		spinny2.BrickColor = BrickColor.random()
		spinny3.BrickColor = BrickColor.random()
		task.wait(0.05)
	end
	
	-- Couleur finale selon la rareté
	if result and result.Secret then
		local col = RARITY_COLORS[result.Secret.Rarity] or Color3.fromRGB(255,255,255)
		spinny1.Color = col
		spinny2.Color = col
		spinny3.Color = col
		
		-- Flash les LEDs
		if leds then
			TweenService:Create(leds, TweenInfo.new(0.2), {Color = col}):Play()
			task.delay(1.5, function()
				TweenService:Create(leds, TweenInfo.new(0.5), {Color = Color3.fromRGB(255, 255, 0)}):Play()
			end)
		end
	end
end

-- Animation du levier
local function animateLever()
	if not lever then return end
	local origCF = lever.CFrame
	-- Tirer le levier vers le bas
	TweenService:Create(lever, TweenInfo.new(0.15), {CFrame = origCF * CFrame.Angles(math.rad(-40), 0, 0)}):Play()
	task.wait(0.2)
	TweenService:Create(lever, TweenInfo.new(0.3), {CFrame = origCF}):Play()
end

-- Connexion au ProximityPrompt
local pp = lever and lever:FindFirstChildOfClass("ProximityPrompt")
if pp then
	pp.Triggered:Connect(function(player)
		-- Vérifier cooldown
		local now = tick()
		if cooldowns[player] and now - cooldowns[player] < COOLDOWN then
			NotificationService.Error(player, "Attends un peu avant de réessayer !")
			return
		end
		cooldowns[player] = now

		-- Animer le levier immédiatement
		task.spawn(animateLever)

		-- Récupérer les données du joueur
		local data = Synchronizer:Get(player)
		if not data then return end

		local SecretMachineData = require(game:GetService("ServerStorage").Modules.SecretMachineData)

		-- Logique de spin inline (déclenchée par la machine physique)
		local smData = data:Get("SecretMachine") or {}
		local todayStamp = os.time() - (os.time() % 86400)
		local isFreeUsed = (smData.LastFreeDay == todayStamp)

		if not isFreeUsed then
			smData.LastFreeDay = todayStamp
		else
			local coins = data:Get("Coins") or 0
			data:Set("Coins", coins - SecretMachineData.CostPerSpin)
		end

		-- Tirer le secret
		local totalWeight = 0
		for _, s in ipairs(SecretMachineData.Secrets) do totalWeight += s.Weight end
		local roll = math.random(1, totalWeight)
		local cumul = 0
		local secret = SecretMachineData.Secrets[1]
		for _, s in ipairs(SecretMachineData.Secrets) do
			cumul += s.Weight
			if roll <= cumul then secret = s break end
		end

		-- Sauvegarder
		local history = smData.History or {}
		table.insert(history, 1, { Name = secret.Name, Rarity = secret.Rarity, Emoji = secret.Emoji })
		if #history > 20 then table.remove(history, #history) end
		smData.History = history
		data:Set("SecretMachine", smData)

		-- Animer la machine
		task.spawn(function()
			animateSpinnies({ Secret = secret })
		end)

		-- Notifier
		NotificationService.Notify(
			player,
			secret.Emoji .. " Secret obtenuCONFIG : " .. secret.Name .. " (" .. secret.Rarity .. ") !",
			6,
			"Sounds.Sfx.Success"
		)
	end)
	print("[JackpotMachineHandler] ProximityPrompt connecté sur la Slot Machine ✅")
else
	warn("[JackpotMachineHandler] ProximityPrompt introuvable sur le Lever")
end
