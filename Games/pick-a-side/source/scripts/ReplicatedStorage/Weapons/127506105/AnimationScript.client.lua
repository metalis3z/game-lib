-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:17
-- Luau version 6, Types version 3
-- Time taken: 0.002689 seconds

local Parent_upvr = script.Parent
local tbl_upvr = {}
local tbl_upvw = {}
local var7_upvw
local var8_upvw
for _, v_3 in pairs({"BeginSmash", "EndSmash"}) do
	local SOME = script:WaitForChild(v_3)
	if SOME:IsA("Animation") then
		tbl_upvr[v_3] = SOME
	end
end
Parent_upvr.Equipped:connect(function() -- Line 27, Named "OnEquipped"
	--[[ Upvalues[5]:
		[1]: var7_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: tbl_upvr (readonly)
		[5]: tbl_upvw (read and write)
	]]
	var7_upvw = Parent_upvr.Parent
	var8_upvw = var7_upvw:WaitForChild("Humanoid")
	for i, v in pairs(tbl_upvr) do
		tbl_upvw[i] = var8_upvw:LoadAnimation(v)
		tbl_upvw[i]:AdjustSpeed(2)
	end
end)
Parent_upvr.Changed:connect(function(arg1) -- Line 38, Named "OnChanged"
	--[[ Upvalues[3]:
		[1]: Parent_upvr (readonly)
		[2]: tbl_upvw (read and write)
		[3]: var7_upvw (read and write)
	]]
	if arg1 == "Enabled" and Parent_upvr.Enabled == false then
		tbl_upvw.BeginSmash:Play()
		wait(0.5)
		if Parent_upvr.Parent == var7_upvw then
			tbl_upvw.BeginSmash:Stop()
			tbl_upvw.EndSmash:Play()
			wait(0.5)
			tbl_upvw.EndSmash:Stop()
		end
	end
end)
Parent_upvr.Unequipped:connect(function() -- Line 53, Named "OnUnequipped"
	--[[ Upvalues[1]:
		[1]: tbl_upvw (read and write)
	]]
	for _, v_2 in pairs(tbl_upvw) do
		v_2:Stop()
	end
	tbl_upvw = {}
end)