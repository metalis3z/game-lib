--credit to quartz games studio
return {
	HumanFriendlyRound = function(p1) --[[ Line: 2 ]]
		if p1 < 10 then
			return math.floor(p1 + 0.5)
		end

		if p1 < 100 then
			return math.floor(p1 / 5 + 0.5) * 5
		end

		if p1 < 1000 then
			return math.floor(p1 / 25 + 0.5) * 25
		end

		if p1 < 10000 then
			return math.floor(p1 / 100 + 0.5) * 100
		end

		if p1 < 100000 then
			return math.floor(p1 / 500 + 0.5) * 500
		end

		if p1 < 1000000 then
			return math.floor(p1 / 1000 + 0.5) * 1000
		end

		return math.floor(p1 / 5000 + 0.5) * 5000
	end,
	FormatWithCommas = function(p1) --[[ Line: 12 ]]
		local v1, v2, v3 = tostring(p1):match("^([^%d]*)(%d+)(.-)$")

		return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. v3
	end,
	Abbreviate = function(p1, p2) --[[ Line: 19 ]]
		local v2 = math.abs(p1)
		local v3, v4

		if v2 >= 1000000000000000 then
			v3 = p1 / 1000000000000000
			v4 = "Qd"
		elseif v2 >= 1000000000000 then
			v3 = p1 / 1000000000000
			v4 = "T"
		elseif v2 >= 1000000000 then
			v3 = p1 / 1000000000
			v4 = "B"
		elseif v2 >= 1000000 then
			v3 = p1 / 1000000
			v4 = "M"
		else
			if not (v2 >= 1000) then
				return tostring(p1)
			end

			v3 = p1 / 1000
			v4 = "K"
		end

		return string.format(("%%.%*f"):format(p2 or 2), v3):gsub("%.?0+$", "") .. v4
	end,
	Parse = function(p1, p2, p3) --[[ Line: 43 ]]
		local v1 = 0

		if type(p1) == "string" then
			local v2 = p1:lower():gsub("[,%s]", ""):gsub("[^%d%.kmbtqn%-]", "")

			if not v2:find("[i]") then
				local v3, v4

				if v2:find("qi") or v2:find("qn") then
					v3 = v2
					v4 = 1e18
				elseif v2:find("q") then
					v3 = v2
					v4 = 1000000000000000
				elseif v2:find("t") then
					v3 = v2
					v4 = 1000000000000
				elseif v2:find("b") then
					v3 = v2
					v4 = 1000000000
				elseif v2:find("m") then
					v3 = v2
					v4 = 1000000
				elseif v2:find("k") then
					v3 = v2
					v4 = 1000
				else
					v3 = v2
					v4 = 1
				end

				local v5 = v3:gsub("[^%d%.%-]", "")

				if v5 ~= "" and (v5 ~= "." and (v5 ~= "-" and v5 ~= "-.")) then
					v1 = (tonumber(v5) or 0) * v4
				end
			end
		else
			v1 = tonumber(p1) or 0
		end

		if v1 ~= v1 or math.abs(v1) == (1 / 0) then
			v1 = 0
		end

		return (p2 or p3) and math.clamp(v1, p2 or (-1 / 0), p3 or (1 / 0)) or v1
	end
}