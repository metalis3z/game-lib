local r3new = Region3int16.new
local v3new = Vector3int16.new

return function(a, b, t)
	local imin = (b.Min - a.Min)*t + a.Min
	local imax = (b.Max - a.Max)*t + a.Max
	local min = v3new(
		imin.x < imax.x and imin.x or imax.x,
		imin.y < imax.y and imin.y or imax.y,
		imin.z < imax.z and imin.z or imax.z
	)
	local max = v3new(
		imin.x > imax.x and imin.x or imax.x,
		imin.y > imax.y and imin.y or imax.y,
		imin.z > imax.z and imin.z or imax.z
	)
	
	return r3new(
		min,
		max
	)
end