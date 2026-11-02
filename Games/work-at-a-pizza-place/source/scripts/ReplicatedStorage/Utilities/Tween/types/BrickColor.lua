return function(a, b, t)
	return BrickColor.new(
		(b.r-a.r)*t + a.r,
		(b.g-a.g)*t + a.g,
		(b.b-a.b)*t + a.b
	)
end