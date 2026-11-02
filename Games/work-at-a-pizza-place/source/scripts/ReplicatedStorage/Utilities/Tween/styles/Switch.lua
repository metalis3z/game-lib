-- Instant switch after a certain point

return function(a, v)
	return a >= (v or 1) and 1 or 0
end