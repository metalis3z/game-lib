--credit to leon games studio
local v1 = nil
local t = {}
local t2 = {}

t.Type = "Task"
function t.Spawn(p1, p2, ...) --[[ Spawn | Line: 22 | Upvalues: t2 (copy), v1 (ref) ]]
	local v12 = task.spawn

	return v12(table.remove(t2) or task.spawn(v1), p2, ...)
end
function t.Defer(p1, p2, ...) --[[ Defer | Line: 26 | Upvalues: t2 (copy), v1 (ref) ]]
	local defer = task.defer

	return defer(table.remove(t2) or task.spawn(v1), p2, ...)
end
function t.Delay(p1, p2, p3, ...) --[[ Delay | Line: 30 | Upvalues: t2 (copy), v1 (ref) ]]
	local v12 = task.delay

	return v12(p2, table.remove(t2) or task.spawn(v1), p3, ...)
end

local function Call(p1, ...) --[[ Call | Line: 36 | Upvalues: t2 (copy) ]]
	p1(...)
	table.insert(t2, coroutine.running())
end

v1 = function() --[[ Thread | Line: 41 | Upvalues: Call (ref) ]]
	while true do
		Call(coroutine.yield())
	end
end

return t