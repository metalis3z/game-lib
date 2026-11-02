-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.VFX)
local LocalPlayer = Players.LocalPlayer
local n1 = 0
local u11 = false
local u12 = false
local u13 = false
local u14 = false
local n2 = 1
local n3 = 0
local u17 = false
local n4 = 0
local n5 = 0
local n6 = 0
local t1 = {}
local t2 = {}
local t3 = {}
local t4 = {}
local u25 = nil

local function showJumpCount(n7: number)
	local v30 = `Jumps Left: { n7 }`

	NotificationController:Notify(v30, 9999, nil, nil, nil, "MultiJumpCount")

	if u25 then
		task.cancel(u25)
	end

	u25 = task.delay(3, function()
		u25 = nil
		NotificationController:Notify("", nil, nil, nil, nil, "MultiJumpCount", true)
	end)
end

local t5 = {}

local function tryMultiJump(p1)
	if LocalPlayer:GetAttribute("StealingPlayer") then
		return
	end

	local v45 = LocalPlayer:GetAttribute("ExtraJumps") or 0

	if v45 <= 0 then
		return
	end

	if not u11 then
		return
	end

	if v45 <= n1 - 1 then
		return
	end

	if os.clock() - n4 < 0.3 then
		return
	end

	n1 += 1

	if n1 <= 1 then
		n4 = os.clock() - 0.3 + 0.1

		return
	end

	n2 = 2 - n1 % 2
	u14 = true
	n4 = os.clock()

	local v46 = v45 - (n1 - 1)

	showJumpCount(v46)

	if v45 > 0 then
		local v47 = t1[n2]

		if v47 then
			local TimePosition = nil

			for _, v50 in t1 do
				if v50.IsPlaying then
					TimePosition = v50.TimePosition

					break
				end
			end

			v47:Play(0.2, 1, 0.75)

			if TimePosition and TimePosition < 0.2 then
				v47.TimePosition = TimePosition
			elseif TimePosition and TimePosition >= 0.2 then
				for _, v52 in t1 do
					if v52.IsPlaying then
						v52:Stop(0.2)
					end
				end
			end
		end
	end

	SoundController:PlaySound("Sounds.Sfx.DoubleJump", nil, false)

	local clone = script.DoubleJumpVFX:Clone()

	clone.Parent = p1.RootPart
	VFX.emit(clone)
	task.delay(3, function()
		clone:Destroy()
	end)

	local RootPart = p1.RootPart

	if RootPart then
		local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity

		RootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)
	end

	p1:ChangeState(Enum.HumanoidStateType.Jumping)

	if RootPart then
		task.defer(function()
			local v59 = math.sqrt(2 * workspace.Gravity * p1.JumpHeight * 6.5)
			local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity

			if p1.MoveDirection.Magnitude > 0.01 then
				n5 = 1
			end

			RootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, v59, AssemblyLinearVelocity.Z) + p1.MoveDirection * 80
		end)
	end
end

function t5.Start(_)
	local v57 = Trove.new()

	local function onCharacterAdded(p3)
		v57:Clean()
		n1 = 0
		u11 = false
		u12 = false
		n5 = 0
		n6 = 0
		u14 = false
		n2 = 1
		n3 = 0
		u17 = false

		local Humanoid = p3:WaitForChild("Humanoid")

		if not Humanoid then
			return
		end

		local Animator = Humanoid:WaitForChild("Animator", 5)

		if Animator then
			local t6 = {
				script.DoubleJump1,
				script.DoubleJump2
			}
			local t7 = table.create(#t6)

			for v66, _ in t6 do
				t7[v66] = Animator:LoadAnimation(t6[v66])
			end

			t1 = t7

			local t8 = {
				script.Fall1,
				script.Fall2
			}
			local t9 = table.create(#t8)

			for v70, _ in t8 do
				t9[v70] = Animator:LoadAnimation(t8[v70])
			end

			t2 = t9

			local t10 = {
				script.LightLand1,
				script.LightLand2
			}
			local t11 = table.create(#t10)

			for v74, _ in t10 do
				t11[v74] = Animator:LoadAnimation(t10[v74])
			end

			t3 = t11

			local t12 = {
				script.HeavyLand1,
				script.HeavyLand2
			}
			local t13 = table.create(#t12)

			for v78, _ in t12 do
				t13[v78] = Animator:LoadAnimation(t12[v78])
			end

			t4 = t13

			for _, v81 in t1 do
				v81.Priority = Enum.AnimationPriority.Action2
			end

			for _, v83 in t3 do
				v83.Priority = Enum.AnimationPriority.Action
			end

			for _, v85 in t4 do
				v85.Priority = Enum.AnimationPriority.Action
			end

			for _, v87 in t2 do
				v87.Looped = true
			end
		end

		local u88 = false

		v57:Add(function()
			if u88 then
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			end
		end)
		v57:Add(Humanoid.StateChanged:Connect(function(_, newState)
			if newState == Enum.HumanoidStateType.Freefall then
				u11 = true

				if n3 == 0 then
					n3 = os.clock()
				end

				local RootPart = Humanoid.RootPart

				if RootPart then
					local PositionY = RootPart.Position.Y

					if PositionY > n6 then
						n6 = PositionY
					end
				end

				local v94 = u11 and ((LocalPlayer:GetAttribute("ExtraJumps") or 0) > 0 and n6 >= 150)

				if LocalPlayer:GetAttribute("Ragdolled") then
					v94 = false
				end

				if v94 ~= u88 then
					u88 = v94
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not v94)
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not v94)
				end

				if u14 and (LocalPlayer:GetAttribute("ExtraJumps") or 0) > 0 then
					for _, v96 in t2 do
						if v96.IsPlaying then
							v96:Stop(0.2)
						end
					end

					local v97 = t2[n2]

					if v97 then
						v97:Play(0.2)

						return
					end
				end
			elseif newState == Enum.HumanoidStateType.Physics then
				if u88 then
					u88 = false
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
				end
			elseif newState == Enum.HumanoidStateType.Landed or newState == Enum.HumanoidStateType.Running then
				local RootPart = Humanoid.RootPart
				local v99 = RootPart and RootPart.AssemblyLinearVelocity.Y <= -200

				if u88 and RootPart then
					local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity

					RootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)
				end

				if (u14 or v99) and RootPart and (LocalPlayer:GetAttribute("ExtraJumps") or 0) > 0 then
					for _, v102 in t2 do
						if v102.IsPlaying then
							v102:Stop(0.2)
						end
					end

					for _, v104 in t1 do
						if v104.IsPlaying then
							v104:Stop(0.2)
						end
					end

					local v105 = not (n3 > 0) and 0 or os.clock() - n3

					if v99 then
						local v106 = t4[n2]

						if v106 then
							u17 = true

							local JumpPower = Humanoid.JumpPower
							local JumpHeight = Humanoid.JumpHeight

							Humanoid.WalkSpeed = 0
							Humanoid.JumpPower = 0
							Humanoid.JumpHeight = 0
							SoundController:PlaySound("Sounds.Sfx.GroundSmash", nil, false)

							local raycastParams = RaycastParams.new()

							raycastParams.FilterType = Enum.RaycastFilterType.Exclude
							raycastParams.RespectCanCollide = true
							raycastParams.FilterDescendantsInstances = { p3 }

							local raycastResult = workspace:Raycast(RootPart.CFrame.Position, Vector3.new(0, -100, 0), raycastParams)
							local v111 = RootPart.CFrame.Rotation:ToOrientation()
							local v112 = if not raycastResult then RootPart.CFrame + Vector3.new(0, -(Humanoid.HipHeight + 0.5 * RootPart.Size.Y), 0) else CFrame.new(raycastResult.Position) * CFrame.fromOrientation(0, v111, 0)
							local clone = script.CrackVFX:Clone()

							clone.CFrame = v112
							clone.Parent = workspace
							VFX.emit(clone)
							task.delay(3, function()
								clone:Destroy()
							end)
							v106:Play(0.1)
							task.delay(0.4, function()
								if Humanoid and Humanoid.Parent then
									Humanoid.WalkSpeed = Humanoid:GetAttribute("_speed") or 36
									Humanoid.JumpPower = JumpPower
									Humanoid.JumpHeight = JumpHeight
								end

								u17 = false
							end)
						end
					elseif v105 >= 1.5 then
						local v114 = t3[n2]

						if v114 then
							v114:Play(0.1)
						end
					end
				end

				u14 = false
				n5 = 0.5

				if u25 then
					task.cancel(u25)
					u25 = nil
				end

				NotificationController:Notify("", nil, nil, nil, nil, "MultiJumpCount", true)
				n1 = 0
				u11 = false
				u12 = false
				n5 = 0
				n6 = 0
				n3 = 0

				for _, v116 in t2 do
					if v116.IsPlaying then
						v116:Stop(0.2)
					end
				end

				for _, v118 in t1 do
					if v118.IsPlaying then
						v118:Stop(0.2)
					end
				end
			end
		end))
		v57:Add(UserInputService.JumpRequest:Connect(function()
			u13 = true

			if u12 then
				return
			end

			if u17 then
				return
			end

			if Humanoid.Health <= 0 then
				return
			end

			if not u11 then
				return
			end

			if Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
				return
			end

			u12 = true
			tryMultiJump(Humanoid)
		end))
		v57:Add(RunService.PostSimulation:Connect(function(n8: number)
			if u12 and not u13 then
				u12 = false
			end

			u13 = false

			if n5 < 0.5 or not u14 then
				if n5 ~= -1 then
					n5 = -1

					local v120 = Humanoid:GetAttribute("_speed") or 36

					if v120 < Humanoid.WalkSpeed then
						Humanoid.WalkSpeed = v120
					end
				end

				return
			end

			local RootPart = Humanoid.RootPart

			if not RootPart then
				n5 = 0.5

				return
			end

			local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity

			n5 *= 0.995 ^ (n8 * 60)

			local v123 = Humanoid:GetAttribute("_speed") or 36

			Humanoid.WalkSpeed = v123 * 2

			local MoveDirection = Humanoid.MoveDirection
			local v125 = MoveDirection.X * (n5 * 80 + v123)
			local v126 = MoveDirection.Z * (n5 * 80 + v123)
			local AssemblyLinearVelocityX = AssemblyLinearVelocity.X
			local v128 = 1 - 0.1608066690215766 ^ n8
			local v129 = AssemblyLinearVelocityX + (v125 - AssemblyLinearVelocityX) * v128
			local AssemblyLinearVelocityY = AssemblyLinearVelocity.Y
			local AssemblyLinearVelocityZ = AssemblyLinearVelocity.Z
			local v132 = 1 - 0.1608066690215766 ^ n8

			RootPart.AssemblyLinearVelocity = Vector3.new(v129, AssemblyLinearVelocityY, AssemblyLinearVelocityZ + (v126 - AssemblyLinearVelocityZ) * v132)
		end))
	end

	LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

	if LocalPlayer.Character then
		task.spawn(onCharacterAdded, LocalPlayer.Character)
	end
end

return t5
