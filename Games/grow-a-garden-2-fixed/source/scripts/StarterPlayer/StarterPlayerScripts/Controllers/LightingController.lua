--credit to leon games studio
local t = {
	StartOrder = 2
}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local v1 = nil
local t2 = {
	Ambient = Lighting.Ambient,
	Brightness = Lighting.Brightness,
	ColorShift_Bottom = Lighting.ColorShift_Bottom,
	ColorShift_Top = Lighting.ColorShift_Top,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	ClockTime = Lighting.ClockTime,
	EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
}
local v2 = table.clone(t2)

function t.GetDefault(p1) --[[ GetDefault | Line: 19 | Upvalues: t2 (copy) ]]
	return t2
end
function t.GetCurrentTarget(p1) --[[ GetCurrentTarget | Line: 22 | Upvalues: v2 (copy) ]]
	return v2
end
function t.TransitionTo(p1, p2, p3) --[[ TransitionTo | Line: 26 | Upvalues: v1 (ref), v2 (copy), TweenService (copy), Lighting (copy) ]]
	if v1 then
		v1:Cancel()
		v1:Destroy()
		v1 = nil
	end

	for v12, v22 in p2 do
		v2[v12] = v22
	end

	local v3 = TweenService:Create(Lighting, TweenInfo.new(p3 or 3, Enum.EasingStyle.Sine), p2)

	v1 = v3
	v3.Completed:Once(function() --[[ Line: 39 | Upvalues: v1 (ref), v3 (copy) ]]
		if v1 == v3 then
			v1 = nil
		end

		v3:Destroy()
	end)
	v3:Play()
end
function t.SetImmediate(p1, p2) --[[ SetImmediate | Line: 46 | Upvalues: v1 (ref), v2 (copy), Lighting (copy) ]]
	if v1 then
		v1:Cancel()
		v1:Destroy()
		v1 = nil
	end

	for v12, v22 in p2 do
		v2[v12] = v22
		Lighting[v12] = v22
	end
end
function t.Init(p1) --[[ Init | Line: 60 ]] end
function t.Start(p1) --[[ Start | Line: 61 ]] end

return t