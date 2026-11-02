

local v1 = newproxy(true)

getmetatable(v1).__tostring = function()
	return "Freeze.None"
end

return v1
