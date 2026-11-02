--credit to quartz games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = (p3 or 1) + 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 21 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v1 + v2:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v22, v3), v5, v22, v3
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 29 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v3 = 1 * v1
		local v4 = 0.35 * v1

		local function generateTrunk(p12) --[[ generateTrunk | Line: 62 | Upvalues: p1 (copy), v3 (copy), v4 (copy), v2 (copy), FruitSpawnLocations (copy) ]]
			local Segment = p1.Segment

			Segment:ScaleTo(v3)

			local v1 = Segment

			for i = 1, p12 do
				local v42 = math.lerp(v3, v4, i / p12)
				local v5 = Segment:Clone()

				v5:ScaleTo(v42)

				local Y = v1:FindFirstChildWhichIsA("Part").Size.Y

				v5:PivotTo(v1:GetPivot() * CFrame.new(0, Y, 0))

				local v6 = v5:GetPivot()

				v5:PivotTo(v6 * CFrame.Angles(math.rad((v2:NextInteger(-15, 15))), math.rad((v2:NextInteger(-15, 15))), (math.rad((v2:NextInteger(-15, 15))))))
				v5.Parent = p1

				for v12, v13 in v5:GetDescendants() do
					if v13.Name == "3" and v2:NextInteger(1, 2) == 1 then
						v13.Color = Color3.fromRGB(79, 186, 37)
					end

					if v13:IsA("Model") then
						local v14 = v13:GetPivot()

						v13:PivotTo(v14 * CFrame.Angles(math.rad((v2:NextInteger(-10, 10))), math.rad((v2:NextInteger(-10, 10))), (math.rad((v2:NextInteger(-10, 10))))))
					end
				end

				for v20, v21 in v5:GetDescendants() do
					if tonumber(v21.Name) then
						v21.Name = tonumber(v21.Name) + i
					end
				end

				for k, v in pairs(v5:GetDescendants()) do
					if v.Name == "Spawn" then
						v.Parent = FruitSpawnLocations
					end
				end

				v1 = v5
			end

			local top = p1.top

			top:PivotTo(v1:GetPivot() * CFrame.new(0, v1:FindFirstChildWhichIsA("Part").Size.Y, 0))
			top:ScaleTo(v1:GetScale() * 2)

			for v24, v25 in top:GetDescendants() do
				if v25.Name == "2" and v2:NextInteger(1, 2) == 1 then
					v25.Color = Color3.fromRGB(79, 186, 37)
				end

				if v25:IsA("Model") then
					local v26 = v25:GetPivot()

					v25:PivotTo(v26 * CFrame.Angles(math.rad((v2:NextInteger(-10, 10))), math.rad((v2:NextInteger(-10, 10))), (math.rad((v2:NextInteger(-10, 10))))))
				end
			end

			for v32, v33 in top:GetDescendants() do
				if tonumber(v33.Name) then
					v33.Name = tonumber(v33.Name) + p12 + 1
				end
			end
		end

		local v5 = v2:NextInteger(5, 7)

		while v2:NextInteger(1, 100) == 1 do
			v5 = v5 * 2
		end

		generateTrunk((math.floor((math.clamp(v5 * math.clamp(v1 / 2, 1, 100), 0.5, 100)))))
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 144 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 172 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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