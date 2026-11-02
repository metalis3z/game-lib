--credit to quartz games studio
local function getMiddle50(p1) --[[ getMiddle50 | Line: 1 ]]
	local v1 = #p1
	local t = {}

	for i = math.floor(v1 * 0.25) + 1, math.ceil(v1 * 0.75) do
		table.insert(t, p1[i])
	end

	return t
end

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 18 | Upvalues: getMiddle50 (copy) ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local v3 = Base.Position.Y - Base.Size.Y / 2
		local v4 = 0
		local Stud_Part = script.Stud_Part
		local count = v2:NextInteger(1, 2)

		if v2:NextInteger(1, 10) == 1 then
			while v2:NextInteger(1, 3) == 1 do
				count = count + 1
			end
		end

		local sum = 3 + v1 * 0.5
		local v5 = 3 + v1
		local count2 = 0.3 + v1 * 0.25

		while v2:NextInteger(1, 100) == 1 do
			sum = sum + 2
		end

		while v2:NextInteger(1, 100) == 1 do
			count2 = count2 + 1
		end

		local v6 = 7 * (v1 * 0.25 + 0.75)

		if v2:NextInteger(1, 300) == 1 then
			while v2:NextInteger(1, 2) == 1 do
				v6 = v6 * 2
			end
		end

		local v7 = v2:NextInteger(90, 110) * 0.015

		while v2:NextInteger(1, 500) == 1 do
			v7 = v7 * 2
		end

		local count3 = 4

		while v2:NextInteger(1, 100) == 1 do
			count3 = count3 + 1
		end

		local tbl = {}
		local v8 = 0
		local v9 = 0
		local v10 = 0

		local function v11(p12, p2) --[[ Branch | Line: 78 | Upvalues: sum (ref), v5 (copy), v1 (ref), v6 (ref), v2 (copy), v8 (ref), v10 (ref), v9 (ref), Stud_Part (copy), count2 (ref), v4 (ref), v3 (copy), p1 (copy), v7 (ref), tbl (copy), getMiddle50 (ref), count3 (ref), v11 (copy) ]]
			if not (sum > v5 * (0.6 - math.clamp(v1 * 0.1, 0.1, 0.5)) and v6 > 0) then
				return
			end

			local v22 = v2:NextNumber() * 2 - 1
			local v32 = v2:NextNumber() * 2 - 1

			if math.sign(v8) == math.sign(v22) then
				v22 = -v22
			end

			v10 = v10 + 1

			if math.sign(v9) == math.sign(v32) then
				v32 = -v32
			end

			v8 = v22
			v9 = v32

			local t = {}

			v6 = v6 - 0.5

			local sum2, sum3, v62 = v22, v32, nil

			for i = 1, v6 do
				local v72 = Stud_Part:Clone()

				v72.Color = Color3.new(0.509804, 0.372549, 0.235294)
				v72.Size = Vector3.new(count2, sum, count2)
				v4 = v4 + 1
				v72.Name = tostring(v4)
				v72.CFrame = p12 * CFrame.new(0, p2.Y / 2 + v72.Size.Y / 2, 0)
				v72.CFrame = v72.CFrame * CFrame.new(0, -v72.Size.Y / 2, 0) * CFrame.Angles(math.rad(sum2), 0, (math.rad(sum3))) * CFrame.new(0, v72.Size.Y / 2, 0)

				if v72.Position.Y - v72.Size.Y / 2 < v3 then
					sum2 = -sum2
					sum3 = -sum3
					v72.CFrame = p12 * CFrame.new(0, p2.Y / 2 + v72.Size.Y / 2, 0)
					v72.CFrame = v72.CFrame * CFrame.new(0, -v72.Size.Y / 2, 0) * CFrame.Angles(math.rad(sum2), 0, (math.rad(sum3))) * CFrame.new(0, v72.Size.Y / 2, 0)
					v62, v22, v32 = v72, -v22, -v32
				else
					v62 = v72
				end

				v62.Parent = p1
				p12 = v62.CFrame
				p2 = v62.Size
				sum2 = sum2 + math.clamp(v22, -0.01, 0.01) * 200 * (1 / (v1 * 0.25 + 0.75)) * v7
				sum3 = sum3 + math.clamp(v32, -0.01, 0.01) * 200 * (1 / (v1 * 0.25 + 0.75)) * v7
				table.insert(t, v62)
			end

			if v62 then
				table.insert(tbl, v62)
			end

			sum = sum * 0.9
			count2 = count2 * 0.9

			local v13 = getMiddle50(t)
			local count = count3

			while count >= 1 do
				count = count - 1

				local v14 = v13[math.random(1, #v13)]

				if count3 - 1 <= count then
					task.spawn(function() --[[ Line: 131 | Upvalues: v11 (ref), v14 (copy), v2 (ref) ]]
						v11(v14.CFrame * CFrame.Angles(math.rad((v2:NextInteger(-25, 25))), math.rad((v2:NextInteger(-25, 25))), (math.rad((v2:NextInteger(-25, 25))))), v14.Size)
					end)
				else
					local v15 = v2

					if v15:NextInteger(1, (math.max(1, (math.round(v5 / sum))))) == 1 then
						task.spawn(function() --[[ Line: 131 | Upvalues: v11 (ref), v14 (copy), v2 (ref) ]]
							v11(v14.CFrame * CFrame.Angles(math.rad((v2:NextInteger(-25, 25))), math.rad((v2:NextInteger(-25, 25))), (math.rad((v2:NextInteger(-25, 25))))), v14.Size)
						end)
					else
						continue
					end
				end
			end
		end

		local sum2 = v4 + 1

		v11(Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0), Base.Size)

		local sum3 = 1

		while v2:NextInteger(1, 3) == 1 do
			sum3 = sum3 + 0.1
		end

		for k, v in pairs(tbl) do
			local v12 = script.Leaf_Part:Clone()
			local v13 = v2:NextInteger(11, 15)

			v12.Size = Vector3.new(v13 * (v1 * 0.25 + 0.75) * sum3, v13 * (v2:NextInteger(7, 9) * 0.1) * (v1 * 0.25 + 0.75) * sum3, v13 * (v1 * 0.25 + 0.75) * sum3)
			v12.Color = Color3.fromHSV(v2:NextInteger(0, 160) * 0.001, 1, 1)
			v12.Name = tostring(sum2)
			v12.CFrame = v.CFrame * CFrame.new(0, v12.Size.Y / 2, 0)
			v12.Orientation = Vector3.new(0, v2:NextInteger(-180, 180), 0)
			v12.Parent = p1

			for i = 1, 1 do
				local Part = Instance.new("Part")

				Part.Transparency = 1
				Part.Anchored = true
				Part.CanCollide = false
				Part.Size = Vector3.new(1, 1, 1)
				Part.Parent = FruitSpawnLocations
				Part.CFrame = v12.CFrame * CFrame.new(v2:NextInteger(-v12.Size.X, v12.Size.X) * 0.25, -v12.Size.Y / 2, v2:NextInteger(-v12.Size.Z, v12.Size.Z) * 0.25)
			end

			sum2 = sum2 + 0.25
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 175 ]]
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

		table.sort(t, function(p1, p2) --[[ Line: 194 ]]
			return p1[4] < p2[4]
		end)

		local function updateGrowth() --[[ updateGrowth | Line: 196 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0

			for v2, v3 in t do
				local v4 = v3[1]
				local v5 = v3[2]
				local v6 = v3[3]
				local v8 = math.clamp(v1 - v3[4], 0, 1)

				if v8 > 0 then
					v4.Size = Vector3.new(v5.X * v8, v5.Y * v8, v5.Z * v8)
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