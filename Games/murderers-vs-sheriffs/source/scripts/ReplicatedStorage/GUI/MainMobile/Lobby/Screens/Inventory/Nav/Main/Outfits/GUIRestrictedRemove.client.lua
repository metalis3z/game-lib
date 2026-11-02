-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-07-20 17:55:47
-- Luau version 6, Types version 3
-- Time taken: 0.000478 seconds

if workspace.GameSettings:GetAttribute("OutfitsRestricted") then
	script.Parent.Changed:Connect(function() -- Line 4
		script.Parent.Visible = false
	end)
	script.Parent.Parent.Radios.Changed:Connect(function() -- Line 7
		script.Parent.Parent.Radios.Size = UDim2.new(0.25, 0, 0.5, 0)
	end)
end