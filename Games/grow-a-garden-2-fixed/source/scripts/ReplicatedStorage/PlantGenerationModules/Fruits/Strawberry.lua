--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.3,
		BaseWeight = 1,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 8 ]]
		Random.new(p2)

		local v1 = p3 * 0.5 + 0.5
		local v2 = script.Strawberry:Clone()
		local v3 = v2.PrimaryPart.CFrame
		local v4 = p1.PrimaryPart.CFrame
		local v5 = v1 + v1 ^ 3 * 1e-6

		for v6, v7 in v2:GetChildren() do
			if v7:IsA("BasePart") then
				v7.CFrame = v4 * v3:ToObjectSpace(v7.CFrame)
			end
		end

		local PrimaryPart = p1.PrimaryPart

		v2.PrimaryPart:Destroy()

		for k, v in pairs(v2:GetChildren()) do
			if v:IsA("BasePart") then
				if v.BrickColor == BrickColor.new("Really red") then
					v:AddTag("Red")
				end

				v.Parent = p1
			end
		end

		if v5 ~= 1 then
			local v8 = PrimaryPart.CFrame

			for v9, v10 in p1:GetDescendants() do
				if v10:IsA("BasePart") then
					v10.Size = v10.Size * v5

					local v11 = v8:ToObjectSpace(v10.CFrame)

					v10.CFrame = v8 * CFrame.new(v11.Position * v5) * v11.Rotation
				end
			end
		end

		p1:SetAttribute("CorePartName", "Strawberry")
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 59 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local t2 = {}

				for v6, v7 in v2:GetDescendants() do
					if v7:IsA("Decal") then
						table.insert(t2, v7)
						v7.Transparency = 1

						continue
					end

					if v7:IsA("ImageLabel") then
						table.insert(t2, v7)
						v7.ImageTransparency = 1
					end
				end

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decorations = t2
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 92 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - v5.partAge / v2) * v2, 0, 1)

					if v7 > 0 then
						local v8 = v5.maxSize * v7

						v5.part.Size = v8
						v5.part.CFrame = PrimaryPart.CFrame * (v5.centerOffset * CFrame.new(0, -((v5.maxSize.Y - v8.Y) / 2), 0))
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true
					else
						v5.part.Transparency = 1
						v5.part.CanCollide = false
					end

					local v12 = if if v7 >= 1 then true else false then 0 else 1

					for v13, v14 in v5.decorations do
						if v14:IsA("Decal") then
							v14.Transparency = v12

							continue
						end

						v14.ImageTransparency = v12
					end
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 134 ]]
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
		FruitType = "Apple",
		Harvestable = true
	}
}