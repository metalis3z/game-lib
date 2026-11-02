--credit to prince games studio
local MaterialService = game:GetService("MaterialService")

local function GetRandomHSV(p1, p2, p3) --[[ GetRandomHSV | Line: 4 ]]
	local v1, v2, v3 = p2:ToHSV()

	if not p3 then
		p3 = 0.05
	end

	local v4 = v1 + p1:NextNumber(-p3, p3)

	return Color3.fromHSV(v4, v2, v3), v4, v2, v3
end

local function CreatePart(p1, p2, p3, p4) --[[ CreatePart | Line: 13 | Upvalues: MaterialService (copy) ]]
	local Part = Instance.new("Part")

	if not p2 then
		p2 = "Studs"
	end

	Part.Parent = p1
	Part.TopSurface = Enum.SurfaceType[p2]
	Part.BackSurface = Enum.SurfaceType[p2]
	Part.FrontSurface = Enum.SurfaceType[p2]
	Part.BottomSurface = Enum.SurfaceType[p2]
	Part.LeftSurface = Enum.SurfaceType[p2]
	Part.RightSurface = Enum.SurfaceType[p2]
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 0

	if p4 then
		Part.Shape = Enum.PartType[p4]
	end

	if p3 then
		Part.MaterialVariant = p3

		local v1 = MaterialService:FindFirstChild(p3, true)

		if not v1 then
			return Part
		end

		Part.Material = v1.BaseMaterial
	end

	return Part
end

local function CreateMeshPart(p1, p2, p3) --[[ CreateMeshPart | Line: 40 ]]
	local v1 = p2:Clone()

	v1.Parent = p1
	v1.Anchored = true
	v1.CanCollide = false
	v1.Transparency = 0

	if p3 then
		v1.MaterialVariant = p3
	end

	return v1
end

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 57 | Upvalues: CreatePart (copy) ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Leaf = script.Leaf
		local GoopEnd = script.GoopEnd
		local v3 = 0.015
		local v4, v5, v6 = Color3.fromRGB(89, 67, 49):ToHSV()

		if not v3 then
			v3 = 0.05
		end

		local v8 = Color3.fromHSV(v4 + v2:NextNumber(-v3, v3), v5, v6)
		local v9 = 0.04
		local v10, v11, v12 = Color3.fromRGB(126, 62, 255):ToHSV()

		if not v9 then
			v9 = 0.05
		end

		local v14 = Color3.fromHSV(v10 + v2:NextNumber(-v9, v9), v11, v12)
		local v15 = 0.04
		local v16, v17, v18 = Color3.fromRGB(120, 50, 160):ToHSV()

		if not v15 then
			v15 = 0.05
		end

		local v20 = Color3.fromHSV(v16 + v2:NextNumber(-v15, v15), v17, v18)
		local v21, v22 = Color3.fromRGB(170, 85, 255)
		local v23, v24, v25 = v21:ToHSV()

		if not v22 then
			v22 = 0.05
		end

		local v27 = Color3.fromHSV(v23 + v2:NextNumber(-v22, v22), v24, v25)
		local v28 = v2:NextNumber(4, 5) * (v1 * 0.25 + 0.75)
		local v29 = v2:NextNumber(4.25, 5) * (v1 * 0.25 + 0.75)
		local sum = v2:NextInteger(5, 8)
		local v30, sum2 = v27, 1

		while v2:NextInteger(1, 30) == 1 do
			sum = sum + v2:NextInteger(7, 12)
			sum2 = sum2 + 0.5
		end

		local v31 = if v2:NextInteger(1, 6) == 1 then true else false
		local v32 = Vector3.new(v28, v29, v28)
		local v33 = Base.CFrame

		local function CreateLeaves(p12, p2, p3) --[[ CreateLeaves | Line: 91 | Upvalues: Leaf (copy), p1 (copy), v2 (copy), sum2 (ref), v14 (copy), v20 (copy), FruitSpawnLocations (copy) ]]
			local v1 = Leaf:Clone()

			v1.Parent = p1
			v1.Size = Vector3.new(v2:NextNumber(7, 13) * p3 * sum2, v2:NextNumber(4, 7) * p3 * sum2, v2:NextNumber(7, 13) * p3 * sum2)
			v1.CFrame = p12 * CFrame.new(v2:NextNumber(-v1.Size.X, v1.Size.X) * 0.25, v1.Size.Y / 2.25, v2:NextNumber(-v1.Size.Z, v1.Size.Z) * 0.25)
			v1.Name = p2 + 1
			v1.Color = v14

			local v5 = v2:NextInteger(2, 4)
			local v6 = Leaf:Clone()

			v6.Parent = p1
			v6.Size = Vector3.new(v1.Size.X * 0.75, v1.Size.Y * v2:NextNumber(0.75, 1), v1.Size.Z * 0.75)

			local v10 = v1.CFrame * CFrame.new(0, v1.Size.Y / 2.2 + v6.Size.Y / 2.2, 0)

			v6.CFrame = v10 * CFrame.Angles(0, math.rad((v2:NextNumber(-5, 5))), (math.rad((v2:NextNumber(-5, 5)))))
			v6.Name = p2 + 2
			v6.Color = v14

			for i = 1, v5 do
				local v142 = Leaf:Clone()
				local v15 = v2:NextNumber(0.5, v1.Size.X) * 0.6
				local v16 = v2:NextNumber(0, v1.Size.Y) * 0.6
				local v17 = v2:NextNumber(0.5, v1.Size.Z) * 0.6

				if i % 2 == 0 then
					v15 = -v15

					if v2:NextInteger(1, 2) == 1 then
						v17 = -v17
					end
				end

				v142.Parent = p1
				v142.Size = Vector3.new(v1.Size.X * v2:NextNumber(0.65, 0.85), v1.Size.Y * v2:NextNumber(0.75, 1.4), v1.Size.X * v2:NextNumber(0.65, 0.85))
				v142.CFrame = v1.CFrame * CFrame.new(v15, v16, v17)
				v142.Name = p2 + 2
				v142.Color = if i % 2 == 0 then v20 else v14
			end

			for j = 1, v2:NextInteger(2, 3) do
				local v23 = nil
				local Part = Instance.new("Part")

				if not v23 then
					v23 = "Studs"
				end

				Part.Parent = p1
				Part.TopSurface = Enum.SurfaceType[v23]
				Part.BackSurface = Enum.SurfaceType[v23]
				Part.FrontSurface = Enum.SurfaceType[v23]
				Part.BottomSurface = Enum.SurfaceType[v23]
				Part.LeftSurface = Enum.SurfaceType[v23]
				Part.RightSurface = Enum.SurfaceType[v23]
				Part.Anchored = true
				Part.CanCollide = false
				Part.Transparency = 0
				Part.Size = Vector3.new(1, 1, 1)
				Part.CFrame = v1.CFrame * CFrame.new(v2:NextNumber(-v1.Size.X, v1.Size.X) * 0.4, -v1.Size.Y / 2, v2:NextNumber(-v1.Size.Z, v1.Size.Z) * 0.4)
				Part.Parent = FruitSpawnLocations
				Part.Transparency = 1
			end
		end

		local function CreateBranch(p12, p2, p3, p4) --[[ CreateBranch | Line: 145 | Upvalues: v2 (copy), CreatePart (ref), p1 (copy), v8 (copy), CreateLeaves (copy) ]]
			local v1 = v2:NextInteger(2, 3)
			local v3 = p12 * CFrame.Angles(0, 0, (math.rad((v2:NextNumber(45, 70)))))

			for i = 1, v1 do
				local v4 = CreatePart(p1, nil, "Studs 2x2 Plastic")

				v4.Size = p2

				local Angles2 = CFrame.Angles
				local v5 = v2:NextNumber(-25, -10)

				v4.CFrame = v3 * Angles2(0, 0, (math.rad(v5))) * CFrame.new(0, p2.Y / 2.15, 0)
				v4.Color = v8
				v4.Name = p3 + i
				v3 = v4.CFrame * CFrame.new(0, p2.Y / 2.15, 0)
				p2 = p2 * 0.85

				if i == v1 then
					local v7 = CFrame.new(v3.Position)
					local Angles3 = CFrame.Angles

					CreateLeaves(v7 * Angles3(0, math.rad(v4.Orientation.Y), 0), i + p3, p4 or 1)
				end
			end
		end

		local t = {}

		for i = 1, sum do
			local v34 = CreatePart(p1, nil, "Studs 2x2 Plastic")
			local v35 = v2:NextNumber(-5, 5)
			local v36 = v2:NextNumber(-5, 5)

			if v31 then
				local v37 = v2:NextNumber(-15, 15)

				v35, v36 = v37, v2:NextNumber(-15, 15)
			end

			if i == 1 then
				v35 = 0
				v36 = 0
			end

			v34.Size = v32
			v34.CFrame = v33 * CFrame.Angles(math.rad(v35), 0, (math.rad(v36))) * CFrame.new(0, v32.Y / 2.2, 0)
			v34.Color = v8
			v34.Name = i

			if i < sum then
				table.insert(t, v34)
			else
				local v39 = v2:NextInteger(2, 4)

				for j = 1, v39 do
					local v40 = 360 / v39 * j + v2:NextNumber(-20, 20)

					CreateBranch(v34.CFrame * CFrame.new(0, v32.Y / 2.2, 0) * CFrame.Angles(0, math.rad(v40), 0), Vector3.new(v34.Size.X * 0.7, v34.Size.Y * 0.8, v34.Size.Z * 0.7), i, 1.25)
				end
			end

			if v2:NextInteger(1, 3) == 1 then
				local v45 = CreatePart(p1, nil, "Stripes")

				v45.Size = Vector3.new(0.15, v2:NextNumber(1.5, 3.5), 0.15)

				local v47 = CFrame.new(v34.CFrame.Position) * CFrame.Angles(0, 0, math.pi) * CFrame.new(0, v34.Size.X / 2 + v45.Size.Y / 2, 0)
				local Angles = CFrame.Angles

				v45.CFrame = v47 * Angles(0, math.rad((v2:NextNumber(-30, 30))), 0)
				v45.Color = v30
				v45.Name = i + 1

				local v49 = GoopEnd:Clone()

				v49.Parent = p1
				v49:PivotTo(v45.CFrame * CFrame.new(0, v45.Size.Y / 2, 0))

				for v50, v51 in v49:GetChildren() do
					v51.Name = tonumber(v51.Name) + i + 1
					v51.Parent = p1
				end
			end

			v33 = v34.CFrame * CFrame.new(0, v32.Y / 2.2, 0)
			v32 = Vector3.new(math.clamp(v32.X * 0.875, 1, v28), math.clamp(v32.Y * 1.05, 0, v29 + v2:NextNumber(0.75, 1.1)), (math.clamp(v32.Z * 0.875, 1, v28)))
		end

		for k = 1, 2 do
			local sum3 = 360 / sum

			if k == 1 then
				sum3 = sum3 + 180
			end

			local v66 = Base.CFrame * CFrame.new(math.cos((math.rad(sum3))) * v28, 0, math.rad((math.sin(sum3))) * v28)

			for v67, v68 in t do
				local v74 = v68.CFrame * CFrame.new(math.cos((math.rad(sum3))) * v28, 0, math.sin((math.rad(sum3))) * v28)
				local v75 = CreatePart(p1, nil, "Studs 2x2 Plastic")
				local v76 = (v66.Position - v74.Position).Magnitude * 1.1

				v75.Size = Vector3.new(v28 * 0.6, v28 * 0.6, v76)
				v75.CFrame = CFrame.lookAt(v66.Position, v74.Position) * CFrame.new(0, 0, -v76 / 2)
				v75.Color = v8
				v75.Name = v67
				v75:SetAttribute("GrowSide", true)

				if v67 == 2 then
					local v77 = Vector3.new(v28 * 0.55, v76, v28 * 0.55)
					local v78 = v75.CFrame * CFrame.Angles(-0.4363323129985824, 0, 1.5707963267948966) * CFrame.new(0, 0, v2:NextNumber(-v68.Size.Z, v68.Size.Z) * 0.3)

					for n = 1, 2 do
						local v79 = CreatePart(p1, nil, "Studs 2x2 Plastic")

						v79.Size = v77

						local Angles = CFrame.Angles
						local v80 = v2:NextNumber(25, 35)

						v79.CFrame = v78 * Angles(0, 0, (math.rad(v80))) * CFrame.new(0, v79.Size.Y / 2.25, 0)
						v79.Color = v8
						v79.Name = n + 2
						v78 = v79.CFrame * CFrame.new(0, v79.Size.Y / 2.25, 0)

						local Angles2 = CFrame.Angles

						v79.CFrame = v79.CFrame * Angles2(0, math.rad((v2:NextNumber(-25, 25))), 0)
						v77 = v77 * 0.85
					end
				end

				sum3 = sum3 + 360 / sum

				if v67 == #t then
					local v83 = v2:NextInteger(2, 3)
					local v84 = v75.CFrame * CFrame.new(0, 0, -v75.Size.Z / 2) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)

					v66 = v74

					for m = 1, v83 do
						CreateBranch(v84 * CFrame.Angles(0, math.rad(360 / v83 * m + v2:NextNumber(-20, 20)), 0), Vector3.new(v75.Size.X * 0.7, v75.Size.Z * 0.8, v75.Size.Y * 0.7), v67, 0.85)
					end

					continue
				end

				v66 = v74
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 294 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local t2 = {}

				for v5, v6 in v2:GetChildren() do
					if v6:IsA("Decal") or v6:IsA("Texture") then
						table.insert(t2, {
							decal = v6,
							originalTransparency = v6.Transparency
						})
						v6.Transparency = 1
					end
				end

				local t3 = {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decals = t2
				}

				t3.growSide = if v2:GetAttribute("GrowSide") == true then true else false
				table.insert(t, t3)
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 326 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v5 = math.min(v1 - v3.partAge, 1)

				if v5 > 0 then
					if v3.growSide then
						local v6 = v3.maxSize.Z * v5

						v3.part.Size = Vector3.new(v3.maxSize.X, v3.maxSize.Y, v6)
						v3.part.CFrame = PrimaryPart.CFrame * v3.centerOffset * CFrame.new(0, 0, (v3.maxSize.Z - v6) / 2)
					else
						local v8 = v3.maxSize.Y * v5

						v3.part.Size = Vector3.new(v3.maxSize.X, v8, v3.maxSize.Z)
						v3.part.CFrame = PrimaryPart.CFrame * v3.centerOffset * CFrame.new(0, -((v3.maxSize.Y - v8) / 2), 0)
					end

					v3.part.Transparency = v3.part:GetAttribute("OG_Transparency") or 0
					v3.part.CanCollide = true

					for v10, v11 in v3.decals do
						v11.decal.Transparency = v11.originalTransparency + (1 - v11.originalTransparency) * (1 - v5)
					end

					continue
				end

				v3.part.Transparency = 1
				v3.part.CanCollide = false

				for v12, v13 in v3.decals do
					v13.decal.Transparency = 1
				end
			end

			if not game.Players.LocalPlayer or (not game:GetService("RunService"):IsClient() or (p1:GetAttribute("playedSfx") or not (p1:GetAttribute("MaxAge") <= v1))) then
				return
			end

			p1:SetAttribute("playedSfx", true)
			game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy)
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}