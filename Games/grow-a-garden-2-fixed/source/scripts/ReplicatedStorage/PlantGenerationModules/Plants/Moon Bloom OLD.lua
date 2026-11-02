--credit to leon games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 18 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v12 + v1:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v2, v3), v5, v2, v3
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

		local t = {
			Color3.fromRGB(23, 212, 255),
			Color3.fromRGB(255, 55, 255),
			Color3.fromRGB(43, 135, 255),
			Color3.fromRGB(158, 48, 255)
		}
		local _ = Base.CFrame
		local v2 = 3
		local v3 = nil
		local v4 = Color3.fromRGB(0, 29, 79)
		local v5 = Color3.fromRGB(0, 87, 163)

		local function generateTrunk(p12, p2, p3) --[[ generateTrunk | Line: 74 | Upvalues: v1 (copy), v4 (copy), v5 (copy), v3 (ref), p1 (copy), t (copy), CreatePart (copy), v2 (ref) ]]
			local v12 = p12:GetPivot() * CFrame.new(0, p12.Size.Y / 2, 0)

			for i = 1, p2 do
				local v22
				local v32 = script.Stud_Part:Clone()
				local v42 = 5 + v1:NextNumber(-2, 3)
				local v10 = CFrame.Angles(math.rad((v1:NextNumber(-15, 15))), math.rad((v1:NextNumber(-15, 15))), (math.rad((v1:NextNumber(-15, 15)))))

				CFrame.new(v12.Position + Vector3.new(v1:NextNumber(-15, 15), v1:NextNumber(-15, 15), v1:NextNumber(-15, 15)))
				v32.Color = v4:Lerp(v5, (math.clamp(i / p2, 0, 1)))
				v32.Size = Vector3.new(1.2999999523162842, v42, 1.2999999523162842)

				if v3 then
					v22 = v3.Size.Y
					v12 = v3:GetPivot()
				else
					v22 = 0
				end

				v32.CFrame = v12 * CFrame.new(0, v22 / 2.1, 0) * v10 * CFrame.new(0, v42 / 2.1, 0)
				v32.Name = i
				v32.Parent = p1

				local v16 = v32:Clone()

				v16.Size = Vector3.new(v32.Size.X * 1.05, v32.Size.X * 1.05, v32.Size.X * 1.05)
				v16.Color = Color3.fromRGB(110, 72, 223)
				v16.Name = i + 1
				v16.Parent = p1

				if i == p2 then
					local v20 = v1:NextNumber(4, 8)

					for j = 1, v20 do
						local v21 = script.Branch:Clone()
						local v222 = v32:GetPivot() * CFrame.new(0, v32.Size.Y / 2, 0)

						v21:PivotTo(v222 * CFrame.Angles(0, math.rad(360 / v20 * j + v1:NextInteger(-15, 15)), (math.rad((v1:NextInteger(5, 35))))))
						v21:ScaleTo(v1:NextNumber(0.8, 1.1))
						v21[4].Color = t[math.random(1, #t)]

						for v26, v27 in v21:GetChildren() do
							local v29 = tonumber(v27.Name)

							v27.Name = v29 + tonumber(v32.Name)
							v27.Parent = p1
						end

						v21:Destroy()
					end

					local v31 = CreatePart()

					v31.Size = Vector3.new(1, 1, 1)
					v31.CFrame = v32:GetPivot() * CFrame.new(0, v32.Size.Y / 2, 0) * CFrame.Angles(math.pi, 0, 0)
					v31.Parent = p1.FruitSpawnLocations
				else
					local v322 = script.Leaf:Clone()
					local v33 = v32:GetPivot()

					v322:PivotTo(v33 * CFrame.Angles(math.rad((v1:NextInteger(-22, 22))), math.rad((v1:NextInteger(0, 360))), (math.rad((v1:NextInteger(70, 100))))))
					v322:ScaleTo(v1:NextNumber(0.7, 1.1))

					for v39, v40 in v322:GetChildren() do
						local v422 = tonumber(v40.Name)

						v40.Name = v422 + tonumber(v32.Name)
						v40.Parent = p1
					end
				end

				v2 = v2 + 1
				v3 = v32
			end

			v3 = nil
		end

		local sum = v1:NextInteger(6, 8)

		while v1:NextInteger(1, 30) == 1 do
			sum = sum + v1:NextInteger(7, 11)

			while v1:NextInteger(1, 10) == 1 do
				sum = sum * 2
			end
		end

		generateTrunk(Base, math.floor(sum), Base:GetPivot())

		while v1:NextInteger(1, 30) == 1 do
			generateTrunk(Base, math.floor(sum), Base:GetPivot())
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 188 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local t2 = {}

				for v5, v6 in v2:GetChildren() do
					if v6:IsA("Decal") then
						table.insert(t2, { v6, v6.Transparency })
						v6.Transparency = 1
					end
				end

				table.insert(t, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4,
					t2
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 216 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v9 = math.min(v1 - v3[4], 1)

				if v9 > 0 then
					v4.Size = Vector3.new(v5.X, v5.Y * v9, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(0, (v4.Size.Y - v5.Y) / 2, 0)
					v4.Transparency = v4:GetAttribute("OG_Transparency") or 0
					v4.CanCollide = true
				else
					v4.Transparency = 1
					v4.CanCollide = false
				end

				local v11 = if v9 >= 1 then true else false

				for v12, v13 in v3[5] do
					v13[1].Transparency = if v11 then v13[2] or 1 else 1
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}