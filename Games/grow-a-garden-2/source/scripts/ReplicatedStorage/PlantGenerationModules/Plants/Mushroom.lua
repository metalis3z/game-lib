--credit to leon games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 5
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = Random.new(p2)
		local Base = p1.Base
		local count = 1
		local Stud_Part = script.Stud_Part
		local MushroomTop = script.MushroomTop
		local v2 = 0.5 + (p3 or 1) * 0.5
		local v3 = 2 + v2 * 0.5
		local v4 = 7 + v2
		local v6 = 1

		if v1:NextInteger(1, 5000) == 1 then
			v6 = v6 * 2

			while v1:NextInteger(1, 3) == 1 do
				v6 = v6 * 2
			end
		end

		local v7 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local Size = Base.Size
		local v8 = (2 + v2) * v6
		local v9 = false
		local v10 = nil

		for i = 1, 2 do
			for j = 1, v3 do
				local v11 = Stud_Part:Clone()

				v11.Size = Vector3.new(v4 * 0.75, v8 * 0.75, v4 * 0.75)
				v11.Color = Color3.new(255/255, 255/255, 255/255)
				v11.Name = tostring(count)
				v11.CFrame = v7 * CFrame.new(0, v11.Size.Y / 2 + Size.Y / 2, 0)

				if v9 == false then
					v4 = v4 * 0.75
					v8 = v8 * 1.25
				else
					v4 = v4 * 1.25
					v8 = v8 * 0.75
				end

				v11.Parent = p1
				v7 = v11.CFrame
				Size = v11.Size
				count, v10 = count + 1, v11
			end

			v9 = not v9
		end

		local v12 = Color3.fromHSV(v1:NextInteger(0, 20) * 0.05, 1, 0.9)
		local v13 = script.MushroomTop:Clone()

		v13:ScaleTo(v2 * 1.5 ^ math.log(v6, 2))
		v13:PivotTo(v10.CFrame * CFrame.new(0, v10.Size.Y / 2 + v13.PrimaryPart.Size.Y / 2 + 0.01, 0) * CFrame.Angles(0, 0, math.pi))

		for k, v in pairs(v13:GetDescendants()) do
			if v:IsA("BasePart") then
				v.AssemblyLinearVelocity = Vector3.new(0, 170 * v2, 0)
			end
		end

		local tbl = {}

		for k, v in pairs(v13:GetChildren()) do
			if v ~= v13.PRIMARY and v:IsA("BasePart") then
				v:SetAttribute("IsMushroomCap", true)
				table.insert(tbl, v)
			end
		end

		while #tbl > 0 do
			local v14 = (-1 / 0)
			local v15 = nil

			count = count + 1

			for k, v in pairs(tbl) do
				if v14 < v.Position.Y then
					v14 = v.Position.Y
					v15 = v
				end
			end

			if v15 then
				v15.Name = tostring(count)
				v15.Parent = p1

				local v16 = table.find(tbl, v15)

				if v16 then
					table.remove(tbl, v16)
				else
					continue
				end
			end
		end

		for v17, v18 in p1:GetChildren() do
			if v18:IsA("BasePart") and v18:GetAttribute("IsMushroomCap") then
				v18.CanCollide = false
				v18:AddTag("MushroomCap")
			end
		end

		v13:Destroy()

		if v1:NextInteger(1, 100) == 1 then
			v12 = Color3.new(0/255, 0/255, 0/255)
		end

		if v1:NextInteger(1, 100) == 1 then
			for k, v in pairs(p1:GetChildren()) do
				if v:IsA("BasePart") and v.BrickColor == BrickColor.new("Bright red") then
					v.Color = v12
					v.Material = Enum.Material.Neon
				end
			end
		elseif v1:NextInteger(1, 10000) == 1 then
			for k, v in pairs(p1:GetChildren()) do
				if v:IsA("BasePart") and v.BrickColor == BrickColor.new("Bright red") then
					v.Color = v12
					v.Material = Enum.Material.ForceField
				end
			end
		else
			for k, v in pairs(p1:GetChildren()) do
				if v:IsA("BasePart") and v.BrickColor == BrickColor.new("Bright red") then
					v.Color = v12
				end
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 151 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 167 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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

					if v6:GetAttribute("NoCanCollide") == nil then
						v6.CanCollide = true
						v6.CanTouch = true
					end

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
				v6.CanTouch = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end
}