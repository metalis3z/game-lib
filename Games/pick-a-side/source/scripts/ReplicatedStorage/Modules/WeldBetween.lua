-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:13
-- Luau version 6, Types version 3
-- Time taken: 0.000644 seconds

function weld(arg1, arg2) -- Line 2
	local Weld = Instance.new("Weld")
	Weld.Parent = arg1
	Weld.C0 = CFrame.new()
	Weld.C1 = arg2.CFrame:inverse() * arg1.CFrame
	Weld.Name = "Weld"
	Weld.Part0 = arg1
	Weld.Part1 = arg2
end
return weld