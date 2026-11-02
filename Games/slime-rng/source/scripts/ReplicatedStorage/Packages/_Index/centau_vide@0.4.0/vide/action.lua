-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: action, time of decompilation: Sun May  3 10:09:36 2026 ]]
local v1 = table.freeze({})

local function is_action(p1) -- line: 8
	-- upvalues: v1 (copy)
	return getmetatable(p1) == v1
end
local function action(p2: ((...any) -> ...any), n1: number?) -- line: 12
	-- upvalues: v1 (copy)
	local t1 = {
		priority = n1 or 1,
		callback = p2
	}

	setmetatable(t1, v1)

	return table.freeze(t1)
end

return function() -- line: 23
	-- upvalues: action (copy), is_action (copy)
	return action, is_action
end
