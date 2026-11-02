local sin = math.sin
local pi = math.pi

return function(a, f)
	return sin(a*pi)^(f or 1)
end