-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:17
-- Luau version 6, Types version 3
-- Time taken: 0.000444 seconds

return function(arg1) -- Line 7
	local var2 = arg1
	repeat
		if not var2.Parent then
			return var2
		end
		local Parent = var2.Parent
	until not Parent.Parent and Parent:IsA("Model")
	return Parent
end