local Players = game:GetService("Players")
local market = game:GetService("MarketplaceService")
local cachedProfiles = {}
local ProfileService = require(script.ProfileService)
local defaultData = {
	ownedCars = {},
	jailed = 0,
	money = 500,
	level = 1,
	xp = 0,
	bank = 0,
	gang = 0,
	claimedgroup = false,
	claimedfollow = false,
	gymstrength = 0,
	gymstamina = 0,
	customname = '',
	customemoji = '',
	crosshair = '973818318 1.5',
	spawners = '',
	clothing = 'nil nil',
	tattoos = '',
	accessories = '',
	wipes = 0,
	safeItemsF = {}
}

local Release = "Data2"
local PlayerProfileStore = ProfileService.GetProfileStore(Release, defaultData)

local function PlayerDataLoaded(player)
	local profile = cachedProfiles[player]

	if not profile.Data.ownedCars then
		profile.Data.ownedCars = {}
	end
	
	if not profile.Data.claimedgroup then
		profile.Data.claimedgroup = false
	end
	
	if not profile.Data.claimedfollow then
		profile.Data.claimedfollow = false
	end
	
	if not profile.Data.level then
		profile.Data.level = 1
	end

	if not profile.Data.xp then
		profile.Data.xp = 0
	end
	
	if not profile.Data.gymstrength then
		profile.Data.gymstrength = 0
	end
	
	if not profile.Data.gymstamina then
		profile.Data.gymstamina = 0
	end
	
	if not profile.Data.gang then
		profile.Data.gang = 0
	end
	
	if not profile.Data.customname then
		profile.Data.customname = ''
	end
	
	if not profile.Data.customemoji then
		profile.Data.customemoji = ''
	end
	
	if not profile.Data.crosshair then
		profile.Data.crosshair = '973818318 1.5'
	end
	
	if not profile.Data.spawners then
		profile.Data.spawners = ''
	end
	
	if not profile.Data.clothing then
		profile.Data.clothing = 'nil nil'
	end
	
	if not profile.Data.tattoos then
		profile.Data.tattoos = ''
	end
	
	if not profile.Data.accessories then
		profile.Data.accessories = ''
	end
	
	if not profile.Data.money then
		profile.Data.money = 500
	end
	
	if not profile.Data.bank then
		profile.Data.bank = 0
	end
	
	if not profile.Data.wipes then
		profile.Data.wipes = 0
	end
	
	if not profile.Data.jailed then
		profile.Data.jailed = 0
	end
	
	if not profile.Data.safeItemsF then
		profile.Data.safeItemsF = {}
	end
	
	local folder = Instance.new("Folder", player)
	folder.Name = "InvData"

	for i, v in pairs(profile.Data.safeItemsF) do
		local x = Instance.new("IntValue", folder)
		x.Name = v
	end
	
	player.stored.Money.Value = profile.Data.money
	player.stored.ClaimedGroup.Value = profile.Data.claimedgroup
	player.stored.Bank.Value = profile.Data.bank
	player.stored.XP.Value = profile.Data.xp 
	player.stored.Level.Value = profile.Data.level
	player.stored.Jailed.Value = profile.Data.jailed
	player.stored.Gang.Value = profile.Data.gang 
	player.stored.CustomName.Value = profile.Data.customname
	player.stored.CustomEmoji.Value = profile.Data.customemoji
	player.stored.ClaimedFollow.Value = profile.Data.claimedfollow
	player.stored.GymStrength.Value = profile.Data.gymstrength
	player.stored.GymStamina.Value = profile.Data.gymstamina
	player.stored.Crosshair.Value = profile.Data.crosshair 
	player.stored.Spawners.Value = profile.Data.spawners
	player.stored.Clothing.Value = profile.Data.clothing
	player.stored.Tattoos.Value = profile.Data.tattoos
	player.stored.Accessories.Value = profile.Data.accessories
	player.stored.Wipes.Value = profile.Data.wipes

	task.spawn(function()
		local profile = cachedProfiles[player]
	end)	
	
	task.spawn(function()
		while (true) do
			local profile = cachedProfiles[player]

			if profile ~= nil then
				profile.Data.claimedgroup = player.stored.ClaimedGroup.Value
				profile.Data.money = player.stored.Money.Value
				profile.Data.bank = player.stored.Bank.Value
				profile.Data.level = player.stored.Level.Value
				profile.Data.xp = player.stored.XP.Value
				profile.Data.jailed = player.stored.Jailed.Value
				profile.Data.gang = player.stored.Gang.Value
				profile.Data.customname = player.stored.CustomName.Value
				profile.Data.customemoji = player.stored.CustomEmoji.Value
				profile.Data.claimedfollow = player.stored.ClaimedFollow.Value
				profile.Data.gymstrength = player.stored.GymStrength.Value
				profile.Data.gymstamina = player.stored.GymStamina.Value
				profile.Data.crosshair = player.stored.Crosshair.Value
				profile.Data.spawners = player.stored.Spawners.Value
				profile.Data.clothing = player.stored.Clothing.Value
				profile.Data.tattoos = player.stored.Tattoos.Value
				profile.Data.accessories = player.stored.Accessories.Value
				profile.Data.wipes = player.stored.Wipes.Value
			else
				break
			end
			task.wait(3)
		end
	end)
end

local function PlayerAdded(player)
	local profile = PlayerProfileStore:LoadProfileAsync(tostring(player.UserId), "ForceLoad")

	if profile ~= nil then
		profile:ListenToRelease(function()
			cachedProfiles[player] = nil
			player:Kick("Rejoin, contact flipsy if this happend")
		end)

		if player:IsDescendantOf(Players) then
			cachedProfiles[player] = profile
			PlayerDataLoaded(player)
		else
			profile:Release()
		end
	else
		player:Kick("Data failed to load, please rejoin.")
	end
end

local function PlayerRemoving(player)
	local profile = cachedProfiles[player]
	
	local Crypto, ETH, DOGE = player:FindFirstChild('Crypto'), player:FindFirstChild('ETH'), player:FindFirstChild('DOGE')
	local CryptoPrice, ETHPrice, DOGEPrice = game:FindService('ReplicatedStorage'):FindFirstChild('Crypto'), game:FindService('ReplicatedStorage'):FindFirstChild('ETH'), game:FindService('ReplicatedStorage'):FindFirstChild('DOGE')
	
	if Crypto and ETH and DOGE then
		if Crypto.Value >= 1 then
			for _ = 1, Crypto.Value do
				player.stored.Money.Value += CryptoPrice.Value
				Crypto.Value -= 1
			end
		end
		if ETH.Value >= 1 then
			for _ = 1, ETH.Value do
				player.stored.Money.Value += ETHPrice.Value
				ETH.Value -= 1
			end
		end
		if DOGE.Value >= 1 then
			for _ = 1, DOGE.Value do
				player.stored.Money.Value += DOGEPrice.Value
				DOGE.Value -= 1
			end
		end
	end
	
	if profile ~= nil then
		profile.Data.claimedgroup = player.stored.ClaimedGroup.Value
		profile.Data.money = player.stored.Money.Value
		profile.Data.bank = player.stored.Bank.Value
		profile.Data.level = player.stored.Level.Value
		profile.Data.xp = player.stored.XP.Value
		profile.Data.jailed = player.stored.Jailed.Value
		profile.Data.gang = player.stored.Gang.Value
		profile.Data.customname = player.stored.CustomName.Value
		profile.Data.customemoji = player.stored.CustomEmoji.Value
		profile.Data.claimedfollow = player.stored.ClaimedFollow.Value
		profile.Data.gymstrength = player.stored.GymStrength.Value
		profile.Data.gymstamina = player.stored.GymStamina.Value
		profile.Data.crosshair = player.stored.Crosshair.Value
		profile.Data.spawners = player.stored.Spawners.Value
		profile.Data.clothing = player.stored.Clothing.Value
		profile.Data.tattoos = player.stored.Tattoos.Value
		profile.Data.accessories = player.stored.Accessories.Value
		profile.Data.wipes = player.stored.Wipes.Value
		
		local findFolder = player:FindFirstChild("InvData")
		if findFolder then
			local saveTable = {}
			for i, v in pairs(findFolder:GetChildren())do
				saveTable[#saveTable + 1] = v.Name
			end
			profile.Data.safeItemsF = saveTable
		end
		
		profile:Release()
	end
end

for _,player in pairs(Players:GetPlayers()) do
	spawn(function()
		PlayerAdded(player)
	end)
end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

return cachedProfiles