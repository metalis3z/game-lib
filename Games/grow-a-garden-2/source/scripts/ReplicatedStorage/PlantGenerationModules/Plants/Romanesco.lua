--credit to prince games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local v2 = p1.Base:GetPivot()

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 19 | Upvalues: v1 (copy) ]]
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

		local v3 = v1:NextInteger(5, 12)

		for i = 1, v3 do
			local v4 = script.Leaf:Clone()

			v4:ScaleTo(v1:NextNumber(0.7, 1.25))
			v4:PivotTo(v2 * CFrame.Angles(math.rad((v1:NextInteger(-3, 3))), math.rad(360 / v3 * i + v1:NextInteger(-22, 22)), (math.rad((v1:NextInteger(-16, -9))))))

			for v10, v11 in v4:GetChildren() do
				v11.Name = tonumber(v11.Name) + i
				v11.Parent = p1
			end

			v4:Destroy()
		end

		local v13 = v1:NextInteger(2, 4)

		for j = 1, v13 do
			local v14 = script.Leaf:Clone()

			v14:ScaleTo(v1:NextNumber(0.6, 0.9))
			v14:PivotTo(v2 * CFrame.Angles(math.rad((v1:NextInteger(-3, 3))), math.rad(360 / v13 * j + v1:NextInteger(-45, 45)), (math.rad((v1:NextInteger(-25, -15))))))

			for v20, v21 in v14:GetChildren() do
				v21.Name = tonumber(v21.Name) + j
				v21.Parent = p1
			end

			v14:Destroy()
		end

		local v23 = CreatePart()

		v23.Size = Vector3.new(1, 1, 1)
		v23.Position = v2.Position
		v23.Parent = p1.FruitSpawnLocations
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 117 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 135 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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