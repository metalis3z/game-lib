-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:16
-- Luau version 6, Types version 3
-- Time taken: 0.001939 seconds

local Players = game:GetService("Players")
local tbl_upvr = {}
local tbl_upvr_2 = {}
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.New(arg1, arg2) -- Line 41
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
	]]
	if arg1 <= 0 then
		error("[RateLimit]: Invalid rate")
	end
	local module = {
		sources = {};
	}
	local var10 = 1 / arg1
	module.rate_period = var10
	if arg2 ~= true then
		var10 = false
	else
		var10 = true
	end
	module.is_full_wait = var10
	setmetatable(module, module_upvr)
	tbl_upvr_2[module] = true
	return module
end
function module_upvr.CheckRate(arg1, arg2) -- Line 58
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local sources = arg1.sources
	local os_clock_result1 = os.clock()
	local var13
	if var13 == nil then
		var13 = "nil"
	end
	local var14 = sources[var13]
	if var14 ~= nil then
		if arg1.is_full_wait ~= true then
			var14 = math.max(os_clock_result1, var14 + arg1.rate_period)
			if var14 - os_clock_result1 < 1 then
				sources[var13] = var14
				return true
			end
			return false
		end
		if var14 <= os_clock_result1 then
			sources[var13] = os_clock_result1 + arg1.rate_period
			return true
		end
		return false
	end
	if typeof(var13) == "Instance" and var13:IsA("Player") and tbl_upvr[var13] == nil then
		return false
	end
	sources[var13] = os_clock_result1 + arg1.rate_period
	return true
end
function module_upvr.CleanSource(arg1, arg2) -- Line 98
	arg1.sources[arg2] = nil
end
function module_upvr.Cleanup(arg1) -- Line 102
	arg1.sources = {}
end
function module_upvr.Destroy(arg1) -- Line 106
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	tbl_upvr_2[arg1] = nil
end
for _, v in ipairs(Players:GetPlayers()) do
	tbl_upvr[v] = true
end
Players.PlayerAdded:Connect(function(arg1) -- Line 116
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	tbl_upvr[arg1] = true
end)
Players.PlayerRemoving:Connect(function(arg1) -- Line 120
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
	]]
	tbl_upvr[arg1] = nil
	for i_2 in pairs(tbl_upvr_2) do
		i_2.sources[arg1] = nil
	end
end)
return module_upvr