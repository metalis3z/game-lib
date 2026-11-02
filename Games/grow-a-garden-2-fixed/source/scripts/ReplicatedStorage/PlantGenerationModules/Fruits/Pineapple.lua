--credit to quartz games studio
return {
	GrowData = {
		GrowRate = 0.01,
		BaseWeight = 5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		local v1 = Random.new(p2)
		local PrimaryPart = p1.PrimaryPart
		local v2 = (p3 or 1) - 0.25

		p1["1"].Color = Color3.fromHSV(v1:NextInteger(125, 165) * 0.001, 1, 1)

		if v2 ~= 1 then
			local v3 = PrimaryPart.CFrame

			for v4, v5 in p1:GetDescendants() do
				if v5:IsA("BasePart") then
					v5.Size = v5.Size * v2

					local v6 = v3:ToObjectSpace(v5.CFrame)

					v5.CFrame = v3 * CFrame.new(v6.Position * v2) * v6.Rotation
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

		local function updateGrowth() --[[ updateGrowth | Line: 84 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	Extras = {
		FruitType = "Sunflower",
		Harvestable = true
	}
}