--!nonstrict
local None = newproxy(true)
local mt = getmetatable(None)
mt.__tostring = function()
	return "Object.None"
end

return None