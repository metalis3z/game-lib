local t = {
	Round = function(p1, p2) --[[ Round | Line: 3 ]]
		return math.floor(p1 + 0.5)
	end
}
local v1 = Random.new()

function t.BreakInPieces(p1, p2) --[[ BreakInPieces | Line: 9 | Upvalues: v1 (copy) ]]
	local v12 = if p2 then p2 else v1:NextInteger(2, 4)

	if p1 < v12 then
		return { p1 }
	end

	local t, v2 = {}, v12

	while #t < v2 - 1 do
		local v3 = v1:NextInteger(1, (math.floor(p1 / v2)))

		t[#t + 1] = v3
		p1 = p1 - v3
	end

	t[#t + 1] = p1

	return t
end
function t.EvalNumberSequence(p1, p2) --[[ EvalNumberSequence | Line: 23 ]]
	if p2 == 0 then
		return p1.Keypoints[1].Value
	end

	if p2 == 1 then
		return p1.Keypoints[#p1.Keypoints].Value
	end

	for i = 1, #p1.Keypoints - 1 do
		local v1 = p1.Keypoints[i]
		local v2 = p1.Keypoints[i + 1]

		if v1.Time <= p2 and p2 < v2.Time then
			return v1.Value + (v2.Value - v1.Value) * ((p2 - v1.Time) / (v2.Time - v1.Time))
		end
	end
end

return t