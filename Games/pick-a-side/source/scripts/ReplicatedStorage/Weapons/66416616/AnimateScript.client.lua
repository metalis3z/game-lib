-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:40
-- Luau version 6, Types version 3
-- Time taken: 0.001447 seconds

local Parent_upvr = script.Parent
local Event_upvr = Parent_upvr:WaitForChild("Event")
function unleashWrath(arg1) -- Line 10
	--[[ Upvalues[1]:
		[1]: Event_upvr (readonly)
	]]
	if arg1:lower() == 'q' then
		Event_upvr:FireServer()
	end
end
local var3_upvw
local var4_upvw
local var5_upvw
function onEquipped(arg1) -- Line 16
	--[[ Upvalues[4]:
		[1]: var3_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	var3_upvw = Parent_upvr.Parent
	var4_upvw = var3_upvw:FindFirstChild("Humanoid")
	var5_upvw = var3_upvw:FindFirstChild("Torso")
	if arg1 then
		arg1.KeyDown:connect(unleashWrath)
	end
end
Parent_upvr.Equipped:connect(onEquipped)