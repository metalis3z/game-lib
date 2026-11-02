--credit to leon games studio
local Stud_Part = script.Stud_Part

return {
	GrowData = {
		GrowRate = 0.0119,
		BaseWeight = 1.5,
		GrowTickTime = NumberRange.new(4.8, 6)
	},
	InitFruit = function(p1, p2, p3) --[[ InitFruit | Line: 11 | Upvalues: Stud_Part (copy) ]]
		local v1 = Random.new(p2)
		local v2 = Stud_Part:Clone()

		v2.Anchored = true
		v2.Parent = p1

		local v3 = Color3.new(0, 0.666667, 0)

		if v1:NextInteger(1, 100) == 1 then
			v3 = Color3.new(0.458824, 0, 0)
		end

		v2.Color = v3
		v2.CFrame = p1.PrimaryPart.CFrame

		local v5 = 2 * p3
		local Size = v2.Size
		local t = {}

		v2.Size = Vector3.new(v5, v5, v5)
		v2.CFrame = v2.CFrame * CFrame.new(0, (v2.Size.Y - Size.Y) / 2, 0)
		v2.Name = "1"

		local Spike = script.Spike

		local function CreateSpikesOnFace(p12, p2) --[[ CreateSpikesOnFace | Line: 45 | Upvalues: v1 (copy), p3 (copy), v2 (copy), Spike (copy), p1 (copy), t (copy) ]]
			for i = 1, if v1:NextInteger(1, 3) == 1 then v1:NextInteger(2, 3) else 1 do
				local v3, v4
				local v5 = v1:NextInteger(20, 40) * 0.01 * p3

				if v1:NextInteger(1, 3) == 1 then
					v5 = v5 * 1.5

					if v1:NextInteger(1, 3) == 1 then
						v5 = v5 * 1.25
					end
				end

				local v7 = if p12 == "X" then v2.Size.Z / 2 else v2.Size.X / 2
				local v8 = (v1:NextNumber() * 2 - 1) * (v2.Size.Y / 2 - v5)
				local v9 = (v1:NextNumber() * 2 - 1) * (v7 - v5)
				local v10 = Spike:Clone()

				if p12 == "X" then
					v3 = v2.CFrame * CFrame.new(p2 * v2.Size.X / 2, 0, 0) * CFrame.new(0, v8, v9)
					v4 = CFrame.Angles(0, 0, (math.rad(-90 * p2)))
				else
					v3 = v2.CFrame * CFrame.new(0, 0, p2 * v2.Size.Z / 2) * CFrame.new(v9, v8, 0)

					local v122 = CFrame.Angles(0, math.rad(-90 * p2), (math.rad(90 * p2)))

					v4 = if p2 == 1 then v122 * CFrame.Angles(math.pi, 0, 0) else v122
				end

				v10.Size = Vector3.new(v5, v5 * 0.8, v5)
				v10.CFrame = v3 * v4 * CFrame.new(0, v10.Size.Y / 2, 0)
				v10.Parent = p1
				table.insert(t, v10)
			end
		end

		CreateSpikesOnFace("X", 1)
		CreateSpikesOnFace("X", -1)
		CreateSpikesOnFace("Z", 1)
		CreateSpikesOnFace("Z", -1)

		local v6 = Stud_Part:Clone()

		v6.Parent = p1
		v6.Color = Color3.fromHSV(v1:NextInteger(100, 160) * 0.001, 1, 1)
		v6.Size = Vector3.new(1 * p3, v6.Size.Y * 0.05, 1 * p3)
		v6.CFrame = v2.CFrame * CFrame.new(0, v2.Size.Y / 2 + v6.Size.Y / 2, 0)
		v6.Name = "2"

		local t2 = {
			{
				offset = CFrame.new(v6.Size.X / 2, 0, 0),
				preRot = CFrame.Angles(0, 1.5707963267948966, 0),
				tilt = CFrame.Angles(0.7853981633974483, 0, 0)
			},
			{
				offset = CFrame.new(-v6.Size.X / 2, 0, 0),
				preRot = CFrame.Angles(0, 1.5707963267948966, 0),
				tilt = CFrame.Angles(-0.7853981633974483, 0, 0)
			},
			{
				offset = CFrame.new(0, 0, -v6.Size.Z / 2),
				preRot = CFrame.new(),
				tilt = CFrame.Angles(-0.7853981633974483, 0, 0)
			},
			{
				offset = CFrame.new(0, 0, v6.Size.Z / 2),
				preRot = CFrame.new(),
				tilt = CFrame.Angles(0.7853981633974483, 0, 0)
			}
		}
		local v9 = Vector3.new(v6.Size.X, v6.Size.X, v6.Size.Y * 2)
		local t3 = {}

		for v10, v11 in t2 do
			local v12 = v6:Clone()

			v12.Color = Color3.new(255/255, 0/255, 0/255)
			v12.Size = v9
			v12.CFrame = v6.CFrame * v11.offset
			v12.Parent = p1
			v12.CFrame = v12.CFrame * v11.preRot
			v12.CFrame = v12.CFrame * v11.tilt
			v12.CFrame = v12.CFrame * CFrame.new(0, v9.Y / 2, 0)
			v12.Name = "3"
			table.insert(t3, v12)
		end

		for v13, v14 in t do
			v14.Color = Color3.new(0.27451, 0.27451, 0.27451)
			v14.Name = "4"
		end

		for v15, v16 in p1:GetChildren() do
			if v16:IsA("BasePart") then
				v16.CanCollide = false
				v16.CanQuery = true
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginFruitGrowth = function(p1) --[[ BeginFruitGrowth | Line: 166 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if (v2:IsA("BasePart") or v2:IsA("UnionOperation")) and v4 then
				local v5 = not v2:GetAttribute("DontShow")

				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					centerOffset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4
				})
				v2.CanCollide = false

				if v5 then
					v2.Transparency = 1
				end
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 189 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				if not v5.part:GetAttribute("DontShow") then
					local v7 = math.clamp((v3 - (v5.partAge - 1) / v2) * v2, 0, 1)

					if v7 > 0 then
						v5.part.Size = v5.maxSize * v7
						v5.part.CFrame = PrimaryPart.CFrame * v5.centerOffset
						v5.part.Transparency = v5.part:GetAttribute("OG_Transparency") or 0
						v5.part.CanCollide = true

						continue
					end

					v5.part.Transparency = 1
					v5.part.CanCollide = false
				end
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end,
	OnFullyGrown = function(p1) --[[ OnFullyGrown | Line: 218 ]]
		local v1 = p1:GetAttribute("CorePartName")

		if v1 then
			local v2 = p1:FindFirstChild(v1)

			if v2 then
				local Collect_PROX_Apple = game.ServerStorage:FindFirstChild("Collect_PROX_Apple")

				if Collect_PROX_Apple then
					local ProximityPrompt = Collect_PROX_Apple:Clone()

					ProximityPrompt.Name = "ProximityPrompt"
					ProximityPrompt.Parent = v2
				end
			end
		end

		p1:AddTag("PlantGenerated")
	end,
	Extras = {
		FruitType = "Cactus",
		Harvestable = true
	}
}