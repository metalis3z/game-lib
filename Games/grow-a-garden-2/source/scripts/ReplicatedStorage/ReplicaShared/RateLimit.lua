--credit to prince games studio
local Players = game:GetService("Players")
local t = {}
local t2 = {}
local t3 = {}

t3.__index = t3
function t3.New(p1, p2) --[[ New | Line: 41 | Upvalues: t3 (copy), t2 (copy) ]]
	if p1 <= 0 then
		error("[RateLimit]: Invalid rate")
	end

	local t = {
		sources = {},
		rate_period = 1 / p1
	}

	t.is_full_wait = p2 == true
	setmetatable(t, t3)
	t2[t] = true

	return t
end
function t3.CheckRate(p1, p2) --[[ CheckRate | Line: 58 | Upvalues: t (copy) ]]
	local sources = p1.sources
	local v1 = os.clock()

	if p2 == nil then
		p2 = "nil"
	end

	local v2 = sources[p2]

	if v2 == nil then
		if typeof(p2) == "Instance" and (p2:IsA("Player") and t[p2] == nil) then
			return false
		end

		sources[p2] = v1 + p1.rate_period

		return true
	end

	if p1.is_full_wait == true then
		if v2 <= v1 then
			sources[p2] = v1 + p1.rate_period

			return true
		end

		return false
	end

	local v4 = math.max(v1, v2 + p1.rate_period)

	if v4 - v1 < 1 then
		sources[p2] = v4

		return true
	end

	return false
end
function t3.CleanSource(p1, p2) --[[ CleanSource | Line: 98 ]]
	p1.sources[p2] = nil
end
function t3.Cleanup(p1) --[[ Cleanup | Line: 102 ]]
	p1.sources = {}
end
function t3.Destroy(p1) --[[ Destroy | Line: 106 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end

for i, v in ipairs(Players:GetPlayers()) do
	t[v] = true
end

Players.PlayerAdded:Connect(function(p1) --[[ Line: 116 | Upvalues: t (copy) ]]
	t[p1] = true
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 120 | Upvalues: t (copy), t2 (copy) ]]
	t[p1] = nil

	for k in pairs(t2) do
		k.sources[p1] = nil
	end
end)

return t3