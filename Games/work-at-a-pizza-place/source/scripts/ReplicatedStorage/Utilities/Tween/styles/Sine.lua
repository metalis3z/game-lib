local sin = math.sin
local pi = math.pi

return function(a, f)
	return sin(a*pi/2)^(f or 1)
end