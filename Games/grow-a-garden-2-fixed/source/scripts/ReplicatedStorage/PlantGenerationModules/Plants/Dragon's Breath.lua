--credit to prince games studio
local MaterialService = game:GetService("MaterialService")

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 | Upvalues: MaterialService (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Anchored == false then
					v:AddTag("OriginallyNotAnchored")
				end

				v.Anchored = true
			end
		end

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 30 | Upvalues: v1 (copy) ]]
			local v12, v2, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v12 + v1:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v2, v3), v5, v2, v3
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 38 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v3 = Color3.fromRGB(68, 68, 68)
		local v4 = Color3.fromRGB(163, 62, 59)

		local function generateTrunk(p12, p2, p3) --[[ generateTrunk | Line: 74 | Upvalues: v1 (copy), v3 (copy), v4 (copy), CreatePart (copy), p1 (copy) ]]
			local v12 = p12:GetPivot() * CFrame.new(0, p12.Size.Y / 2, 0)
			local Model = Instance.new("Model")
			local v2 = 0

			for i = 1, p2 do
				local v32 = script.Stud_Part:Clone()
				local v42 = 4 + v1:NextNumber(-1.5, 1.5)
				local v5 = math.min(8, v2 * 0.15)
				local v6 = math.rad(i * 35 + p3)
				local v7 = math.rad((i + 1) * 35 + p3)
				local v10 = v12.Position + Vector3.new(math.cos(v6) * v5, v2, math.sin(v6) * v5)
				local v11 = v2 + v42
				local v122 = math.min(8, v11 * 0.15)
				local v15 = v12.Position + Vector3.new(math.cos(v7) * v122, v11, math.sin(v7) * v122)

				v32.Color = v3:Lerp(v4, (math.clamp(i / p2, 0, 1)))
				v32.Material = Enum.Material.Glacier
				v32.MaterialVariant = "2022 Stud LavaCracks"
				v32.Size = Vector3.new(3, (v15 - v10).Magnitude * 1.12, 3)

				local v17 = v10:Lerp(v15, 0.5)

				v32.CFrame = CFrame.lookAt(v17, v15) * CFrame.Angles(1.5707963267948966, 0, 0)
				v32.CFrame = v32.CFrame * CFrame.Angles(math.pi, 0, 0)
				v32.Name = i
				v32.Parent = Model

				if i % 4 == 0 and i ~= p2 then
					local v18 = CreatePart()
					local v19 = v32.CFrame * CFrame.new(0, 0, v32.Size.Z / 2.1)

					v18:PivotTo(v19 * CFrame.Angles(math.rad((v1:NextInteger(50, 66))), math.rad((v1:NextInteger(-15, 15))), (math.rad((v1:NextInteger(-15, 15))))))
					v18.Parent = p1.FruitSpawnLocations
				elseif i % 2 == 0 and i ~= p2 then
					local v25 = v32:Clone()

					v25.MaterialVariant = "2022 Weld"
					v25.Color = Color3.fromRGB(68, 55, 55)
					v25.Size = Vector3.new(v32.Size.X * 1.1, v32.Size.Y * 0.5, v32.Size.Z * 1.1)
				end

				if i == p2 then
					local v29 = script.Dragon:Clone()

					v29:PivotTo(v32:GetPivot() * CFrame.new(0, v32.Size.Y / 2, 0))

					for v30, v31 in v29:GetDescendants() do
						if tonumber(v31.Name) ~= nil then
							v31.Name = tonumber(v31.Name) + i
						end
					end

					v29.Parent = p1
				end

				v2 = v11
			end

			Model.Parent = p1
		end

		local v5 = v1:NextInteger(6, 10)
		local sum = v5 + math.clamp(math.ceil((p3 or 1) * 1.33 * 2), 0, 20)

		while v1:NextInteger(1, 5) == 1 do
			sum = sum + v1:NextInteger(1, 3)
		end

		while v1:NextInteger(1, 100) == 1 do
			sum = sum * 2

			if v1:NextInteger(1, 4) == 1 then
				sum = sum * 2
			end
		end

		generateTrunk(Base, math.floor(sum), 180)

		local sum2 = sum + math.random(-1, 1)

		while v1:NextInteger(1, 5) == 1 do
			sum2 = sum2 + v1:NextInteger(1, 3)
		end

		generateTrunk(Base, math.floor(sum2), 0)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 182 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 210 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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

					for v11, v12 in v4:GetDescendants() do
						if v12:IsA("ParticleEmitter") then
							v12.Enabled = true
						end
					end
				else
					v4.Transparency = 1
					v4.CanCollide = false

					for v13, v14 in v4:GetDescendants() do
						if v14:IsA("ParticleEmitter") then
							v14.Enabled = false
						end
					end
				end

				local v15 = if v9 >= 1 then true else false

				for v16, v17 in v3[5] do
					v17[1].Transparency = if v15 then v17[2] or 1 else 1
				end
			end

			local v20 = p1:GetAttribute("Age")

			if not (math.round(v20) / p1:GetAttribute("MaxAge") >= 1) or p1:GetAttribute("Setup") then
				return
			end

			for k, v in pairs(p1:GetDescendants()) do
				if v:IsA("BasePart") and v:HasTag("OriginallyNotAnchored") then
					v.Anchored = false
				end
			end

			p1:SetAttribute("Setup", true)
			task.spawn(function() --[[ Line: 260 | Upvalues: p1 (ref) ]]
				if not p1:HasTag("InitializationComplete") then
					repeat
						task.wait(0.2)
					until p1:HasTag("InitializationComplete")
				end

				task.wait(1)

				for v1, v2 in p1:GetChildren() do
					if v2.Name == "Dragon" and not v2:HasTag("DragonBreath") then
						v2:AddTag("DragonBreath")
					end
				end
			end)
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	Extras = {}
}