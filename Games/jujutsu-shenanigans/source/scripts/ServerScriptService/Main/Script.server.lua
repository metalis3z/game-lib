-- Script inside ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local placeBlockEvent = ReplicatedStorage.PlaceBlockEvent

placeBlockEvent.OnServerEvent:Connect(function(player, position, rotationAngle, blockType, brickColorName)
	local block = Instance.new("Part")
	if blockType == "Wall" then
		block.Size = Vector3.new(4, 4, 1)
	elseif blockType == "Cube" then
		block.Size = Vector3.new(2, 2, 2)
	end
	block.Position = position
	block.CFrame = CFrame.new(position) * CFrame.Angles(0, math.rad(rotationAngle), 0)
	block.Anchored = true
	block.BrickColor = BrickColor.new(brickColorName)
	block.Parent = workspace
end)
