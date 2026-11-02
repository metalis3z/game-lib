--credit to leon games studio
return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 0.8
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 8 ]]
		local v1 = Random.new(p2)
		local v2 = p1.PrimaryPart or p1:FindFirstChild("Base")
		local v3 = p3 or 1

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") and v ~= v2 then
				v.Size = v.Size * v3

				local v4 = v2.CFrame:ToObjectSpace(v.CFrame)

				v.CFrame = v2.CFrame * CFrame.new(v4.Position * v3) * v4.Rotation
			end
		end

		local v6 = Color3.fromHSV(0.1 + 0.03 * ((v1:NextInteger(1, 10) - 0.1) * 0.1), 1, 1)

		if v1:NextInteger(1, 100) == 1 then
			v6 = Color3.new(255/255, 255/255, 0/255)
		end

		if v1:NextInteger(1, 1000) == 1 then
			v6 = Color3.new(0, 0.333333, 1)
		end

		if v1:NextInteger(1, 10000) == 1 then
			v6 = Color3.new(1, 0.333333, 1)
		end

		if v1:NextInteger(1, 100000) == 1 then
			v6 = Color3.new(255/255, 255/255, 255/255)
		end

		if v1:NextInteger(1, 1000000) == 1 then
			v6 = Color3.new(0/255, 0/255, 0/255)
		end

		for k, v in pairs(p1:GetChildren()) do
			if v.Name == "1" or v.Name == "2" then
				v.Color = v6
			end
		end

		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 66 ]]
		local PrimaryPart = p1.PrimaryPart
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			local v4 = tonumber(v2.Name)

			if v2:IsA("BasePart") and v4 then
				table.insert(t, {
					part = v2,
					maxSize = v2.Size,
					offset = PrimaryPart.CFrame:ToObjectSpace(v2.CFrame),
					partAge = v4
				})
				v2.CanCollide = false
				v2.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 86 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy) ]]
			local v1 = p1:GetAttribute("Age") or 0
			local v2 = p1:GetAttribute("MaxAge") or 1
			local v3 = v1 / v2

			for v4, v5 in t do
				local part = v5.part
				local maxSize = v5.maxSize
				local offset = v5.offset
				local v7 = math.min((v3 - v5.partAge / v2) * v2, 1)

				if v7 > 0 then
					part.Size = Vector3.new(maxSize.X, maxSize.Y * v7, maxSize.Z)
					part.CFrame = PrimaryPart.CFrame * offset * CFrame.new(0, (part.Size.Y - maxSize.Y) / 2, 0)
					part.Transparency = part:GetAttribute("OG_Transparency") or 0
					part.CanCollide = true

					if part:FindFirstChild("Decal") and v7 >= 1 then
						for v10, v11 in part:GetChildren() do
							if v11:IsA("Decal") then
								v11.Transparency = 0.4
							end
						end
					end

					continue
				end

				part.Transparency = 1
				part.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end
}