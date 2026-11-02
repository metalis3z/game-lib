--credit to quartz games studio
return {
	GrowData = {
		GrowRate = 0.0023,
		BaseWeight = 2.25,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		local v1 = Random.new(p2)

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 10 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()

			if not p2 then
				p2 = 0.05
			end

			local v4 = v12 + v1:NextNumber(-p2, p2)

			return Color3.fromHSV(v4, v2, v3), v4, v2, v3
		end

		local v2, v3 = Color3.fromRGB(0, 159, 13)
		local v4, v5, v6 = v2:ToHSV()

		if not v3 then
			v3 = 0.05
		end

		local v8 = Color3.fromHSV(v4 + v1:NextNumber(-v3, v3), v5, v6)
		local v9, v10 = Color3.fromRGB(149, 99, 171)
		local v11, v12, v13 = v9:ToHSV()

		if not v10 then
			v10 = 0.05
		end

		local v15 = Color3.fromHSV(v11 + v1:NextNumber(-v10, v10), v12, v13)
		local Leaf = p1:FindFirstChild("Leaf")

		if Leaf then
			local v16 = Leaf:GetPivot()
			local Angles = CFrame.Angles

			Leaf:PivotTo(v16 * Angles(math.rad((v1:NextNumber(-180, 180))), 0, 0))

			if v1:NextInteger(1, 6) == 1 then
				Leaf:Destroy()
			else
				Leaf.Name = "2"
			end
		end

		local v18 = p1:FindFirstChild("1")

		if v18 then
			v18.CFrame = v18.CFrame * CFrame.Angles(0, math.rad((v1:NextNumber(-180, 180))), (math.rad((v1:NextNumber(-5, 5)))))
		end

		local v23, v24 = v8, v15

		for v25, v26 in p1:GetChildren() do
			if v26:IsA("BasePart") or v26:IsA("MeshPart") then
				local Angles = CFrame.Angles

				v26.CFrame = v26.CFrame * Angles(0, math.rad((v1:NextNumber(-5, 5))), 0)

				if v26.Color == Color3.fromRGB(0, 159, 13) then
					v26.Color = v23
				end

				if v26.Color == Color3.fromRGB(149, 99, 171) then
					v26.Color = v24
				end

				if v26:FindFirstChild("Decal") then
					for v29, v30 in v26:GetChildren() do
						if v30:IsA("Decal") then
							v30.Color3 = v24
						end
					end
				end
			end
		end

		p1:ScaleTo(p3)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 56 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 91 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 126 ]]
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
		FruitType = "Fruit",
		Harvestable = true
	}
}