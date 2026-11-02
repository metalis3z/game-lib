--credit to quartz games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.4067,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 13 ]]
		local v1 = Random.new(p2)
		local v2 = p1.Base:GetPivot()

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 22 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = (v12 + v1:NextNumber(-v4, v4)) % 1

			return Color3.fromHSV(v5, math.clamp(v2, 0, 1), (math.clamp(v3, 0, 1))), v5, v2, v3
		end

		local function ApplyColorKeepBrightness(p1, p2, p3) --[[ ApplyColorKeepBrightness | Line: 30 ]]
			if not p1:IsA("BasePart") then
				return
			end

			local _, _2, v2 = p1.Color:ToHSV()
			local v3, v4 = p2:ToHSV()

			p1.Color = Color3.fromHSV(v3, v4 * (p3 or 1), v2)
		end

		local t = {
			Color3.fromRGB(254, 98, 165),
			Color3.fromRGB(160, 93, 254),
			Color3.fromRGB(254, 146, 92),
			Color3.fromRGB(108, 254, 225)
		}
		local v3, v4, v5 = t[v1:NextInteger(1, #t)]:ToHSV()
		local v6 = 0.1 or 0.05
		local v8 = Color3.fromHSV((v3 + v1:NextNumber(-v6, v6)) % 1, math.clamp(v4, 0, 1), (math.clamp(v5, 0, 1)))
		local v9 = v1:NextInteger(5, 9)
		local v10 = v8

		for i = 1, v9 do
			local v11 = script.Petal:Clone()

			v11:ScaleTo(v1:NextNumber(1.2, 1.5))
			v11:PivotTo(v2 * CFrame.Angles(math.rad((v1:NextInteger(-3, 3))), math.rad(360 / v9 * i + v1:NextInteger(-9, 9)), (math.rad((v1:NextInteger(-15, -10))))))

			for v17, v18 in v11:GetChildren() do
				v18.Name = tonumber(v18.Name) + i

				local v20 = nil or 1

				if v18:IsA("BasePart") then
					local _, _2, v21 = v18.Color:ToHSV()
					local v22, v23 = v10:ToHSV()

					v18.Color = Color3.fromHSV(v22, v23 * v20, v21)
				end

				v18.Parent = p1
			end

			v11:Destroy()
		end

		local v24 = v1:NextInteger(3, 6)

		for j = 1, v24 do
			local v25 = script.Petal:Clone()

			v25:ScaleTo(v1:NextNumber(0.94, 1.2))
			v25:PivotTo(v2 * CFrame.Angles(math.rad((v1:NextInteger(-3, 3))), math.rad(360 / v24 * j + v1:NextInteger(-9, 9)), (math.rad((v1:NextInteger(-50, -40))))))

			for v31, v32 in v25:GetChildren() do
				v32.Name = tonumber(v32.Name) + j

				local v34 = nil or 1

				if v32:IsA("BasePart") then
					local _, _2, v35 = v32.Color:ToHSV()
					local v36, v37 = v10:ToHSV()

					v32.Color = Color3.fromHSV(v36, v37 * v34, v35)
				end

				v32.Parent = p1
			end

			v25:Destroy()
		end

		p1:ScaleTo(p3)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 104 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 125 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 157 ]]
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