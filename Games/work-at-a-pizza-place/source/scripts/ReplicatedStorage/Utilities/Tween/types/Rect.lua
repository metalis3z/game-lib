local rnew = Rect.new

return function(a, b, t)
	local min = (b.Min - a.Min)*t + a.Min
	local max = (b.Max - a.Max)*t + a.Max
	
	return rnew(min.x, min.y, max.x, max.y)
end