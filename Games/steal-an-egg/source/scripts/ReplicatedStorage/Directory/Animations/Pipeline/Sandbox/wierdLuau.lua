-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	foo = function() --[[ foo | Line: 15 ]]
		return "test foo"
	end
}

function t.new() --[[ new | Line: 19 | Upvalues: t (copy) ]]
	return setmetatable({
		_privateTest = "private test"
	}, {
		__index = t
	})
end

local v1 = t.new()

function v1.eatRocks(p1) --[[ eatRocks | Line: 41 ]]
	return ""
end
function v1.die(p1) --[[ die | Line: 45 ]]
	return true
end

return v1