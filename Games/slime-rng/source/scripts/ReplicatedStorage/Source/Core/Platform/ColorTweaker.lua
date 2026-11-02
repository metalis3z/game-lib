-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ColorTweaker, time of decompilation: Sun May  3 10:10:52 2026 ]]
local t1 = {
	enums = {
		primaryColors = {
			red = 0,
			yellow = 0.16666666666666666,
			green = 0.3333333333333333,
			cyan = 0.5,
			blue = 0.6666666666666666,
			magenta = 0.8333333333333334,
			master = -1
		}
	}
}

local function tweakColor(color3: Color3, t2: {[any]: any}) -- line: 42
	-- upvalues: t1 (copy)
	local v9, v10, v11 = Color3.toHSV(color3)
	local v12 = true

	if t2.primaryColor ~= t1.enums.primaryColors.master then
		local v13 = math.abs(v9 - t2.primaryColor)

		v12 = math.min(v13, 1 - v13) < (t2.range or 0.16666666666666666)
	end

	if not v12 then
		return color3
	end

	local v14 = if not t2.forcedhue then (v9 + (t2.hue or 0)) % 1 else t2.forcedhue
	local v15 = math.clamp((t2.saturationBoost or 1) * (v10 + (t2.saturation or 0)), 0, 1)
	local v16 = math.clamp((t2.valueBoost or 1) * (v11 + (t2.value or 0)), 0, 1)

	return Color3.fromHSV(v14, v15, v16)
end

function t1.tweakColorSequence(p1, p2) -- line: 59
	-- upvalues: t1 (copy)
	local t3 = {}

	for _, v in ipairs(p1.Keypoints) do
		local v22 = t1.tweak(v.Value, p2)

		table.insert(t3, ColorSequenceKeypoint.new(v.Time, v22))
	end

	return ColorSequence.new(t3)
end
function t1.tweak(color3: Color3, p3) -- line: 69
	-- upvalues: tweakColor (copy)
	if p3[1] then
		for _, v in ipairs(p3) do
			color3 = tweakColor(color3, v)
		end

		return color3
	end

	return (tweakColor(color3, p3))
end
function t1.setInstanceOriginalColor(p4) -- line: 82
	if p4:IsA("BasePart") or (p4:IsA("Light") or p4:IsA("ParticleEmitter") or p4:IsA("Beam")) then
		p4:SetAttribute("OriginalColor", p4.Color)

		return
	end

	if p4:IsA("Decal") then
		p4:SetAttribute("OriginalColor", p4.Color3)

		return
	end

	if p4:IsA("SpecialMesh") then
		local VertexColor = p4.VertexColor

		p4:SetAttribute("OriginalColor", (Color3.new(VertexColor.X, VertexColor.Y, VertexColor.Z)))
	end
end
function t1.fromInstance(p5, p6, b1: boolean?) -- line: 94
	-- upvalues: t1 (copy)
	local v32 = b1 and p5:GetAttribute("OriginalColor")

	if p5:IsA("BasePart") or p5:IsA("Light") then
		p5.Color = t1.tweak(v32 or p5.Color, p6)

		if p5:IsA("UnionOperation") then
			p5.UsePartColor = true

			return
		end
	else
		if p5:IsA("Decal") then
			p5.Color3 = t1.tweak(v32 or p5.Color3, p6)

			return
		end

		if p5:IsA("SpecialMesh") then
			local VertexColor = p5.VertexColor
			local v34 = v32 or Color3.new(VertexColor.X, VertexColor.Y, VertexColor.Z)
			local v35 = t1.tweak(v34, p6)

			p5.VertexColor = Vector3.new(v35.r, v35.g, v35.b)

			return
		end

		if p5:IsA("ParticleEmitter") or p5:IsA("Beam") then
			p5.Color = t1.tweakColorSequence(v32 or p5.Color, p6)
		end
	end
end
function t1.fromContainer(p7, p8, b2: boolean?) -- line: 113
	-- upvalues: t1 (copy)
	for _, v40 in p7:GetDescendants() do
		t1.fromInstance(v40, p8, b2)
	end
end
function t1.setContainerOriginalColor(p9) -- line: 119
	-- upvalues: t1 (copy)
	for _, v43 in p9:GetDescendants() do
		t1.setInstanceOriginalColor(v43)
	end
end

return t1
