--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local v2 = 0.75 + (p3 or 1) * 0.25
		local v3 = Base.CFrame
		local Size = Base.Size
		local tbl = {}
		local sum = 4 * v2
		local count = 0
		local v4 = 0.3 * v2
		local sum2 = 5 * v2

		for i = 1, 1000 do
			if sum > 1.5 then
				count = count + 1
				sum = sum - v4
				sum2 = sum2 - v4 * 0.5

				local v5 = game.ReplicatedStorage.Assets.Stud_Part:Clone()

				v5.Size = Vector3.new(sum, sum2, sum)
				v5.CFrame = v3 * CFrame.new(0, Size.Y / 2 + v5.Size.Y / 2, 0)
				v5.Anchored = true
				v5.CanCollide = false
				v5.Color = Color3.new(0.27451, 0.180392, 0.0627451)
				v5.Name = tostring(count)
				v3 = v5.CFrame
				Size = v5.Size
				v5.Parent = p1
				table.insert(tbl, v5)
			end
		end

		local count2 = 0
		local v6 = 0
		local tbl2 = {}

		for k, v in pairs(tbl) do
			local v9 = math.round((math.sqrt(v.Size.X * 15)))

			count2 = count2 + 1

			for j = 1, v9 do
				count = count + 1

				local v11 = v:Clone()

				v11.Size = Vector3.new(v.Size.X * 0.5, v.Size.Y, v.Size.X * 0.5)

				if v6 < v11.Size.X then
					v6 = v11.Size.X
				end

				local v17 = v.CFrame * CFrame.Angles(0, math.rad(360 / v9 * j + count2 * 5), (math.rad((v1:NextInteger(-20, 20)))))
				local Angles2 = CFrame.Angles
				local v19 = math.clamp(90 - count2 * 10 + v1:NextInteger(-10, 10) * (count2 * 0.5 + 1), 5, 90)

				v11.CFrame = v17 * Angles2(math.rad(v19), 0, 0) * CFrame.new(0, v11.Size.Y / 2, 0)
				v11.Name = tostring(count)
				v11.Anchored = true
				v11.Parent = p1
				table.insert(tbl2, v11)
			end
		end

		local v20 = (1 / 0)
		local v21 = (-1 / 0)

		for k, v in pairs(tbl2) do
			if v.Position.Y < v20 then
				v20 = v.Position.Y
			end

			if v21 < v.Position.Y then
				v21 = v.Position.Y
			end
		end

		for k, v in pairs(tbl2) do
			count = count + 1

			local v22 = v.Size.X * 3 + 1
			local v24 = math.clamp(1 + v.Size.X * 0.25, 1, 3)
			local v26 = 0.3 + (if v21 == v20 then 0.5 else (v.Position.Y - v20) / (v21 - v20)) * 0.5

			for k2 = 1, v24 do
				local v27 = v:Clone()

				v27.Size = Vector3.new(v22, v22, v22)
				v27.Name = tostring(count)
				v27.Color = Color3.fromHSV(0.333333, 0.876921, v26)
				v27.Parent = p1
				v27.CFrame = v.CFrame * CFrame.new(0, v.Size.Y / 2 + v27.Size.Y / 2, 0)

				local v28 = v1:NextInteger(0, 360)

				v27.Orientation = Vector3.new(v28, v1:NextInteger(0, 360), v1:NextInteger(0, 360))
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 106 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 124 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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