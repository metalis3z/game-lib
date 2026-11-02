local sin = math.sin
local pi = math.pi

return function(a, f)
	return sin(sin(a*pi*(f or 1))*pi/2)
end