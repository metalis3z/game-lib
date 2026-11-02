-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:21
-- Luau version 6, Types version 3
-- Time taken: 0.001478 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "FFlagController";
	_fFlags = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
function any_CreateController_result1.canBypass(arg1, arg2) -- Line 28
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	return var6_upvw.fFlagUtils.canBypass(arg2)
end
function any_CreateController_result1.getFFlag(arg1, arg2) -- Line 32
	--[[ Upvalues[1]:
		[1]: var7_upvw (read and write)
	]]
	local var8 = arg1._fFlags[arg2]
	if var8 == nil then
		var7_upvw.print(`FFlag '{arg2}' finns inte!`, warn)
		return
	end
	return var8
end
function any_CreateController_result1.fFlagChanged(arg1) -- Line 42
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	var4_upvw.fFlagChanged:Connect(function(arg1_2, arg2) -- Line 43
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var7_upvw (copied, read and write)
		]]
		for i, v in arg1_2 do
			arg1._fFlags[i] = v
			if not arg2 then
				var7_upvw.print(`FFlag \xE4ndrades! ({i}: {v})`)
			end
		end
	end)
end
function any_CreateController_result1.initFFlags(arg1) -- Line 54
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	for i_2, v_2 in var5_upvw do
		arg1._fFlags[i_2] = v_2.default
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 60
	arg1:initFFlags()
	arg1:fFlagChanged()
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var15_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 65
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var15_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetService("FFlagService")
	var5_upvw = require(ReplicatedStorage_upvr.Shared.List.FFlags)
	var6_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var15_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
end
return any_CreateController_result1