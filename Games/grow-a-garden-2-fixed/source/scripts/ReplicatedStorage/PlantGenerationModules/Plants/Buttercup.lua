--credit to leon games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 5
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 8 ]]
		local v1 = Random.new(p2)
		local Stud_Part = script.Stud_Part
		local v2 = p3 or 1
		local v3 = Stud_Part:Clone()

		v3.Color = Color3.new(0, 0.666667, 0)
		v3.Size = Vector3.new(1, v1:NextInteger(2, 3), 1) * v2
		v3.CFrame = p1.Base.CFrame * CFrame.new(0, v3.Size.Y / 2, 0)
		v3.Name = "1"
		v3.Parent = p1

		local v5 = Stud_Part:Clone()

		v5.Color = Color3.new(255/255, 255/255, 0/255)
		v5.Size = Vector3.new(1, 1, 1) * v2
		v5.CFrame = v3.CFrame * CFrame.new(0, v3.Size.Y / 2 + v5.Size.Y / 2, 0)
		v5.Name = "2"
		v5.Parent = p1

		local v6 = Random.new(v1:NextInteger(1, 100000000))
		local v7 = Color3.fromHSV(v6:NextInteger(1, 100) * 0.01, 1, 1)

		if v6:NextInteger(1, 1000) == 1 then
			v7 = Color3.fromHSV(0, 0, 0)
		end

		if v6:NextInteger(1, 1000) == 1 then
			v7 = Color3.fromHSV(0, 0, 1)
		end

		local t = {}
		local v10 = Stud_Part:Clone()

		v10.Color = v7
		v10.Size = Vector3.new(1, 1, 1) * v2
		v10.CFrame = v5.CFrame * CFrame.new(v5.Size.X / 2 + v10.Size.X / 2, 0, 0)
		v10.CFrame = v10.CFrame * CFrame.Angles(0, 0, -1.5707963267948966)
		v10.Name = "3"
		v10.Parent = p1
		table.insert(t, v10)

		local v11 = Stud_Part:Clone()

		v11.Color = v7
		v11.Size = Vector3.new(1, 1, 1) * v2
		v11.CFrame = v5.CFrame * CFrame.new(-(v5.Size.X / 2 + v11.Size.X / 2), 0, 0)
		v11.CFrame = v11.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
		v11.Name = "3"
		v11.Parent = p1
		table.insert(t, v11)

		local v12 = Stud_Part:Clone()

		v12.Color = v7
		v12.Size = Vector3.new(1, 1, 1) * v2
		v12.CFrame = v5.CFrame * CFrame.new(0, 0, -(v5.Size.Z / 2 + v12.Size.Z / 2))
		v12.CFrame = v12.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
		v12.Name = "3"
		v12.Parent = p1
		table.insert(t, v12)

		local v13 = Stud_Part:Clone()

		v13.Color = v7
		v13.Size = Vector3.new(1, 1, 1) * v2
		v13.CFrame = v5.CFrame * CFrame.new(0, 0, v5.Size.Z / 2 + v13.Size.Z / 2)
		v13.CFrame = v13.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
		v13.Name = "3"
		v13.Parent = p1
		table.insert(t, v13)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 79 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 97 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
					v6.CFrame = PrimaryPart.CFrame * v8 * CFrame.new(0, (v6.Size.Y - v7.Y) / 2, 0)
					v6.Transparency = v6:GetAttribute("OG_Transparency") or 0
					v6.CanCollide = true

					if v6:FindFirstChild("Decal") and v10 >= 1 then
						for v12, v13 in v6:GetChildren() do
							if v13:IsA("Decal") then
								v13.Transparency = 0.4
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