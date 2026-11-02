local tool = script.Parent
local pods = game.ReplicatedStorage.Accessories:WaitForChild("DiamondStudEarring")
local wear = false
Character = nil
tool.Equipped:Connect((function()
	Character = tool.Parent
end))
tool.Activated:Connect(function()
if wear == false then
	pods:clone().Parent = Character
	wear = true
 elseif wear == true then
 Character.DiamondStudEarring:destroy()
	wear = false
end
end)
tool.Unequipped:Connect(function()
	Character = nil
end)