--credit to prince games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0333,
		BaseWeight = 1.125,
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

		local sum = v1:NextNumber(0.1, 1)
		local v2 = p3 * 0.2

		while v1:NextInteger(1, 7) == 1 do
			sum = sum + 0.12
		end

		for v3, v4 in p1:GetChildren() do
			if v4:GetAttribute("Offset") then
				v4.CFrame = v4.CFrame * CFrame.new(0, sum, 0)
			end

			if v4:GetAttribute("Scale") then
				v4.Size = v4.Size + Vector3.new(0, sum, 0)
				v4.CFrame = v4.CFrame * CFrame.new(0, v2, 0)
			end
		end

		local v5 = p1:WaitForChild("3"):GetPivot()
		local Y = p1:WaitForChild("3").Size.Y
		local v6 = script.SideSpikes:Clone()
		local Angles = CFrame.Angles

		v6:PivotTo(v5 * Angles(0, math.rad(90 * v1:NextInteger(0, 3)), 0))

		for v8, v9 in v6:GetChildren() do
			v9.Parent = p1
		end

		v6:Destroy()

		local v10 = script.SideSpikes:Clone()
		local Angles2 = CFrame.Angles
		local v11 = 90 * v1:NextInteger(0, 3)

		v10:PivotTo(v5 * Angles2(0, math.rad(v11), 0) * CFrame.new(0, Y / 2.5, 0))

		for v12, v13 in v10:GetChildren() do
			v13.Parent = p1
		end

		v10:Destroy()

		local v14 = script.SideSpikes:Clone()
		local Angles3 = CFrame.Angles
		local v15 = 90 * v1:NextInteger(0, 3)

		v14:PivotTo(v5 * Angles3(0, math.rad(v15), 0) * CFrame.new(0, -Y / 2.5, 0))

		for v16, v17 in v14:GetChildren() do
			v17.Parent = p1
		end

		v14:Destroy()
		p1:ScaleTo(p3)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 59 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 80 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 112 ]]
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