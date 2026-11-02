-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")
require(ReplicatedStorage.Packages.Observers)

local Timer = require(ReplicatedStorage.Packages.Timer)
local t1 = {}
local t2 = {}

local function triggerResyncFor(p1, n1: number)
	while n1 > 0 do
		local v11 = os.clock() % p1.Length

		if math.abs(v11 - p1.TimePosition) > 0.05 or p1.Length == 0 then
			p1.TimePosition = v11
		end

		n1 -= task.wait()
	end
end

function t1.Add(_: {[any]: any}, p2)
	table.insert(t2, p2)

	local thread = task.spawn(triggerResyncFor, p2, 1)

	return function()
		if coroutine.status(thread) == "suspended" then
			pcall(task.cancel, thread)
		end

		local v19 = table.find(t2, p2)

		if v19 then
			table.remove(t2, v19)
		end
	end
end

Timer.Simple(1, function()
	local elapsed = os.clock()

	for _, v17 in t2 do
		local v18 = elapsed % v17.Length

		if math.abs(v18 - v17.TimePosition) > 0.05 or v17.Length == 0 then
			v17.TimePosition = v18
		end
	end
end)

return t1
