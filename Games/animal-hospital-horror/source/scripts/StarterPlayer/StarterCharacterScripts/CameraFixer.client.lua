task.wait()

local function FixFirstPersonHeight(p1) --[[ FixFirstPersonHeight | Line: 3 ]]
	p1:WaitForChild("Humanoid").CameraOffset = Vector3.new(0, -0.5, 0)
end

local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character

if not Character then
	return
end

LocalPlayer.Character:WaitForChild("Humanoid").CameraOffset = Vector3.new(0, -0.5, 0)

local Humanoid = Character:WaitForChild("Humanoid")

while LocalPlayer.Character == Character and (Humanoid.Parent and Character.PrimaryPart) do
	Character:WaitForChild("Humanoid").CameraOffset = Vector3.new(0, -0.5, 0)
	task.wait(30)
end