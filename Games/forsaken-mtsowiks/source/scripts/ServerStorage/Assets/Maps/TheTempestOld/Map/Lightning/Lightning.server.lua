while script.Parent ~= nil do
	task.wait(math.random(10, 30))
	script.Parent["Lightning" .. tostring(math.random(1, 2))]:Play()
	for i, v in ipairs(script:GetChildren()) do
		v:FindFirstChildOfClass("ParticleEmitter"):Emit(v:FindFirstChildOfClass("ParticleEmitter"):GetAttribute("EmitCount"))
	end
	for i, v in ipairs(script.Parent:GetChildren()) do
		if v:IsA("SurfaceLight") then
			v.Brightness = 40
			game:GetService("TweenService"):Create(v, TweenInfo.new(0.5), {Brightness = 0}):Play()
		end
	end
end