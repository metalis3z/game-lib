-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	MIN_EGG_SCALE = 0.8,
	MAX_EGG_SCALE = 3,
	MIN_ICON_SCALE = 0.5,
	MAX_ICON_SCALE = 1.1,
	MapEggScaleToIconScale = function(p1) --[[ mapEggScaleToIconScale | Line: 8 ]]
		if typeof(p1) == "number" and (p1 == p1 and not (p1 <= 0)) then
			return (math.clamp(p1, 0.8, 3) - 0.8) / 2.2 * 0.6000000000000001 + 0.5
		end

		return 1.1
	end,
	ApplyIconScaleToImageLabel = function(p1, p2) --[[ applyIconScaleToImageLabel | Line: 23 ]]
		local v1 = if typeof(p2) == "number" and (p2 == p2 and not (p2 <= 0)) then (math.clamp(p2, 0.8, 3) - 0.8) / 2.2 * 0.6000000000000001 + 0.5 else 1.1

		p1.Size = UDim2.fromScale(v1, v1)
	end
}