--credit to quartz games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0088,
		BaseWeight = 7.5,
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
			Color3.fromRGB(184, 41, 12),
			Color3.fromRGB(184, 62, 6),
			Color3.fromRGB(207, 28, 28),
			Color3.fromRGB(124, 37, 16)
		}
		local v2 = t[v1:NextInteger(1, #t)]
		local v3 = nil

		local function generateTrunk(p12, p2) --[[ generateTrunk | Line: 38 | Upvalues: v1 (copy), v2 (copy), v3 (ref), p1 (copy) ]]
			for i = 1, p2 do
				local v12
				local v22 = script.Part:Clone()
				local v32 = math.clamp(2.5 - i * 0.1, 1, 10) * v1:NextNumber(0.9, 1.1)
				local v9 = CFrame.Angles(math.rad((v1:NextNumber(5, 15))), math.rad((v1:NextNumber(-5, 5))), (math.rad((v1:NextNumber(5, 15)))))
				local v10, v11, v122 = v2:ToHSV()
				local v13 = 0.025 or 0.05

				v22.Color = Color3.fromHSV((v10 + v1:NextNumber(-v13, v13)) % 1, math.clamp(v11, 0, 1), (math.clamp(v122, 0, 1)))
				v22.Size = Vector3.new(v32, 1.5, v32)

				if v3 then
					v12 = v3.Size.Y
					p12 = v3:GetPivot()
				else
					v12 = 0
				end

				local v16 = 1.5 + v1:NextNumber(-0.5, 0.5)

				v22.CFrame = p12 * CFrame.new(0, v12 / 3, 0) * v9 * CFrame.new(0, v16 / 3, 0)
				v22.Name = i + 2
				v22.Parent = p1

				if i == math.floor(p2 / 2) then
					local v17 = script.PixelGradient:Clone()

					v17.Parent = v22
					v17.Enabled = true
				end

				if v3 then
					local v19 = v3:GetPivot()

					v3:PivotTo(v19 * CFrame.Angles(math.rad((v1:NextInteger(-20, 20))), math.rad((v1:NextInteger(-20, 20))), (math.rad((v1:NextInteger(-20, 20))))))
				end

				v22:AddTag("GhostPepper")
				v3 = v22
			end

			v3 = nil
		end

		local count = v1:NextInteger(6, 10)

		while v1:NextInteger(1, 6) == 1 do
			count = count + 1
		end

		local v4 = p1["2"]:GetPivot()
		local Angles = CFrame.Angles

		generateTrunk(v4 * Angles(0, math.rad((v1:NextInteger(1, 360))), 0), count)
		p1:ScaleTo(p3)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 86 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 107 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 139 ]]
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