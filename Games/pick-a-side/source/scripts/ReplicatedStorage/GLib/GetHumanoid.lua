-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:02
-- Luau version 6, Types version 3
-- Time taken: 0.000958 seconds

return function(arg1) -- Line 6
	if arg1 then
		for _, v in next, arg1:GetChildren() do
			if v:IsA("Humanoid") then
				return v
			end
		end
	else
		return nil
	end
end