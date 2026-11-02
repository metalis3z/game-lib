return function(a, b, t)
	local colors = {}
	for i=1, #a.Keypoints do
		local color = Color3.new(
			(b[i].r-a[i].r)*t + a[i].r,
			(b[i].g-a[i].g)*t + a[i].g,
			(b[i].b-a[i].b)*t + a[i].b
		)
		colors[i] = color
	end
	return ColorSequence.new(colors[1], colors[2])
end