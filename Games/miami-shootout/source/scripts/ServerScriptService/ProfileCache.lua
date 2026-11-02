local Players = game:GetService("Players")
local market = game:GetService("MarketplaceService")
local cachedProfiles = {}
local ProfileService = require(script.ProfileService)
local defaultData = {
	arrests = {},
	--cameraBobbingF = true,
	ownedCars = {},
	money = 150000,
	bank = 150000,
	safeItemsF = {}
}

local Release = "Data1"
local TestBranch = "TestBranch4"
local PlayerProfileStore = ProfileService.GetProfileStore(Release, defaultData)
local OLDdatastore = game:GetService("DataStoreService"):GetDataStore("Stats2")
local OLDsafeData = game:GetService("DataStoreService"):GetDataStore("InvDataStore2")

local function PlayerDataLoaded(player)
	print("loading data")
	local profile = cachedProfiles[player]

	if not profile.Data.arrests then
		profile.Data.arrests = {}
	end
	
	if profile.Data.cameraBobbingF == nil then
		profile.Data.cameraBobbingF = true
	end
	
	if profile.Data.autoRP == nil then
		profile.Data.autoRP = false
	end
	
	if not profile.Data.ownedCars then
		profile.Data.ownedCars = {}
	end
	
	if not profile.Data.money then
		profile.Data.money = 150000
	end
	
	if not profile.Data.bank then
		profile.Data.bank = 0
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
	player.stored.Bank.Value = profile.Data.bank
	
	task.spawn(function()
		local profile = cachedProfiles[player]
	end)	
	
	spawn(function()
		while true do
			local profile = cachedProfiles[player]

			if profile ~= nil then
				if profile.Data.poisoned == true then
					--player:Kick("BAN WAVE #1")
				end
				profile.Data.money = player.stored.Money.Value
				profile.Data.bank = player.stored.Bank.Value
				--if profile.Data.isBanned == true then
				--	player:Kick("Banned from " .. game.Name);
				--end
			else
				break
			end

			wait(0.1)
		end
	end)

	print(player.Name .. "'s profile data is loaded")
end

local function PlayerAdded(player)
	local profile = PlayerProfileStore:LoadProfileAsync(tostring(player.UserId), "ForceLoad")

	if profile ~= nil then
		profile:ListenToRelease(function()
			cachedProfiles[player] = nil
			player:Kick("Rejoin.")
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
	print("saved")
	
	if profile ~= nil then
		profile.Data.money = player.stored.Money.Value
		profile.Data.bank = player.stored.Bank.Value
		
		local findFolder = player:FindFirstChild("InvData")
		if findFolder then
			local saveTable = {}
			for i, v in pairs(findFolder:GetChildren())do
				saveTable[#saveTable + 1] = v.Name
			end
			print("SAVING "..tostring(saveTable))
			profile.Data.safeItemsF = saveTable
		else
			print("No table")
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