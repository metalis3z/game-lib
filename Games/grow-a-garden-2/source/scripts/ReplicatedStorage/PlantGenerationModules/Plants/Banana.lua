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
		local v3 = if v1 > 2 then if v2:NextInteger(1, 5000) == 1 then true else false else false

		if v3 then
			p1:AddTag("LoopyBanana")
		end

		local v4 = if v2:NextInteger(1, 5000) == 1 then true else false

		if v4 then
			p1:AddTag("SpiralBanana")
		end

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 28 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v5 = v1 + v2:NextNumber(-v4, v4)

			return Color3.fromHSV(v5, v22, v3), v5, v22, v3
		end

		local function CreatePart(p12, p2, p3) --[[ CreatePart | Line: 36 | Upvalues: p1 (copy), MaterialService (ref) ]]
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

		local v5 = Vector3.new(2, 4.5, 2) * v1
		local _ = Base.CFrame
		local Base2 = p1.Base
		local v6 = Color3.fromRGB(149, 105, 80)
		local v7 = Color3.fromRGB(180, 195, 80)

		local function generateTrunk(p12, p2) --[[ generateTrunk | Line: 73 | Upvalues: v2 (copy), v5 (copy), v4 (copy), v6 (copy), v7 (copy), Base2 (ref), Base (copy), p1 (copy), v1 (ref), v3 (copy) ]]
			local v12 = p12:GetPivot()
			local v22 = v2:NextInteger(-9, 9)
			local v32 = v2:NextInteger(-9, 9)

			for i = 1, p2 do
				local v42, v52, v62
				local v72 = script.Stud_Part:Clone()
				local _ = (i - 1) / math.max(p2 - 1, 1)
				local v9 = math.clamp(v5.X - (i - 1) / (p2 - 1) * (v5.X / 3), 1, 10)
				local v10 = v2:NextNumber(-5, 5)

				if v4 then
					v42 = (i - 1) / math.max(p2 - 1, 1) * 1.9 + 0.1
					v52 = 30
					v10 = 0
					v62 = 60
				else
					v42 = 1
					v52 = v22
					v62 = v32
				end

				local v11 = (v5.Y + v2:NextNumber(-2, 2)) * v42
				local v16 = CFrame.Angles(math.rad(v52 + v2:NextNumber(-2, 2)), math.rad(v10), (math.rad(v62 + v2:NextNumber(-2, 2))))

				CFrame.new(v12.Position + Vector3.new(v2:NextNumber(-5, 5), v2:NextNumber(-5, 5), v2:NextNumber(-5, 5)))
				v72.Color = v6:Lerp(v7, (math.clamp(i / p2, 0, 1)))
				v72.Size = Vector3.new(v9, v11, v9)

				local v21 = 0

				if Base2 and Base2 ~= Base then
					v21 = Base2.Size.Y
					v12 = Base2:GetPivot()
				elseif v4 then
					local Angles2 = CFrame.Angles
					local v23 = v2:NextNumber(0, 360)

					v16 = Angles2(0, math.rad(v23), 0) * CFrame.Angles(1.4835298641951802, 0, 0)
				else
					v16 = CFrame.Angles(math.rad(v52 + v2:NextNumber(-2, 2)), math.rad((v2:NextNumber(0, 360))), (math.rad(v52 + v2:NextNumber(-2, 2))))
				end

				v72.CFrame = v12 * CFrame.new(0, v21 / 2.1, 0) * v16 * CFrame.new(0, v11 / 2.1, 0)
				v72.Name = i
				v72.Parent = p1

				if i == p2 then
					local count = v2:NextNumber(3, 6)

					while v2:NextInteger(1, 10) == 1 and count < 30 do
						count = count + 1
					end

					for j = 1, count do
						local v30 = script.SpawnWing:Clone()
						local v31 = v72:GetPivot() * CFrame.new(0, v72.Size.Y / 2, 0)
						local Angles2 = CFrame.Angles
						local v33 = math.rad((v2:NextInteger(-5, 5)))
						local v35 = math.rad(360 / count * j + v2:NextInteger(-15, 15))
						local v36 = v2:NextInteger(-5, 5)

						v30:PivotTo(v31 * Angles2(v33, v35, (math.rad(v36))) * CFrame.Angles(0.8726646259971648, 0, 0))
						v30:ScaleTo(v2:NextNumber(0.6, 1.1) * v1)
						v30.FruitSpawn.Parent = p1.FruitSpawnLocations

						for v37, v38 in v30:GetChildren() do
							local v40 = tonumber(v38.Name)

							v38.Name = v40 + tonumber(v72.Name)
							v38.Parent = p1
						end

						v30:Destroy()
					end
				end

				if i == p2 then
					local v422 = v2:NextNumber(3, 6)

					for k = 1, v422 do
						local count = v2:NextInteger(6, 8)

						while v2:NextInteger(1, 6) == 1 and count < 30 do
							count = count + 1
						end

						while v2:NextInteger(1, 1000) == 1 do
							count = count * 2
						end

						local v43 = nil
						local v44 = v2:NextInteger(12, 19)
						local v48 = Vector3.new(v2:NextNumber(1, 2), v2:NextNumber(2.5, 3), v2:NextNumber(4, 5.5)) * v1

						if count > 17 then
							v44 = 4
						elseif count > 12 then
							v44 = 7
						end

						if v3 then
							local v49 = v2:NextInteger(22, 28)

							count, v44 = v49, math.ceil(400 / v49)
						end

						for n = 1, count do
							local v51
							local v522 = script.Stud_Part:Clone()

							v522.Color = Color3.fromRGB(126, 180, 40)
							v522.Material = Enum.Material.Glacier
							v522.MaterialVariant = "2022 Weld"

							local v53 = 1 - ((n - 1) / math.max(count - 1, 1)) ^ 1.15 * 0.7

							v522.Size = Vector3.new(v48.Z * v53, v48.Y, v48.X * v53)

							if n == 1 then
								local v56 = v72.CFrame * CFrame.new(0, v72.Size.Y / 2, 0)
								local v622 = v56 * CFrame.Angles(math.rad((v2:NextInteger(-7, 7))), math.rad(360 / v422 * k + v2:NextInteger(-7, 7)), (math.rad((v2:NextInteger(-7, 7)))))
								local Angles3 = CFrame.Angles
								local v63 = v2:NextInteger(55, 60)

								v51 = v622 * Angles3(math.rad(v63), 0, 0) * CFrame.new(0, v522.Size.Y / 2, 0)
							else
								local v64 = v43:GetPivot() * CFrame.new(0, v43.Size.Y / 2, 0)
								local Angles2 = CFrame.Angles
								local v66 = math.rad(v44 + v2:NextNumber(-2, 2))
								local v68 = math.rad((v2:NextNumber(-5, 5)))
								local v69 = v2:NextNumber(-3, 3)

								v51 = v64 * Angles2(v66, v68, (math.rad(v69))) * CFrame.new(0, v522.Size.Y / 2, 0)
							end

							if n == 1 then
								v522.Size = v522.Size - Vector3.new(v522.Size.X / 1.5, 0, v522.Size.Z / 2)
							end

							v522:PivotTo(v51)
							v522.Name = n + p2
							v522.Parent = p1
							v43 = v522
						end
					end
				end

				Base2 = v72
			end

			Base2 = nil
		end

		local sum = v2:NextInteger(4, 8)

		while v2:NextInteger(1, 8) == 1 do
			sum = sum + 1.5
		end

		if v2:NextInteger(1, 1000) == 1 then
			sum = sum * 2
		end

		if v4 then
			sum = v2:NextInteger(15, 20)
		end

		generateTrunk(Base, math.floor(sum), true)
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 284 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 302 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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