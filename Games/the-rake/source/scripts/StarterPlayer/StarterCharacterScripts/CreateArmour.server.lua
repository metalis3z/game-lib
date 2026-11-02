local human = script.Parent:WaitForChild("Humanoid")

local newArmour = game.ServerStorage.Vest.Armour:Clone()
local shirt = game.ServerStorage.Vest.VestShirt:Clone()
newArmour.Name = "VestArmour"
newArmour.Parent = script.Parent
human.MaxHealth = 200
human.Health = human.MaxHealth
if script.parent:FindFirstChild("Shirt") then
	script.parent.Shirt:Destroy()
end
shirt.Parent = script.parent
script.Parent.VestArmour.CFrame = script.Parent.Torso.CFrame
script.Parent.VestArmour.WeldConstraint.Part1 = script.Parent.Torso