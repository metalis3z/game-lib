--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.0064,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		Random.new(p2)

		local Base = p1.Base
		local v1 = (p3 or 1) * 0.5

		if v1 ~= 1 then
			local v2 = Base.CFrame

			for v3, v4 in p1:GetDescendants() do
				if v4:IsA("BasePart") then
					v4.Size = v4.Size * v1

					local v5 = v2:ToObjectSpace(v4.CFrame)

					v4.CFrame = v2 * CFrame.new(v5.Position * v1) * v5.Rotation
				end
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 35 ]]
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
							obj = v9,
							ogTransparency = v9.Transparency
						})
					end
				end

				table.insert(t, {
					part = v2,
					maxSizeY = v2.Size.Y,
					fullSize = v2.Size,
					bottomCF = v7,
					rotation = v6.Rotation,
					partAge = v4,
					textures = t2
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1

					for v10, v11 in t2 do
						v11.obj.Transparency = 1
					end
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 74 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						for v10, v11 in v5.textures do
							v11.obj.Transparency = v11.ogTransparency
						end

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false

					for v12, v13 in v5.textures do
						v13.obj.Transparency = 1
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 107 ]]
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
		FruitType = "Pomegranate",
		Harvestable = true
	}
}