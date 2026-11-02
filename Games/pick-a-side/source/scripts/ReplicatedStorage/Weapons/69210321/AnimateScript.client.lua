-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:20
-- Luau version 6, Types version 3
-- Time taken: 0.002012 seconds

local Parent_upvr = script.Parent
local var2_upvw
local var3_upvw
local Event_upvr = Parent_upvr:WaitForChild("Event")
function choiceIsYours(arg1) -- Line 11
	--[[ Upvalues[3]:
		[1]: var2_upvw (read and write)
		[2]: var3_upvw (read and write)
		[3]: Event_upvr (readonly)
	]]
	if var2_upvw == nil or var3_upvw == nil then
	elseif arg1:lower() == 'q' then
		Event_upvr:FireServer('q')
	end
end
local var5_upvw
function onEquipped(arg1) -- Line 19
	--[[ Upvalues[4]:
		[1]: var2_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: var3_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	var2_upvw = Parent_upvr.Parent
	var3_upvw = var2_upvw:FindFirstChild("Humanoid")
	var5_upvw = var2_upvw:FindFirstChild("Torso")
	if arg1 then
		arg1.KeyDown:connect(choiceIsYours)
	end
end
Parent_upvr.Activated:connect(function() -- Line 29
	--[[ Upvalues[2]:
		[1]: Event_upvr (readonly)
		[2]: var3_upvw (read and write)
	]]
	Event_upvr:FireServer('a', var3_upvw.TargetPoint)
end)
Parent_upvr.Equipped:connect(onEquipped)