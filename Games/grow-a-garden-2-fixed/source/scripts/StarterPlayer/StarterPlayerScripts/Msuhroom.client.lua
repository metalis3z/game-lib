--credit to quartz games studio
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer

local function RegisterCap(p1) --[[ RegisterCap | Line: 8 | Upvalues: LocalPlayer (copy) ]]
	local v1 = 0

	p1.Touched:Connect(function(p13) --[[ Line: 12 | Upvalues: v1 (ref), LocalPlayer (ref), p1 (copy) ]]
		local v12 = os.clock()

		if v12 - v1 < 0.25 then
			return
		end

		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		if not p13:IsDescendantOf(Character) then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			return
		end

		if not (HumanoidRootPart.Position.Y - Humanoid.HipHeight < p1.Position.Y + p1.Size.Y / 2 - 1) then
			v1 = v12
			HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X * 0.2, 120, HumanoidRootPart.AssemblyLinearVelocity.Z * 0.2)
		end
	end)
end

for v1, v2 in CollectionService:GetTagged("MushroomCap") do
	if v2:IsA("BasePart") then
		local v3 = 0

		v2.Touched:Connect(function(p13) --[[ Line: 12 | Upvalues: v3 (ref), LocalPlayer (copy), v2 (copy) ]]
			local v12 = os.clock()

			if v12 - v3 < 0.25 then
				return
			end

			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			if not p13:IsDescendantOf(Character) then
				return
			end

			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				return
			end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			if not (HumanoidRootPart.Position.Y - Humanoid.HipHeight < v2.Position.Y + v2.Size.Y / 2 - 1) then
				v3 = v12
				HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X * 0.2, 120, HumanoidRootPart.AssemblyLinearVelocity.Z * 0.2)
			end
		end)
	end
end

CollectionService:GetInstanceAddedSignal("MushroomCap"):Connect(function(p1) --[[ Line: 46 | Upvalues: LocalPlayer (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	local v1 = 0

	p1.Touched:Connect(function(p13) --[[ Line: 12 | Upvalues: v1 (ref), LocalPlayer (ref), p1 (copy) ]]
		local v12 = os.clock()

		if v12 - v1 < 0.25 then
			return
		end

		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		if not p13:IsDescendantOf(Character) then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			return
		end

		if not (HumanoidRootPart.Position.Y - Humanoid.HipHeight < p1.Position.Y + p1.Size.Y / 2 - 1) then
			v1 = v12
			HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X * 0.2, 120, HumanoidRootPart.AssemblyLinearVelocity.Z * 0.2)
		end
	end)
end)