local r3new = Region3.new
local v3new = Vector3.new

return function(a, b, t)
	local amin = a.CFrame * (-a.Size/2)
	local amax = a.CFrame * ( a.Size/2)
	local bmin = b.CFrame * (-b.Size/2)
	local bmax = b.CFrame * ( b.Size/2)
	local imin = (bmin - amin)*t + amin
	local imax = (bmax - amax)*t + amax
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