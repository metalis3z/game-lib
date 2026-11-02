-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Default"] = nil
}
local v2 = game:GetService("Players")
local v_u_3 = {}
local v_u_4 = {}
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.CheckRate(p6, p7)
	-- upvalues: (copy) v_u_3
	local v8 = p6._sources
	local v9 = os.clock()
	local v10 = v8[p7]
	if v10 == nil then
		if typeof(p7) == "Instance" and (p7:IsA("Player") and v_u_3[p7] == nil) then
			return false
		end
		v8[p7] = v9 + p6._rate_period
		return true
	end
	local v11 = v10 + p6._rate_period
	local v12 = math.max(v9, v11)
	if v12 - v9 >= 1 then
		return false
	end
	v8[p7] = v12
	return true
end
function v_u_5.CleanSource(p13, p14)
	p13._sources[p14] = nil
end
function v_u_5.Cleanup(p15)
	p15._sources = {}
end
function v_u_5.Destroy(p16)
	-- upvalues: (copy) v_u_4
	v_u_4[p16] = nil
end
function v1.NewRateLimiter(p17)
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	if p17 <= 0 then
		error("[RateLimiter]: Invalid rate")
	end
	local v18 = {
		["_sources"] = {},
		["_rate_period"] = 1 / p17
	}
	local v19 = v_u_5
	setmetatable(v18, v19)
	v_u_4[v18] = true
	return v18
end
local v20 = {
	["DefaultRateLimiterRate"] = 120
}
for _, v21 in ipairs(v2:GetPlayers()) do
	v_u_3[v21] = true
end
v1.Default = v1.NewRateLimiter(v20.DefaultRateLimiterRate)
v2.PlayerAdded:Connect(function(p22)
	-- upvalues: (copy) v_u_3
	v_u_3[p22] = true
end)
v2.PlayerRemoving:Connect(function(p23)
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	v_u_3[p23] = nil
	for v24 in pairs(v_u_4) do
		v24._sources[p23] = nil
	end
end)
return v1
