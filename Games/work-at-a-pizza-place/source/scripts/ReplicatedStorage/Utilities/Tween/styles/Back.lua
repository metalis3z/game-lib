local sin = math.sin
local cos = math.cos
local pi = math.pi

return function(a, f)
	return sin(a*pi/2) + (sin(a*pi) * (cos(a*pi)+1)/2)*(f or 1)
end