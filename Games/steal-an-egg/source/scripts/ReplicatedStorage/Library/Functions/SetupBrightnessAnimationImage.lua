-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

local function adjustBrightness(p1, p2) --[[ adjustBrightness | Line: 3 ]]
	local v1, v2, v3 = p1:ToHSV()

	return Color3.fromHSV(v1, v2, (math.clamp(v3 + p2, 0, 1)))
end

return function(p1) --[[ Line: 9 | Upvalues: TweenService (copy) ]]
	local InletTexture = p1:FindFirstChild("InletTexture", true)

	if not p1:GetAttribute("DefaultColor") then
		p1:SetAttribute("DefaultColor", InletTexture.ImageColor3)
	end

	local v1 = p1:GetAttribute("DefaultColor")
	local v2, v3, v4 = v1:ToHSV()
	local v6 = Color3.fromHSV(v2, v3, (math.clamp(v4 + 0.1, 0, 1)))
	local SENSOR = p1:FindFirstChild("SENSOR", true)

	p1:FindFirstChild("UIScale", true)

	local v7 = TweenService:Create(InletTexture, TweenInfo.new(0.25), {
		ImageColor3 = v6
	})
	local v8 = TweenService:Create(InletTexture, TweenInfo.new(0.25), {
		ImageColor3 = v1
	})

	SENSOR.MouseEnter:Connect(function() --[[ Line: 26 | Upvalues: v7 (copy) ]]
		v7:Play()
	end)
	SENSOR.MouseLeave:Connect(function() --[[ Line: 29 | Upvalues: v8 (copy) ]]
		v8:Play()
	end)

	return SENSOR
end