local TweenService = game:GetService('TweenService')
local DistributedGameTime = workspace.DistributedGameTime

for _, Part in pairs(script.Parent.Parent:GetChildren()) do

	if Part.Name == 'TweenPart' or Part.Name == 'Meshes/Booth19_WoodStump2' or Part.Name == 'Meshes/Booth19_WoodStump' or Part.Name == 'PrimaryPart' then

	else

		local WeldConstraint = Instance.new('WeldConstraint', Part)
		WeldConstraint.Part0 = Part
		WeldConstraint.Part1 = script.Parent

		Part.Anchored = false

	end

end

local RotationY = script.Parent.Orientation.Y

while true do
	
	wait(3)
	
	TweenService:Create(script.Parent, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		CFrame = CFrame.new(script.Parent.Position.X, 3, script.Parent.Position.Z) * CFrame.Angles(0, math.rad(RotationY), 0)
	}):Play()

	wait(3)

	TweenService:Create(script.Parent, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		CFrame = CFrame.new(script.Parent.Position.X, 1.514, script.Parent.Position.Z) * CFrame.Angles(0, math.rad(RotationY), 0)
	}):Play()

end