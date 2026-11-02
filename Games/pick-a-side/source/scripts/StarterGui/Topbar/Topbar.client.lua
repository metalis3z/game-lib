-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:48
-- Luau version 6, Types version 3
-- Time taken: 0.001363 seconds

local Holder = script.Parent.Holder
if game:GetService("GuiService").TopbarInset.Height < 52 then
	Holder.UIListLayout.Padding = UDim.new(0, 8)
	Holder.Size = UDim2.new(1, 0, 0, 36)
	for _, v in Holder:GetChildren() do
		if v:IsA("GuiObject") then
			v.Size = UDim2.new(0, 32, 0, 32)
		end
	end
end