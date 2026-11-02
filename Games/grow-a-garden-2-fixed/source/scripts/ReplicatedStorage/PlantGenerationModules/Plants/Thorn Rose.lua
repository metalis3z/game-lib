--credit to quartz games studio
local Thorn = script.Thorn

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 8 | Upvalues: Thorn (copy) ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local v2 = Color3.fromRGB(34, 120, 42)
		local v3 = Color3.fromRGB(180, 35, 35)
		local t = { p1 }
		local v4 = RaycastParams.new()

		v4.FilterDescendantsInstances = t
		v4.FilterType = Enum.RaycastFilterType.Exclude

		local Position = (Base.CFrame * CFrame.new(0, Base.Size.Y / 2 + 0.5, 0)).Position
		local v5 = Vector3.new(0, 1, 0)
		local Y = Position.Y
		local LookVector = Base.CFrame.LookVector
		local v6 = LookVector - LookVector:Dot(v5) * v5

		if v6.Magnitude < 0.01 then
			v6 = Base.CFrame.RightVector
		end

		local Unit = v6.Unit
		local t2 = {}

		local function getTangent(p1, p2) --[[ getTangent | Line: 46 ]]
			local v1 = p2 - p2:Dot(p1) * p1

			if v1.Magnitude < 0.01 then
				local v2 = p1:Cross(Vector3.new(1, 0, 0))

				v1 = if v2.Magnitude < 0.01 then p1:Cross(Vector3.new(0, 0, 1)) else v2
			end

			return v1.Unit
		end

		local function probe(p1, p2, p3) --[[ probe | Line: 55 | Upvalues: v4 (copy) ]]
			if p2.Magnitude < 0.01 then
				return nil
			end

			return workspace:Raycast(p1, p2.Unit * (p3 or 15), v4)
		end

		local function loopPenalty(p1) --[[ loopPenalty | Line: 60 | Upvalues: t2 (copy) ]]
			local sum = 0

			for v1, v2 in t2 do
				local Magnitude = (p1 - v2).Magnitude

				if Magnitude < 8 then
					sum = sum + (8 - Magnitude) * 5
				end
			end

			return sum
		end

		local function addToHistory(p1) --[[ addToHistory | Line: 71 | Upvalues: t2 (copy) ]]
			table.insert(t2, p1)

			if not (#t2 > 12) then
				return
			end

			table.remove(t2, 1)
		end

		local t3 = {}
		local v7 = 0

		for i = -1, 1 do
			for j = -1, 1 do
				for k = -1, 1 do
					if i ~= 0 or (j ~= 0 or k ~= 0) then
						local Unit2 = Vector3.new(i, j, k).Unit

						table.insert(t3, Unit2)
					end
				end
			end
		end

		local t4 = {
			(Vector3.new(1, 2, 0)).Unit,
			(Vector3.new(-1, 2, 0)).Unit,
			(Vector3.new(0, 2, 1)).Unit,
			(Vector3.new(0, 2, -1)).Unit,
			(Vector3.new(1, 2, 1)).Unit,
			(Vector3.new(-1, 2, 1)).Unit,
			(Vector3.new(1, 2, -1)).Unit,
			(Vector3.new(-1, 2, -1)).Unit,
			(Vector3.new(1, 3, 0)).Unit,
			(Vector3.new(-1, 3, 0)).Unit,
			(Vector3.new(0, 3, 1)).Unit,
			(Vector3.new(0, 3, -1)).Unit,
			Vector3.new(0, 1, 0)
		}

		local function attachThorn(p12, p2, p3, p4) --[[ attachThorn | Line: 104 | Upvalues: v7 (ref), v1 (copy), Thorn (ref), v3 (copy), p1 (copy), t (copy) ]]
			v7 = v7 + 1

			local v2 = p12.Position + p12.LookVector * v1:NextNumber(-p2.Z * 0.35, p2.Z * 0.35) + p3 * p4
			local v32 = CFrame.lookAt(v2, v2 + p3, p12.LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0)
			local v4 = Thorn:Clone()

			v4.Size = v4.Size * 0.7
			v4.CFrame = v32
			v4.Color = v3
			v4.Anchored = true
			v4.CanCollide = false
			v4.Transparency = 1
			v4.Name = tostring(v7)
			v4.Parent = p1
			table.insert(t, v4)
		end

		local function attachAllThorns(p1, p2) --[[ attachAllThorns | Line: 128 | Upvalues: attachThorn (copy) ]]
			attachThorn(p1, p2, p1.RightVector, p2.X / 2)
			attachThorn(p1, p2, -p1.RightVector, p2.X / 2)
			attachThorn(p1, p2, p1.UpVector, p2.Y / 2)
			attachThorn(p1, p2, -p1.UpVector, p2.Y / 2)
		end

		for n = 1, 40 do
			table.insert(t2, Position)

			if #t2 > 12 then
				table.remove(t2, 1)
			end

			local v9 = v1:NextNumber(-0.7, 0.7)
			local Position2 = (CFrame.fromAxisAngle(v5, v9) * CFrame.new(Unit)).Position
			local v10 = Position2 - Position2:Dot(v5) * v5

			if v10.Magnitude < 0.01 then
				local v11 = v5:Cross(Vector3.new(1, 0, 0))

				v10 = if v11.Magnitude < 0.01 then v5:Cross(Vector3.new(0, 0, 1)) else v11
			end

			local Unit2 = v10.Unit
			local v13 = Position + v5 * 0.3
			local t5 = {}

			for v14, v15 in t3 do
				local v16 = if v15.Magnitude < 0.01 then nil else workspace:Raycast(v13, v15.Unit * 15, v4)

				if v16 then
					table.insert(t5, v16)
				end
			end

			for v17, v18 in t4 do
				local v19 = if v18.Magnitude < 0.01 then nil else workspace:Raycast(v13, v18.Unit * 15, v4)

				if v19 then
					table.insert(t5, v19)
				end
			end

			local v20 = (-1 / 0)
			local v21 = nil
			local v22 = nil
			local v23 = nil

			for v25, v26 in t5 do
				local v24
				local Normal = v26.Normal
				local v27 = v26.Position + Normal * 0.5
				local Magnitude = (v27 - Position).Magnitude

				if not (Magnitude < 0.3) then
					local v28, v29, sum, v30, v31, sum2, v32, sum3, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43

					if Magnitude > 3.5999999999999996 then
						v27 = Position + (v26.Position - Position).Unit * 3

						local v45 = -Normal

						v24 = if v45.Magnitude < 0.01 then nil else workspace:Raycast(v27 + Normal * 2, v45.Unit * 4, v4)

						if v24 then
							v27 = v24.Position + v24.Normal * 0.5
							Normal = v24.Normal
						end

						Magnitude = (v27 - Position).Magnitude

						if not (Magnitude < 0.3) then
							v28 = Normal.Y
							v29 = 1 - math.abs(v28)
							sum = (v27.Y - Position.Y) * 15 + v29 * 20 + (v27.Y - Y) * 2 + math.max(0, 15 - Magnitude) * 0.3
							v30 = v27 - Position

							if v30.Magnitude > 0.01 then
								sum = sum + v30.Unit:Dot(Unit2) * 2
							end

							v31 = v27
							sum2 = 0

							for v47, v48 in t2 do
								v32 = (v31 - v48).Magnitude

								if v32 < 8 then
									sum2 = sum2 + (8 - v32) * 5
								end
							end

							sum3 = sum - sum2

							if v27.Y < Y then
								sum3 = sum3 - (Y - v27.Y) * 5
							end

							if v20 < sum3 then
								v33 = Vector3.new(0, 1, 0) - (Vector3.new(0, 1, 0)):Dot(Normal) * Normal

								if v33.Magnitude < 0.01 then
									v34 = Normal:Cross(Vector3.new(1, 0, 0))

									if v34.Magnitude < 0.01 then
										v35 = Normal:Cross(Vector3.new(0, 0, 1))
										v33 = v35
									else
										v33 = v34
									end
								end

								v36 = v33.Unit
								v37 = Unit2 - Unit2:Dot(Normal) * Normal

								if v37.Magnitude < 0.01 then
									v38 = Normal:Cross(Vector3.new(1, 0, 0))

									if v38.Magnitude < 0.01 then
										v39 = Normal:Cross(Vector3.new(0, 0, 1))
										v37 = v39
									else
										v37 = v38
									end
								end

								v40 = v36 * 0.7 + v37.Unit * 0.3

								if v40.Magnitude > 0.01 then
									v41 = v40 - v40:Dot(Normal) * Normal

									if v41.Magnitude < 0.01 then
										v42 = Normal:Cross(Vector3.new(1, 0, 0))

										if v42.Magnitude < 0.01 then
											v43 = Normal:Cross(Vector3.new(0, 0, 1))
											v41 = v43
										else
											v41 = v42
										end
									end

									v22 = v41.Unit
									v20 = sum3
									v21 = v27
									v23 = Normal

									continue
								end

								v20 = sum3
								v21 = v27
								v22 = v36
								v23 = Normal
							end
						end
					else
						v28 = Normal.Y
						v29 = 1 - math.abs(v28)
						sum = (v27.Y - Position.Y) * 15 + v29 * 20 + (v27.Y - Y) * 2 + math.max(0, 15 - Magnitude) * 0.3
						v30 = v27 - Position

						if v30.Magnitude > 0.01 then
							sum = sum + v30.Unit:Dot(Unit2) * 2
						end

						v31 = v27
						sum2 = 0

						for v47, v48 in t2 do
							v32 = (v31 - v48).Magnitude

							if v32 < 8 then
								sum2 = sum2 + (8 - v32) * 5
							end
						end

						sum3 = sum - sum2

						if v27.Y < Y then
							sum3 = sum3 - (Y - v27.Y) * 5
						end

						if v20 < sum3 then
							v33 = Vector3.new(0, 1, 0) - (Vector3.new(0, 1, 0)):Dot(Normal) * Normal

							if v33.Magnitude < 0.01 then
								v34 = Normal:Cross(Vector3.new(1, 0, 0))

								if v34.Magnitude < 0.01 then
									v35 = Normal:Cross(Vector3.new(0, 0, 1))
									v33 = v35
								else
									v33 = v34
								end
							end

							v36 = v33.Unit
							v37 = Unit2 - Unit2:Dot(Normal) * Normal

							if v37.Magnitude < 0.01 then
								v38 = Normal:Cross(Vector3.new(1, 0, 0))

								if v38.Magnitude < 0.01 then
									v39 = Normal:Cross(Vector3.new(0, 0, 1))
									v37 = v39
								else
									v37 = v38
								end
							end

							v40 = v36 * 0.7 + v37.Unit * 0.3

							if v40.Magnitude > 0.01 then
								v41 = v40 - v40:Dot(Normal) * Normal

								if v41.Magnitude < 0.01 then
									v42 = Normal:Cross(Vector3.new(1, 0, 0))

									if v42.Magnitude < 0.01 then
										v43 = Normal:Cross(Vector3.new(0, 0, 1))
										v41 = v43
									else
										v41 = v42
									end
								end

								v22 = v41.Unit
								v20 = sum3
								v21 = v27
								v23 = Normal

								continue
							end

							v20 = sum3
							v21 = v27
							v22 = v36
							v23 = Normal
						end
					end
				end
			end

			if not v21 then
				for v50, v51 in {
					(Unit2 - Vector3.new(0, 1, 0)).Unit,
					Vector3.new(-0, -1, -0),
					(Unit2 * 0.5 - Vector3.new(0, 1, 0)).Unit,
					(-Unit2 * 0.5 - Vector3.new(0, 1, 0)).Unit,
					(CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 1.5707963267948966) * CFrame.new(Unit2)).Position.Unit - Vector3.new(0, 0.5, 0),
					(CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -1.5707963267948966) * CFrame.new(Unit2)).Position.Unit - Vector3.new(0, 0.5, 0)
				} do
					local v49

					if v51.Magnitude > 0.01 then
						local Unit3 = v51.Unit

						v49 = if Unit3.Magnitude < 0.01 then nil else workspace:Raycast(Position + v5 * 0.3, Unit3.Unit * 30, v4)

						if v49 then
							local v54 = v49.Position + v49.Normal * 0.5

							if (v54 - Position).Magnitude >= 0.3 then
								v23 = v49.Normal

								local Normal = v49.Normal
								local v55 = Unit2 - Unit2:Dot(Normal) * Normal

								if v55.Magnitude < 0.01 then
									local v56 = Normal:Cross(Vector3.new(1, 0, 0))

									v55 = if v56.Magnitude < 0.01 then Normal:Cross(Vector3.new(0, 0, 1)) else v56
								end

								v22 = v55.Unit
								v21 = v54

								break
							end
						end
					end
				end

				if not v21 then
					v22 = Unit2
					v21 = Position + Vector3.new(0, 3, 0)
					v23 = Vector3.new(0, 1, 0)
				end
			end

			local v58 = v21 - Position

			if v58.Magnitude < 0.1 then
				v21 = Position + Unit2 * 3
				v58 = v21 - Position
			end

			local v59 = Stud_Part:Clone()

			v59.Size = Vector3.new(1, 1, v58.Magnitude)
			v59.CFrame = CFrame.lookAt((Position + v21) / 2, v21, v23)
			v59.Anchored = true
			v59.CanCollide = false
			v59.Transparency = 1
			v59.Color = v2
			v59.Name = tostring(n)
			v59.Parent = p1
			table.insert(t, v59)
			attachAllThorns(v59.CFrame, v59.Size)

			if v1:NextNumber() <= 0.1 then
				local Fruit_Spawn = Instance.new("Part")

				Fruit_Spawn.Size = Vector3.new(1, 1, 1)
				Fruit_Spawn.Transparency = 1
				Fruit_Spawn.Anchored = true
				Fruit_Spawn.CanCollide = false
				Fruit_Spawn.CFrame = CFrame.new(v59.CFrame.Position + v59.CFrame.UpVector * (v59.Size.Y / 2 + 0.5))
				Fruit_Spawn.Name = "Fruit_Spawn"
				Fruit_Spawn.Parent = FruitSpawnLocations
			end

			v4.FilterDescendantsInstances = t
			Position, v5, Unit = v21, v23, v22
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 301 ]]
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

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4,
					decals = t2
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 331 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v5 = math.min(v1 - v3.partAge, 1)

				if v5 > 0 then
					local v6 = v3.maxSize.Z * v5

					v3.part.Size = Vector3.new(v3.maxSize.X, v3.maxSize.Y, v6)
					v3.part.CFrame = PrimaryPart.CFrame * v3.centerOffset * CFrame.new(0, 0, (v3.maxSize.Z - v6) / 2)
					v3.part.Transparency = v3.part:GetAttribute("OG_Transparency") or 0
					v3.part.CanCollide = true

					for v8, v9 in v3.decals do
						v9.decal.Transparency = v9.originalTransparency + (1 - v9.originalTransparency) * (1 - v5)
					end

					continue
				end

				v3.part.Transparency = 1
				v3.part.CanCollide = false

				for v10, v11 in v3.decals do
					v11.decal.Transparency = 1
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