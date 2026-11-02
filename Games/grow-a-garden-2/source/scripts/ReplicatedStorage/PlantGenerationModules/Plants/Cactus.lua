--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = (p3 or 1) * 0.5 + 0.5
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local count = 0
		local t = {}
		local t2 = {}
		local Cactus_Cylinder = script.Cactus_Cylinder
		local Cactus_Ball = script.Cactus_Ball
		local Cactus_Prickle = script.Cactus_Prickle

		if v2:NextNumber() < 0.08 then
			v2:NextNumber(2, 3)
		end

		p1:SetAttribute("BigSpikes", false)

		local v3 = v2:NextInteger(4, 5)

		while v2:NextInteger(1, 100) == 1 do
			v3 = v3 * 2
		end

		local v6 = Vector3.new(v3, v2:NextInteger(20, 30) * 0.1 * (v1 * 0.1 + 1), v2:NextInteger(20, 30) * 0.1 * (v1 * 0.1 + 1))
		local v7 = v2:NextInteger(2, 3) + v3 * 0.5

		local function newCylinder(p12, p2) --[[ newCylinder | Line: 56 | Upvalues: Cactus_Cylinder (copy), count (ref), p1 (copy), t (copy), t2 (copy) ]]
			local v1 = Cactus_Cylinder:Clone()

			v1.Size = p12
			v1.CFrame = p2
			count = count + 1
			v1.Name = tostring(count)
			v1.Parent = p1
			table.insert(t, v1)
			table.insert(t2, v1)

			return v1
		end

		local function attachBall(p12, p2) --[[ attachBall | Line: 68 | Upvalues: Cactus_Ball (copy), count (ref), p1 (copy), t (copy) ]]
			local Y = p12.Size.Y

			if p12.Size.Z < Y then
				Y = p12.Size.Z
			end

			local v1 = Cactus_Ball:Clone()

			v1.Size = Vector3.new(Y, Y, Y)
			v1.CFrame = p12.CFrame * CFrame.new(p12.Size.X / 2, 0, 0)
			count = count + 1
			v1.Name = tostring(count)
			v1.Parent = p1
			table.insert(t, v1)

			return v1
		end

		local v8, v9 = (function(p12, p2, p3, p4) --[[ createChain | Line: 83 | Upvalues: Cactus_Cylinder (copy), count (ref), p1 (copy), t (copy), t2 (copy), FruitSpawnLocations (copy) ]]
			local t3 = {}
			local v1 = p2.X / 2
			local v2 = Cactus_Cylinder:Clone()

			v2.Size = p2
			v2.CFrame = p3
			count = count + 1
			v2.Name = tostring(count)
			v2.Parent = p1
			table.insert(t, v2)
			table.insert(t2, v2)

			if p4 then
				local v6 = script.Spawn_Object:Clone()

				v6.CFrame = v2.CFrame.Rotation + (v2.Position + Vector3.new(0, v2.Size.Y / 2, 0))
				v6.Parent = FruitSpawnLocations
			end

			local v8 = v2

			t3[1] = v8

			for i = 2, p12 do
				local v10 = v8.CFrame * CFrame.new(v1 * 2, 0, 0)
				local v11 = Cactus_Cylinder:Clone()

				v11.Size = p2
				v11.CFrame = v10
				count = count + 1
				v11.Name = tostring(count)
				v11.Parent = p1
				table.insert(t, v11)
				table.insert(t2, v11)

				if p4 then
					local v15 = script.Spawn_Object:Clone()

					v15.CFrame = v11.CFrame * CFrame.new(0, 0, v11.Size.X / 3)
					v15.Parent = FruitSpawnLocations
				end

				v8 = v11
				t3[i] = v11
			end

			return t3, v8
		end)(v7, v6, Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0) * CFrame.Angles(0, 0, 1.5707963267948966), false)

		attachBall(v9, true)

		local v10 = (-1 / 0)
		local v11 = (1 / 0)

		for v12, v13 in t2 do
			if v10 < v13.Position.Y then
				v10 = v13.Position.Y
			end

			if v13.Position.Y < v11 then
				v11 = v13.Position.Y
			end
		end

		local v14 = v8[1].CFrame
		local v18 = Vector3.new(math.clamp(v6.X * 0.75, 3, 10), v6.Y, v6.Z)
		local v19 = v18.X / 2
		local sum = 5
		local t3 = {}

		while sum <= (v9.Position - v8[1].Position).Magnitude + v6.X / 2 - 5 do
			local v21 = nil

			for i = 1, 5 do
				local v22 = v2:NextInteger(-180, 180)
				local v23 = true

				for v24, v25 in t3 do
					if math.abs(v25.dist - sum) < 8 and math.abs((v25.angle - v22 + 180) % 360 - 180) < 35 then
						v23 = false

						break
					end
				end

				if v23 then
					table.insert(t3, {
						dist = sum,
						angle = v22
					})
					v21 = v22

					break
				end
			end

			if v21 then
				local v28 = v14 * CFrame.new(sum, 0, 0) * CFrame.Angles(math.rad(v21), 1.5707963267948966, 0) * CFrame.new(v19, 0, 0)
				local _ = v18.X / 2
				local v29 = Cactus_Cylinder:Clone()

				v29.Size = v18
				v29.CFrame = v28
				count = count + 1
				v29.Name = tostring(count)
				v29.Parent = p1
				table.insert(t, v29)
				table.insert(t2, v29)

				local v31 = script.Spawn_Object:Clone()

				v31.CFrame = v29.CFrame.Rotation + (v29.Position + Vector3.new(0, v29.Size.Y / 2, 0))
				v31.Parent = FruitSpawnLocations;
				({})[1] = v29
				attachBall(v29, true)

				local v33 = v29.CFrame * CFrame.new(v19, 0, v19) * CFrame.Angles(0, -1.5707963267948966, 0)
				local t4 = {}
				local v35 = Cactus_Cylinder:Clone()

				v35.Size = v18
				v35.CFrame = v33
				count = count + 1
				v35.Name = tostring(count)
				v35.Parent = p1
				table.insert(t, v35)
				table.insert(t2, v35)
				t4[1] = v35

				local v38 = v35.CFrame * CFrame.new(v18.X / 2 * 2, 0, 0)
				local v39 = Cactus_Cylinder:Clone()

				v39.Size = v18
				v39.CFrame = v38
				count = count + 1
				v39.Name = tostring(count)
				v39.Parent = p1
				table.insert(t, v39)
				table.insert(t2, v39)
				t4[2] = v39
				attachBall(v39, true)
			end

			sum = sum + v2:NextNumber(4, 7)
		end

		local v41 = math.floor(2 * v1 * 1)
		local v42 = math.floor(3 * v1 * 1)

		for v43, v44 in t2 do
			for j = 1, v2:NextInteger(v41, v42) do
				if j % 2 ~= 0 then
					local v45 = Cactus_Prickle:Clone()

					v45.Size = Vector3.new((v44.Size.Y + 0.5) * 1, 0.125, 0.125)

					local v47 = v44.CFrame * CFrame.new(v2:NextNumber(-v44.Size.X, v44.Size.X) * 0.5, 0, 0)

					v45.CFrame = v47 * CFrame.Angles(math.rad((v2:NextInteger(-180, 180))), 1.5707963267948966, 0)
					count = count + 1
					v45.Name = tostring(count)
					v45.Parent = p1
					v45:AddTag("DetailPart")
					v45:SetAttribute("Prickle", true)
				end
			end
		end

		for v50, v51 in FruitSpawnLocations:GetChildren() do
			v51.CFrame = v51.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 225 ]]
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

		table.sort(t, function(p1, p2) --[[ Line: 243 ]]
			return p1[4] < p2[4]
		end)

		local function updateGrowth() --[[ updateGrowth | Line: 245 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.clamp(v1 - v3[4], 0, 1)

				if v8 > 0 then
					v4.Size = Vector3.new(v5.X * v8, v5.Y, v5.Z)
					v4.CFrame = PrimaryPart.CFrame * v6 * CFrame.new(-((v5.X - v4.Size.X) / 2), 0, 0)
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

		local LocalPlayer = game.Players.LocalPlayer

		if not LocalPlayer then
			return
		end

		if p1:GetAttribute("UserId") == LocalPlayer.UserId then
			return
		end

		local v5 = if p1:GetAttribute("BigSpikes") then 10 else 5
		local v6 = 0

		local function onTouch(p1) --[[ onTouch | Line: 285 | Upvalues: LocalPlayer (copy), v6 (ref), v5 (copy) ]]
			local v1 = p1.Parent and p1.Parent:FindFirstChildOfClass("Humanoid")

			if not v1 or p1.Parent ~= LocalPlayer.Character then
				return
			end

			local v2 = os.clock()

			if v2 - v6 < 1 then
				return
			end

			v6 = v2

			if not (v1.Health > 1) then
				return
			end

			v1.Health = math.max(v1.Health - v5, 0)
		end

		for v7, v8 in p1:GetDescendants() do
			if v8:IsA("BasePart") then
				v8.Touched:Connect(onTouch)
			end
		end
	end,
	Extras = {}
}