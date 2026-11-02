-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new() --[[ new | Line: 4 | Upvalues: t (copy) ]]
	return setmetatable({
		_first = 0,
		_last = -1,
		_queue = {}
	}, t)
end
function t.isEmpty(p1) --[[ isEmpty | Line: 12 ]]
	return p1._first > p1._last
end
function t.enqueue(p1, p2) --[[ enqueue | Line: 16 ]]
	local v1 = p1._last + 1

	p1._last = v1
	p1._queue[v1] = p2
end
function t.dequeue(p1) --[[ dequeue | Line: 22 ]]
	if not p1:isEmpty() then
		local v1, v2

		v1 = p1._first
		v2 = p1._queue[v1]
		p1._queue[v1] = nil
		p1._first = v1 + 1

		return v2
	end

	error("Cannot dequeue from empty queue")
end

return t