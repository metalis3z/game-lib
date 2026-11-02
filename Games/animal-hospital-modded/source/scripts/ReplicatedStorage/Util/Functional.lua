local t = {
	FastSpawn = function(p1, ...) --[[ Line: 3 ]]
		local v1 = Instance.new("BindableEvent")

		v1.Event:Connect(p1)
		v1:Fire(...)
		v1:Destroy()
	end,
	WaitForPath = function(p1) --[[ WaitForPath | Line: 10 ]]
		local v1 = string.split(p1, ".")
		local v2 = game

		for v3, v4 in v1 do
			v2 = v2:WaitForChild(v4)
		end

		return v2
	end
}
local v1 = game["Run Service"]

function t.RealWait(p1) --[[ Line: 22 | Upvalues: v1 (copy) ]]
	local sum = p1 or 0
	local sum2 = 0

	while sum >= 0 do
		local _, v12 = v1.Stepped:wait()

		sum = sum - v12
		sum2 = sum2 + v12
	end

	return sum2
end
function t.Wait1Frame() --[[ Wait1Frame | Line: 33 | Upvalues: v1 (copy) ]]
	local _, v12 = v1.Stepped:wait()

	return v12
end

local v2 = Random.new()

function t.GetRandom(p1) --[[ GetRandom | Line: 39 | Upvalues: v2 (copy) ]]
	local v1 = p1:GetChildren()

	return v1[v2:NextInteger(1, #v1)]
end
function t.GetRandomFromChance(p1) --[[ GetRandomFromChance | Line: 44 | Upvalues: v2 (copy) ]]
	local sum = 0

	for k, v in pairs(p1) do
		sum = sum + v
	end

	local sum2 = v2:NextInteger(0, sum)
	local v1 = nil

	for k, v in pairs(p1) do
		sum2 = sum2 - v

		if sum2 < 0 then
			return k
		end

		v1 = k
	end

	return v1
end
t.Wait = t.RealWait
t.Spawn = t.FastSpawn
t.wait = t.RealWait
t.spawn = t.FastSpawn
function t.OnPlayerAdded(p1) --[[ OnPlayerAdded | Line: 65 ]]
	for i, v in ipairs(game.Players:GetChildren()) do
		p1(v)
	end

	game.Players.PlayerAdded:Connect(function(p12) --[[ Line: 69 | Upvalues: p1 (copy) ]]
		p1(p12)
	end)
end

return t