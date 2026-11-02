-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: functions, time of decompilation: Sun May  3 10:09:20 2026 ]]
local t2 = {
	AnimateSheet = function(p1, p2, p3, p4, p5, p6, p7, p8, p9) -- line: 13
		local v15 = p6 / p5 * p8
		local v16 = p7 / p5 * p9
		local v17 = p2 + math.floor((p3 - p2) * p4) - 1
		local v18 = math.floor(v17 / p5)
		local v19 = v17 % p5

		for _, v21 in p1 do
			v21.OffsetStudsU = v15 + v19 * (p6 / p5)
			v21.OffsetStudsV = v16 + v18 * (p7 / p5)
		end
	end,
	randomFloat = function(p10, p11) -- line: 36
		return math.random() * (p11 - p10) + p10
	end,
	LerpTransparencyCurveValues = function(p12, p13, p14) -- line: 41
		local t1 = {}

		for v28, v29 in p12 do
			t1[v28] = NumberSequenceKeypoint.new(v29.Time, v29.Value + (p13[v28].Value - v29.Value) * p14)
		end

		return (NumberSequence.new(t1))
	end,
	GetRandomPointOnSphereSurface = function(p15, p16) -- line: 51
		local v32 = math.random()
		local v33 = math.random()
		local v34 = v32 * 2 * 3.141592653589793
		local v35 = math.acos(2 * v33 - 1)

		return p15 + Vector3.new(p16 * math.sin(v35) * math.cos(v34), p16 * math.sin(v35) * math.sin(v34), p16 * math.cos(v35))
	end
}

function t2.GetRandomPointOnPartialSphereSurface(p17, p18, p19) -- line: 65
	-- upvalues: t2 (copy)
	local v39

	repeat
		v39 = t2.GetRandomPointOnSphereSurface(p17, p18)
	until v39.Y >= p17.Y + p19.X and v39.Y <= p17.Y + p19.Y

	return v39
end
function t2.AdjustColorSequenceHue(p20, p21, p22) -- line: 81
	local v49 = math.clamp(p22, 1, #p20.Keypoints)
	local v50 = Color3.toHSV(p20.Keypoints[v49].Value)
	local t3 = {}

	for i, v in ipairs(p20.Keypoints) do
		if i == v49 then
			table.insert(t3, ColorSequenceKeypoint.new(v.Time, p21))
		else
			local v54 = Color3.toHSV(v.Value) - v50
			local v55, v56, v57 = Color3.toHSV(p21)
			local v58 = (v55 + v54) % 1
			local color3 = Color3.fromHSV(v58, v56, v57)

			table.insert(t3, ColorSequenceKeypoint.new(v.Time, color3))
		end
	end

	return ColorSequence.new(t3)
end
function t2.NeonifyColor(p23, p24) -- line: 100
	return Color3.new(p23.R * p24.X, p23.G * p24.Y, p23.B * p24.Z)
end

return t2
