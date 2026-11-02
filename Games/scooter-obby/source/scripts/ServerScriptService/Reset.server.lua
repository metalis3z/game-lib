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

game:GetService("ReplicatedStorage").RemoteEvents.resetPlayer.OnServerEvent:Connect(function(player)
	player:WaitForChild("leaderstats")
	player.leaderstats.Stage.Value = 1
		if game:GetService("Players"):FindFirstChild(player.Name) then
			local player = player
			local stage = player.leaderstats.Stage.Value

			if stageObjects[stage] then
				for i, v in pairs(stageObjects[stage]) do
					if v.Name == "Checkpoint" then
						local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
						FakeChar.Velocity = Vector3.new(0,0,0)
						FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
					end
				end
			end
		end
end)
