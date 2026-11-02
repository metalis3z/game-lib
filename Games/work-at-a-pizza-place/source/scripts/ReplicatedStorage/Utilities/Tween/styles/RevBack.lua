local sin = math.sin
local cos = math.cos
local pi = math.pi

return function(a, f)
	a = 1-a
	a = sin(a*pi/2) + (sin(a*pi) * (cos(a*pi)+1)/2)*(f or 1)
	a = 1-a
	return a
end