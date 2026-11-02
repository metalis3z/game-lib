--credit to prince games studio
local Lighting = game:GetService("Lighting")
local t = {}

if Lighting:GetAttribute("ActiveWeatherEffects") == nil then
	Lighting:SetAttribute("ActiveWeatherEffects", 0)
end

local v1 = 1 / 60

local function recompute() --[[ recompute | Line: 30 | Upvalues: Lighting (copy), v1 (ref) ]]
	v1 = 1 / math.max(10, 60 / math.max(1, Lighting:GetAttribute("ActiveWeatherEffects") or 1))
end

Lighting:GetAttributeChangedSignal("ActiveWeatherEffects"):Connect(recompute)
v1 = 1 / math.max(10, 60 / math.max(1, Lighting:GetAttribute("ActiveWeatherEffects") or 1))
function t.Register() --[[ Register | Line: 40 | Upvalues: Lighting (copy) ]]
	Lighting:SetAttribute("ActiveWeatherEffects", (Lighting:GetAttribute("ActiveWeatherEffects") or 0) + 1)
end
function t.Unregister() --[[ Unregister | Line: 45 | Upvalues: Lighting (copy) ]]
	Lighting:SetAttribute("ActiveWeatherEffects", (math.max(0, (Lighting:GetAttribute("ActiveWeatherEffects") or 0) - 1)))
end
function t.GetTickInterval() --[[ GetTickInterval | Line: 51 | Upvalues: v1 (ref) ]]
	return v1
end
function t.GetActiveCount() --[[ GetActiveCount | Line: 56 | Upvalues: Lighting (copy) ]]
	return math.max(1, Lighting:GetAttribute("ActiveWeatherEffects") or 1)
end

return t