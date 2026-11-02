-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TypeMarshaller, time of decompilation: Sun May  3 10:09:20 2026 ]]
local _typeof = typeof

return function(p1) --[[ typeof ]] -- line: 5
	-- upvalues: _typeof (copy)
	local v3 = _typeof(p1)

	if v3 ~= "table" then
		return v3
	end

	local mt = getmetatable(p1)

	if _typeof(mt) ~= "table" then
		return v3
	end

	local __type = mt.__type

	if __type == nil then
		return v3
	end

	return __type
end
