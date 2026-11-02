--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Notify = ReplicatedStorage:WaitForChild("Notify")

local function ComputePhase(p1) --[[ ComputePhase | Line: 27 ]]
	if p1 <= 0 then
		return 0
	end

	if not (p1 <= 13) then
		return (p1 - 13) / 0.25 + 9.611640903764576
	end

	local v1 = 4 - p1 * 3.75 / 13

	if v1 <= 0.001 then
		v1 = 0.001
	end

	return math.log(4 / v1) * 3.466666666666667
end

return function(p1) --[[ Line: 44 | Upvalues: LocalPlayer (copy), Notify (copy), Networking (copy), Players (copy) ]]
	local Data = p1.Build.Data
	local TargetTilt = Data.TargetTilt
	local UP = Data:FindFirstChild("UP")
	local Tilt = p1.Build.Tilt
	local ATT1 = Tilt.Center.ATT1
	local v1 = false

	for v2, v3 in Tilt:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.Anchored = false
		end
	end

	local v4 = p1:GetAttribute("UserId")
	local v5 = p1:GetAttribute("PropId")
	local t = { Tilt.OBJ1, Tilt.OBJ2 }

	for v6, v7 in t do
		if v7:IsA("BasePart") then
			v7.CanCollide = false
		end
	end

	local t2 = { nil, nil }
	local t3 = { nil, nil }
	local v8 = false
	local v9 = nil
	local v10 = nil
	local v11 = nil

	local function CancelSoloNotify() --[[ CancelSoloNotify | Line: 75 | Upvalues: v11 (ref) ]]
		if not v11 then
			return
		end

		task.cancel(v11)
		v11 = nil
	end

	local function ScheduleSoloNotify() --[[ ScheduleSoloNotify | Line: 82 | Upvalues: v11 (ref), t3 (copy), LocalPlayer (ref), Notify (ref) ]]
		if not v11 then
			v11 = task.delay(2, function() --[[ Line: 84 | Upvalues: v11 (ref), t3 (ref), LocalPlayer (ref), Notify (ref) ]]
				v11 = nil

				local v1 = false

				if t3[1] == LocalPlayer.UserId or t3[2] == LocalPlayer.UserId then
					v1 = true
				end

				if not v1 then
					return
				end

				local v2 = false

				if t3[1] and t3[1] ~= LocalPlayer.UserId or t3[2] and t3[2] ~= LocalPlayer.UserId then
					v2 = true
				end

				if v2 then
					return
				end

				Notify:Fire("Ask a friend to join you!")
			end)

			return
		end

		task.cancel(v11)
		v11 = nil
		v11 = task.delay(2, function() --[[ Line: 84 | Upvalues: v11 (ref), t3 (ref), LocalPlayer (ref), Notify (ref) ]]
			v11 = nil

			local v1 = false

			if t3[1] == LocalPlayer.UserId or t3[2] == LocalPlayer.UserId then
				v1 = true
			end

			if not v1 then
				return
			end

			local v2 = false

			if t3[1] and t3[1] ~= LocalPlayer.UserId or t3[2] and t3[2] ~= LocalPlayer.UserId then
				v2 = true
			end

			if v2 then
				return
			end

			Notify:Fire("Ask a friend to join you!")
		end)
	end

	local v12 = 0
	local v13 = 0
	local v14 = 0

	local function UpdateTilt(p1) --[[ UpdateTilt | Line: 111 | Upvalues: ATT1 (copy) ]]
		ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(p1)))
	end

	local function SampleTiltVelocity(p1) --[[ SampleTiltVelocity | Line: 115 | Upvalues: v13 (ref), v14 (ref), v12 (ref) ]]
		local v1 = os.clock()

		if v13 > 0 then
			local v2 = v1 - v13

			if v2 > 0.0001 then
				v14 = (p1 - v12) / v2
			end
		end

		v12 = p1
		v13 = v1
	end

	local function ResetTiltVelocitySample() --[[ ResetTiltVelocitySample | Line: 127 | Upvalues: v13 (ref), v14 (ref), v12 (ref), TargetTilt (copy) ]]
		v13 = 0
		v14 = 0
		v12 = TargetTilt.Value
	end

	local function ApplyLocalExitFling(p12) --[[ ApplyLocalExitFling | Line: 133 | Upvalues: LocalPlayer (ref), v14 (ref), p1 (copy) ]]
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local v1 = Character:FindFirstChildWhichIsA("Humanoid")

		if not (HumanoidRootPart and v1) then
			return
		end

		local v4 = math.clamp(math.abs(v14) / 376.99111843077515, 0, 1)
		local v5 = math.lerp(1.5, 22.5, v4)
		local LookVector = HumanoidRootPart.CFrame.LookVector
		local v6 = Vector3.new(LookVector.X, 0, LookVector.Z)
		local v7 = if v6.Magnitude > 0.01 then v6.Unit else Vector3.new(0, 0, 1)
		local v8 = v7 * 7.5 * v5 + Vector3.new(0, v5 * 24, 0)

		v1.PlatformStand = true
		HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 2.5, 0)
		HumanoidRootPart.AssemblyLinearVelocity = v8

		local v9 = v7:Cross(Vector3.new(0, 1, 0))
		local v10

		if v9.Magnitude > 0.1 then
			v10 = v9.Unit * (v4 * 21 * v5)
			HumanoidRootPart.AssemblyAngularVelocity = v10
		else
			v10 = Vector3.new(0, 0, 0)
		end

		task.spawn(function() --[[ Line: 165 | Upvalues: Character (copy), p1 (ref), v10 (ref), v1 (copy), HumanoidRootPart (copy) ]]
			local v12 = RaycastParams.new()

			v12.FilterType = Enum.RaycastFilterType.Exclude
			v12.FilterDescendantsInstances = { Character, p1 }

			local v2 = v10

			while v1.Parent and (HumanoidRootPart.Parent and v1.PlatformStand) do
				if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -4, 0), v12) then
					HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

					local v3 = Vector3.new(HumanoidRootPart.CFrame.LookVector.X, 0, HumanoidRootPart.CFrame.LookVector.Z)

					if not (v3.Magnitude > 0.01) then
						break
					end

					HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + v3)

					break
				end

				v2 = v2 * 0.92
				HumanoidRootPart.AssemblyAngularVelocity = v2
				task.wait()
			end

			if not v1.Parent then
				return
			end

			v1.PlatformStand = false
		end)
	end

	local function ClearWeld(p1) --[[ ClearWeld | Line: 192 | Upvalues: t2 (copy) ]]
		if not t2[p1] then
			return
		end

		t2[p1]:Destroy()
		t2[p1] = nil
	end

	local function CreateWeld(p1, p2) --[[ CreateWeld | Line: 199 | Upvalues: t2 (copy), t (copy) ]]
		if t2[p1] then
			t2[p1]:Destroy()
			t2[p1] = nil
		end

		local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart then
			local SeatWeld = Instance.new("Weld")

			SeatWeld.Name = "SeatWeld"
			SeatWeld.Part0 = t[p1]
			SeatWeld.Part1 = HumanoidRootPart
			SeatWeld.C0 = CFrame.new(0, 2, 0)
			SeatWeld.Parent = t[p1]
			t2[p1] = SeatWeld
		end
	end

	local function StopAnimation() --[[ StopAnimation | Line: 213 | Upvalues: v8 (ref), v9 (ref), v1 (ref), ATT1 (copy), TargetTilt (copy), UP (copy), v13 (ref), v14 (ref), v12 (ref) ]]
		v8 = false

		if v9 then
			task.cancel(v9)
			v9 = nil
		end

		if not v1 then
			ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
			TargetTilt.Value = 0

			if UP then
				UP.Value = 0
			end
		end

		v13 = 0
		v14 = 0
		v12 = TargetTilt.Value
	end

	local function StartAnimation(p1) --[[ StartAnimation | Line: 227 | Upvalues: v8 (ref), v9 (ref), v1 (ref), ATT1 (copy), TargetTilt (copy), UP (copy), v13 (ref), v14 (ref), v12 (ref), v11 (ref) ]]
		v8 = false

		if v9 then
			task.cancel(v9)
			v9 = nil
		end

		if not v1 then
			ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
			TargetTilt.Value = 0

			if UP then
				UP.Value = 0
			end
		end

		v13 = 0
		v14 = 0
		v12 = TargetTilt.Value

		if v11 then
			task.cancel(v11)
			v11 = nil
		end

		v8 = true
		v9 = task.spawn(function() --[[ Line: 232 | Upvalues: v8 (ref), v1 (ref), p1 (copy), ATT1 (ref), v13 (ref), v14 (ref), v12 (ref), TargetTilt (ref), UP (ref) ]]
			while v8 and not v1 do
				local v15
				local v2 = workspace:GetServerTimeNow() - p1

				if v2 <= 0 then
					v15 = 0
				elseif v2 <= 13 then
					local v3 = 4 - v2 * 3.75 / 13

					if v3 <= 0.001 then
						v3 = 0.001
					end

					v15 = math.log(4 / v3) * 3.466666666666667
				else
					v15 = (v2 - 13) / 0.25 + 9.611640903764576
				end

				local v4 = math.sin(6.283185307179586 * v15) * 15

				ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(v4)))

				local v5 = os.clock()

				if v13 > 0 then
					local v6 = v5 - v13

					if v6 > 0.0001 then
						v14 = (v4 - v12) / v6
					end
				end

				v12 = v4
				v13 = v5
				TargetTilt.Value = v4

				if UP then
					UP.Value = v2 * 0.6
				end

				task.wait()
			end
		end)
	end

	local function ConnectLocalUnsit() --[[ ConnectLocalUnsit | Line: 246 | Upvalues: v10 (ref), LocalPlayer (ref), v11 (ref), t3 (copy), t2 (copy), ApplyLocalExitFling (copy), v8 (ref), v9 (ref), v1 (ref), ATT1 (copy), TargetTilt (copy), UP (copy), v13 (ref), v14 (ref), v12 (ref), Networking (ref), v4 (copy), v5 (copy) ]]
		if v10 then
			v10:Disconnect()
			v10 = nil
		end

		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local v15 = Character:FindFirstChildWhichIsA("Humanoid")

		if v15 then
			v10 = v15:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 257 | Upvalues: v15 (copy), v11 (ref), t3 (ref), LocalPlayer (ref), t2 (ref), ApplyLocalExitFling (ref), v8 (ref), v9 (ref), v1 (ref), ATT1 (ref), TargetTilt (ref), UP (ref), v13 (ref), v14 (ref), v12 (ref), Networking (ref), v4 (ref), v5 (ref) ]]
				if v15.Sit then
					return
				end

				if v11 then
					task.cancel(v11)
					v11 = nil
				end

				for i = 1, 2 do
					if t3[i] == LocalPlayer.UserId then
						if t2[i] then
							t2[i]:Destroy()
							t2[i] = nil
						end

						ApplyLocalExitFling(i)
						t3[i] = nil
						v8 = false

						if v9 then
							task.cancel(v9)
							v9 = nil
						end

						if v1 then
							v13 = 0
							v14 = 0
							v12 = TargetTilt.Value
							Networking.Seesaw.Unsit:Fire(v4, v5, i)

							return
						end

						ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
						TargetTilt.Value = 0

						if not UP then
							v13 = 0
							v14 = 0
							v12 = TargetTilt.Value
							Networking.Seesaw.Unsit:Fire(v4, v5, i)

							return
						end

						UP.Value = 0
						v13 = 0
						v14 = 0
						v12 = TargetTilt.Value
						Networking.Seesaw.Unsit:Fire(v4, v5, i)

						return
					end
				end
			end)
		end
	end

	local v15 = Networking.Seesaw.SeatChanged.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) --[[ Line: 273 | Upvalues: v4 (copy), v5 (copy), t3 (copy), LocalPlayer (ref), t2 (copy), v8 (ref), v9 (ref), v1 (ref), ATT1 (copy), TargetTilt (copy), UP (copy), v13 (ref), v14 (ref), v12 (ref), v11 (ref), Players (ref), CreateWeld (copy) ]]
		if p1 ~= v4 or p2 ~= v5 then
			return
		end

		if p4 == 0 then
			if t3[p3] == LocalPlayer.UserId then
				return
			end

			if t2[p3] then
				t2[p3]:Destroy()
				t2[p3] = nil
			end

			t3[p3] = nil
			v8 = false

			if v9 then
				task.cancel(v9)
				v9 = nil
			end

			if not v1 then
				ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
				TargetTilt.Value = 0

				if UP then
					UP.Value = 0
				end
			end

			v13 = 0
			v14 = 0
			v12 = TargetTilt.Value
		elseif p4 == LocalPlayer.UserId then
			if not (p5 > 0) then
				return
			end

			v8 = false

			if v9 then
				task.cancel(v9)
				v9 = nil
			end

			if not v1 then
				ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
				TargetTilt.Value = 0

				if UP then
					UP.Value = 0
				end
			end

			v13 = 0
			v14 = 0
			v12 = TargetTilt.Value

			if v11 then
				task.cancel(v11)
				v11 = nil
			end

			v8 = true
			v9 = task.spawn(function() --[[ Line: 232 | Upvalues: v8 (ref), v1 (ref), p5 (copy), ATT1 (ref), v13 (ref), v14 (ref), v12 (ref), TargetTilt (ref), UP (ref) ]]
				while v8 and not v1 do
					local v15
					local v2 = workspace:GetServerTimeNow() - p5

					if v2 <= 0 then
						v15 = 0
					elseif v2 <= 13 then
						local v3 = 4 - v2 * 3.75 / 13

						if v3 <= 0.001 then
							v3 = 0.001
						end

						v15 = math.log(4 / v3) * 3.466666666666667
					else
						v15 = (v2 - 13) / 0.25 + 9.611640903764576
					end

					local v4 = math.sin(6.283185307179586 * v15) * 15

					ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(v4)))

					local v5 = os.clock()

					if v13 > 0 then
						local v6 = v5 - v13

						if v6 > 0.0001 then
							v14 = (v4 - v12) / v6
						end
					end

					v12 = v4
					v13 = v5
					TargetTilt.Value = v4

					if UP then
						UP.Value = v2 * 0.6
					end

					task.wait()
				end
			end)
		else
			t3[p3] = p4

			local v15 = Players:GetPlayerByUserId(p4)

			if v15 and v15.Character then
				local v2 = v15.Character:FindFirstChildWhichIsA("Humanoid")

				if v2 then
					v2.Sit = true
				end

				CreateWeld(p3, v15.Character)
			end

			if not (p5 > 0) then
				return
			end

			v8 = false

			if v9 then
				task.cancel(v9)
				v9 = nil
			end

			if not v1 then
				ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
				TargetTilt.Value = 0

				if UP then
					UP.Value = 0
				end
			end

			v13 = 0
			v14 = 0
			v12 = TargetTilt.Value

			if v11 then
				task.cancel(v11)
				v11 = nil
			end

			v8 = true
			v9 = task.spawn(function() --[[ Line: 232 | Upvalues: v8 (ref), v1 (ref), p5 (copy), ATT1 (ref), v13 (ref), v14 (ref), v12 (ref), TargetTilt (ref), UP (ref) ]]
				while v8 and not v1 do
					local v15
					local v2 = workspace:GetServerTimeNow() - p5

					if v2 <= 0 then
						v15 = 0
					elseif v2 <= 13 then
						local v3 = 4 - v2 * 3.75 / 13

						if v3 <= 0.001 then
							v3 = 0.001
						end

						v15 = math.log(4 / v3) * 3.466666666666667
					else
						v15 = (v2 - 13) / 0.25 + 9.611640903764576
					end

					local v4 = math.sin(6.283185307179586 * v15) * 15

					ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(v4)))

					local v5 = os.clock()

					if v13 > 0 then
						local v6 = v5 - v13

						if v6 > 0.0001 then
							v14 = (v4 - v12) / v6
						end
					end

					v12 = v4
					v13 = v5
					TargetTilt.Value = v4

					if UP then
						UP.Value = v2 * 0.6
					end

					task.wait()
				end
			end)
		end
	end)

	for i = 1, 2 do
		t[i].Touched:Connect(function(p1) --[[ Line: 308 | Upvalues: t3 (copy), i (copy), LocalPlayer (ref), CreateWeld (copy), ConnectLocalUnsit (copy), v11 (ref), Notify (ref), Networking (ref), v4 (copy), v5 (copy) ]]
			if t3[i] then
				return
			end

			local v1 = p1:FindFirstAncestorWhichIsA("Model")

			if v1 ~= LocalPlayer.Character then
				return
			end

			local v2 = v1:FindFirstChildWhichIsA("Humanoid")

			if not v2 then
				return
			end

			if v2.Sit then
				return
			end

			v2.Sit = true
			CreateWeld(i, v1)
			t3[i] = LocalPlayer.UserId
			ConnectLocalUnsit()

			if v11 then
				task.cancel(v11)
				v11 = nil
			end

			v11 = task.delay(2, function() --[[ Line: 84 | Upvalues: v11 (ref), t3 (ref), LocalPlayer (ref), Notify (ref) ]]
				v11 = nil

				local v1 = false

				if t3[1] == LocalPlayer.UserId or t3[2] == LocalPlayer.UserId then
					v1 = true
				end

				if not v1 then
					return
				end

				local v2 = false

				if t3[1] and t3[1] ~= LocalPlayer.UserId or t3[2] and t3[2] ~= LocalPlayer.UserId then
					v2 = true
				end

				if v2 then
					return
				end

				Notify:Fire("Ask a friend to join you!")
			end)
			Networking.Seesaw.Sit:Fire(v4, v5, i)
		end)
	end

	ConnectLocalUnsit()
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 331 | Upvalues: ConnectLocalUnsit (copy) ]]
		task.wait()
		ConnectLocalUnsit()
	end)
	p1.Destroying:Connect(function() --[[ Line: 336 | Upvalues: v1 (ref), v11 (ref), t3 (copy), LocalPlayer (ref), t2 (copy), v8 (ref), v9 (ref), ATT1 (copy), TargetTilt (copy), UP (copy), v13 (ref), v14 (ref), v12 (ref), v15 (copy), v10 (ref) ]]
		v1 = true

		if v11 then
			task.cancel(v11)
			v11 = nil
		end

		for i = 1, 2 do
			if t3[i] == LocalPlayer.UserId then
				if t2[i] then
					t2[i]:Destroy()
					t2[i] = nil
				end

				t3[i] = nil

				local Character = LocalPlayer.Character

				if Character then
					local v16 = Character:FindFirstChildWhichIsA("Humanoid")

					if v16 then
						v16.Sit = false
					end
				end

				continue
			end

			if t2[i] then
				if t2[i] then
					t2[i]:Destroy()
					t2[i] = nil
				end

				t3[i] = nil
			end
		end

		v8 = false

		if v9 then
			task.cancel(v9)
			v9 = nil
		end

		if not v1 then
			ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
			TargetTilt.Value = 0

			if UP then
				UP.Value = 0
			end
		end

		v13 = 0
		v14 = 0
		v12 = TargetTilt.Value
		v15:Disconnect()

		if not v10 then
			return
		end

		v10:Disconnect()
	end)
	ATT1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
	Networking.Seesaw.RequestState:Fire(v4, v5)
end