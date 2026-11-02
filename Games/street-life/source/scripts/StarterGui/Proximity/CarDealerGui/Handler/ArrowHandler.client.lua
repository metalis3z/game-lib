local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

local Arrow = script:FindFirstChild('Arrow')
Arrow.Parent = Character

local Target = script.Target.Value

task.delay(30, function()
	Arrow:Destroy()
	script:Destroy()
end)

while Target do
	pcall(function()
		Arrow.CFrame = CFrame.new(HumanoidRootPart.Position, Target.Position) * CFrame.Angles(0, math.rad(-45), 0) * CFrame.new(-2, 0, -2)
		Arrow.Transparency = 1 - (math.clamp((Arrow.Position - Target.Position).Magnitude - 2, 0, 2) / 2)
		if (Arrow.Position - Target.Position).Magnitude < 6 then
			Arrow:Destroy()
			script:Destroy()
		end
	end)
	task.wait()
end

if Character:FindFirstChild('Arrow') then
	Character:FindFirstChild('Arrow'):Destroy()
	script:Destroy()
end