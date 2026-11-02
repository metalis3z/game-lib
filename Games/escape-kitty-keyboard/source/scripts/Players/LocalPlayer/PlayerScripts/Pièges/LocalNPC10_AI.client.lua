-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("ContentProvider")
local u5 = v1.LocalPlayer
local u6 = {
	["CHASE_SPEED"] = 150,
	["RETURN_SPEED"] = 50,
	["DETECTION_RANGE_SQ"] = 4000000,
	["STOP_DISTANCE"] = 12,
	["UPDATE_RATE"] = 0.03,
	["PHYSICS_WALL"] = 350,
	["ID_WALK"] = "rbxassetid://104571570562605",
	["ID_IDLE"] = "rbxassetid://123873530367173"
}
local u7 = v3:WaitForChild("NPC10")
local u8 = Instance.new("Animation")
u8.AnimationId = u6.ID_WALK
local u9 = Instance.new("Animation")
u9.AnimationId = u6.ID_IDLE
local u10 = u7:GetPivot()
task.spawn(function()
	-- upvalues: (copy) u4, (copy) u8, (copy) u9, (copy) u7
	u4:PreloadAsync({ u8, u9, u7 })
end)
local u11 = {}
local function u41(u12, _) -- name: startNPCLogic
	-- upvalues: (copy) u11, (copy) u7, (copy) u10, (copy) u8, (copy) u9, (copy) u5, (copy) u6
	if not u11[u12] then
		u11[u12] = true
		local u13 = u7:Clone()
		u13:PivotTo(u10)
		u13.Parent = workspace
		local u14 = u13:WaitForChild("HumanoidRootPart")
		local u15 = u13:WaitForChild("Humanoid")
		local v16 = u15:WaitForChild("Animator")
		local v17 = u13:WaitForChild("Hitbox")
		local u18 = u14:WaitForChild("ChaseMusic")
		u14.Anchored = true
		u15:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		u15:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		u15:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		u15:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
		local u19 = v16:LoadAnimation(u8)
		local u20 = v16:LoadAnimation(u9)
		local u21 = "Idle"
		u20:Play()
		local u24 = v17.Touched:Connect(function(p22)
			-- upvalues: (ref) u5
			if p22.Parent == u5.Character then
				local v23 = p22.Parent:FindFirstChildOfClass("Humanoid")
				if v23 and v23.Health > 0 then
					v23.Health = 0
				end
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) u13, (copy) u12, (ref) u5, (copy) u14, (ref) u10, (ref) u6, (ref) u21, (copy) u15, (copy) u18, (copy) u19, (copy) u20, (copy) u24, (ref) u11
			while u13.Parent and u12.Parent do
				local v25 = u5.Character
				local v26
				if v25 then
					v26 = v25:FindFirstChild("HumanoidRootPart")
				else
					v26 = nil
				end
				local v27 = u14.Position
				local v28 = v26 and (v26.Position or Vector3.new(0, -5000, 0)) or Vector3.new(0, -5000, 0)
				local v29 = v28 - v27
				local v30 = v29:Dot(v29)
				local v31 = math.sqrt(v30)
				local v32 = (v27 - u10.Position) * Vector3.new(1, 0, 1)
				local v33 = v32:Dot(v32)
				if v27.Y < u10.Y - 50 then
					u13:PivotTo(u10)
				end
				local v34 = u12.CFrame:PointToObjectSpace(v28)
				local v35 = v34.X
				local v36
				if math.abs(v35) <= u12.Size.X / 2 then
					local v37 = v34.Z
					v36 = math.abs(v37) <= u12.Size.Z / 2
				else
					v36 = false
				end
				local v38 = v36 and v30 < u6.DETECTION_RANGE_SQ and "Chasing" or (u6.STOP_DISTANCE * u6.STOP_DISTANCE < v33 and "Returning" or "Idle")
				if v38 ~= u21 then
					if v38 == "Chasing" or v38 == "Returning" then
						u14.Anchored = false
						u15.WalkSpeed = v38 == "Chasing" and u6.CHASE_SPEED or u6.RETURN_SPEED
						if not u18.IsPlaying then
							u18:Play()
						end
						u19:Play()
						u20:Stop()
					elseif v38 == "Idle" then
						u14.Anchored = true
						u15:Move(Vector3.new(0, 0, 0))
						u14.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						if u18.IsPlaying then
							u18:Stop()
						end
						u19:Stop(0.1)
						u20:Play()
						u13:PivotTo(u10)
					end
					u21 = v38
				end
				if u21 == "Chasing" and v26 then
					if u6.PHYSICS_WALL < v31 then
						u14.Anchored = true
						local v39 = (v28 - v27).Unit
						u13:PivotTo(CFrame.lookAt(v27 + v39 * u6.CHASE_SPEED * u6.UPDATE_RATE, v28))
					else
						u14.Anchored = false
						u15:MoveTo(v26.Position)
					end
				elseif u21 == "Returning" then
					if u6.PHYSICS_WALL < v31 then
						u14.Anchored = true
						local v40 = (u10.Position - v27).Unit
						u13:PivotTo(CFrame.lookAt(v27 + v40 * u6.RETURN_SPEED * u6.UPDATE_RATE, u10.Position))
					else
						u14.Anchored = false
						u15:MoveTo(u10.Position)
					end
				end
				task.wait(u6.UPDATE_RATE)
			end
			u24:Disconnect()
			u11[u12] = nil
			u13:Destroy()
		end)
	end
end
local function v43(p42) -- name: onZoneDetected
	-- upvalues: (copy) u41
	u41(p42, p42)
end
v2:GetInstanceAddedSignal("NPC10_AttackZone"):Connect(v43)
for _, v44 in ipairs(v2:GetTagged("NPC10_AttackZone")) do
	task.spawn(v43, v44)
end