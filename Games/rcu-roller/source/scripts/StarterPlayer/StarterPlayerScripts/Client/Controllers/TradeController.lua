-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:02
-- Luau version 6, Types version 3
-- Time taken: 0.001630 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "TradeController";
	_playerInfos = {};
})
local var4_upvw
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_CreateController_result1.getPlayerInfo(arg1, arg2) -- Line 36
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local SOME = Players_upvr:FindFirstChild(arg2)
	if not SOME then
		return {}
	end
	local var8 = arg1._playerInfos[arg2]
	if not var8 then
		var8 = {}
	end
	var8.username = SOME.Name
	var8.displayName = SOME.DisplayName
	var8.userId = SOME.UserId
	return var8
end
function any_CreateController_result1.getPlayerInfos(arg1) -- Line 51
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if tick() - (arg1._debounce or 0) < 3 then
	else
		arg1._debounce = tick()
		arg1._playerInfos = var4_upvw:getPlayerInfos()
	end
end
function any_CreateController_result1.periodicallyGetPlayerInfos(arg1) -- Line 61
	task.spawn(function() -- Line 62
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		while true do
			arg1:getPlayerInfos()
			task.wait(60)
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 70
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	arg1:periodicallyGetPlayerInfos()
	Players_upvr.PlayerAdded:Connect(function() -- Line 73
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:getPlayerInfos()
	end)
	Players_upvr.PlayerRemoving:Connect(function() -- Line 76
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:getPlayerInfos()
	end)
end
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 81
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var12_upvw (read and write)
		[4]: var13_upvw (read and write)
		[5]: var14_upvw (read and write)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: var15_upvw (read and write)
		[8]: var16_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetService("TradeService")
	var12_upvw = Knit_upvr.GetController("DataController")
	var13_upvw = Knit_upvr.GetController("SoundController")
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var16_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
end
return any_CreateController_result1