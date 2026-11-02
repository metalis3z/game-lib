--credit to prince games studio
local function isLocalPlayersPlant(p1) --[[ isLocalPlayersPlant | Line: 2 ]]
	local LocalPlayer = game.Players.LocalPlayer

	if not LocalPlayer then
		return false
	end

	local isUserId = p1:GetAttribute("UserId") == LocalPlayer.UserId

	return isUserId
end

return {
	GrowData = {
		InheritPlantSizeMultiplier = 0.25,
		BaseWeight = 5
	},
	InitPlant = function(p1, p2, p3) --[[ InitPlant | Line: 13 ]]
		local v1 = Random.new(p2)
		local Base = p1.Base
		local v2 = p3 or 1
		local count = 0
		local Stud_Part = script.Stud_Part
		local v4 = math.round(v1:NextInteger(7, 11) + v2 ^ 2)
		local v5 = math.round(v2 * 0.5 + 0.5)

		if v2 > 3 and v1:NextInteger(1, 3) == 1 then
			v5 = 2
		end

		local Size = Base.Size
		local v6 = Base.CFrame * CFrame.new(0, -Base.Size.Y / 2, 0)
		local v7 = Color3.new(0, 0.666667, 0)
		local v8 = Color3.new(0, 0.392157, 0)
		local v9 = true
		local sum = 0

		for i = 1, v4 do
			local v10

			count = count + 1

			if v9 == true then
				local v11 = Stud_Part:Clone()

				v11.Size = Vector3.new(v5, 3, v5)
				v11.CFrame = v6 * CFrame.new(0, v11.Size.Y / 2 + Size.Y / 2, 0)
				v11.Name = tostring(count)
				v11.Color = v7
				v11:SetAttribute("NoCanCollide", true)
				v11.Parent = p1
				v10 = v11
			else
				local v12 = Stud_Part:Clone()

				v12.Size = Vector3.new(v5 + 0.25, 0.5, v5 + 0.25)
				v12.CFrame = v6 * CFrame.new(0, v12.Size.Y / 2 + Size.Y / 2, 0)
				v12.Name = tostring(count)
				v12.Color = v8
				v12:SetAttribute("NoCanCollide", true)
				v12.Parent = p1
				v10 = v12
			end

			sum = sum + v10.Size.Y
			v6 = v10.CFrame
			Size = v10.Size
			v9 = not v9
		end

		local count2, v13 = 0, sum

		while sum > 0 do
			count2 = count2 + 1

			local v14 = Stud_Part:Clone()

			v14.Size = Vector3.new(0.5, v5 + 0.5, v5 + 0.5)
			v14.Shape = Enum.PartType.Cylinder

			local v15 = count2 * 1 - 0.75

			v14.CFrame = Base.CFrame * CFrame.new(0, v15, 0)
			v14.CFrame = v14.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
			v14.Name = tostring(count * (v15 / v13))
			v14.Transparency = 1
			v14:SetAttribute("OG_Transparency", 1)
			v14:SetAttribute("ClimbRung", true)
			v14.Parent = p1
			sum = sum - 1
		end

		local CollisionBlock = Stud_Part:Clone()

		CollisionBlock.Name = "CollisionBlock"
		CollisionBlock.Size = Vector3.new(v5 + 0.25, v13, v5 + 0.25)
		CollisionBlock.CFrame = Base.CFrame * CFrame.new(0, v13 / 2, 0)
		CollisionBlock.Transparency = 1
		CollisionBlock:SetAttribute("OG_Transparency", 1)
		CollisionBlock:SetAttribute("IsCollisionBlock", true)
		CollisionBlock:SetAttribute("MaxHeight", v13)
		CollisionBlock.Parent = p1
		p1:AddTag("InitializationComplete")
	end,
	BeginPlantGrowth = function(p1) --[[ BeginPlantGrowth | Line: 97 ]]
		local LocalPlayer = game.Players.LocalPlayer
		local v1 = if LocalPlayer then if p1:GetAttribute("UserId") == LocalPlayer.UserId then true else false else false
		local PrimaryPart = p1.PrimaryPart
		local CollisionBlock = p1:WaitForChild("CollisionBlock")
		local v2 = CollisionBlock:GetAttribute("MaxHeight")

		CollisionBlock.CanCollide = false
		CollisionBlock.Transparency = 1

		local t = {}

		for v3, v4 in p1:GetDescendants() do
			local v6 = tonumber(v4.Name)

			if v4:IsA("BasePart") and v6 then
				table.insert(t, {
					v4,
					v4.Size,
					PrimaryPart.CFrame:ToObjectSpace(v4.CFrame),
					v6
				})
				v4.CanCollide = false
				v4.Transparency = 1
			end
		end

		local function updateGrowth() --[[ updateGrowth | Line: 121 | Upvalues: p1 (copy), t (copy), PrimaryPart (copy), v1 (copy), v2 (copy), CollisionBlock (copy) ]]
			local v12 = p1:GetAttribute("Age") or 0
			local v22 = p1:GetAttribute("MaxAge") or 1
			local v3 = v12 / v22

			for v4, v5 in t do
				local v6 = v5[1]
				local v7 = v5[2]
				local v8 = v5[3]
				local v10 = math.min((v3 - v5[4] / v22) * v22, 1)

				if v10 > 0 then
					v6.Size = Vector3.new(v7.X, v7.Y * v10, v7.Z)
					v6.CFrame = PrimaryPart.CFrame * v8 * CFrame.new(0, (v6.Size.Y - v7.Y) / 2, 0)
					v6.Transparency = v6:GetAttribute("OG_Transparency") or 0

					if v6:GetAttribute("ClimbRung") then
						v6.CanCollide = v1
					end

					if v6:FindFirstChild("Decal") and v10 >= 1 then
						for v122, v13 in v6:GetChildren() do
							if v13:IsA("Decal") then
								v13.Transparency = 0.4
							end
						end
					end

					continue
				end

				v6.Transparency = 1
				v6.CanCollide = false
			end

			local v14 = v2 * v3

			if v14 > 0 then
				CollisionBlock.Size = Vector3.new(CollisionBlock.Size.X, v14, CollisionBlock.Size.Z)
				CollisionBlock.CFrame = PrimaryPart.CFrame * CFrame.new(0, v14 / 2, 0)
				CollisionBlock.CanCollide = not v1
			else
				CollisionBlock.CanCollide = false
			end
		end

		p1:GetAttributeChangedSignal("Age"):Connect(updateGrowth)
		updateGrowth()
	end
}