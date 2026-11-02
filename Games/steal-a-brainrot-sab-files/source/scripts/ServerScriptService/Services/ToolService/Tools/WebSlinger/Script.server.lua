local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local webslinger = require(script.Parent)
local PlayerCooldowns = {}

local activeDrags = {}

local function endDragForPlayer(player)
	local d = activeDrags[player]
	if not d then return end
	if d.hb and d.hb.Connected then
		pcall(function() d.hb:Disconnect() end)
	end
	webslinger.CleanupDragData(player, d)
	activeDrags[player] = nil
end

Net:RemoteEvent("UseItem").OnServerEvent:Connect(function(player, hitPos, target)
	local char = player.Character
	if not char or not char.PrimaryPart then return end

	local root = char.PrimaryPart



	local beam, att0, att1

	local targetChar = nil
	local targetPlayer = nil

	if target then
		targetChar = target:FindFirstAncestorWhichIsA("Model")
		if targetChar then
			targetPlayer = Players:GetPlayerFromCharacter(targetChar)
		end
	end

	if targetPlayer then
		beam, att0, att1 = webslinger.CreateBeam(root, target, workspace)

		task.delay(0.3, function()
			if beam then beam:Destroy() end
			if att0 then att0:Destroy() end
			if att1 then att1:Destroy() end
		end)

		activeDrags[player] = webslinger.AttachDrag(char, targetChar)

	else
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


pcall(function()
	Net:RemoteEvent("ToolUnequipped").OnServerEvent:Connect(function(player)
		endDragForPlayer(player)
	end)
end)

local plainUnequip = ReplicatedStorage:FindFirstChild("ToolUnequipped")
if plainUnequip and plainUnequip:IsA("RemoteEvent") then
	plainUnequip.OnServerEvent:Connect(function(player)
		endDragForPlayer(player)
	end)
end

Players.PlayerRemoving:Connect(function(player)
	if activeDrags[player] then
		endDragForPlayer(player)
	end
end)
