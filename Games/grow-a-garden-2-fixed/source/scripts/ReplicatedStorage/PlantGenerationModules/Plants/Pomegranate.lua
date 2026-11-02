--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 6 ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local Stud_Part = script.Stud_Part
		local Position = (Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)).Position
		local v2 = ((p3 or 1) * 0.5 + 0.5) * 0.7

		local function getGreenColor(p1) --[[ getGreenColor | Line: 18 ]]
			local v1 = 30 + p1:NextInteger(-10, 20)
			local v2 = 130 + p1:NextInteger(-20, 40)

			return Color3.fromRGB(v1, v2, 20 + p1:NextInteger(-10, 15))
		end

		local t = {}

		local function orientYAlongDir(p1, p2) --[[ orientYAlongDir | Line: 28 ]]
			local Unit = p2.Unit
			local v1 = Vector3.new(0, 0, 1)

			if math.abs((Unit:Dot(v1))) > 0.99 then
				v1 = Vector3.new(1, 0, 0)
			end

			local Unit2 = Unit:Cross(v1).Unit

			return CFrame.fromMatrix(p1, Unit2, Unit)
		end

		local function makeBlock(p12, p2, p3, p4) --[[ makeBlock | Line: 38 | Upvalues: Stud_Part (copy), p1 (copy) ]]
			local v1 = Stud_Part:Clone()

			v1.Size = p12
			v1.CFrame = p2
			v1.Color = if p4 then p4 else Color3.new(0.509804, 0.380392, 0.25098)
			v1.Anchored = true
			v1.CanCollide = false
			v1:SetAttribute("OG_Transparency", 0)
			v1.Name = tostring(p3)
			v1.Parent = p1

			return v1
		end

		local function makeLeaf(p1, p2, p3, p4) --[[ makeLeaf | Line: 51 | Upvalues: makeBlock (copy), t (copy) ]]
			local v1 = makeBlock(p1, p2, p3, p4)

			v1:SetAttribute("IsLeaf", true)
			table.insert(t, v1)

			return v1
		end

		local function makeSegment(p1, p2, p3, p4, p5) --[[ makeSegment | Line: 58 | Upvalues: makeBlock (copy) ]]
			local v2 = p2 - p1
			local Magnitude = v2.Magnitude

			if Magnitude < 0.01 then
				return
			end

			local Unit = v2.Unit
			local v3 = Vector3.new(0, 0, 1)

			if math.abs((Unit:Dot(v3))) > 0.99 then
				v3 = Vector3.new(1, 0, 0)
			end

			local Unit2 = Unit:Cross(v3).Unit
			local v5 = CFrame.fromMatrix((p1 + p2) / 2, Unit2, Unit)

			makeBlock(Vector3.new(p3, Magnitude + 0.05, p3), v5, p4, p5)
		end

		local count = 1
		local v3 = 2.5 * v2
		local v4 = 2.5 * v2

		makeBlock(Vector3.new(v4, v3, v4), CFrame.new(Position + Vector3.new(0, v3 / 2, 0)), count)

		local t2 = {}
		local v5 = 0
		local t3 = {}
		local v6 = 0
		local v7 = 2.2 * v2
		local v8 = 18 * v2
		local v9 = 0.7 * v2
		local v10 = 1.6 * v2

		for i = 0, 2 do
			for j = 0, 1 do
				local v11 = i / 3 * math.pi * 2
				local v12 = v11 + (j / 2 - 0.5) * 1.5 + (v1:NextNumber() - 0.5) * 0.4
				local v13 = 6 + v1:NextNumber() * 5
				local v14 = 1 + v1:NextNumber() * 0.4
				local v15 = 0.15 + v1:NextNumber() * 0.1
				local v16 = 0.8 + v1:NextNumber() * 1.2
				local v20 = Position + Vector3.new(math.cos(v11) * v7 * 0.5, v1:NextNumber() * 1, math.sin(v11) * v7 * 0.5)
				local v21 = math.floor(v13 * 0.3)

				if v21 < 2 then
					v21 = 2
				end

				local v22 = v1:NextNumber() * 100
				local t4 = {}

				for k = 0, v21 do
					local v23 = k / v21
					local v24 = v23 * v13
					local v25 = math.sin(v22) * 0.5 + 1.8
					local v26 = math.cos(v22 * 0.7) * 0.8 + 3.2
					local v27 = math.sin(v22 * 1.3) * 0.3 + 0.6
					local v28 = math.cos(v22 * 0.9) * 0.15 + 0.3
					local v29 = math.sin(v23 * math.pi * v25 + v22) * v27 * v23 + math.sin(v23 * math.pi * v26 + v22 * 2.1) * v28 * v23
					local sum = v16 * (1 - v23) + math.sin(v23 * math.pi * 1.5 + v22 * 0.5) * 0.15 * v23

					if v23 > 0.3 then
						sum = sum - (v23 - 0.3) * 0.3
					end

					local v30 = math.max(sum, -0.15)
					local v31 = v12 + 1.5707963267948966
					local v32 = math.cos(v12) * v24 + math.cos(v31) * v29

					t4[k + 1] = v20 + Vector3.new(v32, v30, math.sin(v12) * v24 + math.sin(v31) * v29) * v2
				end

				local t5 = {}

				for n = 1, #t4 - 1 do
					t5[n] = (v14 + (v15 - v14) * ((n - 1) / (#t4 - 1))) * v2
				end

				table.insert(t2, {
					points = t4,
					widths = t5
				})

				if v5 < #t4 - 1 then
					v5 = #t4 - 1
				end

				if v1:NextNumber() > 0.45 and #t4 > 4 then
					local v35 = math.clamp(math.floor(#t4 * 0.45) + v1:NextInteger(0, (math.floor(#t4 * 0.2))), 2, #t4 - 1)
					local v36 = v12 + (v1:NextNumber() - 0.5) * 1.2
					local v37 = v13 * (0.25 + v1:NextNumber() * 0.25)
					local v38 = v14 * 0.45
					local v39 = math.floor(v37 * 0.3)

					if v39 < 2 then
						v39 = 2
					end

					local v40 = v1:NextNumber() * 100
					local v41 = t4[v35]
					local t6 = {}

					for m = 0, v39 do
						local v42 = m / v39
						local v43 = v42 * v37
						local v44 = math.sin(v40) * 0.5 + 1.8
						local v45 = math.cos(v40 * 0.7) * 0.8 + 3.2
						local v46 = math.sin(v40 * 1.3) * 0.3 + 0.6
						local v47 = math.cos(v40 * 0.9) * 0.15 + 0.3
						local v48 = math.sin(v42 * math.pi * v44 + v40) * v46 * v42 + math.sin(v42 * math.pi * v45 + v40 * 2.1) * v47 * v42
						local sum = (1 - v42) * 0.1 + math.sin(v42 * math.pi * 1.5 + v40 * 0.5) * 0.15 * v42

						if v42 > 0.3 then
							sum = sum - (v42 - 0.3) * 0.3
						end

						local v49 = math.max(sum, -0.15)
						local v50 = v36 + 1.5707963267948966
						local v51 = math.cos(v36) * v43 + math.cos(v50) * v48

						t6[m + 1] = v41 + Vector3.new(v51, v49, math.sin(v36) * v43 + math.sin(v50) * v48) * v2
					end

					local t7 = {}

					for i2 = 1, #t6 - 1 do
						t7[i2] = (v38 + (v15 - v38) * ((i2 - 1) / (#t6 - 1))) * v2
					end

					table.insert(t3, {
						points = t6,
						widths = t7
					})

					if v6 < #t6 - 1 then
						v6 = #t6 - 1
					end
				end
			end
		end

		for i = 1, v5 do
			count = count + 1

			for v53, v54 in t2 do
				if i <= #v54.points - 1 then
					local v55 = v54.points[i]
					local v56 = v54.points[i + 1]
					local v57 = v54.widths[i]
					local v58 = (v55 + v56) / 2
					local v59 = v56 - v55
					local Magnitude = v59.Magnitude

					if not (Magnitude < 0.01) then
						local Unit = v59.Unit
						local v60 = Vector3.new(0, 0, 1)

						if math.abs((Unit:Dot(v60))) > 0.99 then
							v60 = Vector3.new(1, 0, 0)
						end

						local Unit2 = Unit:Cross(v60).Unit
						local v62 = CFrame.fromMatrix(v58, Unit2, Unit)

						makeBlock(Vector3.new(v57, Magnitude + 0.05, v57), v62, count, nil)
					end
				end
			end
		end

		for i = 1, v6 do
			count = count + 1

			for v63, v64 in t3 do
				if i <= #v64.points - 1 then
					local v65 = v64.points[i]
					local v66 = v64.points[i + 1]
					local v67 = v64.widths[i]
					local v68 = (v65 + v66) / 2
					local v69 = v66 - v65
					local Magnitude = v69.Magnitude

					if not (Magnitude < 0.01) then
						local Unit = v69.Unit
						local v70 = Vector3.new(0, 0, 1)

						if math.abs((Unit:Dot(v70))) > 0.99 then
							v70 = Vector3.new(1, 0, 0)
						end

						local Unit2 = Unit:Cross(v70).Unit
						local v72 = CFrame.fromMatrix(v68, Unit2, Unit)

						makeBlock(Vector3.new(v67, Magnitude + 0.05, v67), v72, count, nil)
					end
				end
			end
		end

		local t4 = {}
		local t5 = {}
		local t6 = {}

		for i = 0, 2 do
			t4[i] = {}

			local v73 = i / 3 * math.pi * 2

			for i2 = 0, 10 do
				local v74 = i2 / 10
				local v75 = v73 + v74 * math.pi * 2 * 1
				local v76 = v7 * (1 - v74 * 0.4)
				local t7 = {}

				t7.pos = Position + Vector3.new(math.cos(v75) * v76, v74 * v8, math.sin(v75) * v76)
				t7.t = v74
				t7.angle = v75
				t4[i][i2] = t7
			end
		end

		for i = 0, 10 do
			count = count + 1

			if i < 4 then
				local v80 = i / 4
				local v81 = (2 - v80 * 1) * v2
				local v82 = v8 / 4 + 0.1
				local v83 = Position + Vector3.new(0, v80 * v8 + v82 / 2, 0)

				makeBlock(Vector3.new(v81, v82, v81), CFrame.new(v83), count)
			end

			if i > 0 and i <= 10 then
				for i2 = 0, 2 do
					local v85 = t4[i2][i]
					local v86 = v10 + (v9 - v10) * v85.t
					local pos = t4[i2][i - 1].pos
					local pos2 = v85.pos
					local v87 = (pos + pos2) / 2
					local v88 = pos2 - pos
					local Magnitude = v88.Magnitude

					if not (Magnitude < 0.01) then
						local Unit = v88.Unit
						local v89 = Vector3.new(0, 0, 1)

						if math.abs((Unit:Dot(v89))) > 0.99 then
							v89 = Vector3.new(1, 0, 0)
						end

						local Unit2 = Unit:Cross(v89).Unit
						local v91 = CFrame.fromMatrix(v87, Unit2, Unit)

						makeBlock(Vector3.new(v86, Magnitude + 0.05, v86), v91, count, nil)
					end

					if v85.t < 0.15 then
						table.insert(t5, {
							pos = v85.pos,
							angle = v85.angle,
							helix = i2
						})
					end

					if v85.t > 0.85 then
						table.insert(t6, {
							pos = v85.pos,
							angle = v85.angle,
							helix = i2
						})
					end
				end
			end
		end

		local v92 = 6 + v1:NextInteger(0, 3)
		local t7 = {}

		for i = 1, v92 do
			local v93 = i / v92 * math.pi * 2 + (v1:NextNumber() - 0.5) * 0.4
			local v95 = math.rad(30 + v1:NextNumber() * 30)
			local v96 = (4 + v1:NextNumber() * 4) * v2
			local v97 = (1 + v1:NextNumber() * 0.5) * v2
			local v98 = (0.2 + v1:NextNumber() * 0.15) * v2
			local v99 = v8 * (0.55 + v1:NextNumber() * 0.45)
			local v102 = Vector3.new(math.cos(v93) * v7 * 0.4, 0, math.sin(v93) * v7 * 0.4)
			local v103 = Position + Vector3.new(0, v99, 0) + v102
			local v104 = v1:NextNumber() * 100
			local v105 = v103

			for i2 = 1, 2 do
				local v106 = i2 / 2
				local v107 = math.cos(v93)
				local v108 = math.sin(v93)
				local v109 = math.sin(v95) * (1 - v106 * 0.4)
				local v112 = v105 + Vector3.new(v107 + math.sin(v106 * math.pi * 2 + v104) * 0.2 * v106, v109, v108 + math.cos(v106 * math.pi * 1.5 + v104 * 1.3) * 0.15 * v106).Unit * (v96 / 2) * v2
				local v113 = v97 + (v98 - v97) * v106

				count = count + 1

				local v114 = (v105 + v112) / 2
				local v115 = v112 - v105
				local Magnitude = v115.Magnitude

				if not (Magnitude < 0.01) then
					local Unit = v115.Unit
					local v116 = Vector3.new(0, 0, 1)

					if math.abs((Unit:Dot(v116))) > 0.99 then
						v116 = Vector3.new(1, 0, 0)
					end

					local Unit2 = Unit:Cross(v116).Unit
					local v118 = CFrame.fromMatrix(v114, Unit2, Unit)

					makeBlock(Vector3.new(v113, Magnitude + 0.05, v113), v118, count, nil)
				end

				if v106 > 0.3 and (v106 < 0.85 and v1:NextNumber() > 0.55) then
					local v119 = v93 + (v1:NextNumber() - 0.5) * 1.2
					local v121 = math.rad(15 + v1:NextNumber() * 35)
					local v122 = v96 * (0.3 + v1:NextNumber() * 0.3)

					v123 = v112
					v124 = v113 * 0.75

					for i3 = 1, 1 do
						local v125 = i3 / 1
						local v129 = v123 + Vector3.new(math.cos(v119) + math.sin(v125 * math.pi + v104) * 0.15, math.sin(v121) * (1 - v125 * 0.5), math.sin(v119) + math.cos(v125 * math.pi + v104) * 0.15).Unit * (v122 / 1) * v2
						local v130 = v124 + (v98 - v124) * v125

						count = count + 1

						local v131 = (v123 + v129) / 2
						local v132 = v129 - v123
						local Magnitude2 = v132.Magnitude

						if not (Magnitude2 < 0.01) then
							local Unit = v132.Unit
							local v133 = Vector3.new(0, 0, 1)

							if math.abs((Unit:Dot(v133))) > 0.99 then
								v133 = Vector3.new(1, 0, 0)
							end

							local Unit2 = Unit:Cross(v133).Unit
							local v135 = CFrame.fromMatrix(v131, Unit2, Unit)

							makeBlock(Vector3.new(v130, Magnitude2 + 0.05, v130), v135, count, nil)
						end

						v123 = v129
					end

					table.insert(t7, v123)
				end

				v105 = v112
			end

			table.insert(t7, v105)
		end

		for v136, v137 in t7 do
			for i = 1, 2 + v1:NextInteger(0, 2) do
				local v141 = v137 + Vector3.new((v1:NextNumber() - 0.5) * 6 * v2, (v1:NextNumber() - 0.3) * 4 * v2, (v1:NextNumber() - 0.5) * 6 * v2)
				local v142 = (4 + v1:NextNumber() * 4) * v2
				local v143 = (1.8 + v1:NextNumber() * 1.4) * v2
				local v144 = CFrame.new(v141) * CFrame.Angles((v1:NextNumber() - 0.5) * 0.3, v1:NextNumber() * math.pi * 2, (v1:NextNumber() - 0.5) * 0.3)

				count = count + 1

				local v145 = makeBlock(Vector3.new(v142, v143, v142), v144, count, (getGreenColor(v1)))

				v145:SetAttribute("IsLeaf", true)
				table.insert(t, v145)
			end
		end

		local v146 = Position + Vector3.new(0, v8 * 1.05, 0)
		local v147 = 11 * v2
		local v148 = 7 * v2

		for i = 1, 20 + v1:NextInteger(0, 10) do
			local v149 = v1:NextNumber() * math.pi * 2
			local v150 = v1:NextNumber() * math.pi * 0.6
			local v151 = v147 * (0.4 + v1:NextNumber() * 0.6)
			local v155 = v146 + Vector3.new(math.cos(v149) * math.sin(v150) * v151, math.cos(v150) * v148 * 0.5 + (v1:NextNumber() - 0.3) * 2.5 * v2, math.sin(v149) * math.sin(v150) * v151)
			local v156 = (4.5 + v1:NextNumber() * 5) * v2
			local v157 = (1.5 + v1:NextNumber() * 1.8) * v2
			local v158 = CFrame.new(v155) * CFrame.Angles((v1:NextNumber() - 0.5) * 0.4, v1:NextNumber() * math.pi * 2, (v1:NextNumber() - 0.5) * 0.4)

			count = count + 1

			local v159 = makeBlock(Vector3.new(v156, v157, v156), v158, count, (getGreenColor(v1)))

			v159:SetAttribute("IsLeaf", true)
			table.insert(t, v159)
		end

		for v160, v161 in t do
			v161.CanCollide = true
		end

		local v162 = RaycastParams.new()

		v162.FilterType = Enum.RaycastFilterType.Include
		v162.FilterDescendantsInstances = { p1 }

		local v163 = 8 + v1:NextInteger(0, 6)
		local v164 = Position.Y + v8 * 0.5
		local v165 = v8 * 1.2
		local count2 = 0

		for i = 1, v163 * 8 do
			if v163 <= count2 then
				break
			end

			local v166 = v1:NextNumber() * math.pi * 2
			local v167 = v147 * (0.2 + v1:NextNumber() * 0.8)
			local v171 = workspace:Raycast(Vector3.new(Position.X + math.cos(v166) * v167, v164, Position.Z + math.sin(v166) * v167), Vector3.new(0, v165, 0), v162)

			if v171 and (v171.Instance and v171.Instance:GetAttribute("IsLeaf")) then
				local v173 = v171.Instance.CFrame.Position - Vector3.new(0, v171.Instance.Size.Y / 2, 0)
				local v174 = false

				for v175, v176 in FruitSpawnLocations:GetChildren() do
					if (v176.CFrame.Position - v173).Magnitude < 3 * v2 then
						v174 = true

						break
					end
				end

				if not v174 then
					local Fruit_Spawn = Instance.new("Part")

					Fruit_Spawn.Size = Vector3.new(1, 1, 1)
					Fruit_Spawn.Transparency = 1
					Fruit_Spawn.Anchored = true
					Fruit_Spawn.CanCollide = false
					Fruit_Spawn.CFrame = CFrame.new(v173)
					Fruit_Spawn.Name = "Fruit_Spawn"
					Fruit_Spawn.Parent = FruitSpawnLocations
					count2 = count2 + 1
				end
			end
		end

		if count2 < 4 and #t > 0 then
			for i = 1, math.min(6, #t) do
				if v163 <= count2 then
					break
				end

				local v177 = t[v1:NextInteger(1, #t)]
				local v179 = v177.CFrame.Position - Vector3.new(0, v177.Size.Y / 2, 0)
				local v180 = false

				for v181, v182 in FruitSpawnLocations:GetChildren() do
					if (v182.CFrame.Position - v179).Magnitude < 3 * v2 then
						v180 = true

						break
					end
				end

				if not v180 then
					local Fruit_Spawn = Instance.new("Part")

					Fruit_Spawn.Size = Vector3.new(1, 1, 1)
					Fruit_Spawn.Transparency = 1
					Fruit_Spawn.Anchored = true
					Fruit_Spawn.CanCollide = false
					Fruit_Spawn.CFrame = CFrame.new(v179)
					Fruit_Spawn.Name = "Fruit_Spawn"
					Fruit_Spawn.Parent = FruitSpawnLocations
					count2 = count2 + 1
				end
			end
		end

		for v183, v184 in t do
			v184.CanCollide = false
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 451 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				local v5 = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame)

				table.insert(t, {
					part = v2,
					maxSizeY = v2.Size.Y,
					fullSize = v2.Size,
					bottomCF = v5 * CFrame.new(0, -v2.Size.Y / 2, 0),
					rotation = v5.Rotation,
					partAge = v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 475 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v5 = math.min(v1 - v3.partAge, 1)

				if v5 > 0 then
					local v6 = v3.maxSizeY * v5

					v3.part.Size = Vector3.new(v3.fullSize.X, v6, v3.fullSize.Z)
					v3.part.CFrame = PrimaryPart.CFrame * CFrame.new((v3.bottomCF * CFrame.new(0, v6 / 2, 0)).Position) * v3.rotation
					v3.part.Transparency = v3.part:GetAttribute("OG_Transparency") or 0
					v3.part.CanCollide = true

					continue
				end

				v3.part.Transparency = 1
				v3.part.CanCollide = false
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