--credit to quartz games studio
local function getMiddle50(p1) --[[ getMiddle50 | Line: 2 ]]
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
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 19 | Upvalues: getMiddle50 (copy) ]]
		local v1 = p3 or 1
		local v2 = Random.new(p2)
		local FruitSpawnLocations = p1.FruitSpawnLocations
		local Base = p1.Base
		local v3 = 0
		local Stud_Part = script.Stud_Part
		local sum = v2:NextInteger(4, 7)
		local v4 = 1 * (v1 * 0.25 + 0.75)
		local v5 = 3 * (v1 * 0.25 + 0.75)
		local sum2 = 12 * (v1 * 0.25 + 0.75)
		local sum3 = 1

		if v2:NextInteger(1, 300) == 1 then
			v5 = v5 * 3
			sum3 = sum3 * 3
			sum = sum * 3
			sum2 = sum2 * 3
			v4 = v4 * 3
		end

		while v2:NextInteger(1, 30) == 1 do
			sum2 = sum2 + v2:NextInteger(4, 7)
			sum = sum + v2:NextInteger(4, 7)
			sum3 = sum3 + 0.25
		end

		local v6 = Color3.new(1, 0.92549, 0.631373)
		local tbl = {}

		local function buildChain(p12, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ buildChain | Line: 59 | Upvalues: Stud_Part (copy), v6 (copy), v3 (ref), p1 (copy) ]]
			local t = {}
			local v1 = if p10 then p12 * CFrame.Angles(0, math.rad(p10), 0) else p12
			local sum, sum2, v2 = p6, p7, p2

			for i = 1, p3 do
				local v32 = Stud_Part:Clone()

				v32.Color = v6
				v32.Size = Vector3.new(p4, p5, p4)
				v3 = v3 + 1
				v32.Name = tostring(v3)
				v32.CFrame = v1 * CFrame.new(0, v2.Y / 2 + v32.Size.Y / 2, 0)
				v32.CFrame = v32.CFrame * CFrame.new(0, -v32.Size.Y / 2, 0) * CFrame.Angles(math.rad(sum), 0, (math.rad(sum2))) * CFrame.new(0, v32.Size.Y / 2, 0)
				v32.Parent = p1
				v1 = v32.CFrame
				v2 = v32.Size
				table.insert(t, v32)

				if i == 1 then
					sum2 = p9
					sum = p8
				else
					sum2 = sum2 + p9
					sum = sum + p8
				end

				p4 = p4 * 0.95
				p5 = p5 * 0.95
			end

			return t
		end

		local sum4 = v3 + 1
		local v7 = (v2:NextNumber() * 2 - 1) * 1.5
		local v8 = (v2:NextNumber() * 2 - 1) * 1.5
		local v9 = buildChain(Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0), Base.Size, sum2, v4, v5, v7, v8, v7 * 0.2, v8 * 0.2, nil)
		local v10 = getMiddle50(v9)

		for i = 1, sum do
			local v11 = v10[v2:NextInteger(1, #v10)]
			local v12 = v4 * 0.75
			local v13 = v5 * 0.5
			local v14 = v2:NextInteger(6, 10)
			local v15 = v2:NextInteger(40, 70)
			local v17 = v15 * (if v2:NextInteger(0, 1) == 0 then -1 else 1)
			local v18 = v2:NextInteger(40, 70)
			local v22 = buildChain(v11.CFrame, v11.Size, v14, v12, v13, v17, v18 * (if v2:NextInteger(0, 1) == 0 then -1 else 1), 2.5, 2.5, (v2:NextInteger(-180, 180)))

			if #v22 > 0 then
				table.insert(tbl, v22[#v22])
			end

			local v24 = v2:NextInteger(1, 3)
			local v25 = if #v22 > 2 then getMiddle50(v22) else v22

			for j = 1, v24 do
				if #v25 == 0 then
					break
				end

				local v27 = v25[v2:NextInteger(1, #v25)]
				local v30 = v2:NextInteger(4, 6)
				local v31 = v2:NextInteger(35, 65)
				local v33 = v31 * (if v2:NextInteger(0, 1) == 0 then -1 else 1)
				local v34 = v2:NextInteger(35, 65)
				local v38 = buildChain(v27.CFrame, v27.Size, v30, v12 * 0.65, v13 * 0.5, v33, v34 * (if v2:NextInteger(0, 1) == 0 then -1 else 1), 2, 2, (v2:NextInteger(-180, 180)))

				if #v38 > 0 then
					table.insert(tbl, v38[#v38])
				end
			end
		end

		table.insert(tbl, v9[#v9])

		local t = {
			Color3.fromRGB(255, 133, 231),
			Color3.fromRGB(255, 174, 244),
			Color3.fromRGB(255, 98, 226),
			Color3.fromRGB(255, 169, 232)
		}

		for k, v in pairs(tbl) do
			local v41 = script.Leaf_Part:Clone()
			local v42 = v2:NextInteger(5, 9) * 1.2

			v41.Size = Vector3.new(v42 * (v1 * 0.1 + 0.9) * sum3, v42 * (v2:NextInteger(6, 8) * 0.1) * 1.2 * (v1 * 0.1 + 0.9) * sum3, v42 * (v1 * 0.1 + 0.9) * sum3)
			v41.Color = t[v2:NextInteger(1, #t)]
			v41.Name = tostring(sum4)
			v41.CFrame = v.CFrame * CFrame.new(0, v41.Size.Y / 2, 0)
			v41.Orientation = Vector3.new(0, v2:NextInteger(-180, 180), 0)
			v41.Parent = p1

			for k2 = 1, 1 do
				local Part = Instance.new("Part")

				Part.Transparency = 1
				Part.Anchored = true
				Part.CanCollide = false
				Part.Size = Vector3.new(1, 1, 1)
				Part.Parent = FruitSpawnLocations

				local v45 = RaycastParams.new()

				v45.FilterType = Enum.RaycastFilterType.Include
				v45.FilterDescendantsInstances = { v41 }
				v45.IgnoreWater = true

				local v46 = v2:NextNumber(0, 6.283185307179586)
				local v47 = -v2:NextNumber(0.15, 1)
				local v48 = math.sqrt(1 - v47 * v47)
				local v51 = Vector3.new(math.cos(v46) * v48, v47, math.sin(v46) * v48)
				local v55 = v41.Position + Vector3.new(v51.X * v41.Size.X * 0.6, v51.Y * v41.Size.Y * 1.2, v51.Z * v41.Size.Z * 0.6)
				local v57 = workspace:Raycast(v55, (v41.Position - v55).Unit * (math.max(v41.Size.X, v41.Size.Y, v41.Size.Z) * 3), v45)

				if v57 then
					Part.Position = v57.Position + v57.Normal * 0.05

					continue
				end

				Part.Position = v41.Position
			end

			sum4 = sum4 + 0.25
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 251 ]]
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

		table.sort(t, function(p1, p2) --[[ Line: 269 ]]
			return p1[4] < p2[4]
		end)

		local function updateGrowth() --[[ updateGrowth | Line: 271 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
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