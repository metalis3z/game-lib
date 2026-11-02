-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = workspace
local v2 = UserSettings()

return function(p1, p2) --[[ Line: 4 | Upvalues: v2 (copy), v1 (copy) ]]
	local SavedQualityLevel = v2.GameSettings.SavedQualityLevel.Value

	return p1 * ((if SavedQualityLevel == 0 then 10 else SavedQualityLevel) / 10) * math.clamp(1 - ((v1.CurrentCamera.CFrame.Position - p2).Magnitude - 200) / 800, 0, 1)
end