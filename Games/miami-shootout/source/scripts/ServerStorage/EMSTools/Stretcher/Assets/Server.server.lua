local tool = script.Parent.Parent
local track = nil
local animation = tool.Assets.Stretcher

tool.Seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	local humanoid = tool.Seat.Occupant
	if humanoid then
		track = humanoid:LoadAnimation(animation)
		track:Play()
	else
		track:Stop()
		track = nil
	end
end)

tool.Unequipped:Connect(function()		
	if tool.Seat.Occupant then
		if track then track:Stop() end
		tool.Seat.Occupant.Jump = true
	end
end)