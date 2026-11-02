--credit to prince games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.03,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 13 ]]
		local v1 = Random.new(p2)
		local PrimaryPart = p1.PrimaryPart

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 21 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = (v12 + v1:NextNumber(-v4, v4)) % 1

			return Color3.fromHSV(v5, math.clamp(v2, 0, 1), (math.clamp(v3, 0, 1))), v5, v2, v3
		end

		local v2 = v1:NextNumber(3, 4)

		for i = 1, v2 do
			local v3 = script.Layer1:Clone()
			local v4 = PrimaryPart:GetPivot()
			local v6 = v4 * CFrame.Angles(0, math.rad(360 / v2 * i + v1:NextInteger(-15, 15)), 0)

			v3:PivotTo(v6 * CFrame.Angles(math.rad(177 + v1:NextInteger(-4, 4)), 0, 0))

			local v8 = v3["1"]

			v3:ScaleTo(v1:NextNumber(0.9, 1.1))
			v8.Name = tonumber(v8.Name) + i
			v8.Parent = p1
			v3:Destroy()
		end

		local v10 = v1:NextNumber(4, 5)

		for j = 1, v10 do
			local v11 = script.Layer2:Clone()
			local v12 = PrimaryPart:GetPivot()
			local v14 = v12 * CFrame.Angles(0, math.rad(360 / v10 * j + v1:NextInteger(-15, 15)), 0)

			v11:PivotTo(v14 * CFrame.Angles(math.rad(190 + v1:NextInteger(-4, 4)), 0, 0))

			local v16 = v11["1"]

			v11:ScaleTo(v1:NextNumber(0.9, 1.1))
			v16.Name = tonumber(v16.Name) + j + 1
			v16.Parent = p1
			v11:Destroy()
		end

		local v18 = v1:NextNumber(5, 6)

		for k = 1, v18 do
			local v19 = script.Layer3:Clone()
			local v20 = PrimaryPart:GetPivot()
			local v22 = v20 * CFrame.Angles(0, math.rad(360 / v18 * k + v1:NextInteger(-15, 15)), 0)

			v19:PivotTo(v22 * CFrame.Angles(math.rad(205 + v1:NextInteger(-4, 4)), 0, 0))

			local v24 = v19["1"]

			v19:ScaleTo(v1:NextNumber(0.9, 1.1))
			v24.Name = tonumber(v24.Name) + k + 2
			v24.Parent = p1
			v19:Destroy()
		end

		local v26 = v1:NextNumber(3, 4)

		for n = 1, v26 do
			local v27 = script.Layer4:Clone()
			local v28 = PrimaryPart:GetPivot()
			local v30 = v28 * CFrame.Angles(0, math.rad(360 / v26 * n + v1:NextInteger(-15, 15)), 0)

			v27:PivotTo(v30 * CFrame.Angles(math.rad(236 + v1:NextInteger(-4, 4)), 0, 0))

			local v32 = v27["1"]

			v27:ScaleTo(v1:NextNumber(0.8, 1))
			v32.Name = tonumber(v32.Name) + n + 3
			v32.Parent = p1
			v27:Destroy()
		end

		local v34 = v1:NextNumber(3, 4)

		for m = 1, v34 do
			local v35 = script.Layer5:Clone()
			local v36 = PrimaryPart:GetPivot()
			local v38 = v36 * CFrame.Angles(0, math.rad(360 / v34 * m + v1:NextInteger(-15, 15)), 0)

			v35:PivotTo(v38 * CFrame.Angles(math.rad(255 + v1:NextInteger(-4, 4)), 0, 0))

			local v40 = v35["1"]

			v35:ScaleTo(v1:NextNumber(0.8, 1))
			v40.Name = tonumber(v40.Name) + m + 4
			v40.Parent = p1
			v35:Destroy()
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 117 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local t2 = {}

				for v6, v7 in v2:GetChildren() do
					if v7:IsA("Decal") or v7:IsA("Texture") then
						table.insert(t2, {
							decal = v7,
							originalTransparency = v7.Transparency
						})

						if v5 then
							v7.Transparency = 1
						end
					end
				end

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decals = t2
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 152 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						local v8 = v5.maxSize * v7

						v5.part.Size = v8
						v5.part.CFrame = PrimaryPart.CFrame * v5.centerOffset * CFrame.new(0, -((v5.maxSize.Y - v8.Y) / 2), 0)
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						for v10, v11 in v5.decals do
							v11.decal.Transparency = v11.originalTransparency + (1 - v11.originalTransparency) * (1 - v7)
						end

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false

					for v12, v13 in v5.decals do
						v13.decal.Transparency = 1
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 187 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Apple = game.ServerStorage:FindFirstChild("Collect_PROX_Apple")

				if Collect_PROX_Apple then
					local ProximityPrompt = Collect_PROX_Apple:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Acorn",
		Harvestable = true
	}
}