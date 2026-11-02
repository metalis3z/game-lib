-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:12
-- Luau version 6, Types version 3
-- Time taken: 0.001220 seconds

function getModelMass(arg1) -- Line 2
	local var8
	for _, v in pairs(arg1:GetChildren()) do
		if v:IsA("BasePart") then
			var8 += v:GetMass()
		end
		var8 += getModelMass(v)
	end
	return var8
end
return getModelMass