--credit to quartz games studio
local LocalPlayer = game.Players.LocalPlayer
local v1 = script.Parent
local plr_Val = script.Parent.Parent.plr_Val

function UpdateSpeed() --[[ UpdateSpeed | Line: 7 | Upvalues: LocalPlayer (copy), v1 (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChild("Humanoid")

	if not Humanoid then
		return
	end

	v1.Velocity = -script.Parent.CFrame.RightVector * (Humanoid.WalkSpeed - 0.25)
end
function TrackCharater(p1) --[[ TrackCharater | Line: 17 ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	if not Humanoid then
		return
	end

	UpdateSpeed()
	Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function() --[[ Line: 21 ]]
		UpdateSpeed()
	end)
end

local Character = LocalPlayer.Character

while Character == nil do
	task.wait()
end

TrackCharater(Character)
LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 34 ]]
	TrackCharater(p1)
end)
v1:GetPropertyChangedSignal("Orientation"):Connect(function() --[[ Line: 38 ]]
	UpdateSpeed()
end)
game:GetService("TweenService")
TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)

local RunService = game:GetService("RunService")
local Top = script.Parent.Top

RunService.Heartbeat:Connect(function() --[[ Line: 50 | Upvalues: plr_Val (copy), Top (copy) ]]
	local v2 = Top

	v2.OffsetStudsU = v2.OffsetStudsU - 0.05 * plr_Val.Value
end)