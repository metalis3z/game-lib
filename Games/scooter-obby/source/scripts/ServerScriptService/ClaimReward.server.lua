local replicatedStorage = game:GetService("ReplicatedStorage")
local serverScriptService = game:GetService("ServerScriptService")
local coinEvent = serverScriptService.StageUpdater.CoinTake
local spinEvent = serverScriptService.SpinScript.GiveSkips
local skipHandler = require(serverScriptService.SkipHandler)

local function newClaim(claim, player)
	if player:FindFirstChild("ClaimedRewards") then
		local claimedReward = player:FindFirstChild("ClaimedRewards")
		local reward = Instance.new("NumberValue", claimedReward)
		reward.Name = claim
	else
		local claimedReward = Instance.new("Folder", player)
		claimedReward.Name = "ClaimedRewards"
		local reward = Instance.new("NumberValue", claimedReward)
		reward.Name = claim
	end
end

replicatedStorage.RemoteEvents.claimPlaytimeReward.OnServerEvent:Connect(function(player, rewardID)
	if rewardID == "1" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 120 + timeStart
		
		if -(os.time() - timeEnd) < 1 then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("1") then
					newClaim(1, player)
					coinEvent:Fire(player, 250)
				end
			else
				newClaim(1, player)
				coinEvent:Fire(player, 250)
			end
		end
	end
	
	if rewardID == "2" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 300 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("2") then
					newClaim(2, player)
					spinEvent:Fire(player, 1)
				end
			else
				newClaim(2, player)
				spinEvent:Fire(player, 1)
			end
		end
	end
	
	if rewardID == "3" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 600 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("3") then
					newClaim(3, player)
					coinEvent:Fire(player, 400)
				end
			else
				newClaim(3, player)
				coinEvent:Fire(player, 400)
			end
		end
	end
	
	if rewardID == "4" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 900 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("4") then
					newClaim(4, player)
					skipHandler.AddSkips(player, 1)
				end
			else
				newClaim(4, player)
				skipHandler.AddSkips(player, 1)
			end
		end
	end
	
	if rewardID == "5" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 1200 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("5") then
					newClaim(5, player)
					spinEvent:Fire(player, 1)
				end
			else
				newClaim(5, player)
				spinEvent:Fire(player, 1)
			end
		end
	end
	
	if rewardID == "6" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 1500 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("6") then
					newClaim(6, player)
					coinEvent:Fire(player, 650)
				end
			else
				newClaim(6, player)
				coinEvent:Fire(player, 650)
			end
		end
	end
	
	if rewardID == "7" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 1800 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("7") then
					newClaim(7, player)
					skipHandler.AddSkips(player, 2)
				end
			else
				newClaim(7, player)
				skipHandler.AddSkips(player, 2)
			end
		end
	end
	
	if rewardID == "8" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 2100 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("8") then
					newClaim(8, player)
					coinEvent:Fire(player, 800)
				end
			else
				newClaim(8, player)
				coinEvent:Fire(player, 800)
			end
		end
	end
	
	if rewardID == "9" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 2400 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("9") then
					newClaim(9, player)
					skipHandler.AddSkips(player, 4)
				end
			else
				newClaim(9, player)
				skipHandler.AddSkips(player, 4)
			end
		end
	end
	
	if rewardID == "10" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 2700 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("10") then
					newClaim(10, player)
					coinEvent:Fire(player, 1050)
				end
			else
				newClaim(10, player)
				coinEvent:Fire(player, 1050)
			end
		end
	end
	
	if rewardID == "11" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 3000 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("11") then
					newClaim(11, player)
					spinEvent:Fire(player, 2)
				end
			else
				newClaim(11, player)
				spinEvent:Fire(player, 2)
			end
		end
	end
	
	if rewardID == "12" then
		local timeStart = player:GetAttribute("joinTime")
		local timeEnd = 3300 + timeStart

		if -(os.time() - timeEnd) < timeEnd then
			if player:FindFirstChild("ClaimedRewards") then
				if not player:FindFirstChild("ClaimedRewards"):FindFirstChild("12") then
					newClaim(12, player)
					coinEvent:Fire(player, 2500)
				end
			else
				newClaim(12, player)
				coinEvent:Fire(player, 2500)
			end
		end
	end
end)