local v_u_1 = script.Parent:WaitForChild("Handle")
return function(p_u_2, p3, p4)
	-- upvalues: (copy) v_u_1
	local v_u_5 = v_u_1:Clone()
	v_u_5.CFrame = v_u_1.CFrame
	game.Debris:AddItem(v_u_5, 3)
	local v6 = (p4 - p3).Unit
	local _ = (p4 - p3).Magnitude
	local v7 = 120
	local v8 = v6.X * v7
	local v9 = v6.Z * v7
	v_u_5.AssemblyLinearVelocity = Vector3.new(v8, 24, v9)
	local v10 = math.random(-10, 10)
	local v11 = math.random(-10, 10)
	local v12 = math.random
	v_u_5.AssemblyAngularVelocity = Vector3.new(v10, v11, v12(-10, 10))
	v_u_5.CollisionGroup = "AnchoredRagdolls"
	v_u_5.CanCollide = false
	v_u_1.Transparency = 1
	v_u_5.Touched:Connect(function(p13)
		-- upvalues: (copy) p_u_2, (copy) v_u_5
		if not p13:IsDescendantOf(p_u_2) then
			local v14 = Instance.new("Part")
			v14.Anchored = true
			v14.Size = Vector3.new(1, 1, 1)
			v14.CanCollide = false
			v14.CanQuery = false
			v14.Transparency = 1
			v14.CFrame = v_u_5.CFrame
			v14.Parent = workspace
			game.Debris:AddItem(v14, 1)
			local v15 = script.Effect1:Clone()
			local v16 = script.Effect2:Clone()
			v15.Parent = v14
			v16.Parent = v14
			v15:Emit(5)
			v16:Emit(5)
			v_u_5:Destroy()
		end
	end)
	v_u_5.Parent = workspace
	task.wait(2)
	v_u_1.Transparency = 0
end
