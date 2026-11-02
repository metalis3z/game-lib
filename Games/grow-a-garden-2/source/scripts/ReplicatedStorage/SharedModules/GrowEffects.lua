--credit to prince games studio
local t = {
	SmoothGrow = false,
	GrowTick = 0.25,
	InitialScale = 1
}

function t.GetGrowthScale(p1, p2) --[[ GetGrowthScale | Line: 24 | Upvalues: t (copy) ]]
	local InitialScale = t.InitialScale

	if InitialScale == 1 then
		return 1
	end

	if p2 <= 0 then
		return 1
	end

	return math.lerp(InitialScale, 1, (math.clamp(p1 / p2, 0, 1)))
end
function t.AddDescendantsAtBaseline(p1, p2) --[[ AddDescendantsAtBaseline | Line: 48 ]]
	local v1 = p1:GetScale()

	if math.abs(v1 - 1) < 0.0001 then
		p2()
	else
		p1:ScaleTo(1)
		p2()
		p1:ScaleTo(v1)
	end
end

return table.freeze(t)