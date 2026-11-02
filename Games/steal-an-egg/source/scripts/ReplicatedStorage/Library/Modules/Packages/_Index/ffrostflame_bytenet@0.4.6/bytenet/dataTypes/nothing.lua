-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.types)

local t = {
	write = function() --[[ write | Line: 4 ]] end,
	read = function() --[[ read | Line: 6 ]]
		return nil, 0
	end
}

return function() --[[ Line: 11 | Upvalues: t (copy) ]]
	return t
end