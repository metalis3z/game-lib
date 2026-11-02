--credit to prince games studio
return {
	GrowData = {
		GrowRate = 0.007,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		local v1 = Random.new(p2)
		local PrimaryPart = p1.PrimaryPart
		local v2 = (p3 or 1) * 0.75
		local v3 = v1:NextInteger(3, 4)
		local v4 = 2 * v2
		local v5 = v1:NextInteger(40, 50)
		local v6 = v1:NextInteger(65, 75)
		local v7 = v1:NextInteger(10, 20)
		local count = 0
		local v8 = 0

		local function generateRing(p12) --[[ generateRing | Line: 26 | Upvalues: v3 (copy), v6 (copy), v7 (copy), v5 (copy), count (ref), v8 (ref), v2 (ref), PrimaryPart (copy), v4 (copy), p1 (copy) ]]
			local v22 = v6 + (v7 - v6) * ((p12 - 1) / math.max(v3 - 1, 1))
			local v32 = (p12 - 1) * v5

			count = count + 1
			v8 = v8 + 0.02

			local v42 = Color3.fromHSV(0.8 - v8, 0.580392, 1)

			for i = 0, 3 do
				local v52 = script.Leaf:Clone()

				v52.Name = tostring(count)
				v52.Size = Vector3.new(1 * v2, 5 * v2, 5 * v2)
				v52.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, math.rad(i * 90 + v32), 0) * CFrame.new(0, 0, -v4) * CFrame.Angles(math.rad(v22 - 90), 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, v52.Size.Y / 2, 0)
				v52.Color = v42
				v52.Parent = p1
			end
		end

		generateRing(1)

		local v9 = 4 * v2

		for i = 1, v1:NextInteger(3, 5) do
			local v10 = script.Stud_Part:Clone()

			v10.Size = Vector3.new(v9, v9, v9)
			v10.Material = Enum.Material.Neon
			v10.Shape = Enum.PartType.Ball
			v10.CFrame = PrimaryPart.CFrame * CFrame.new(0, v10.Size.Y / 3 + PrimaryPart.Size.Y / 2, 0)
			v10.Transparency = 0.75
			count = count + 1
			v10.Name = tostring(count)
			v10.Parent = p1
			v9 = v9 * 1.075
		end

		for j = 2, v3 do
			generateRing(j)
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 84 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local v6 = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame)
				local v7 = v6 * CFrame.new(0, -v2.Size.Y / 2, 0)
				local t2 = {}

				for v8, v9 in v2:GetChildren() do
					if v9:IsA("Texture") or v9:IsA("Decal") then
						table.insert(t2, {
							instance = v9,
							originalTransparency = v9.Transparency
						})

						if v5 then
							v9.Transparency = 1
						end
					end
				end

				local v10 = v2:GetAttribute("OG_Transparency")

				if v10 == nil then
					v10 = v2.Transparency
				end

				if v2.Material == Enum.Material.Neon then
					v10 = 0.5
				end

				v2:SetAttribute("OG_Transparency", v10)
				table.insert(t, {
					part = v2,
					maxSizeY = v2.Size.Y,
					fullSize = v2.Size,
					bottomCF = v7,
					rotation = v6.Rotation,
					partAge = v4,
					originalTransparency = v10,
					textures = t2
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 133 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						local v8 = v5.maxSizeY * v7

						v5.part.Size = Vector3.new(v5.fullSize.X, v8, v5.fullSize.Z)
						v5.part.CFrame = PrimaryPart.CFrame * CFrame.new((v5.bottomCF * CFrame.new(0, v8 / 2, 0)).Position) * v5.rotation
						v5.part.Transparency = v5.originalTransparency
						v5.part.CanCollide = true

						for v10, v11 in v5.textures do
							v11.instance.Transparency = v11.originalTransparency
						end

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false

					for v12, v13 in v5.textures do
						v13.instance.Transparency = 1
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 167 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Flower = game.ServerStorage:FindFirstChild("Collect_PROX_Flower")

				if Collect_PROX_Flower then
					local ProximityPrompt = Collect_PROX_Flower:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Sunflower",
		Harvestable = true
	}
}