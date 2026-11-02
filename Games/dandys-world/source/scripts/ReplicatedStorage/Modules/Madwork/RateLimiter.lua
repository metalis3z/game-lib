--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local t = {
	Default = nil
}
local Players = game:GetService("Players")
local t2 = {}
local t3 = {}
local t4 = {}

t4.__index = t4
function t4.CheckRate(p1, p2) --[[ CheckRate | Line: 59 | Upvalues: t2 (copy) ]]
	local _sources = p1._sources
	local v1 = os.clock()
	local v2 = _sources[p2]

	if v2 == nil then
		if typeof(p2) == "Instance" and (p2:IsA("Player") and t2[p2] == nil) then
			return false
		end

		_sources[p2] = v1 + p1._rate_period

		return true
	end

	local v4 = math.max(v1, v2 + p1._rate_period)

	if v4 - v1 < 1 then
		_sources[p2] = v4

		return true
	end

	return false
end
function t4.CleanSource(p1, p2) --[[ CleanSource | Line: 83 ]]
	p1._sources[p2] = nil
end
function t4.Cleanup(p1) --[[ Cleanup | Line: 87 ]]
	p1._sources = {}
end
function t4.Destroy(p1) --[[ Destroy | Line: 91 | Upvalues: t3 (copy) ]]
	t3[p1] = nil
end
function t.NewRateLimiter(p1) --[[ NewRateLimiter | Line: 96 | Upvalues: t4 (copy), t3 (copy) ]]
	if not (p1 <= 0) then
		local v1, v2

		v1 = {
			_sources = {},
			_rate_period = 1 / p1
		}
		v2 = t4
		setmetatable(v1, t4)
		t3[v1] = true

		return v1
	end

	error("[RateLimiter]: Invalid rate")
end

for i, v in ipairs(Players:GetPlayers()) do
	t2[v] = true
end

t.Default = t.NewRateLimiter(120)
Players.PlayerAdded:Connect(function(p1) --[[ Line: 122 | Upvalues: t2 (copy) ]]
	t2[p1] = true
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 126 | Upvalues: t2 (copy), t3 (copy) ]]
	t2[p1] = nil

	for k in pairs(t3) do
		k._sources[p1] = nil
	end
end)

return t