local part = script.Parent
local stageObjects = {}

local CollectionService = game:GetService("CollectionService")

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end

	table.insert(stageObjects[stage], cp)
end

part.Touched:Connect(function(otherPart)
	if otherPart.Parent then
		if game:GetService("Players"):FindFirstChild(otherPart.Name) then
			local player = game:GetService("Players"):FindFirstChild(otherPart.Name)
			if not player then
				local stringFPC = string.sub(otherPart.Name, 0, 7)
				player = game:GetService("Players"):FindFirstChild(stringFPC)
			end
			local character = workspace:FindFirstChild(otherPart.Name)
			player.leaderstats.Stage.Value = 0
			local ss = game:GetService("ServerStorage")
			if not ss.PlayersDone:FindFirstChild(player.Name) then
				local newValue = Instance.new("StringValue", ss.PlayersDone)
				newValue.Name = player.Name
				game.ServerScriptService["Coins + Inv Save"].GiveWin:Fire(player)
			end
			local stage = player.leaderstats.Stage.Value
			
			if stageObjects[0] then
				for i, v in pairs(stageObjects[0]) do
					if v.Name == "Checkpoint" then
						local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
						game.Players:FindFirstChild(player.Name):SetAttribute("Safe2", .5)
						FakeChar.Velocity = Vector3.new(0,0,0)
						FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
						game:GetService("ReplicatedStorage").SpeedTimer.Value = 0
					end
				end
			end
		end
	end
end)