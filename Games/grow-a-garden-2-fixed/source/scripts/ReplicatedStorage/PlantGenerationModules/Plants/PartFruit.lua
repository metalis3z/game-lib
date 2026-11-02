--credit to quartz games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 7 ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local v3 = v2:NextInteger(5, 7) * v1
		local PrimaryPart = p1.PrimaryPart
		local count = 5
		local v4 = 2 * v1
		local count2 = 1

		while count >= 1 do
			task.wait()

			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.CanCollide = false
			Part.Size = Vector3.new(v4, v3, v4)
			count2 = count2 + 1
			Part.Name = tostring(count2)
			Part.CFrame = PrimaryPart.CFrame * CFrame.new(0, PrimaryPart.Size.Y / 2 + Part.Size.Y / 2, 0)
			Part.Parent = p1

			local Part2 = Instance.new("Part")

			Part2.Parent = p1.FruitSpawnLocations
			Part2.Anchored = true
			Part2.CanCollide = false
			Part2.Size = Vector3.new(0.5, 0.5, 0.5)
			Part2.CFrame = Part.CFrame * CFrame.new(-(Part.Size.X / 2 + Part2.Size.X / 2), v2:NextInteger(-Part.Size.Y / 2, Part.Size.Y / 2), 0)
			count, v4, PrimaryPart = count - 1, v4 * 0.8, Part
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 39 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 57 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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