return function(Knife)
	local KnifeEquipped = false
	Instance.new("BoolValue", Knife.Parent).Name = "DualEffect"

	Knife.Parent.Equipped:connect(function()
		if Knife.Parent.Parent:FindFirstChild("Humanoid") and not KnifeEquipped then
			local Player = Knife.Parent.Parent;
			KnifeEquipped = true
			local Character = Knife.Parent.Parent
			local Dual = Knife:Clone()
			local LeftArm = Character:WaitForChild("LeftHand")

			Dual.Parent = Knife.Parent
			Dual.Name = "DualKnife"
			Dual.CanCollide = false

			local Weld = Instance.new("Weld", Dual)
			Weld.Part0,Weld.Part1 = LeftArm,Dual
			Weld.C0 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(-90),0,0) * Knife.Parent.Grip:inverse()
		end
	end)

	Knife.Parent.Unequipped:connect(function()
		if Knife.Parent.Parent:FindFirstChild("Humanoid") and Knife.Parent:FindFirstChild("DualKnife") and KnifeEquipped then
			KnifeEquipped = false
			Knife.Parent.DualKnife:Destroy()
		end
	end)
end
