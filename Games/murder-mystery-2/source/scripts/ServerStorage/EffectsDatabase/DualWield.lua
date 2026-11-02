return function(Knife)
	local hasEquipped = false
	local DualValue = Instance.new("BoolValue", Knife)
	DualValue.Name = "DualEffect"
	DualValue.Value = true
	Knife.Equipped:connect(function()
		if Knife.Parent:FindFirstChild("Humanoid") and not hasEquipped then
			hasEquipped = true
			local Player = Knife.Parent
			local Dual = Knife.Handle:Clone()
			local LeftArm = Player:WaitForChild("LeftLowerArm")
			local Weld = Instance.new("Weld", Player)

			Dual.Parent = Knife
			Dual.Name = "Dual"
			Dual.CanCollide = false
			Dual.Massless = true
			Weld.Part0 = LeftArm
			Weld.Part1 = Dual

			if Knife.Handle.Mesh.MeshId == "http://www.roblox.com/asset/?id=238314098" or Knife.Handle.Mesh.MeshId == "http://www.roblox.com/asset/?id=352571495" or Knife.Handle.Mesh.MeshId == "http://www.roblox.com/asset/?id=238314382" then
				Weld.C1 = CFrame.new(0, 1, 1)
			elseif Knife.Handle.Mesh.MeshId == "http://www.roblox.com/asset/?id=117500241" or Knife.Handle.Mesh.MeshId == "http://www.roblox.com/asset/?id=62275962" then
				Weld.C1 = CFrame.new(-1, -1, 0) * CFrame.Angles(math.pi / 2, 0, math.pi / 2)
			else
				Weld.C1 = CFrame.new(0, -1, 1) * CFrame.Angles(math.pi / 2, 0, 0)
			end
		end
	end)
end