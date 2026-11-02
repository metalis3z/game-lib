--credit to quartz games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0413,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 13 ]]
		local v1 = Random.new(p2)

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 19 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = (v12 + v1:NextNumber(-v4, v4)) % 1

			return Color3.fromHSV(v5, math.clamp(v2, 0, 1), (math.clamp(v3, 0, 1))), v5, v2, v3
		end

		local t = {
			Color3.fromRGB(255, 237, 38),
			Color3.fromRGB(255, 201, 24),
			Color3.fromRGB(228, 255, 92),
			Color3.fromRGB(255, 219, 75),
			Color3.fromRGB(255, 234, 0)
		}
		local v2 = t[math.random(1, #t)]
		local v3 = t[math.random(1, #t)]
		local v4 = nil

		while v2 == v3 do
			v3 = t[math.random(1, #t)]
		end

		local function generateTrunk(p12, p2) --[[ generateTrunk | Line: 46 | Upvalues: v1 (copy), v4 (ref), p1 (copy) ]]
			for i = 1, p2 do
				local v12
				local v2 = script.Part:Clone()
				local v42 = (math.sin((i - 1) / math.max(p2 - 1, 1) * math.pi) * 0.7 + 0.30000000000000004) * 1.75
				local v5 = math.clamp(v42, 0.15, 10) * v1:NextNumber(0.9, 1.1)
				local v11 = CFrame.Angles(math.rad((v1:NextNumber(5, 7))), math.rad((v1:NextNumber(-5, 5))), (math.rad((v1:NextNumber(5, 7)))))

				if v4 then
					v12 = v4.Size.Y
					p12 = v4:GetPivot()
				else
					v12 = 0
				end

				local v13 = 1 + v1:NextNumber(-0.5, 0.5)

				v2.Size = Vector3.new(v5, v13, v5)
				v2.CFrame = p12 * CFrame.new(0, v12 / 3, 0) * v11 * CFrame.new(0, v13 / 3, 0)
				v2.Name = i + 2
				v2.Parent = p1
				v2.Color = Color3.fromRGB(255, 247, 0)

				if i == 1 or i == p2 then
					v2.Color = Color3.fromRGB(184, 139, 84)
					v2.Material = Enum.Material.Glacier
					v2.MaterialVariant = "2022 Weld"
				else
					local _ = (i - 2) / math.max(p2 - 1 - 2, 1)

					v2.Color = Color3.fromRGB(255, 255, 0)
				end

				v4 = v2
			end

			v4 = nil
		end

		local v5 = v1:NextInteger(7, 9) + p3
		local v6 = p1.Base:GetPivot()
		local Angles = CFrame.Angles

		generateTrunk(v6 * Angles(math.pi, math.rad((v1:NextInteger(-90, 90))), 0), v5)

		local v8 = p3 * 0.5 + 0.5

		p1:ScaleTo(v8 + v8 ^ 3 * 0.00001)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 113 ]]
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
					partAge = v4
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 134 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 166 ]]
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