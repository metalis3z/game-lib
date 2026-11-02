--credit to leon games studio
return {
	GrowData = {
		GrowRate = 0.0061,
		BaseWeight = 6,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 9 ]]
		local v1 = Random.new(p2)
		local v2 = Color3.fromRGB(221, 126, 57)
		local v3 = Color3.fromRGB(246, 178, 10)

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 24 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05

			return Color3.fromHSV(math.clamp(v12 + v1:NextNumber(-v4, v4), 0.01, 0.99), v2, v3)
		end

		local v4, v5, v6 = v2:ToHSV()
		local v7 = 0.02 or 0.05
		local v10 = Color3.fromHSV(math.clamp(v4 + v1:NextNumber(-v7, v7), 0.01, 0.99), v5, v6)
		local v11, v12, v13 = v3:ToHSV()
		local v14 = 0.02 or 0.05
		local v17 = Color3.fromHSV(math.clamp(v11 + v1:NextNumber(-v14, v14), 0.01, 0.99), v12, v13)
		local Middle = p1.Middle
		local v18 = Middle:GetPivot()

		Middle:PivotTo(v18 * CFrame.Angles(0, math.rad((v1:NextNumber(-180, 180))), 0))

		local count = 1

		Middle.Name = tostring(count)

		local t = { p1:FindFirstChild("3"), p1:FindFirstChild("4") }
		local v20 = t[2]
		local v21, v22 = v17, v10

		for v23, v24 in t do
			if v24 then
				local Angles2 = CFrame.Angles

				v24.CFrame = v24.CFrame * Angles2(0, math.rad((v1:NextNumber(-30, 30))), 0)
				count = count + 1
				v24.Name = tostring(count)
			end
		end

		local Petal = script.Petal
		local v27 = v1:NextInteger(6, 8)
		local t2 = {}

		for i = 1, v27 do
			local v28 = Petal:Clone()
			local v29 = v20.CFrame * CFrame.Angles(0, math.rad(360 / v27 * i), 0)
			local Angles2 = CFrame.Angles
			local v30 = v1:NextNumber(75, 110)

			v28:PivotTo(v29 * Angles2(math.rad(v30), 0, 0) * CFrame.new(0, v20.Size.X / 2, 0))

			local v31 = v28.TopPetal:GetPivot()
			local Angles3 = CFrame.Angles

			v28.TopPetal:PivotTo(v31 * Angles3(math.rad((v1:NextNumber(-25, 25))), 0, 0))

			local v33 = v28:GetPivot()
			local t3 = {}

			for v34, v35 in v28:GetDescendants() do
				if v35:IsA("BasePart") then
					table.insert(t3, {
						part = v35,
						dist = v33:ToObjectSpace(v35.CFrame).Position.Magnitude
					})
				end
			end

			table.sort(t3, function(p1, p2) --[[ Line: 93 ]]
				return p1.dist < p2.dist
			end)

			for v36, v37 in t3 do
				if not t2[v36] then
					t2[v36] = {}
				end

				v37.part.Parent = p1
				table.insert(t2[v36], v37.part)
			end

			v28:Destroy()
		end

		for j = 1, #t2 do
			count = count + 1

			for v39, v40 in t2[j] do
				v40.Name = tostring(count)
			end
		end

		for v41, v42 in p1:GetDescendants() do
			if v42:IsA("BasePart") then
				if v42.Color == Color3.fromRGB(246, 178, 10) then
					v42.Color = v21
				elseif v42.Color == Color3.fromRGB(221, 126, 57) then
					v42.Color = v22
				end

				if v42.Parent ~= p1 then
					v42.Parent = p1
				end
			end
		end

		local v43 = p3 * 0.5 + 0.5

		p1:ScaleTo(v43 + v43 ^ 3 * 0.00005)
		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 144 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = not v2:GetAttribute("DontShow")
				local v6 = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame)

				table.insert(t, {
					part = v2,
					maxSizeY = v2.Size.Y,
					fullSize = v2.Size,
					bottomCF = v6 * CFrame.new(0, -v2.Size.Y / 2, 0),
					rotation = v6.Rotation,
					partAge = v4
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 177 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 215 ]]
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