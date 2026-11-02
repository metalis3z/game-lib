local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local plant = handle:WaitForChild("Plant")
local model = game.ServerStorage.EMSkit
local offset = 0.25

local medicBags = game.Workspace.MedicBags

function countBags(player)
	local count = 0
	for i,v in pairs(medicBags:GetChildren()) do
		if v.Name == player.Name.."_EMSKIT" then
			count += 1
		end
	end
	
	wait()
	
	return count
end

plant.Triggered:Connect(function(p)
	if p.Team ~= game.Teams.EMS then return end
	
	if countBags(p) >= 4 then
		return game.ReplicatedStorage.server:FireClient(p,"alert","You can only have 4 bags placed at once!")
	end
	
	if p.Character:WaitForChild("Humanoid").Sit then
		return game.ReplicatedStorage.server:FireClient(p,"alert","Cannot place while seated!")
	end
	
	local castRay = Ray.new(p.Character.PrimaryPart.Position, Vector3.new(0, -10000, 0))
	local ignoreList = {p.Character}
	local hit, position = workspace:FindPartOnRayWithIgnoreList(castRay,ignoreList)
	
	local newCFrame = CFrame.new(position.X, position.Y + offset, position.Z)
	
	local newModel = model:Clone()
	newModel.Parent = medicBags
	newModel.Name = p.Name.."_EMSKIT"
	newModel.CFrame = newCFrame
	newModel.Orientation = p.Character.PrimaryPart.Orientation
	newModel.Take.Enabled = true
end)