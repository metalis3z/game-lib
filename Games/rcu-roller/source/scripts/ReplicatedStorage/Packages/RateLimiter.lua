-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:13
-- Luau version 6, Types version 3
-- Time taken: 0.001821 seconds

local module_2 = {
	Default = nil;
}
local Players = game:GetService("Players")
local tbl_upvr = {}
local tbl_upvr_2 = {}
local tbl_upvr_3 = {}
tbl_upvr_3.__index = tbl_upvr_3
function tbl_upvr_3.CheckRate(arg1, arg2) -- Line 59
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local _sources = arg1._sources
	local os_clock_result1 = os.clock()
	local var13 = _sources[arg2]
	if var13 ~= nil then
		local maximum = math.max(os_clock_result1, var13 + arg1._rate_period)
		if maximum - os_clock_result1 < 1 then
			_sources[arg2] = maximum
			return true
		end
		return false
	end
	if typeof(arg2) == "Instance" and arg2:IsA("Player") and tbl_upvr[arg2] == nil then
		return false
	end
	_sources[arg2] = os_clock_result1 + arg1._rate_period
	return true
end
function tbl_upvr_3.CleanSource(arg1, arg2) -- Line 83
	arg1._sources[arg2] = nil
end
function tbl_upvr_3.Cleanup(arg1) -- Line 87
	arg1._sources = {}
end
function tbl_upvr_3.Destroy(arg1) -- Line 91
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	tbl_upvr_2[arg1] = nil
end
function module_2.NewRateLimiter(arg1) -- Line 96
	--[[ Upvalues[2]:
		[1]: tbl_upvr_3 (readonly)
		[2]: tbl_upvr_2 (readonly)
	]]
	if arg1 <= 0 then
		error("[RateLimiter]: Invalid rate")
	end
	local module = {
		_sources = {};
		_rate_period = 1 / arg1;
	}
	setmetatable(module, tbl_upvr_3)
	tbl_upvr_2[module] = true
	return module
end
for _, v in ipairs(Players:GetPlayers()) do
	tbl_upvr[v] = true
end
module_2.Default = module_2.NewRateLimiter(({
	DefaultRateLimiterRate = 120;
}).DefaultRateLimiterRate)
Players.PlayerAdded:Connect(function(arg1) -- Line 122
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	tbl_upvr[arg1] = true
end)
Players.PlayerRemoving:Connect(function(arg1) -- Line 126
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
	]]
	tbl_upvr[arg1] = nil
	for i_2 in pairs(tbl_upvr_2) do
		i_2._sources[arg1] = nil
	end
end)
return module_2