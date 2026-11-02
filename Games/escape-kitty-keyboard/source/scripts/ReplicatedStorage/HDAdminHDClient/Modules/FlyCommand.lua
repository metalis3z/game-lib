

local u1 = _G.HDAdminMain
local v2 = {}
local function u6(p3, p4) 

	for _, v5 in pairs(p3:GetDescendants()) do
		if v5:IsA("BasePart") then
			u1.physicsService:SetPartCollisionGroup(v5, p4)
		end
	end
end
function v2.Fly(_, p7, p8) 

	local v9 = p7 == "fly2" and "Sit" or "PlatformStand"
	local v10 = u1:GetModule("cf"):GetHRP()
	local v11 = u1:GetModule("cf"):GetHumanoid()
	if v10 and v11 then
		local v12 = Instance.new("BodyPosition")
		v12.MaxForce = Vector3.new(inf, inf, inf)
		v12.Position = v10.Position + Vector3.new(0, 4, 0)
		v12.Name = "HDAdminFlyForce"
		v12.Parent = v10
		local v13 = Instance.new("BodyGyro")
		v13.D = 50
		v13.MaxTorque = Vector3.new(inf, inf, inf)
		if p8 then
			v13.P = 2000
		else
			v13.P = 200
		end
		v13.Name = "HDAdminFlyGyro"
		v13.CFrame = v10.CFrame
		v13.Parent = v10
		local v14 = 0
		local v15 = 0
		if p8 then
			u6(workspace, "Group1")
			u6(u1.player.Character, "Group2")
		end
		local v16 = tick()
		local v17 = v10.Position
		while true do
			local v18 = tick() - v16
			local v19 = (u1.camera.Focus.p - u1.camera.CFrame.p).unit
			local v20 = u1.commandSpeeds[p7]
			local v21, v22 = u1:GetModule("cf"):GetNextMovement(v18, v20 * 10)
			local v23 = v10.Position
			local v24 = CFrame.new(v23, v23 + v19) * v21
			local v25 = 750 + v20 * 0.2
			if p8 then
				v25 = v25 / 2
			end
			local v26
			if v21.p == Vector3.new() then
				v15 = v15 + 1
				v26 = 1
				if (v10.Position - v17).magnitude > 6 and v15 >= 4 then
					v12.Position = v10.Position
				end
			else
				v12.D = v25
				v26 = v14 + 1
				v12.Position = v24.p
				v15 = 0
			end
			v14 = math.abs(v26) > 25 and 25 or v26
			if v12.D == v25 then
				local _ = v14 * v22.X * -0.5
				local v27 = p8 and 0 or v14 * v22.Z
				v13.CFrame = v24 * CFrame.Angles(math.rad(v27), 0, 0)
			end
			v16 = tick()
			v17 = v10.Position
			v11[v9] = true
			wait()
			if not (u1.commandsActive[p7] and (v11 and v10)) then
				v12:Destroy()
				v13:Destroy()
				if v11 then
					v11[v9] = false
				end
				if p8 then
					u6(workspace, "Group3")
				end
				goto l4
			end
		end
	else
		::l4::
		u1.commandsActive[p7] = nil
		return
	end
end
return v2