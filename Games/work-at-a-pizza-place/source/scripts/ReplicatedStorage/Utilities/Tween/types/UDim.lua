return function(a, b, t)
	return UDim.new(
		(b.Scale-a.Scale)*t + a.Scale,
		(b.Offset-a.Offset)*t + a.Offset
	)
end