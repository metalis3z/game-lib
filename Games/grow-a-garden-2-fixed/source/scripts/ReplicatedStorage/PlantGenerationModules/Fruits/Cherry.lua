--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.0064,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local t = {
			Color3.fromRGB(179, 25, 25),
			Color3.fromRGB(179, 25, 25),
			Color3.fromRGB(255, 36, 36),
			Color3.fromRGB(234, 82, 82),
			Color3.fromRGB(134, 34, 34)
		}
		local v2 = t[v1:NextInteger(1, #t)]
		local v3 = t[v1:NextInteger(1, #t)]

		p1.Stem.m1:ScaleTo(v1:NextNumber(0.8, 1.22) * p3)

		local v4 = p1.Stem.m1:GetPivot()

		p1.Stem.m1:PivotTo(v4 * CFrame.Angles(math.rad((v1:NextInteger(-25, 25))), math.rad((v1:NextInteger(-45, 45))), (math.rad((v1:NextInteger(-25, 25))))))
		p1.Stem.m1["4"].Color = v2
		p1.Stem.m2:ScaleTo(v1:NextNumber(0.8, 1.22) * p3)

		local v10 = p1.Stem.m2:GetPivot()

		p1.Stem.m2:PivotTo(v10 * CFrame.Angles(math.rad((v1:NextInteger(-25, 25))), math.rad((v1:NextInteger(-45, 45))), (math.rad((v1:NextInteger(-25, 25))))))
		p1.Stem.m2["4"].Color = v3

		local v16 = p1.Stem:GetPivot()

		p1.Stem:PivotTo(v16 * CFrame.Angles(math.rad((v1:NextInteger(-33, 33))), math.rad((v1:NextInteger(-33, 33))), (math.rad((v1:NextInteger(-33, 33))))))
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 38 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					upVector = PrimaryPart.CFrame:VectorToObjectSpace(v2.CFrame.UpVector),
					partAge = v4
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 62 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - (v5.partAge - 1) / v2) * v2, 0, 1)

					if v7 > 0 then
						v5.part.Size = v5.maxSize * v7
						v5.part.CFrame = PrimaryPart.CFrame * (v5.centerOffset + v5.upVector * (v5.maxSize.Y / 2 * (1 - v7)) * (if v5.part:GetAttribute("GrowUp") then -1 else 1))
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 95 ]]
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
		FruitType = "Cherry",
		Harvestable = true
	}
}