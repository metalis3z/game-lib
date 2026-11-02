--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 0.5
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 8 ]]
		local v1 = Random.new(p2)
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local v2 = p3 or 1
		local v3 = nil
		local v4 = Vector3.new(0.18, 0.6, 0.18) * v2
		local t = {
			Color3.fromRGB(203, 28, 28),
			Color3.fromRGB(244, 243, 239),
			Color3.fromRGB(255, 204, 51),
			Color3.fromRGB(230, 89, 23),
			Color3.fromRGB(232, 98, 123),
			Color3.fromRGB(182, 38, 208)
		}

		local function generateTrunk(p12, p2, p3) --[[ generateTrunk | Line: 29 | Upvalues: t (copy), v1 (copy), v4 (copy), v3 (ref), Base (copy), p1 (copy), v2 (ref) ]]
			local v12 = t[v1:NextInteger(1, #t)]

			for i = 1, p2 do
				local v22 = script.Stud_Part:Clone()
				local X = v4.X
				local v32 = v4.Y + v1:NextNumber(-0.15, 0.15)
				local v9 = CFrame.Angles(math.rad((v1:NextNumber(-15, 15))), math.rad((v1:NextNumber(-15, 15))), (math.rad((v1:NextNumber(-15, 15)))))

				CFrame.new(p12.Position + Vector3.new(v1:NextNumber(-15, 15), v1:NextNumber(-15, 15), v1:NextNumber(-15, 15)))
				v22.Color = Color3.fromRGB(37, 121, 50)
				v22.Size = Vector3.new(X, v32, X)

				if v3 and v3 ~= Base then
					local v14 = v3:GetPivot()

					v22.CFrame = v14 * CFrame.new(0, v3.Size.Y / 2.05, 0) * v9 * CFrame.new(0, v32 / 2.05, 0)
					p12 = v14
				else
					v22.CFrame = p12 * v9 * CFrame.new(0, v32 / 2.05, 0)
				end

				v22.Name = i
				v22.Parent = p1

				if i == p2 then
					local v15 = script.Top:Clone()

					v15:ScaleTo(0.6 * v2)

					local v16 = v22:GetPivot() * CFrame.new(0, v22.Size.Y / 2, 0)

					v15:PivotTo(v16 * CFrame.Angles(math.rad((v1:NextInteger(-15, 15))), math.rad((v1:NextInteger(-15, 15))), (math.rad((v1:NextInteger(-15, 15))))))

					for v222, v23 in v15:GetChildren() do
						v23.Color = v12
						v23.Name = tonumber(v23.Name) + i
						v23.Parent = p1
					end

					v15:Destroy()
				end

				v3 = v22
			end

			v3 = nil
		end

		local v5 = 1000 - v2 ^ 5
		local count = 1

		while v1:NextInteger(1, (math.clamp(v5, 10, 100000))) == 1 and count < 40 do
			count = count + 1
		end

		for i = 1, count do
			local count2 = v1:NextInteger(2, 3)

			while v1:NextInteger(1, 7) == 1 and count2 < 65 do
				count2 = count2 + 1
			end

			if count > 1 then
				local v7 = Base:GetPivot()

				generateTrunk(v7 * CFrame.Angles(0, (i - 1) / count * math.pi * 2, 0) * CFrame.Angles(-0.3839724354387525, 0, 0), count2, v7)

				continue
			end

			generateTrunk(Base:GetPivot(), count2, Base:GetPivot())
		end

		local count2 = 1

		while v1:NextInteger(1, 5) == 1 and count2 < 65 do
			count2 = count2 + 1
		end

		for j = 1, count2 do
			local v8 = p1.Wedge:Clone()

			v8:ScaleTo(v2)

			local v9 = p1:GetPivot()

			v8:PivotTo(v9 * CFrame.Angles(math.rad((v1:NextInteger(-20, 20))), math.rad((v1:NextInteger(0, 360))), (math.rad((v1:NextInteger(-20, 20))))))
			v8["1"].Parent = p1
			v8:Destroy()
		end

		p1.Wedge:Destroy()
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 121 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 139 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				local v6 = v5[1]
				local v7 = v5[2]
				local v8 = v5[3]
				local v10 = math.min((v3 - v5[4] / v2) * v2, 1)

				if v10 > 0 then
					v6.Size = Vector3.new(v7.X, v7.Y * v10, v7.Z)
					v6.CFrame = PrimaryPart.CFrame * v8 * CFrame.new(0, (v6.Size.Y - v7.Y) / 2, 0)
					v6.Transparency = v6:GetAttribute("OG_Transparency") or 0
					v6.CanCollide = true

					if v6:FindFirstChild("Decal") and v10 >= 1 then
						for v12, v13 in v6:GetChildren() do
							if v13:IsA("Decal") then
								v13.Transparency = 0.4
							end
						end
					end

					continue
				end

				v6.Transparency = 1
				v6.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end
}