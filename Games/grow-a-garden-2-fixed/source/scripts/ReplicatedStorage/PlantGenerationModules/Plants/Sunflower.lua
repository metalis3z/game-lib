--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local Base = p1.Base
		local Stud_Part = script.Stud_Part

		local function GetRandomHSV(p1, p2) --[[ GetRandomHSV | Line: 19 | Upvalues: v2 (copy) ]]
			local v1, v22, v3 = p1:ToHSV()
			local v4 = p2 or 0.05
			local v6 = math.clamp(v1 + v2:NextNumber(-v4, v4), 0.01, 0.99)

			return Color3.fromHSV(v6, v22, v3), v6, v22, v3
		end

		local v3, v4 = Color3.fromRGB(137, 191, 57)
		local v5, v6, v7 = v3:ToHSV()
		local v8 = v4 or 0.05
		local v10 = math.clamp(v5 + v2:NextNumber(-v8, v8), 0.01, 0.99)
		local v11 = Color3.fromHSV(v10, v6, v7)

		local function CreatePart(p12, p2) --[[ CreatePart | Line: 29 | Upvalues: Stud_Part (copy), p1 (copy) ]]
			local v1 = Stud_Part:Clone()

			v1.Parent = p1
			v1.Anchored = true
			v1.CanCollide = false
			v1.Transparency = 1

			if p2 then
				v1.Shape = Enum.PartType[p2]
			end

			return v1
		end

		local v12 = v2:NextNumber(2.3, 2.7) * (v1 * 0.25 + 0.75)
		local v13 = v2:NextNumber(3.25, 3.75) * (v1 * 0.25 + 0.75)
		local v14 = Stud_Part:Clone()

		v14.Parent = p1
		v14.Anchored = true
		v14.CanCollide = false
		v14.Transparency = 1

		local v15 = v14

		v15.Size = Vector3.new(v12, v13, v12)
		v15.CFrame = Base.CFrame * CFrame.new(0, v13 * v2:NextNumber(1.1, 1.5), 0)
		v15.Color = v11

		local v16 = v15:Clone()

		v16.Parent = p1
		v16.CFrame = v15.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)
		v16.Size = Vector3.new(v16.Size.X, v16.Size.Y * 0.7, v16.Size.Z)

		local v18 = v2:NextInteger(3, (math.floor(5 + v1 * 2)))

		local function GenerateDownwardsStem(p12, p2, p3, p4) --[[ GenerateDownwardsStem | Line: 68 | Upvalues: v15 (copy), v2 (copy), Base (copy), Stud_Part (copy), p1 (copy), v11 (copy) ]]
			local Y = v15.Position.Y
			local v1 = p12 * CFrame.Angles(math.pi, 0, 0)
			local v22 = v2:NextNumber(0.8, 1) * p3
			local v4 = Vector3.new(v22, v2:NextNumber(2.3, 2.85), v22)
			local count = 0
			local t = {}
			local v5 = p4 or 0

			while Base.Position.Y < Y do
				local v6 = Stud_Part:Clone()

				v6.Parent = p1
				v6.Anchored = true
				v6.CanCollide = false
				v6.Transparency = 1

				local v8 = math.rad((v2:NextNumber(p2[1], p2[2])))

				if v2:NextInteger(1, 3) == 1 then
					v8 = v8 * 2
				end

				if count == 1 and v2:NextNumber(1, 2) == 1 then
					v8 = -v8
				end

				count = count + 1
				v6.Size = v4
				v6.CFrame = v1 * CFrame.Angles(0, 0, v8) * CFrame.new(0, v6.Size.Y / 2.3, 0)
				v6.Color = v11
				v6.Name = tostring(count + v5)
				Y = v6.Position.Y
				v1 = v6.CFrame * CFrame.new(0, v6.Size.Y / 2.3, 0)

				local v9 = v4.X * v2:NextNumber(1.275, 1.45)
				local v112 = Vector3.new(v9, v4.Y * v2:NextNumber(1.05, 1.25), v9)

				table.insert(t, v6)
				v6.CFrame = v6.CFrame * CFrame.Angles(0, math.rad((v2:NextNumber(-45, 45))), 0)
				v4 = v112
			end

			return t, count
		end

		local v19, v20 = GenerateDownwardsStem(v15.CFrame * CFrame.new(0, -v13 / 2, 0), { -5, 5 }, 2)
		local v21, v22, v23 = v10, v6, v7

		for v24, v25 in v19 do
			v25.Name = tostring(v20 - tonumber(v25.Name) + 1)
			v25.CFrame = v25.CFrame * CFrame.Angles(math.pi, 0, 0)
		end

		for i = 1, v18 do
			local v28 = v15.CFrame * CFrame.new(0, -v13 * v2:NextNumber(-0.1, 0.3), 0)
			local Angles = CFrame.Angles
			local v29 = 360 / v18 * i + v2:NextNumber(-15, 15)
			local v30 = v28 * Angles(0, math.rad(v29), 0) * CFrame.new(v15.Size.X / 2.5, 0, 0)
			local Angles2 = CFrame.Angles

			GenerateDownwardsStem(v30 * Angles2(0, 0, (math.rad((v2:NextNumber(42.5, 60))))), { 5, 11 }, 1, v20 + 1)
		end

		v15.Name = tostring(v20 + 1)
		v16.Name = tostring(v20 + 1)
		p1:PivotTo(p1:GetPivot() * CFrame.new(0, 0.5, 0))

		local count = v2:NextInteger(1, (math.floor(2 + v1)))
		local v35 = Vector3.new(v15.Size.X * 0.875, v15.Size.Y * 0.85, v15.Size.Z * 0.875)
		local v36 = v15.CFrame * CFrame.new(0, v15.Size.Y / 2.3, 0)
		local v37 = nil

		while v2:NextInteger(1, 6) == 1 do
			count = count + 1
		end

		for j = 1, count do
			local v38
			local v39 = Stud_Part:Clone()

			v39.Parent = p1
			v39.Anchored = true
			v39.CanCollide = false
			v39.Transparency = 1
			v39.Size = v35

			local Angles = CFrame.Angles
			local v41 = math.rad((v2:NextNumber(-10, 10)))
			local v43 = math.rad((v2:NextNumber(-25, 25)))
			local v44 = v2:NextNumber(-10, 10)

			v39.CFrame = v36 * Angles(v41, v43, (math.rad(v44))) * CFrame.new(0, v39.Size.Y / 2.3, 0)
			v39.Color = v11
			v39.Name = tostring(j + v20 + 1)

			local v45 = v39:Clone()

			v45.Parent = p1
			v45.CFrame = v39.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)
			v45.Size = Vector3.new(v45.Size.X, v45.Size.Y * 0.7, v45.Size.Z)

			if j == 1 or v2:NextInteger(1, 4) == 1 then
				v38 = v39

				for k = 1, 2 do
					local v47 = script.Leaf:Clone()
					local v48 = k * 180 + v2:NextNumber(-35, 35) + j * 90

					v47.Parent = p1
					v47:ScaleTo(v2:NextNumber(0.85, 1.15) * (v1 * 0.15 + 0.85))
					v47:PivotTo(v39.CFrame * CFrame.Angles(0, math.rad(v48), -1.3962634015954636))

					for v49, v50 in v47:GetChildren() do
						if v50.Name == "1" or v50.Name == "2" then
							v50.Color = v11
						else
							v50.Color = Color3.fromHSV(v21, v22, v23 - 0.15)
						end

						local v52 = tonumber(v50.Name)

						if v52 then
							v50.Name = tostring(v52 + j + v20 + 1)
							v50.Parent = p1
						end
					end
				end
			else
				v38 = v39
			end

			local v56 = Vector3.new(v35.X * 0.875, v15.Size.Y * v2:NextNumber(0.875, 1.15), v35.Z * 0.875)

			v36 = v38.CFrame * CFrame.new(0, v38.Size.Y / 2.3, 0)
			v37 = v38.CFrame * CFrame.new(0, v38.Size.Y / 2, 0)
			v35 = v56
		end

		local v57 = v2:NextInteger(2, (math.floor(2 + v1)))
		local t = {}
		local v58 = nil

		for n = 1, v57 do
			local v59 = Stud_Part:Clone()

			v59.Parent = p1
			v59.Anchored = true
			v59.CanCollide = false
			v59.Transparency = 1
			v59.Size = v35

			local Angles = CFrame.Angles
			local v61 = math.rad((v2:NextNumber(-3, 3)))
			local v63 = math.rad((v2:NextNumber(-25, 25)))
			local v64 = v2:NextNumber(-3, 3)

			v59.CFrame = v36 * Angles(v61, v63, (math.rad(v64))) * CFrame.new(0, v59.Size.Y / 2.3, 0)
			v59.Color = v11
			v59.Name = tostring(n + v20 + 1 + count)
			table.insert(t, v59)
			v36 = v59.CFrame * CFrame.new(0, v59.Size.Y / 2.3, 0)
			v58 = v59.CFrame * CFrame.new(0, v59.Size.Y / 2, 0)
		end

		local Magnitude = (v37.Position - v58.Position).Magnitude

		for m = 1, 2 do
			local sum = 360 / Magnitude

			if m == 1 then
				sum = sum + 180
			end

			local v65 = math.floor(Magnitude)
			local count2, v66 = 1, v37

			for i = 1, v65 do
				local v67, v68
				local v73 = v37 * CFrame.new(math.cos((math.rad(sum))) * v12, count2, math.sin((math.rad(sum))) * v12)
				local v74 = Stud_Part:Clone()

				v74.Parent = p1
				v74.Anchored = true
				v74.CanCollide = false
				v74.Transparency = 1

				local v75 = (v66.Position - v73.Position).Magnitude * 1.1
				local v76 = if i % 2 == 0 then v12 * 0.4 else v12 * 0.5

				if i == v65 then
					v75, v73 = v75 * 1.4, v58
				end

				v74.Size = Vector3.new(v76, v75, v76)
				v74.CFrame = CFrame.lookAt(v66.Position, v73.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v75 / 2, 0)

				if i % 2 == 0 then
					v67 = Color3.fromHSV(v21, v22, v23 - 0.15)

					if v67 then
						v68 = v74
					else
						v68 = v74
						v67 = v11
					end
				else
					v68 = v74
					v67 = v11
				end

				v68.Color = v67
				v68.Name = tostring(i + count + v20 + 2)
				count2, v66, sum = count2 + 1, v73, sum + 360 / v57 * 0.35
			end
		end

		local v77 = v57 + v20 + 2 + count
		local v78 = Stud_Part:Clone()

		v78.Parent = p1
		v78.Anchored = true
		v78.CanCollide = false
		v78.Transparency = 1
		v78.Size = Vector3.new(v35.X * 1.3, v35.Y * 0.75, v35.Z * 1.3)
		v78.CFrame = v58 * CFrame.new(0, v78.Size.Y / 2, 0)
		v78.Color = v11
		v78.Name = tostring(v77)

		local v82 = v78

		for i = 1, 4 do
			local v83 = v82.CFrame * CFrame.Angles(0, math.rad(i * 90), 0) * CFrame.new(0, 0, v82.Size.Z / 1.85)
			local v84 = Stud_Part:Clone()

			v84.Parent = p1
			v84.Anchored = true
			v84.CanCollide = false
			v84.Transparency = 1

			local v85 = v2:NextNumber(v82.Size.X * 0.65, v82.Size.X * 0.85)

			v84.Size = Vector3.new(v85, v85 * v2:NextNumber(1, 1.5), v85 * 0.425)

			local Angles = CFrame.Angles

			v84.CFrame = v83 * Angles(math.rad((v2:NextNumber(28, 43))), 0, 0)
			v84.Color = v11
			v84.Name = tostring(v77 + 1)

			local v88 = Stud_Part:Clone()

			v88.Parent = p1
			v88.Anchored = true
			v88.CanCollide = false
			v88.Transparency = 1

			local v90 = v84.Size.Y * v2:NextNumber(0.3, 0.45)

			v88.Size = Vector3.new(v84.Size.X * 0.8, v90, v84.Size.Z * 0.8)
			v88.CFrame = v84.CFrame * CFrame.new(0, v84.Size.Y / 2 + v88.Size.Y / 2.1, 0)
			v88.Color = Color3.fromHSV(v21, v22, v23 - 0.15)
			v88.Name = tostring(v77 + 2)
		end

		local v92 = Stud_Part:Clone()

		v92.Parent = p1
		v92.Anchored = true
		v92.CanCollide = false
		v92.Transparency = 1
		v92.Size = Vector3.new(1, 1, 1)
		v92.CFrame = v82.CFrame * CFrame.new(0, v82.Size.Y / 2, 0)
		v92.Transparency = 1
		v92.Parent = p1.FruitSpawnLocations
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 348 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 366 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			p1:GetAttribute("MaxAge")

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