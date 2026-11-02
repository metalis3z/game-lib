-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:08
-- Luau version 6, Types version 3
-- Time taken: 0.002016 seconds

local Parent_upvr = script.Parent
local var2_upvw
local var3_upvw
local var4_upvw
function onActivated() -- Line 8
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: var2_upvw (read and write)
	]]
	var4_upvw = Parent_upvr.Parent
	myHumanoid = var4_upvw:FindFirstChild("Humanoid") -- Setting global
	if myHumanoid == nil then
	else
		var2_upvw = myHumanoid:LoadAnimation(Parent_upvr.AxeSlash)
		if var2_upvw then
			var2_upvw:Play()
		end
	end
end
function onEquipped() -- Line 21
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: var3_upvw (read and write)
	]]
	var4_upvw = Parent_upvr.Parent
	myHumanoid = var4_upvw:FindFirstChild("Humanoid") -- Setting global
	if myHumanoid then
		var3_upvw = myHumanoid:LoadAnimation(Parent_upvr.TwoHandAnim)
		if var3_upvw then
			var3_upvw:Play()
		end
	end
end
function onUnequipped() -- Line 30
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: var3_upvw (read and write)
	]]
	if var2_upvw then
		var2_upvw:Stop()
	end
	if var3_upvw then
		var3_upvw:Stop()
	end
end
Parent_upvr.Activated:connect(onActivated)
Parent_upvr.Equipped:connect(onEquipped)
Parent_upvr.Unequipped:connect(onUnequipped)