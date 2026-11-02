-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, ...) --[[ Line: 3 ]]
	local v1 = nil
	local v2 = nil
	local v3 = table.pack(xpcall(p1, function(p1) --[[ Line: 7 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = tostring(p1)
		v2 = tostring(debug.traceback(nil, 3))
	end, ...))
	local v4 = v3[1]

	if v4 then
		return v4, table.unpack(v3, 2)
	end

	warn(string.format("Error: %s\nStack Begin\n%s\nStack End", tostring(v1), (tostring(v2))))

	return false, v1
end