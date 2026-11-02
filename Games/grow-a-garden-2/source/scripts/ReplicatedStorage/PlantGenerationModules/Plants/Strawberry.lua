--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = math.round((p3 or 1) * 10) * 0.1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local v3 = Color3.new(0, 0.666667, 0)

		Color3.new(0.368627, 0.784314, 0.254902)

		local sum = v2:NextInteger(1, 2)
		local v4 = 1

		while v2:NextInteger(1, 3) == 1 do
			sum = sum + 1
		end

		if v2:NextInteger(1, 100) == 1 then
			sum = sum + v2:NextInteger(13, 15)
		end

		local v5 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local Size = Base.Size

		for i = 1, sum do
			local v6 = 0.25 * v1
			local v7 = 1.5 * v1
			local v8 = Stud_Part:Clone()

			v8.Color = v3
			v8.Name = tostring(v4)
			v8.Size = Vector3.new(v6, v7, v6)
			v8.CFrame = v5 * CFrame.new(0, v8.Size.Y / 2, 0)
			v8.CFrame = v8.CFrame * CFrame.Angles(math.rad((v2:NextInteger(-15, 15))), math.rad((v2:NextInteger(-15, 15))), (math.rad((v2:NextInteger(-15, 15)))))
			v8.CFrame = v8.CFrame * CFrame.new(0, Size.Y / 2, 0)
			v8.CFrame = v8.CFrame * CFrame.Angles(0, math.rad(i * 5), 0)
			v8.Parent = p1

			local v15 = v4 + 1
			local v16 = Stud_Part:Clone()

			v16.Color = v3
			v16.Name = tostring(v15)
			v16.Size = Vector3.new(v6 * 0.85, v2:NextNumber(v7 / 4, v7 / 3.3), v6 * 0.85)
			v16.CFrame = v8.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
			v16.CFrame = v16.CFrame * CFrame.Angles(math.rad((v2:NextInteger(-15, 15))), math.rad((v2:NextInteger(-15, 15))), (math.rad((v2:NextInteger(-15, 15)))))
			v16.CFrame = v16.CFrame * CFrame.new(0, v16.Size.Y / 2 + v8.Size.X / 2, 0)
			v16.Parent = p1

			local v24 = Stud_Part:Clone()

			v24.Size = Vector3.new(1, 1, 1)
			v24.Parent = FruitSpawnLocations
			v24.CFrame = v16.CFrame * CFrame.new(0, v16.Size.Y / 2, 0)
			v24.Transparency = 1

			local v25 = v15 + 1
			local v26 = Stud_Part:Clone()

			v26.Color = v3
			v26.Name = tostring(v25)
			v26.Size = Vector3.new(v6 * 0.85, v2:NextNumber(v7 / 4, v7 / 3.3), v6 * 0.85)
			v26.CFrame = v8.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
			v26.CFrame = v26.CFrame * CFrame.Angles(math.rad((v2:NextInteger(-15, 15))), math.rad((v2:NextInteger(-15, 15))), (math.rad((v2:NextInteger(-15, 15)))))
			v26.CFrame = v26.CFrame * CFrame.new(0, v26.Size.Y / 2 + v8.Size.X / 2, 0)
			v26.Parent = p1

			local v34 = Stud_Part:Clone()

			v34.Size = Vector3.new(1, 1, 1)
			v34.Parent = FruitSpawnLocations
			v34.CFrame = v26.CFrame * CFrame.new(0, v26.Size.Y / 2, 0)
			v34.Transparency = 1

			local v35 = script.Leaves:Clone()

			v35:PivotTo(v8.CFrame * CFrame.new(0, v8.Size.Y / 2, 0))
			v35:ScaleTo(v1)
			v35.PrimaryPart:Destroy()
			v4 = v25 + 1

			for k, v in pairs(v35:GetChildren()) do
				v.Parent = p1
				v.Name = tostring(v4)
			end

			v5 = v8.CFrame
			Size = v8.Size
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 109 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 127 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.min(v1 - v3[4], 1)

				if v8 > 0 then
					v4.Size = Vector3.new(v5.X, v5.Y * v8, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(0, (v4.Size.Y - v5.Y) / 2, 0)
					v4.Transparency = v4:GetAttribute("OG_Transparency") or 0
					v4.CanCollide = true

					continue
				end

				v4.Transparency = 1
				v4.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}