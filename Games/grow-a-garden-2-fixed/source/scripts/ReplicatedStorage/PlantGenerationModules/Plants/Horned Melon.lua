--credit to leon games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 20 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v12 + v1:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v2, v3), v5, v2, v3
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 28 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v2 = p1:WaitForChild("2")
		local v3, v4, v5 = Color3.fromRGB(101, 182, 79):ToHSV()
		local v6 = 0.03 or 0.05

		v2.Color = Color3.fromHSV(v3 + v1:NextNumber(-v6, v6), v4, v5)

		local v8 = v1:NextNumber(1, 3)

		v2.Position = v2.Position + Vector3.new(0, v8 / 2, 0)
		v2.Size = v2.Size + Vector3.new(0, v8, 0)

		local _ = p1.Base.CFrame
		local count = v1:NextInteger(2, 4)
		local v9 = nil
		local v10 = 3

		while v1:NextInteger(1, 4) == 1 and count < 20 do
			count = count + 1
		end

		local function generateTrunk(p12, p2, p3) --[[ generateTrunk | Line: 82 | Upvalues: v1 (copy), v9 (ref), v2 (copy), v10 (ref), p1 (copy), CreatePart (copy) ]]
			local v12 = p12:GetPivot() * CFrame.new(0, p12.Size.Y / 2, 0)

			for i = 1, p2 do
				local v22 = script.Stud_Part:Clone()
				local v3 = 1.5 + v1:NextNumber(-0.8, 1.3)
				local v92 = CFrame.Angles(math.rad((v1:NextNumber(-25, 25))), math.rad((v1:NextNumber(-15, 15))), (math.rad((v1:NextNumber(-25, 10)))))

				CFrame.new(v12.Position + Vector3.new(v1:NextNumber(-15, 15), v1:NextNumber(-15, 15), v1:NextNumber(-15, 15)))

				local v14, v15, v16 = Color3.fromRGB(101, 182, 79):ToHSV()
				local v17 = 0.03 or 0.05

				v22.Color = Color3.fromHSV(v14 + v1:NextNumber(-v17, v17), v15, v16)
				v22.Size = Vector3.new(0.5299999713897705, v3, 0.5299999713897705)

				local v19 = 0

				if i == 1 then
					v92 = CFrame.Angles(math.rad((v1:NextNumber(-5, 5))), math.rad(p3), (math.rad((v1:NextNumber(-25, -15)))))
				else
					v19 = v9.Size.Y

					local v25 = v9:GetPivot()

					if math.ceil(p2 / 2.5) <= i then
						v92 = CFrame.Angles(math.rad((v1:NextNumber(-10, 10))), 0, (math.rad((v1:NextNumber(-30, -10)))))
					end

					if i > 5 then
						v12, v92 = v25, CFrame.Angles(math.rad((v1:NextNumber(-15, 15))), math.rad((v1:NextNumber(-15, 15))), (math.rad((v1:NextNumber(-5, 15)))))
					else
						v12 = v25
					end
				end

				v22.CFrame = v12 * CFrame.new(0, v19 / 2.1, 0) * v92 * CFrame.new(0, v3 / 2.1, 0)

				if v2.Position.Y > v22.Position.Y then
					local v36 = v12 * CFrame.new(0, v19 / 2.1, 0)
					local Unit = Vector3.new(v1:NextNumber(-0.2, 0.2), 1, v1:NextNumber(-0.2, 0.2)).Unit
					local _, v39, _2 = v92:ToEulerAnglesYXZ()

					v22.CFrame = v36 * (CFrame.new(Vector3.new(0, 0, 0), Unit) * CFrame.Angles(0, v39, 0)) * CFrame.new(0, v3 / 2.1, 0)
				end

				v22.Name = v10
				v22.Parent = p1

				if v1:NextInteger(1, 6) == 1 then
					local v40 = script.Flower:Clone()
					local v41 = v22:GetPivot()
					local Angles2 = CFrame.Angles

					v40:PivotTo(v41 * Angles2(0, math.rad((v1:NextInteger(0, 360))), 1.5707963267948966))

					for v43, v44 in v40:GetChildren() do
						v44.Name = tonumber(v44.Name) + v10
						v44.Parent = p1
					end
				end

				if v1:NextInteger(1, 15) == 1 then
					local v46 = script.Leaf:Clone()
					local v47 = v22:GetPivot()

					v46:PivotTo(v47 * CFrame.Angles(0, math.rad((v1:NextInteger(0, 360))), (math.rad((v1:NextInteger(60, 120))))))

					for v51, v52 in v46:GetChildren() do
						v52.Name = tonumber(v52.Name) + v10
						v52.Parent = p1
					end
				end

				v10 = v10 + 1
				v9 = v22
			end

			local v54 = script.Leaf:Clone()
			local v55 = v9:GetPivot()

			v54:PivotTo(v55 * CFrame.Angles(0, math.rad((v1:NextInteger(0, 360))), (math.rad((v1:NextInteger(60, 120))))))

			for v59, v60 in v54:GetChildren() do
				local v62 = tonumber(v60.Name)

				v60.Name = v62 + tonumber(v9.Name)
				v60.Parent = p1
			end

			local v64 = CreatePart()

			v64.Size = Vector3.new(1, 1, 1)
			v64.CFrame = v9:GetPivot() * CFrame.new(0, v9.Size.Y / 2, 0)
			v64.Orientation = Vector3.new(0, 0, 180)
			v64.Parent = p1.FruitSpawnLocations
			v9 = nil
		end

		for i = 1, count do
			local count2 = v1:NextInteger(3, 6)

			while v1:NextInteger(1, 8) == 1 and count2 < 13 do
				count2 = count2 + 1
			end

			generateTrunk(v2, math.floor(count2), 360 / count * i + v1:NextInteger(-15, 15))
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 200 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 218 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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