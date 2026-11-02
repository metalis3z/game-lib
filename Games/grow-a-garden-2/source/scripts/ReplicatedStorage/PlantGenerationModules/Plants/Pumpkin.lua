--credit to leon games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 5
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		Random.new(p2)

		local Base = p1.Base
		local v1 = 3 * (p3 or 1)
		local v2 = script.Main:Clone()

		v2.Size = Vector3.new(v1, v1, v1)
		v2.CFrame = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2 + v2.Size.Y / 2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
		v2.Parent = p1

		local v3 = v1 * 0.15
		local v4 = v2.CFrame * CFrame.new(0, v2.Size.Y / 2, 0)
		local t = { v4 }
		local v5 = v3 * 1.2
		local t2 = {}
		local count = 1

		for i = 1, 8 do
			local v6 = v4 * CFrame.Angles(0, 0, 0.20943951023931956)
			local v7 = v6 * CFrame.new(0, v5 / 2, 0)
			local v8 = script.Stem:Clone()

			v8.Size = Vector3.new(v3, v5, v3)
			v8.CFrame = v7
			v8:SetAttribute("GrowUp", true)
			v8.Parent = p1
			table.insert(t2, v8)
			v4 = v6 * CFrame.new(0, v5, 0)
			table.insert(t, v4)
		end

		for j = #t2, 1, -1 do
			t2[j].Name = tostring(count)
			count = count + 1
		end

		local v9 = v1 * 0.03
		local t3 = { 1, -1, 1 }
		local t4 = { 25, -20, 30 }
		local v10 = v1 * 0.25

		for i, v in ipairs({ 3, 5, 7 }) do
			if t[v] then
				local v11 = t3[i]
				local v12 = t4[i]
				local v13 = v10 * (1 - (i - 1) * 0.15)
				local v14 = script.Stem:Clone()

				v14.Size = Vector3.new(v13, v9, v13)
				v14.CFrame = t[v] * CFrame.new(v13 * 0.5 * v11, 0, v9 * 2) * CFrame.Angles(math.rad(v12), 0, (math.rad(v12 * v11)))
				v14:SetAttribute("GrowUp", true)
				v14.Name = tostring(count)
				v14.Parent = p1
				count = count + 1
			end
		end

		local v15 = v3 * 0.95
		local t5 = {}
		local v16 = v1 * 0.07

		for k = 0, 28 do
			local v17 = k / 28
			local v18 = v2.CFrame * CFrame.new(0, v2.Size.Y / 2, 0)
			local v19 = v17 * 8

			for n = 1, math.floor(v19) do
				v18 = v18 * CFrame.Angles(0, 0, 0.20943951023931956) * CFrame.new(0, v5, 0)
			end

			local v20 = v19 - math.floor(v19)
			local v21 = v18 * CFrame.Angles(0, 0, v20 * 0.20943951023931956) * CFrame.new(0, v5 * v20, 0)
			local v22 = v17 * math.pi * 2 * 1.5

			table.insert(t5, v21 * CFrame.new(math.cos(v22) * v15, 0, math.sin(v22) * v15))
		end

		for m = 1, #t5 - 1 do
			local Position = t5[m].Position
			local Position2 = t5[m + 1].Position
			local Magnitude = (Position2 - Position).Magnitude
			local v26 = CFrame.lookAt(Position, Position + (Position2 - Position).Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
			local v27 = script.Stem:Clone()

			v27.Size = Vector3.new(v16, Magnitude, v16)
			v27.CFrame = v26 * CFrame.new(0, Magnitude / 2, 0)
			v27:SetAttribute("GrowUp", true)
			v27.Name = tostring(count)
			v27.Parent = p1
			count = count + 1
		end

		v2.Name = tostring(count)
		v2.CFrame = v2.CFrame * CFrame.Angles(0, math.pi, 0)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 126 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 142 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				local v6 = v5[1]
				local v7 = v5[2]
				local v8 = v5[3]
				local v10 = math.min((v3 - v5[4] / v2) * v2, 1)

				if v10 > 0 then
					v6.Size = Vector3.new(v7.X, v7.Y * v10, v7.Z)
					v6.CFrame = PrimaryPart.CFrame * v8 * CFrame.new(0, if v6:GetAttribute("GrowUp") then (v7.Y - v6.Size.Y) / 2 else (v6.Size.Y - v7.Y) / 2, 0)
					v6.Transparency = v6:GetAttribute("OG_Transparency") or 0
					v6.CanCollide = true

					if v6:FindFirstChild("Decal") and v10 >= 1 then
						for v13, v14 in v6:GetChildren() do
							if v14:IsA("Decal") then
								v14.Transparency = 0.4
							end
						end
					end

					continue
				end

				v6.Transparency = 1
				v6.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end
}