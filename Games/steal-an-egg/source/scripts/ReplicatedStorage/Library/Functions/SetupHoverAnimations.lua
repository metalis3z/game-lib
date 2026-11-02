-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

return function(p1, p2) --[[ Line: 3 | Upvalues: TweenService (copy) ]]
	local SENSOR = p1:FindFirstChild("SENSOR", true)
	local UIScale = p1:FindFirstChild("UIScale", true)
	local v1 = p2 or 0.05
	local Scale = UIScale.Scale
	local v2 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
		Scale = Scale * (1 + v1)
	})
	local v3 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
		Scale = Scale * (1 - v1)
	})
	local v4 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
		Scale = Scale
	})

	SENSOR.MouseButton1Down:Connect(function() --[[ Line: 13 | Upvalues: v3 (copy) ]]
		v3:Play()
	end)
	SENSOR.MouseButton1Up:Connect(function() --[[ Line: 16 | Upvalues: v2 (copy) ]]
		v2:Play()
	end)
	SENSOR.MouseEnter:Connect(function() --[[ Line: 19 | Upvalues: v2 (copy) ]]
		v2:Play()
	end)
	SENSOR.MouseLeave:Connect(function() --[[ Line: 22 | Upvalues: v4 (copy) ]]
		v4:Play()
	end)

	return SENSOR
end