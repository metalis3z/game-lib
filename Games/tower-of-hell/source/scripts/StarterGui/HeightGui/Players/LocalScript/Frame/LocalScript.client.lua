local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local towerHeight = tonumber(replicatedStorage.TowerHeight.Value)

runService.Heartbeat:Connect(function()
	local character = workspace:FindFirstChild(script.Parent.Name)
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local leftLeg = character:FindFirstChild("Left Leg")
	if not hrp or not leftLeg then return end
	script.Parent.Position = UDim2.new(0, 0, 1 - ((hrp.Position.Y - (hrp.Size.Y/2 + leftLeg.Size.Y))/towerHeight), 0)
end)

replicatedStorage.TowerHeight.Changed:Connect(function(value)
	towerHeight = tonumber(value)
end)