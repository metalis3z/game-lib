-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:12
-- Luau version 6, Types version 3
-- Time taken: 0.000779 seconds

return function(arg1, arg2) -- Line 7
	if arg2 == 0 then
		return arg1.Keypoints[1].Value
	end
	if arg2 == 1 then
		return arg1.Keypoints[#arg1.Keypoints].Value
	end
	for i = 1, #arg1.Keypoints - 1 do
		local var3 = arg1.Keypoints[i]
		local var4 = arg1.Keypoints[i + 1]
		if var3.Time <= arg2 and arg2 < var4.Time then
			local var5 = (arg2 - var3.Time) / (var4.Time - var3.Time)
			return Color3.new((var4.Value.R - var3.Value.R) * var5 + var3.Value.R, (var4.Value.G - var3.Value.G) * var5 + var3.Value.G, (var4.Value.B - var3.Value.B) * var5 + var3.Value.B)
		end
	end
end