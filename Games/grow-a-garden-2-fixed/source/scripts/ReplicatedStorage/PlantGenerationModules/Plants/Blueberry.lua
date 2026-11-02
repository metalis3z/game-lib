--credit to leon games studio
function RoundSize(p1) --[[ RoundSize | Line: 2 ]]
	return math.round(p1 * 100) * 0.01
end

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 11 ]]
		local v1 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local v2 = p3 or 1

		while v1:NextInteger(1, 200) == 1 do
			v2 = v2 * v1:NextInteger(3, 4)

			while v1:NextInteger(1, 50) == 1 do
				v2 = v2 * v1:NextInteger(3, 4)
			end
		end

		local v3 = if v1:NextInteger(1, 100) == 1 then true else false
		local Part = script.Part

		Color3.new(0, 0.666667, 0)
		Color3.new(0.368627, 0.784314, 0.254902)

		local v4 = v1:NextInteger(2, 3) + v2 * 0.25
		local t = {}

		table.insert(t, 2 * (v2 * 0.25 + 0.75))
		table.insert(t, 3 * (v2 * 0.25 + 0.75))
		table.insert(t, 4 * (v2 * 0.25 + 0.75))
		table.insert(t, 5 * (v2 * 0.25 + 0.75))

		local count = 0

		for i = #t, 2, -1 do
			local v5 = v1:NextInteger(1, i)
			local v7 = t[i]

			t[i] = t[v5]
			t[v5] = v7
		end

		local v8 = math.min(v4, #t)
		local _ = Base.CFrame
		local v9 = Base.CFrame
		local tbl = {}

		for j = 1, v8 do
			local v10 = t[j]
			local v11 = Part:Clone()

			v11.Size = Vector3.new(v10, v10 * 0.75, v10)
			count = count + 1
			v11.Name = tostring(count)
			v11.CFrame = v9 * CFrame.new(v1:NextInteger(-v10 / 2, v10 / 2), v11.Size.Y / 4, v1:NextInteger(-v10 / 2, v10 / 2))
			v11.Parent = p1
			table.insert(tbl, v11)

			local _2 = v11.CFrame
		end

		if v3 then
			p1:AddTag("StackedBlueberry")

			local v12 = tbl[1]

			for v13, v14 in tbl do
				if v14.Size.X > v12.Size.X then
					v12 = v14
				end
			end

			local v15 = v12

			for k = 1, 50 do
				if k > 1 and v1:NextInteger(1, 3) ~= 1 then
					break
				end

				local X = v15.Size.X
				local v16 = v1:NextNumber(2, 5) * (v2 * 0.25 + 0.5)
				local v17 = v16 * 0.75
				local v18 = v1:NextNumber(-0.15, 0.15) * X
				local v19 = v1:NextNumber(-0.15, 0.15) * X
				local v20 = Part:Clone()

				v20.Size = Vector3.new(v16, v17, v16)
				count = count + 1
				v20.Name = tostring(count)
				v20.CFrame = v15.CFrame * CFrame.new(v18, v15.Size.Y / 2 + v17 / 2, v19)
				v20.Parent = p1
				table.insert(tbl, v20)

				local _2 = v20.CFrame

				v15 = v20
			end
		end

		local v21 = RaycastParams.new()

		v21.FilterType = Enum.RaycastFilterType.Include
		v21.FilterDescendantsInstances = { p1 }

		for k, v in pairs(tbl) do
			local Position = v.Position
			local v22 = v.Size.X / 2

			for n = 1, math.round(v.Size.X) * 0.5 do
				local v24 = math.rad((v1:NextInteger(0, 360)))
				local v26 = math.rad((v1:NextInteger(15, 165)))
				local Unit = Vector3.new(math.sin(v26) * math.cos(v24), math.cos(v26), math.sin(v26) * math.sin(v24)).Unit
				local v30 = workspace:Raycast(Position + Unit * (v22 + 5), -Unit * (v22 + 10), v21)

				if v30 and v30.Instance == v then
					local FruitSpawn = Instance.new("Part")

					FruitSpawn.Size = Vector3.new(1, 1, 1)
					FruitSpawn.Transparency = 1
					FruitSpawn.Anchored = true
					FruitSpawn.CanCollide = false
					FruitSpawn.Position = v30.Position
					FruitSpawn.Name = "FruitSpawn"
					FruitSpawn.Parent = FruitSpawnLocations
				end
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 168 ]]
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

		local function updateGrowth() --[[ updateGrowth | Line: 186 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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