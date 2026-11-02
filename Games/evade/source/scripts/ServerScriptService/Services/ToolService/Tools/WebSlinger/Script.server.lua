-- Server script (ServerScriptService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local webslinger = require(script.Parent)
local PlayerCooldowns = {}

local activeDrags = {} -- maps player -> {rope, beam, a0, a1, target, hb}

-- Helper: end drag for player
local function endDragForPlayer(player)
	local d = activeDrags[player]
	if not d then return end
	-- cleanup any heartbeat updater
	if d.hb and d.hb.Connected then
		pcall(function() d.hb:Disconnect() end)
	end
	-- cleanup module resources and unragdoll
	webslinger.CleanupDragData(player, d)
	activeDrags[player] = nil
end

-- UseItem remote handler
Net:RemoteEvent("UseItem").OnServerEvent:Connect(function(player, hitPos, target)
--	local lastUse = PlayerCooldowns[player.UserId]
	--if lastUse and (tick() - lastUse) < COOLDOWN then
--		return nil
	--end
	local char = player.Character
	if not char or not char.PrimaryPart then return end

	local root = char.PrimaryPart



	local beam, att0, att1

	-- FIXED: Get character no matter what was hit.
	local targetChar = nil
	local targetPlayer = nil

	if target then
		targetChar = target:FindFirstAncestorWhichIsA("Model")
		if targetChar then
			targetPlayer = Players:GetPlayerFromCharacter(targetChar)
		end
	end

	if targetPlayer then
		-- beam to hit part
		beam, att0, att1 = webslinger.CreateBeam(root, target, workspace)

		task.delay(0.3, function()
			if beam then beam:Destroy() end
			if att0 then att0:Destroy() end
			if att1 then att1:Destroy() end
		end)

		-- NOW this will ALWAYS run when hitting any part of a player
		activeDrags[player] = webslinger.AttachDrag(char, targetChar)

	else
		-- Missed: make a 10-stud beam
		local direction = (hitPos - root.Position).Unit
		local endPos = root.Position + direction * 10

		beam, att0, att1 = webslinger.CreateBeam(root, endPos, workspace)

		task.delay(0.3, function()
			if beam then beam:Destroy() end
			if att0 then att0:Destroy() end
			if att1 then att1:Destroy() end
		end)
	end

end)


-- Handle tool unequip: try both Net remote name and a plain RemoteEvent in ReplicatedStorage
-- Try Net version first (if your Net wrapper exposes ToolUnequipped)
pcall(function()
	Net:RemoteEvent("ToolUnequipped").OnServerEvent:Connect(function(player)
		endDragForPlayer(player)
	end)
end)

-- Also listen for a plain RemoteEvent named "ToolUnequipped" (in case you used ReplicatedStorage.ToolUnequipped).
local plainUnequip = ReplicatedStorage:FindFirstChild("ToolUnequipped")
if plainUnequip and plainUnequip:IsA("RemoteEvent") then
	plainUnequip.OnServerEvent:Connect(function(player)
		endDragForPlayer(player)
	end)
end

-- Clean up if player leaves
Players.PlayerRemoving:Connect(function(player)
	if activeDrags[player] then
		endDragForPlayer(player)
	end
end)
