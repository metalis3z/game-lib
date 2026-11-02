repeat wait() until script.Parent.Parent:FindFirstChildOfClass("Humanoid")

local humanoid = script.Parent.Parent:FindFirstChildOfClass("Humanoid")
local equipanim = humanoid:LoadAnimation(script.Equip)
local idleanim = humanoid:LoadAnimation(script.Idle)

script.Parent.Equipped:Connect(function()
	equipanim:Play()
	idleanim:Play()
end)

script.Parent.Unequipped:Connect(function()
	equipanim:Stop()
	idleanim:Stop()
end)