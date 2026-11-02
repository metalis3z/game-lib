-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lighting = game:GetService("Lighting")
local VecToColor = require(script.Parent.VecToColor)
local ColorToVec = require(script.Parent.ColorToVec)
local RobloxSaturation = require(script.Parent.RobloxSaturation)

return function(p1) --[[ Line: 6 | Upvalues: Lighting (copy), ColorToVec (copy), VecToColor (copy), RobloxSaturation (copy) ]]
	local v1 = ColorToVec(Lighting.Ambient):Max(ColorToVec(Lighting.OutdoorAmbient))
	local v2 = ColorToVec(Color3.fromRGB(255, 255, 255))
	local ColorCorrectionEffect = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
	local v3, v4

	if ColorCorrectionEffect and ColorCorrectionEffect.Enabled then
		v3 = ColorCorrectionEffect.Brightness
		v4 = ColorCorrectionEffect.Saturation
		v2 = ColorToVec(ColorCorrectionEffect.TintColor)
	else
		v4 = 0
		v3 = 0
	end

	return VecToColor(ColorToVec(RobloxSaturation(VecToColor(ColorToVec(p1) * Lighting.Brightness * v1 * v2 * (v3 + 1)), v4)))
end