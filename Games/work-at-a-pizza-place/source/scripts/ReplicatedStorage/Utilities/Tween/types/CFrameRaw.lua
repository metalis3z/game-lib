return function(a, b, t)
	local arx, ary, arz = a:toEulerAnglesXYZ()
	local brx, bry, brz = b:toEulerAnglesXYZ()
	return CFrame.new(
		(b.p - a.p)*t + a.p
	) * CFrame.Angles(
		(brx-arx)*t + arx,
		(bry-ary)*t + ary,
		(brz-arz)*t + arz
	)
end