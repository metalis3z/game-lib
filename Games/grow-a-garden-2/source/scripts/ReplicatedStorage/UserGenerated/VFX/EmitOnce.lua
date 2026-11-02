--credit to quartz games studio
return function(p1) --[[ EmitOnce | Line: 20 ]]
	local TimeScale = p1.TimeScale

	if TimeScale <= 0 then
		return 0
	end

	local Rate = p1.Rate
	local v1 = p1:GetAttribute("EmitCount")

	if type(v1) == "number" then
		Rate = v1
	end

	local count = math.floor(Rate)
	local v3 = Rate - count

	if v3 > 0 and math.random() < v3 then
		count = count + 1
	end

	if count < 1 then
		return 0
	end

	local v4 = p1:GetAttribute("EmitDelay")
	local v5 = if type(v4) == "number" then v4 else 0

	if v5 == (1 / 0) then
		return 0
	end

	local v6 = math.max(v5, 0)

	task.delay(v6, function() --[[ Line: 53 | Upvalues: p1 (copy), count (ref) ]]
		p1:Emit(count)
	end)

	return v6 + p1.Lifetime.Max / TimeScale
end