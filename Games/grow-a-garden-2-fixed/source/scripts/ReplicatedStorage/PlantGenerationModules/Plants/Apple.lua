--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local v3 = p1:GetAttribute("Mutation") ~= nil
		local v4 = Color3.fromRGB(139, 90, 43)
		local v5 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local Size = Base.Size
		local v6 = 2 + (v1 * 0.5 + 0.5)
		local v7 = 7 + (v1 * 0.5 + 0.5)
		local count, v8, v9, v10, v11, v12, v13, v14 = 0, 0.9, {}, {}, 2 + v1, v6, v7, nil

		while v2:NextInteger(1, 200) == 1 do
			v11 = v11 * v2:NextInteger(7, 12)
			v6 = v6 * v2:NextInteger(5, 7)
			v8 = 0.95

			while v2:NextInteger(1, 70) == 1 do
				v6 = v6 * v2:NextInteger(2, 3)
				v11 = v11 * v2:NextInteger(2, 3)
			end
		end

		for i = 1, v11 do
			if v12 > 0.5 then
				local v15 = Stud_Part:Clone()

				v15.Size = Vector3.new(v12, v13, v12)
				v15.CFrame = v5 * CFrame.new(0, v15.Size.Y / 2 + Size.Y / 2, 0)

				if not v3 then
					v15.Color = v4
				end

				v15.Parent = p1
				count = count + 1
				v15.Name = tostring(count)
				v5 = v15.CFrame
				Size = v15.Size
				table.insert(v9, v15)
				v12, v13, v14 = v12 * v8, v13 * v8, v15
			end
		end

		table.insert(v10, v14)

		local count2 = 0
		local v16 = count + 1

		for k, v in pairs(v9) do
			count2 = count2 + 1

			for j = 1, v2:NextInteger(0, v.Size.Y * 0.5) do
				local v17 = nil
				local count3 = 0

				while v17 == nil and count3 < 50 do
					local v18

					count3 = count3 + 1

					local v19 = v2:NextInteger(0, 360)
					local v21 = math.clamp(v6 * 0.5, 0.1, v.Size.X * 0.5)
					local v22 = Vector3.new(v21, v7, v21)

					if v14 == v then
						local v23 = v.CFrame * CFrame.new(0, -v2:NextInteger(-v.Size.Y * 3, v.Size.Y * 10) * 0.04, 0)
						local Angles = CFrame.Angles
						local v24 = math.rad(v19)
						local v25 = v2:NextInteger(45, 70)

						v18 = v23 * Angles(0, v24, (math.rad(v25))) * CFrame.new(0, v22.Y / 2, 0)
					else
						local v26 = v.CFrame * CFrame.new(0, -v2:NextInteger(-v.Size.Y * 10, v.Size.Y * 10) * 0.04, 0)
						local Angles = CFrame.Angles
						local v27 = math.rad(v19)
						local v28 = v2:NextInteger(45, 70)

						v18 = v26 * Angles(0, v27, (math.rad(v28))) * CFrame.new(0, v22.Y / 2, 0)
					end

					local Position = v18.Position
					local LookVector = v18.LookVector
					local v29 = true

					for k2, v15 in pairs(v10) do
						if v15 ~= v14 and not table.find(v9, v15) then
							local Magnitude = (v15.Position - Position).Magnitude

							if Magnitude < 5 or Magnitude < 10 and math.deg((math.acos((math.clamp(LookVector:Dot(v15.CFrame.LookVector), -1, 1))))) < 20 then
								v29 = false

								break
							end
						end
					end

					if v29 then
						local v33 = Stud_Part:Clone()

						v33.Size = v22
						v33.CFrame = v18
						v33.Name = tostring(v16)

						if v14 == v and not v3 then
							v33.Color = Color3.new(255/255, 255/255, 255/255)
						end

						v17 = v33

						if not v3 then
							v33.Color = v4
						end

						table.insert(v10, v33)
						v33.Parent = p1
					end
				end
			end
		end

		local v34 = v16 + 1
		local tbl = {}

		for k, v in pairs(v10) do
			local v35 = Stud_Part:Clone()

			v35.Shape = Enum.PartType.Ball

			if v3 then
				v2:NextInteger(250, 375)
				v2:NextInteger(7, 12)
				v2:NextInteger(4, 7)
			else
				local fromHSV = Color3.fromHSV
				local v36 = v2:NextInteger(250, 375) * 0.001

				v35.Color = fromHSV(v36, math.clamp(v2:NextInteger(7, 12), 7, 10) * 0.1, v2:NextInteger(4, 7) * 0.1)
			end

			local v38 = 10 * (v1 * 0.1 + 0.9)
			local v39 = if v14 == v then v38 * 1.5 else v38 * 0.75

			v35.Size = Vector3.new(v39, v39, v39)
			v35.CFrame = v.CFrame * CFrame.new(0, v.Size.Y / 2 + v35.Size.Y / 2 - 1, 0)
			v35.Name = tostring(v34)
			v35.Parent = p1
			table.insert(tbl, v35)
		end

		local v40 = RaycastParams.new()

		v40.FilterType = Enum.RaycastFilterType.Include
		v40.FilterDescendantsInstances = { p1 }

		for k, v in pairs(tbl) do
			local Position = v.Position
			local v41 = v.Size.X / 2

			for k2 = 1, math.round(v.Size.X) * 0.5 do
				local v43 = math.rad((v2:NextInteger(0, 360)))
				local v45 = math.rad((v2:NextInteger(15, 165)))
				local Unit = Vector3.new(math.sin(v45) * math.cos(v43), math.cos(v45), math.sin(v45) * math.sin(v43)).Unit
				local v49 = workspace:Raycast(Position + Unit * (v41 + 5), -Unit * (v41 + 10), v40)

				if v49 and v49.Instance == v then
					local FruitSpawn = Instance.new("Part")

					FruitSpawn.Size = Vector3.new(1, 1, 1)
					FruitSpawn.Transparency = 1
					FruitSpawn.Anchored = true
					FruitSpawn.CanCollide = false
					FruitSpawn.Position = v49.Position
					FruitSpawn.Name = "FruitSpawn"
					FruitSpawn.Parent = FruitSpawnLocations
				end
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 224 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}
		local t2 = {}

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("BasePart") and v2:HasTag("PlantTruss") then
				table.insert(t, v2)

				continue
			end

			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t2, {
					v2,
					v2.Size,
					PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 247 | Upvalues: p1 (copy), t2 (copy), PrimaryPart (copy), t (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t2 do
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

			for v10, v11 in t do
				local v13 = tonumber((v11:GetAttribute("TrunkReference")))

				if v13 then
					if math.min(v1 - v13, 1) >= 1 then
						v11.CanCollide = true

						continue
					end

					v11.CanCollide = false
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