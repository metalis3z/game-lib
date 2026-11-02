-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function applyNumberSequence(p1, p2, p3) --[[ applyNumberSequence | Line: 13 ]]
	local t = {}

	for i, v in ipairs(p1.Keypoints) do
		local v1 = v.Value * (1 - p3) + p2 * p3

		table.insert(t, NumberSequenceKeypoint.new(v.Time, v1, (math.min(v.Envelope, (math.max(0, (math.min(v1, 1 - v1))))))))
	end

	return NumberSequence.new(t)
end

return function() --[[ CreateTransparencyModule | Line: 38 | Upvalues: applyNumberSequence (copy) ]]
	local t = {}

	local function handleTransparency(p1, p2) --[[ handleTransparency | Line: 41 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		if not v1 then
			v1 = {}
			t[p1] = v1
		end

		if v1[p2] == nil then
			v1[p2] = p1[p2]
		end

		return v1[p2]
	end

	local function v1(p1, p2, p3, p4) --[[ applyTransparencyToInstance | Line: 55 | Upvalues: t (copy), applyNumberSequence (ref), v1 (copy) ]]
		if p4 and table.find(p4, p1.ClassName) then
			return
		end

		if p1:IsA("BasePart") or (p1:IsA("UIStroke") or (p1:IsA("Texture") or p1:IsA("Decal"))) then
			local v12 = t[p1]

			if not v12 then
				v12 = {}
				t[p1] = v12
			end

			if v12.Transparency == nil then
				v12.Transparency = p1.Transparency
			end

			p1.Transparency = v12.Transparency * (1 - p3) + p2 * p3
		elseif p1:IsA("ParticleEmitter") or (p1:IsA("Trail") or p1:IsA("Beam")) then
			local v2 = t[p1]

			if not v2 then
				v2 = {}
				t[p1] = v2
			end

			if v2.Transparency == nil then
				v2.Transparency = p1.Transparency
			end

			p1.Transparency = applyNumberSequence(v2.Transparency, p2, p3)
		elseif p1:IsA("GuiObject") then
			for k, v in pairs({ "BackgroundTransparency", "TextTransparency", "TextStrokeTransparency", "ImageTransparency" }) do
				pcall(function() --[[ Line: 75 | Upvalues: p1 (copy), v (copy), t (ref), p3 (copy), p2 (copy) ]]
					local v1 = p1
					local v2 = v
					local v3 = t[v1]

					if not v3 then
						v3 = {}
						t[v1] = v3
					end

					if v3[v2] == nil then
						v3[v2] = v1[v2]
					end

					p1[v] = v3[v2] * (1 - p3) + p2 * p3
				end)
			end
		end

		for i, v in ipairs(p1:GetChildren()) do
			v1(v, p2, p3, p4)
		end
	end

	return v1
end