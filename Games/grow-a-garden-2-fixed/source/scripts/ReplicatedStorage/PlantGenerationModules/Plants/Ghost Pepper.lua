--credit to prince games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 18 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v1 + v2:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v22, v3), v5, v22, v3
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 26 | Upvalues: p1 (copy), MaterialService (ref) ]]
			local Part = Instance.new("Part")
			local v1 = p12 or "Studs"

			Part.Parent = p1
			Part.TopSurface = Enum.SurfaceType[v1]
			Part.BackSurface = Enum.SurfaceType[v1]
			Part.FrontSurface = Enum.SurfaceType[v1]
			Part.BottomSurface = Enum.SurfaceType[v1]
			Part.LeftSurface = Enum.SurfaceType[v1]
			Part.RightSurface = Enum.SurfaceType[v1]
			Part.Anchored = true
			Part.CanCollide = false
			Part.Transparency = 1

			if p3 then
				Part.Shape = Enum.PartType[p3]
			end

			if p2 then
				Part.MaterialVariant = p2

				local v2 = MaterialService:FindFirstChild(p2, true)

				if not v2 then
					return Part
				end

				Part.Material = v2.BaseMaterial
			end

			return Part
		end

		local v3 = v2:NextInteger(1, 2) * (v1 * 0.5 + 0.5)
		local v4 = v2:NextInteger(3, 5) * (v1 * 0.5 + 0.5)
		local v5 = v2:NextInteger(4, 8)
		local v6 = 3

		while v2:NextInteger(1, (math.round(50 / v1))) == 1 do
			v5 = v5 * v2:NextInteger(2, 3)
			v6 = v6 * v2:NextInteger(2, 3)

			while v2:NextInteger(1, 2) == 1 do
				v3 = v3 * 1.5
				v4 = v4 * 1.5
			end
		end

		local v7 = Vector3.new(v3, v4, v3)
		local _ = Base.CFrame
		local v8 = 1
		local v9 = nil
		local v10 = 0
		local t = {}
		local t2 = {}

		local function generateTrunk(p12, p2, p3) --[[ generateTrunk | Line: 85 | Upvalues: v7 (copy), v9 (ref), v2 (copy), v10 (ref), v8 (ref), p1 (copy), t (copy), t2 (copy), v1 (ref) ]]
			local v12 = p12:GetPivot()

			for i = 1, p2 do
				local v22 = script.Stud_Part:Clone()
				local v4 = math.clamp(v7.X - i * 0.015, 1, 10)

				if v9 then
					v4 = math.clamp(v9.Size.X - i * 0.03, 1, 10)
				elseif p3 == nil then
					v4 = math.clamp(p12.Size.X - i * 0.03, 1, 10)
				end

				local v92 = if p3 then v7.Y + v2:NextNumber(-3.4, 3) else v7.Y + v2:NextNumber(-3.4, 1.5)
				local v15 = CFrame.Angles(math.rad((v2:NextNumber(-15, 15))), math.rad((v2:NextNumber(-20, 20))), (math.rad((v2:NextNumber(-15, 15)))))

				CFrame.new(v12.Position + Vector3.new(v2:NextNumber(-15, 15), v2:NextNumber(-15, 15), v2:NextNumber(-15, 15)))

				local v20, v21, v222 = Color3.fromRGB(101, 165, 38):ToHSV()
				local v23 = 0.03 or 0.05

				v22.Color = Color3.fromHSV(v20 + v2:NextNumber(-v23, v23), v21, v222)
				v22.Size = Vector3.new(v4, v92, v4)

				local v25 = 0

				if v9 then
					v25 = v9.Size.Y

					local v26 = v9:GetPivot()

					if i == math.ceil(p2 / 2) then
						v12, v15 = v26, CFrame.Angles(math.rad((v2:NextNumber(-15, 15))), math.rad((v2:NextNumber(20, 20))), (math.rad((v2:NextNumber(-15, 15)))))
					else
						v12 = v26
					end
				else
					v15 = CFrame.Angles(math.rad((v2:NextNumber(-45, 45))), math.rad((v2:NextNumber(0, 360))), (math.rad((v2:NextNumber(-45, 45)))))
				end

				if p3 then
					v10 = v10 + 1
					v15 = CFrame.Angles(math.rad((v2:NextNumber(-3, 3))), math.rad((v2:NextNumber(3, 3))), (math.rad((v2:NextNumber(-3, 3)))))
				end

				v22.CFrame = v12 * CFrame.new(0, v25 / 2.1, 0) * v15 * CFrame.new(0, v92 / 2.1, 0)
				v22.Name = v8
				v22.Parent = p1
				v8 = v8 + 1

				if p2 - 2 <= i then
					table.insert(t, v22)
				elseif v8 < p2 * 0.85 then
					table.insert(t2, v22)
				end

				if i == p2 then
					local v47 = v2:NextNumber(2, 4)

					for j = 1, v47 do
						local v48 = script.Leaf:Clone()
						local v49 = v22:GetPivot() * CFrame.new(0, v22.Size.Y / 2, 0)

						v48:PivotTo(v49 * CFrame.Angles(math.rad((v2:NextInteger(-5, 20))), math.rad(360 / v47 * j + v2:NextInteger(-15, 15)), (math.rad((v2:NextInteger(-5, 20))))))

						local v55 = v48["1"]
						local v56, v57, v58 = Color3.fromRGB(101, 165, 38):ToHSV()
						local v59 = 0.03 or 0.05

						v55.Color = Color3.fromHSV(v56 + v2:NextNumber(-v59, v59), v57, v58)
						v48:ScaleTo(v2:NextNumber(0.6, 1.1) * (v1 * 0.5 + 0.5))
						v55.Name = tostring(v8)
						v8 = v8 + 1
						v55.Parent = p1
						v48:Destroy()
					end
				end

				v9 = v22
			end

			v9 = nil
		end

		generateTrunk(Base, math.floor(v5), true)

		local v11 = v10 / 5

		math.ceil(v11)

		local count = 0

		while v6 > 0 do
			local count2

			count2, v6 = v2:NextInteger(3, 8), v6 - 1

			while v2:NextInteger(1, 5) == 1 do
				count2 = count2 + 1
			end

			generateTrunk(t2[v2:NextInteger(1, #t2)], count2)
			count = count + 1
		end

		local count2 = math.ceil(v8 / 7)

		while v2:NextInteger(1, 10) == 1 do
			count2 = count2 + 1
		end

		for i = 1, count2 do
			local v13 = CreatePart()

			v13.Size = Vector3.new(1, 1, 1)

			local v14 = t[v2:NextInteger(1, #t)]

			v13.CFrame = v14:GetPivot() * CFrame.new(0, v2:NextNumber(-v14.Size.Y / 2, v14.Size.Y / 2), 0)
			v13.Orientation = Vector3.new(0, 0, 180)
			v13.Parent = p1.FruitSpawnLocations
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 205 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 223 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.min(v1 - v3[4], 1)

				if v8 > 0 then
					v4.Size = Vector3.new(v5.X, v5.Y * v8, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(0, (v4.Size.Y - v5.Y) / 2, 0)
					v4.Transparency = v4:GetAttribute("OG_Transparency") or 0
					v4.CanCollide = true

					continue
				end

				v4.Transparency = 1
				v4.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}