
local observePlayer = require(script.Parent.observePlayer)
local observeCharacter = require(script.Parent.observeCharacter)

local function observeCharacters(p1: ((...any) -> ...any))
	return observePlayer(function(p2)
		return observeCharacter(p2, p1)
	end)
end

return observeCharacters
