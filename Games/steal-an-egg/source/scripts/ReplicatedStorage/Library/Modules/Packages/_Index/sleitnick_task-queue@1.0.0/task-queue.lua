-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 37 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._queue = {}
	v2._flushing = false
	v2._scheduled = nil
	v2._onFlush = p1

	return v2
end
function t.Add(p1, p2) --[[ Add | Line: 52 ]]
	table.insert(p1._queue, p2)

	if p1._scheduled ~= nil then
		return
	end

	p1._scheduled = task.defer(function() --[[ Line: 56 | Upvalues: p1 (copy) ]]
		p1._flushing = true
		p1._onFlush(p1._queue)
		table.clear(p1._queue)
		p1._flushing = false
		p1._scheduled = nil
	end)
end
function t.Clear(p1) --[[ Clear | Line: 77 ]]
	if p1._flushing then
		return
	end

	if p1._scheduled ~= nil then
		task.cancel(p1._scheduled)
		p1._scheduled = nil
	end

	table.clear(p1._queue)
end
function t.Destroy(p1) --[[ Destroy | Line: 93 ]]
	p1:Clear()
end

return t