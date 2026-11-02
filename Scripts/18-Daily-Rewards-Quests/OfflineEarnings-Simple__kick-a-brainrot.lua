-- Reference copy for study. Game: Kick A ... (template) (kick-a-brainrot)
-- Original: ServerScriptService/Controllers/PlayerController.lua  (587 lines)
-- What it does: Minimal offline earnings: time since last save (capped at 8h) x each placed item's income x mutation/level/rebirth/VIP multipliers, shown in a popup and paid on a Claim remote.
-- Excerpt of lines 181-227, 535-543 (only the relevant part of a bigger script).

local function calculateOfflineEarnings(player: Player, profile: any)
	local lastTime = profile.Data.LastSaveTime
	if not lastTime or lastTime == 0 then return end

	local now = os.time()
	local diff = now - lastTime
	if diff < 60 then return end 

	local timeToCalc = math.min(diff, MAX_OFFLINE_TIME)
	local totalEarned = 0

	for _, floorData in pairs(profile.Data.Plots) do
		for _, slotData in pairs(floorData) do
			if slotData.Item then
				local itemConf = ItemConfigurations.GetItemData(slotData.Item.Name)
				if itemConf then
					local base = itemConf.Income
					local mutMult = MUTATION_MULTIPLIERS[slotData.Item.Mutation] or 1
					local level = slotData.Level or 1
					local levelMult = INCOME_SCALING ^ (level - 1)

					local reb = profile.Data.Rebirths or 0
					local rebMult = 1 + (reb * 0.5)

					local vipMult = PlayerController:IsVIP(player) and 1.25 or 1

					local rate = base * mutMult * levelMult * rebMult * vipMult
					local earnings = rate * timeToCalc

					totalEarned += earnings
				end
			end
		end
	end

	if totalEarned > 0 then
		PlayerController.PendingOfflineEarnings[player] = math.floor(totalEarned)
		task.delay(1, function() 
			if player and player.Parent then
				local events = ReplicatedStorage:FindFirstChild("Events")
				local showEvent = events and events:FindFirstChild("ShowOfflineEarnings")
				if showEvent then
					showEvent:FireClient(player, math.floor(totalEarned))
				end
			end
		end)
	end

-- ... (lines 228-534 skipped) ...

	Events.ClaimOfflineEarnings.OnServerEvent:Connect(function(player)
		local pending = PlayerController.PendingOfflineEarnings[player]
		if pending and pending > 0 then
			PlayerController:AddMoney(player, pending)
			PlayerController.PendingOfflineEarnings[player] = nil
			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Claimed offline earnings!", "Success") end
		end
	end)
