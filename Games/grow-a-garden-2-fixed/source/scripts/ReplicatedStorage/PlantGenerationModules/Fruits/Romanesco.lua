--credit to quartz games studio
game:GetService("MaterialService")

return {
	GrowData = {
		GrowRate = 0.0119,
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

		local v3, v4 = Color3.fromRGB(109, 209, 73)
		local v5, v6, v7 = v3:ToHSV()
		local v8 = v4 or 0.05
		local v10 = Color3.fromHSV((v5 + v1:NextNumber(-v8, v8)) % 1, math.clamp(v6, 0, 1), (math.clamp(v7, 0, 1)))
		local v11, v12 = Color3.fromRGB(242, 255, 102)
		local v13, v14, v15 = v11:ToHSV()
		local v16 = v12 or 0.05
		local v18 = Color3.fromHSV((v13 + v1:NextNumber(-v16, v16)) % 1, math.clamp(v14, 0, 1), (math.clamp(v15, 0, 1)))
		local count = v1:NextInteger(6, 10)
		local v19, v20 = v18, v10

		while v1:NextInteger(1, 4) == 1 do
			count = count + 1
		end

		local v22 = math.rad((v1:NextNumber(-6, 6)))
		local v24 = math.rad((v1:NextNumber(-6, 6)))
		local v30 = v2 * CFrame.Angles(math.rad((v1:NextNumber(-10, 10))), math.rad((v1:NextNumber(1, 360))), (math.rad((v1:NextNumber(-10, 10)))))
		local v31 = 60
		local v32 = false

		for i = 1, v31 do
			if i > 25 and v32 == false then
				v32 = true
				v22 = -v22
				v24 = -v24
			end

			local v33 = script.Layer:Clone()

			v33.Parent = workspace

			local v34 = (i - 1) / (v31 - 1)

			v33:ScaleTo(0.9 + -0.55 * v34)

			local v35 = v20:Lerp(v19, v34)

			for v36, v37 in v33:GetDescendants() do
				if v37:IsA("BasePart") then
					v37.Color = v35
				end
			end

			v33:PivotTo(v30)
			v30 = v33:GetPivot() * CFrame.new(0, 2 * v33:GetScale(), 0) * CFrame.Angles(v22, 0, v24)

			for v38, v39 in v33:GetChildren() do
				if v39:IsA("BasePart") then
					v39.Name = tostring(tonumber(v39.Name) + i)
					v39.Parent = p1
				end
			end

			v33:Destroy()
		end

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