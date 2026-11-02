local sin = math.sin
local pi = math.pi

return function(a, f, f2)
	return sin(a*pi*(f or 1))^(f2 or 1)
end