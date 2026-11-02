wait(0.7)

local ev = script.Parent


ev.OnServerEvent:Connect(function()
	local body = script.Parent.Parent:WaitForChild("Body")
	local ps = false
	for i, v in pairs(body.exhaust_backfire:GetChildren()) do
		v.light.bf_light.Enabled = true
		v.particle.flames.Enabled = true
		if ps == false then
			ps = true
			v.particle.sound:Play()
		end
		
		wait(0.04)
		v.light.bf_light.Enabled = false
		v.particle.flames.Enabled = false
	end
end)