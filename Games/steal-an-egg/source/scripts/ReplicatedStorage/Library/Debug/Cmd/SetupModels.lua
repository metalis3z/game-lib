-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Selection = game:GetService("Selection")

game:GetService("ChangeHistoryService")

for i, v in ipairs(Selection:Get()) do
	if v:IsA("Model") then
		local Humanoid = v:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")

		if Humanoid and HumanoidRootPart then
			local v1, v2 = v:GetBoundingBox()
			local Model = Instance.new("Model")

			Model.Parent = v.Parent
			v.Parent = Model

			for i2, v3 in ipairs(Humanoid:GetChildren()) do
				v3:Destroy()
			end

			Humanoid.Parent = Model

			local v3 = HumanoidRootPart:Clone()

			for i2, v4 in ipairs(v3:GetChildren()) do
				v4:Destroy()
			end

			HumanoidRootPart.Anchored = false
			v3.Anchored = false
			v3.Parent = Model

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = HumanoidRootPart
			WeldConstraint.Part1 = v3
			WeldConstraint.Parent = HumanoidRootPart

			local AnimationController = Instance.new("AnimationController")

			Instance.new("Animator").Parent = AnimationController
			AnimationController.Parent = v
			Model.Name = v.Name
			v.Name = "Model"
			Model.PrimaryPart = v3

			local CENTER = Instance.new("Part")

			CENTER.Name = "CENTER"
			CENTER.Size = Vector3.new(0.831, 0.741, 0.002)
			CENTER.Transparency = 1
			CENTER.Anchored = false
			CENTER.CanCollide = false
			CENTER.CanTouch = false
			CENTER.CanQuery = false
			CENTER.Parent = Model
			CENTER.CFrame = v1 * CFrame.new(0, v2.Y / 2 + 3, 0)

			local WeldConstraint2 = Instance.new("WeldConstraint")

			WeldConstraint2.Part0 = CENTER
			WeldConstraint2.Part1 = v3
			WeldConstraint2.Parent = CENTER
		end
	end
end