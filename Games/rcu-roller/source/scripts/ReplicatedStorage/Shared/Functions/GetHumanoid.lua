-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:11
-- Luau version 6, Types version 3
-- Time taken: 0.000362 seconds

return function(arg1) -- Line 9
	if not arg1.Parent then return end
	local Character = arg1.Character
	if not Character then return end
	return Character:FindFirstChild("Humanoid")
end