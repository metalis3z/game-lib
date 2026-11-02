return function(a, b, t)
	return NumberRange.new(
		(b.Min - a.Min)*t + a.Min,
		(b.Max - a.Max)*t + a.Max
	)
end