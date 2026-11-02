return function(a, b, t)
	return UDim2.new(
		(b.X.Scale-a.X.Scale)*t+a.X.Scale,
		(b.X.Offset-a.X.Offset)*t+a.X.Offset,
		(b.Y.Scale-a.Y.Scale)*t+a.Y.Scale,
		(b.Y.Offset-a.Y.Offset)*t+a.Y.Offset
	)
end