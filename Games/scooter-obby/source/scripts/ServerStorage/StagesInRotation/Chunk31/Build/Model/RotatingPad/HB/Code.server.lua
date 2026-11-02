local union = script.Parent
local stageObjects = {}

local CollectionService = game:GetService("CollectionService")

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end

	table.insert(stageObjects[stage], cp)
end

union.Touched:Connect(function(otherPart)
	if otherPart.Parent then
		if game:GetService("Players"):FindFirstChild(otherPart.Name) then
			local player = game:GetService("Players"):FindFirstChild(otherPart.Name)
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
	end
end)