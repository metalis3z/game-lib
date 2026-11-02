-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:28
-- Luau version 6, Types version 3
-- Time taken: 0.001857 seconds

Tool = script.Parent -- Setting global
local var1_upvw = false
local Event_upvr = Tool:WaitForChild("Event")
function activate(arg1) -- Line 6
	--[[ Upvalues[1]:
		[1]: Event_upvr (readonly)
	]]
	if arg1:lower() == 'q' then
		Event_upvr:FireServer()
	end
end
function onEquippedLocal(arg1) -- Line 15
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = true
	if arg1 == nil then
	else
		if arg1 then
			arg1.KeyDown:connect(activate)
		end
		while var1_upvw do
			arg1.Icon = "rbxasset://textures\\GunCursor.png"
			while Tool.Enabled and var1_upvw do
				wait(0.01)
			end
			arg1.Icon = "rbxasset://textures\\GunWaitCursor.png"
			while not Tool.Enabled and var1_upvw do
				wait(0.01)
			end
		end
	end
end
function onUnequippedLocal() -- Line 36
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = false
end
Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)