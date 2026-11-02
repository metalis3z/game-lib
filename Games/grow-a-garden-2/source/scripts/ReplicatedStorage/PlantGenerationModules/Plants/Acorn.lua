--credit to leon games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 9 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local v2 = (p3 or 1) * 0.25 + 0.75

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 18 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v12 + v1:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v2, v3), v5, v2, v3
		end

		local v3, v4, v5 = Color3.fromRGB(120, 95, 80):ToHSV()
		local v6 = 0.03 or 0.05
		local v8 = Color3.fromHSV(v3 + v1:NextNumber(-v6, v6), v4, v5)
		local v9 = Color3.fromRGB(45, 139, 48)
		local v10 = Color3.fromRGB(62, 162, 62)

		local function Recolor(p1, p2, p3, p4) --[[ Recolor | Line: 29 ]]
			local v1, v2, v3 = p1:ToHSV()

			return Color3.fromHSV(v1 + p2, v2 + p3, v3 + p4)
		end

		local v11, v12, v13 = v8:ToHSV()
		local v14 = Color3.fromHSV(v11 + 0, v12 + 0, v13 + -0.075)

		local function GetLeafColor() --[[ GetLeafColor | Line: 35 | Upvalues: v1 (copy), v9 (copy), v10 (copy) ]]
			return v1:NextInteger(1, 2) == 1 and v9 or v10
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 40 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v15 = v1:NextNumber(4, 4.65) * v2
		local v16 = v1:NextNumber(4.25, 5.25) * v2
		local count = v1:NextInteger(5, 6) * v2
		local v17 = v14

		while v1:NextInteger(1, 4) == 1 and count < 10 do
			count = count + 1
		end

		local v18 = Vector3.new(v15, v16, v15)
		local v19 = p1.Base.CFrame
		local v20 = 1
		local sum = 1 * v2

		local function CreateLeaves(p1, p2, p3, p4) --[[ CreateLeaves | Line: 85 | Upvalues: v1 (copy), v2 (ref), CreatePart (copy), v9 (copy), v10 (copy), FruitSpawnLocations (copy) ]]
			local v12 = v1:NextNumber(5.85, 7.25) * p3 * v2
			local v22 = CreatePart(nil, "2022 Weld")

			v22.Size = Vector3.new(v12, v12 * 0.8, v12)
			v22.CFrame = p1
			v22.Orientation = Vector3.new(v22.Orientation.X * 0.2, v22.Orientation.Y, v22.Orientation.Z * 0.2)
			v22.CFrame = v22.CFrame * CFrame.new(0, v22.Size.Y * 0.35, 0)
			v22.Color = v1:NextInteger(1, 2) == 1 and v9 or v10
			v22.Name = tostring(p2 + 1)

			for i = 1, 2 do
				local v6 = CreatePart(nil, "2022 Weld")

				v6.Size = Vector3.new(v12 * 0.75, v12 * 0.55, v12 * v1:NextNumber(1.2, 1.35))
				v6.CFrame = v22.CFrame * CFrame.Angles(math.rad((v1:NextNumber(-5, 5))), math.rad(i * 90), (math.rad((v1:NextNumber(-5, 5)))))
				v6.Color = v1:NextInteger(1, 2) == 1 and v9 or v10
				v6.Name = tostring(p2 + 2)
			end

			if v1:NextInteger(1, 3) == 1 or p4 then
				local v14 = CreatePart(nil, "2022 Weld")

				v14.Size = Vector3.new(v12 * 0.75, v12 * 0.25, v12 * 0.75)

				local v15 = v22.CFrame * CFrame.new(0, v22.Size.Y / 2, 0)

				v14.CFrame = v15 * CFrame.Angles(math.rad((v1:NextNumber(-10, 10))), math.rad((v1:NextNumber(-10, 10))), 0)
				v14.Color = v1:NextInteger(1, 2) == 1 and v9 or v10
				v14.Name = tostring(p2 + 2)
			end

			if v1:NextInteger(1, 3) == 1 then
				for j = 1, v1:NextInteger(1, 3) do
					local v20 = CreatePart(nil, "2022 Weld")
					local v21 = v1:NextNumber(v12 * 0.65, v12 * 0.75)
					local v222 = v1:NextNumber(-v12, v12) / 2.25
					local v23 = v1:NextNumber(-v12, v12) * 0.35
					local v24 = v1:NextNumber(-v12, v12) / 2.25

					v20.Size = Vector3.new(v21, v21 * 0.75, v21)
					v20.CFrame = v22.CFrame * CFrame.new(v222, v23, v24)
					v20.Color = v1:NextInteger(1, 2) == 1 and v9 or v10
					v20.Name = tostring(p2 + 2)
				end
			end

			if p4 then
				return
			end

			for k = 1, 3 do
				local v26 = CreatePart()
				local v27 = k * 120 + v1:NextNumber(-35, 35)

				v26.Size = Vector3.new(1, 1, 1)
				v26.CFrame = v22.CFrame * CFrame.Angles(0, math.rad(v27), 0) * CFrame.new(0, -v22.Size.Y / 2, v22.Size.Z * 0.35)
				v26.Parent = FruitSpawnLocations
				v26.Transparency = 1
			end
		end

		local function CreateBranch(p1, p2, p3) --[[ CreateBranch | Line: 149 | Upvalues: v20 (ref), CreatePart (copy), v1 (copy), v8 (copy), CreateLeaves (copy), sum (ref) ]]
			local count = 5
			local Y = p2.Y

			if v20 > 3 then
				count = count - 1

				if v20 > 5 then
					count = count - 1
				end
			end

			for i = 1, count do
				local v12 = CreatePart()
				local v2 = v1:NextNumber(-25, -15)

				if i > 2 then
					v2 = -v2

					if i == count then
						v2 = v2 * 1.5
					end
				end

				v12.Size = p2

				local Angles = CFrame.Angles
				local v3 = math.rad(v2)
				local v4 = v1:NextNumber(-10, 10)

				v12.CFrame = p1 * Angles(v3, 0, (math.rad(v4))) * CFrame.new(0, p2.Y / 2.2, 0)
				v12.Color = v8
				v12.Name = tostring(p3 + i)
				p1 = v12.CFrame * CFrame.new(0, p2.Y / 2.2, 0)
				p2 = Vector3.new(p2.X * 0.85, Y * v1:NextNumber(0.925, 1.05), p2.Z * 0.85)
			end

			CreateLeaves(p1, p3 + count, sum)
		end

		for i = 1, count do
			local v21 = CreatePart()

			v21.Size = v18

			local Angles = CFrame.Angles
			local v23 = math.rad((v1:NextNumber(-2, 2)))
			local v24 = v1:NextNumber(-2, 2)

			v21.CFrame = v19 * Angles(v23, 0, (math.rad(v24))) * CFrame.new(0, v18.Y / 2.2, 0)
			v21.Color = v17:Lerp(v8, (math.min((i - 1) / 3, 1)))
			v21.Name = tostring(i)
			v19 = v21.CFrame * CFrame.new(0, v18.Y / 2.2, 0)

			local sum2 = v18.Y * 1.075

			if v1:NextInteger(1, 3) == 1 and i < count - 2 then
				local v25 = CreatePart()

				v25.Size = Vector3.new(v18.X * 0.35, v18.Y * 1.25, v18.Z * 0.35)

				local Angles2 = CFrame.Angles
				local v30 = v1:NextNumber(-180, 180)
				local v31 = v21.CFrame * Angles2(0, math.rad(v30), 0) * CFrame.new(0, 0, -v21.Size.Z / 2)

				v25.CFrame = v31 * CFrame.Angles(math.rad((v1:NextNumber(-60, -40))), 0, 0)
				v25.Color = v8
				v25.Name = tostring(i + 1)
				CreateLeaves(v25.CFrame * CFrame.new(0, v25.Size.Y / 2, 0), i + 1, 0.5, true)
			end

			if i == 1 then
				local v33 = v1:NextInteger(1, 4)

				sum2 = sum2 - 1 * v2

				for j = 1, v33 do
					local v34 = v1:NextInteger(2, 4)
					local v35 = 360 / v33 * j + v1:NextNumber(-20, 20)
					local v36 = Vector3.new(v15 * 0.65, v15 * 0.725, v15 * 0.65)
					local v37 = v21.CFrame * CFrame.new(0, v21.Size.Y * 0.25, 0) * CFrame.Angles(0, math.rad(v35), 1.5707963267948966) * CFrame.new(0, v15 * 0.3, 0)

					for k = 1, v34 do
						local v38 = CreatePart()
						local v39 = v1:NextNumber(47, 41)

						if k > 1 then
							v39 = v1:NextNumber(-20, -13)
						end

						if k == 4 then
							v39 = 0
						end

						v38.Size = v36

						local Angles2 = CFrame.Angles
						local v41 = v1:NextNumber(-20, 20)

						v38.CFrame = v37 * Angles2(math.rad(v41), 0, (math.rad(v39))) * CFrame.new(0, v38.Size.Y / 2.2, 0)
						v38.Color = v17
						v38.Name = tostring(i + k)
						v37 = v38.CFrame * CFrame.new(0, v38.Size.Y / 2.2, 0)
						v36 = v36 * 0.85
					end
				end
			end

			if v20 + 2 < i then
				v20 = i

				local v42 = v1:NextInteger(3, 5)

				for n = 1, v42 do
					local v43 = 360 / v42 * n + i * v1:NextNumber(18, 25)

					CreateBranch(v21.CFrame * CFrame.new(0, -v21.Size.Y * 0.65, 0) * CFrame.Angles(0, math.rad(v43), 0) * CFrame.Angles(-0.6108652381980153, 0, 0), v21.Size * 0.725, i)
				end

				sum = sum - 0.175
			end

			v18 = Vector3.new(v18.X * 0.85, sum2, v18.Z * 0.85)
		end

		CreateLeaves(v19, count, v1:NextNumber(1.475, 1.725))
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 264 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 282 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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