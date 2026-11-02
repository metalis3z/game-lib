-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CustomLerp, time of decompilation: Sun May  3 10:09:16 2026 ]]
local t1 = {
	Lerp = function(p1, p2, p3) -- line: 11
		if typeof(p1) == "CFrame" then
			return p1:Lerp(p2, p3)
		end

		return p1 + (p2 - p1) * p3
	end
}

function t1.Constant(p4, p5, _, p7) -- line: 19
	-- upvalues: t1 (copy)
	local n1 = nil

	if p7 == "In" or p7 == nil then
		n1 = 0
	elseif p7 == "Out" then
		n1 = 1
	elseif p7 == "InOut" or p7 == "OutIn" then
		n1 = 0.5
	end

	return t1.Lerp(p4, p5, n1)
end
function t1.Quad(p8, p9, p10, p11) -- line: 31
	-- upvalues: t1 (copy)
	local v14 = nil

	if p11 == "In" or p11 == nil then
		v14 = p10 ^ 2
	elseif p11 == "Out" then
		v14 = -(p10 - 1) ^ 2 + 1
	elseif p11 == "InOut" then
		if p10 <= 0.5 then
			v14 = 2 * p10 ^ 2
		elseif p10 <= 1 then
			v14 = -2 * (p10 - 1) ^ 2 + 1
		end
	elseif p11 == "OutIn" then
		if p10 <= 0.5 then
			v14 = -2 * (p10 - 0.5) ^ 2 + 0.5
		elseif p10 <= 1 then
			v14 = 2 * (p10 - 0.5) ^ 2 + 0.5
		end
	end

	return t1.Lerp(p8, p9, v14)
end
function t1.Sine(p12, p13, p14, p15) -- line: 53
	-- upvalues: t1 (copy)
	local v19 = nil

	if p15 == "In" or p15 == nil then
		v19 = math.sin(1.5707963267948966 * p14 - 1.5707963267948966) + 1
	elseif p15 == "Out" then
		v19 = math.sin(1.5707963267948966 * p14)
	elseif p15 == "InOut" then
		v19 = math.sin(3.141592653589793 * p14 - 1.5707963267948966) * 0.5 + 0.5
	elseif p15 == "OutIn" then
		if p14 <= 0.5 then
			v19 = math.sin(3.141592653589793 * p14) * 0.5
		elseif p14 <= 1 then
			v19 = math.sin(3.141592653589793 * p14 - 3.141592653589793) * 0.5 + 1
		end
	end

	return t1.Lerp(p12, p13, v19)
end
function t1.Quint(p16, p17, p18, p19) -- line: 71
	-- upvalues: t1 (copy)
	local v24 = nil

	if p19 == "In" or p19 == nil then
		v24 = p18 ^ 5
	elseif p19 == "Out" then
		v24 = (p18 - 1) ^ 5 + 1
	elseif p19 == "InOut" then
		if p18 <= 0.5 then
			v24 = 16 * p18 ^ 5
		elseif p18 <= 1 then
			v24 = 16 * (p18 - 1) ^ 5 + 1
		end
	elseif p19 == "OutIn" then
		v24 = 16 * (p18 - 0.5) ^ 5 + 0.5
	end

	return t1.Lerp(p16, p17, v24)
end
function t1.Quart(p20, p21, p22, p23) -- line: 89
	-- upvalues: t1 (copy)
	local v29 = nil

	if p23 == "In" or p23 == nil then
		v29 = p22 ^ 4
	elseif p23 == "Out" then
		v29 = -(p22 - 1) ^ 4 + 1
	elseif p23 == "InOut" then
		if p22 <= 0.5 then
			v29 = 8 * p22 ^ 4
		elseif p22 <= 1 then
			v29 = -8 * (p22 - 1) ^ 4 + 1
		end
	elseif p23 == "OutIn" then
		if p22 <= 0.5 then
			v29 = -8 * (p22 - 0.5) ^ 4 + 0.5
		elseif p22 <= 1 then
			v29 = 8 * (p22 - 0.5) ^ 4 + 0.5
		end
	end

	return t1.Lerp(p20, p21, v29)
end
function t1.Cubic(p24, p25, p26, p27) -- line: 111
	-- upvalues: t1 (copy)
	local v34 = nil

	if p27 == "In" or p27 == nil then
		v34 = p26 ^ 3
	elseif p27 == "Out" then
		v34 = (p26 - 1) ^ 3 + 1
	elseif p27 == "InOut" then
		if p26 <= 0.5 then
			v34 = 4 * p26 ^ 3
		elseif p26 <= 1 then
			v34 = 4 * (p26 - 1) ^ 3 + 1
		end
	elseif p27 == "OutIn" then
		v34 = 4 * (p26 - 0.5) ^ 3 + 0.5
	end

	return t1.Lerp(p24, p25, v34)
end
function t1.Back(p28, p29, p30, p31, p32) -- line: 129
	-- upvalues: t1 (copy)
	local v40 = nil

	if p32 ~= "In" then
		if p32 == "Out" then
			v40 = (p30 - 1) ^ 2 * ((p30 - 1) * (p31 + 1) + p31) + 1
		elseif p32 == "InOut" then
			if p30 <= 0.5 then
				v40 = 2 * p30 * p30 * (2 * p30 * (p31 + 1) - p31)
			elseif p30 <= 1 then
				v40 = 0.5 * (2 * p30 - 2) ^ 2 * ((2 * p30 - 2) * (p31 + 1) + p31) + 1
			end
		elseif p32 == "OutIn" then
			if p30 <= 0.5 then
				v40 = 0.5 * (2 * p30 - 1) ^ 2 * ((2 * p30 - 1) * (p31 + 1) + p31) + 0.5
			elseif p30 <= 1 then
				v40 = 0.5 * (2 * p30 - 1) ^ 2 * ((2 * p30 - 1) * (p31 + 1) - p31) + 0.5
			end
		end
	else
		v40 = p30 * p30 * (p30 * (p31 + 1) - p31)
	end

	return t1.Lerp(p28, p29, v40)
end
function t1.Circular(p33, p34, p35, p36) -- line: 151
	-- upvalues: t1 (copy)
	local v45 = nil

	if p36 == "In" or p36 == nil then
		v45 = -math.sqrt(1 - p35 ^ 2) + 1
	elseif p36 == "Out" then
		v45 = math.sqrt(-(p35 - 1) ^ 2 + 1)
	elseif p36 == "InOut" then
		if p35 <= 0.5 then
			v45 = -math.sqrt(-p35 ^ 2 + 0.25) + 0.5
		elseif p35 <= 1 then
			v45 = math.sqrt(-(p35 - 1) ^ 2 + 0.25) + 0.5
		end
	elseif p36 == "OutIn" then
		if p35 <= 0.5 then
			v45 = math.sqrt(-(p35 - 0.5) ^ 2 + 0.25)
		elseif p35 <= 1 then
			v45 = -math.sqrt(-(p35 - 0.5) ^ 2 + 0.25) + 1
		end
	end

	return t1.Lerp(p33, p34, v45)
end
function t1.Elastic(p37, p38, p39, p40, p41) -- line: 173
	-- upvalues: t1 (copy)
	local v51 = nil

	if p41 == "In" or p41 == nil then
		v51 = -2 ^ (10 * (p39 - 1)) * math.sin(6.283185307179586 * (p39 - 1 - p40 / 4) / p40)
	elseif p41 == "Out" then
		v51 = 2 ^ (-10 * p39) * math.sin(6.283185307179586 * (p39 - p40 / 4) / p40) + 1
	elseif p41 == "InOut" then
		local v52 = math.sin(6.283185307179586 * (2 * p39 - 1.1125) / p40)

		if p39 <= 0.5 then
			v51 = -0.5 * 2 ^ (20 * p39 - 10) * v52
		elseif p39 <= 1 then
			v51 = 0.5 * 2 ^ (-20 * p39 + 10) * v52 + 1
		end
	elseif p41 == "OutIn" then
		if p39 <= 0.5 then
			v51 = 0.5 * 2 ^ (-20 * p39) * math.sin(6.283185307179586 * (2 * p39 - p40 / 4) / p40) + 0.5
		elseif p39 <= 1 then
			v51 = -0.5 * 2 ^ (10 * (2 * p39 - 2)) * math.sin(6.283185307179586 * (2 * p39 - 2 - p40 / 4) / p40) + 0.5
		end
	end

	return t1.Lerp(p37, p38, v51)
end
function t1.Exponential(p42, p43, p44, p45) -- line: 196
	-- upvalues: t1 (copy)
	local v57 = nil

	if p45 == "In" or p45 == nil then
		v57 = 2 ^ (10 * p44 - 10) - 0.001
	elseif p45 == "Out" then
		v57 = 1.001 * -2 ^ (-10 * p44) + 1
	elseif p45 == "InOut" then
		if p44 <= 0.5 then
			v57 = 0.5 * 2 ^ (20 * p44 - 10) - 0.0005
		elseif p44 <= 1 then
			v57 = 0.50025 * -2 ^ (-20 * p44 + 10) + 1
		end
	elseif p45 == "OutIn" then
		if p44 <= 0.5 then
			v57 = 0.5005 * -2 ^ (-20 * p44) + 0.5005
		elseif p44 <= 1 then
			v57 = 0.5 * 2 ^ (10 * (2 * p44 - 2)) + 0.4995
		end
	end

	return t1.Lerp(p42, p43, v57)
end
function t1.Bounce(p46, p47, p48, p49) -- line: 218
	-- upvalues: t1 (copy)
	local v62 = nil

	if p49 == "In" or p49 == nil then
		if p48 <= 0.36363636363636365 then
			v62 = 7.5625 * p48 * p48
		elseif p48 <= 0.7272727272727273 then
			v62 = 7.5625 * (p48 - 0.5454545454545454) ^ 2 + 0.75
		elseif p48 <= 0.9090909090909091 then
			v62 = 7.5625 * (p48 - 0.8181818181818182) ^ 2 + 0.9375
		elseif p48 <= 1 then
			v62 = 7.5625 * (p48 - 0.9545454545454546) ^ 2 + 0.984375
		end
	elseif p49 == "Out" then
		if p48 <= 0.09090909090909091 then
			v62 = -7.5625 * (1 - p48 - 0.9545454545454546) ^ 2 + 0.015625
		elseif p48 <= 0.2727272727272727 then
			v62 = -7.5625 * (1 - p48 - 0.8181818181818182) ^ 2 + 0.0625
		elseif p48 <= 0.6363636363636364 then
			v62 = -7.5625 * (1 - p48 - 0.5454545454545454) ^ 2 + 0.25
		elseif p48 <= 1 then
			v62 = 1 - 7.5625 * (1 - p48) ^ 2
		end
	elseif p49 == "InOut" then
		if p48 <= 0.045454545454545456 then
			v62 = 0.5 * (-7.5625 * (1 - 2 * p48 - 0.9545454545454546) ^ 2 + 0.015625)
		elseif p48 <= 0.13636363636363635 then
			v62 = 0.5 * (-7.5625 * (1 - 2 * p48 - 0.9545454545454546) ^ 2 + 0.0625)
		elseif p48 <= 0.3181818181818182 then
			v62 = 0.5 * (-7.5625 * (1 - 2 * p48 - 0.5454545454545454) ^ 2 + 0.25)
		elseif p48 <= 0.5 then
			v62 = 0.5 * (1 - 7.5625 * (1 - 2 * p48) ^ 2)
		elseif p48 <= 0.6818181818181818 then
			v62 = 0.5 + 3.78125 * (2 * p48 - 1) ^ 2
		elseif p48 <= 0.8636363636363636 then
			v62 = 3.78125 * (2 * p48 - 1.5454545454545454) ^ 2 + 0.875
		elseif p48 <= 0.9545454545454546 then
			v62 = 3.78125 * (2 * p48 - 1.8181818181818181) ^ 2 + 0.96875
		elseif p48 <= 1 then
			v62 = 3.78125 * (2 * p48 - 1.9545454545454546) ^ 2 + 0.9921875
		end
	elseif p49 == "OutIn" then
		if p48 <= 0.18181818181818182 then
			v62 = 15.125 * p48 * p48
		elseif p48 <= 0.36363636363636365 then
			v62 = 3.78125 * (2 * p48 - 0.5454545454545454) ^ 2 + 0.375
		elseif p48 <= 0.45454545454545453 then
			v62 = 3.78125 * (2 * p48 - 0.8181818181818182) ^ 2 + 0.46875
		elseif p48 <= 0.5 then
			v62 = 3.78125 * (2 * p48 - 0.9545454545454546) ^ 2 + 0.4921875
		elseif p48 <= 0.5454545454545454 then
			v62 = -3.78125 * (2 * p48 - 1.0454545454545454) ^ 2 + 0.5078125
		elseif p48 <= 0.6363636363636364 then
			v62 = -3.78125 * (2 * p48 - 1.1818181818181819) ^ 2 + 0.53125
		elseif p48 <= 0.8181818181818182 then
			v62 = -3.78125 * (2 * p48 - 1.4545454545454546) ^ 2 + 0.625
		elseif p48 <= 1 then
			v62 = -15.125 * (p48 - 1) ^ 2 + 1
		end
	end

	return t1.Lerp(p46, p47, v62)
end
function t1.BezierCurve(p50, p51) -- line: 281
	-- upvalues: t1 (copy)
	if #p51 > 2 then
		local t2 = {}

		for i = 1, #p51 - 1 do
			t2[#t2 + 1] = p51[i]:Lerp(p51[i + 1], p50)
		end

		return t1.BezierCurve(p50, t2)
	end

	return p51[1]:Lerp(p51[2], p50)
end

return t1
