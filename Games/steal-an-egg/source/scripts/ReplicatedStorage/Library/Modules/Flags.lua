-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
t.__type = "BitmaskFlag"
function t.new(...) --[[ new | Line: 9 | Upvalues: t (copy) ]]
	return setmetatable({
		Value = bit32.bor(...)
	}, t)
end
function t.__call(p1) --[[ __call | Line: 14 ]]
	return p1.Value
end
function t.Get(p1) --[[ Get | Line: 18 ]]
	return p1.Value
end
function t.Set(p1, ...) --[[ Set | Line: 22 ]]
	p1.Value = bit32.bor(...)
end
function t.Copy(p1, p2) --[[ Copy | Line: 26 ]]
	p1.Value = p2.Value
end
function t.Add(p1, ...) --[[ Add | Line: 30 ]]
	p1.Value = bit32.bor(p1.Value, ...)
end
function t.Has(p1, ...) --[[ Has | Line: 34 ]]
	local v1 = bit32.bor(...)

	return bit32.btest(p1.Value, v1)
end
function t.Remove(p1, ...) --[[ Remove | Line: 39 ]]
	local v2 = bit32.bnot((bit32.bor(...)))

	p1.Value = bit32.band(p1.Value, v2)
end
function t.Band(p1, ...) --[[ Band | Line: 45 ]]
	p1.Value = bit32.band(p1.Value, ...)
end
function t.Clear(p1) --[[ Clear | Line: 49 ]]
	p1.Value = 0
end

return t