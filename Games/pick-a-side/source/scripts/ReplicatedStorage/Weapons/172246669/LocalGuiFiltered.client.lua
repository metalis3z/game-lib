-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:46
-- Luau version 6, Types version 3
-- Time taken: 0.001128 seconds

sp = script.Parent -- Setting global
local WeaponEvent_upvr = sp:WaitForChild("WeaponEvent")
function onEquippedLocal(arg1) -- Line 9
	--[[ Upvalues[1]:
		[1]: WeaponEvent_upvr (readonly)
	]]
	if arg1 then
		arg1.Icon = "rbxasset://textures\\GunCursor.png"
		arg1.Button1Down:connect(function() -- Line 12
			--[[ Upvalues[2]:
				[1]: WeaponEvent_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			WeaponEvent_upvr:FireServer("Fire", arg1.Hit.p)
		end)
	end
end
sp.Equipped:connect(onEquippedLocal)