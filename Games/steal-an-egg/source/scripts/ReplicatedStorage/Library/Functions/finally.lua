-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local wcall = require(script.Parent.wcall)

return function(p1, p2, ...) --[[ Line: 3 | Upvalues: wcall (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = table.pack(xpcall(p1, function(p1) --[[ Line: 6 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = tostring(p1)
		v2 = tostring(debug.traceback(nil, 3))
	end, ...))

	if not v3[1] then
		wcall(p2)
		error(("%s\nStack Begin\n%sStack End"):format(v1, v2))
	end

	wcall(p2)

	return table.unpack(v3, 2)
end