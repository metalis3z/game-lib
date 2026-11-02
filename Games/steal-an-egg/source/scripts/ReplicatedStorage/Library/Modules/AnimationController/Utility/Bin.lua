-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	RBXScriptConnection = function(p1) --[[ Line: 2 ]]
		p1:Disconnect()
	end,
	Instance = function(p1) --[[ Line: 5 ]]
		p1:Destroy()
	end,
	table = function(p1) --[[ Line: 8 ]]
		if p1.__gc then
			p1.__gc(p1)
		end

		table.clear(p1)
		pcall(setmetatable, p1, nil)
	end,
	number = function(p1) --[[ Line: 15 ]] end,
	string = function(p1) --[[ Line: 18 ]] end,
	["function"] = function(p1) --[[ Line: 22 ]]
		task.spawn(p1)
	end,
	thread = function(p1) --[[ Line: 25 ]]
		task.cancel(p1)
	end
}
local t2 = {}
local t3 = {
	__index = t2
}

function t2.Add(p1, ...) --[[ Add | Line: 33 ]]
	local t = { ... }

	table.move(t, 1, #t, #p1._trash + 1, p1._trash)
end
function t2.Remove(p1, ...) --[[ Remove | Line: 38 ]]
	for v1, v2 in { ... } do
		local v3 = table.find(p1._trash, v2)

		if v3 then
			table.remove(p1._trash, v3)
		end
	end
end
function t2.Clear(p1) --[[ Clear | Line: 47 | Upvalues: t (copy) ]]
	for v1, v2 in p1._trash do
		local v3 = t[typeof(v2)]

		if v3 then
			v3(v2)
		end
	end

	table.clear(p1._trash)
end

return {
	new = function() --[[ new | Line: 59 | Upvalues: t3 (copy) ]]
		return setmetatable({
			_trash = {}
		}, t3)
	end,
	schedule = function(p1, p2) --[[ schedule | Line: 65 | Upvalues: t (copy) ]]
		local v1 = t[typeof(p1)]

		if v1 then
			task.delay(p2, v1, p1)
		end
	end
}