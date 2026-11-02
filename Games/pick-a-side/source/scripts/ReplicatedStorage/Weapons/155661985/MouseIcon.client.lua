-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:44
-- Luau version 6, Types version 3
-- Time taken: 0.001570 seconds

Mouse_Icon = "rbxasset://textures/GunCursor.png" -- Setting global
Reloading_Icon = "rbxasset://textures/GunWaitCursor.png" -- Setting global
Tool = script.Parent -- Setting global
Mouse = nil -- Setting global
function UpdateIcon() -- Line 8
	local var1
	if Mouse then
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var1 = Mouse_Icon
			return var1
		end
		if not Tool.Enabled or not INLINED() then
			var1 = Reloading_Icon
		end
		Mouse.Icon = var1
	end
end
function OnEquipped(arg1) -- Line 14
	Mouse = arg1 -- Setting global
	UpdateIcon()
end
function OnChanged(arg1) -- Line 19
	if arg1 == "Enabled" then
		UpdateIcon()
	end
end
Tool.Equipped:connect(OnEquipped)
Tool.Changed:connect(OnChanged)