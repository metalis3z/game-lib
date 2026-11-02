-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:15
-- Luau version 6, Types version 3
-- Time taken: 0.001381 seconds

enabled = true -- Setting global
function onButton1Down(arg1) -- Line 4
	if not enabled then
	else
		enabled = false -- Setting global
		arg1.Icon = "rbxasset://textures\\GunWaitCursor.png"
		wait(1)
		arg1.Icon = "rbxasset://textures\\GunCursor.png"
		enabled = true -- Setting global
	end
end
function onEquippedLocal(arg1) -- Line 18
	if arg1 == nil then
		print("Mouse not found")
	else
		arg1.Icon = "rbxasset://textures\\GunCursor.png"
		arg1.Button1Down:connect(function() -- Line 26
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			onButton1Down(arg1)
		end)
	end
end
script.Parent.Equipped:connect(onEquippedLocal)