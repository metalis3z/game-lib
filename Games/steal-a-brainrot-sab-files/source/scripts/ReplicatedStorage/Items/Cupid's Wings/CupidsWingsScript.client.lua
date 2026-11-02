
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local Tool = script.Parent
local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("CupidsWings")

local Player = nil
if Tool.Parent:IsA("Model") then
	Player = Players:GetPlayerFromCharacter(Tool.Parent)
else
	Player = Tool.Parent.Parent
end

assert(Player and Player:IsA("Player"), "Could not find Player for Cupids Wings")

if Player == Players.LocalPlayer then
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local RootPart = assert(Character:WaitForChild("HumanoidRootPart", 5))
	local Humanoid = assert(Character:WaitForChild("Humanoid", 5))

	Tool:WaitForChild("Handle")

	local ToolsFrames = Player.PlayerGui:WaitForChild("ToolsFrames")
	local InvisibilityButton = ToolsFrames:WaitForChild("CupidsWingsInvisibility")

	local FlightSpeed = {
		X = 70,
		Z = 105
	}

	local Controls = {
		Forward = { Mode = false, Keys = { Key = "w", ByteKey = 17 } },
		Backward = { Mode = false, Keys = { Key = "s", ByteKey = 18 } },
		Left = { Mode = false, Keys = { Key = "a", ByteKey = 20 } },
		Right = { Mode = false, Keys = { Key = "d", ByteKey = 19 } }
	}

	local IsFlying = false
	local ToolEquipped = false
	local JumpConnection = nil
	local FlightMonitor = nil

	local function HandleFlight()
		if Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and RootPart and RootPart.Parent and Player and Player.Parent then

			if FlightMonitor then FlightMonitor:Disconnect() end

			FlightMonitor = RootPart.ChildAdded:Connect(function(child)
				if not IsFlying and child.Name == "FlightHold" then
					local flightSpin = RootPart:FindFirstChild("FlightSpin")
					local flightPower = RootPart:FindFirstChild("FlightPower")
					local flightHold = RootPart:FindFirstChild("FlightHold")

					if not (flightSpin and flightPower and flightHold) then return end

					IsFlying = true
					InvisibilityButton.Visible = true

					local wingFlyTrack = nil

					task.delay(0.1, function()
						local wings = Character:FindFirstChild("WingsRigClone")
						if wings then
							local animController = wings:FindFirstChild("AnimationController")
							local animator = animController and animController:FindFirstChild("Animator")
							local flyAsset = ToolAssets:FindFirstChild("FlyAnim")

							if animator and flyAsset then
								wingFlyTrack = animator:LoadAnimation(flyAsset)
								wingFlyTrack.Priority = Enum.AnimationPriority.Action
								wingFlyTrack.Looped = true
								wingFlyTrack:Play(0.2)
								wingFlyTrack:AdjustSpeed(0.8)

								task.spawn(function()
									while IsFlying and wings.Parent do task.wait(0.2) end
									if wingFlyTrack and wingFlyTrack.IsPlaying then
										wingFlyTrack:Stop(0.2)
									end
								end)
							end
						end
					end)

					Humanoid.WalkSpeed = 0
					Humanoid.PlatformStand = true
					Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
					Humanoid.AutoRotate = false

					if JumpConnection then JumpConnection:Disconnect() end

					JumpConnection = Humanoid.Changed:Connect(function(property)
						if property == "Jump" then
							Humanoid.Jump = false
						end
					end)

					RootPart.Velocity = Vector3.zero
					RootPart.RotVelocity = Vector3.zero

					local Camera = workspace.CurrentCamera
					assert(Camera)

					while IsFlying and flightSpin.Parent and flightPower.Parent and flightHold.Parent and Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and RootPart and RootPart.Parent and Player and Player.Parent do
						local newPush = Vector3.zero
						local camCFrame = Camera.CFrame
						local forwardVector = camCFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
						local sideVector = camCFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))

						local localControlVector = CFrame.new(Vector3.zero, camCFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(Humanoid.MoveDirection)

						newPush = newPush + (forwardVector * FlightSpeed.Z * -localControlVector.Z)
						newPush = newPush + (sideVector * FlightSpeed.X * -localControlVector.X)

						flightSpin.CFrame = CFrame.new(Vector3.zero, forwardVector)

						if newPush.Magnitude < 1 then
							flightHold.MaxForce = Vector3.new(flightHold.P, flightHold.P, flightHold.P)
							flightPower.MaxForce = Vector3.zero
							flightHold.Position = RootPart.Position
						else
							flightHold.MaxForce = Vector3.zero
							flightPower.MaxForce = Vector3.new(flightPower.P * 100, flightPower.P * 100, flightPower.P * 100)
						end

						if wingFlyTrack then
							local targetSpeed = (newPush.Magnitude < 1) and 0.5 or 1.25
							wingFlyTrack:AdjustSpeed(wingFlyTrack.Speed + (targetSpeed - wingFlyTrack.Speed) * 0.15)
						end

						flightPower.Velocity = newPush
						task.wait(1/60)
					end

					IsFlying = false
					InvisibilityButton.Visible = false

					if Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and RootPart and RootPart.Parent and Player and Player.Parent then
						RootPart.Velocity = Vector3.zero
						RootPart.RotVelocity = Vector3.zero
						Humanoid.WalkSpeed = 35
						Humanoid.PlatformStand = false
						Humanoid.AutoRotate = true

						if JumpConnection then JumpConnection:Disconnect() end

						Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
					end
				end
			end)
		end
	end

	local function UpdateKey(key, isDown)
		local lowerKey = string.lower(key)
		local byteKey = string.byte(lowerKey)

		for _, control in pairs(Controls) do
			if lowerKey == control.Keys.Key or byteKey == control.Keys.ByteKey then
				control.Mode = isDown
			end
		end
	end

	local function OnEquipped(mouse)
		if Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and RootPart and RootPart.Parent and Player and Player.Parent then
			ToolEquipped = true

			for _, part in ipairs(Tool:GetDescendants()) do
				if part:IsA("BasePart") then
					local lowerName = string.lower(part.Name)
					if lowerName:find("aura") or lowerName:find("hearts") then
						part.Transparency = 1
					end
				end
			end

			mouse.KeyDown:Connect(function(key) UpdateKey(key, true) end)
			mouse.KeyUp:Connect(function(key) UpdateKey(key, false) end)

			task.spawn(HandleFlight)
		end
	end

	local function OnUnequipped()
		if ToolEquipped then
			IsFlying = false
			InvisibilityButton.Visible = false

			if JumpConnection then JumpConnection:Disconnect() end
			if FlightMonitor then FlightMonitor:Disconnect() end

			for _, control in pairs(Controls) do
				control.Mode = false
			end

			ToolEquipped = false
		end
	end

	Tool.Equipped:Connect(OnEquipped)
	Tool.Unequipped:Connect(OnUnequipped)

	InvisibilityButton.Activate.MouseButton1Up:Connect(function()
		Net:RemoteEvent("Tools/CupidsWings/Invisibility"):FireServer()
	end)

	local function UpdateCooldown()
		local cooldownVal = tonumber(Tool:GetAttribute("CooldownTime")) or 0

		if cooldownVal > 0 then
			InvisibilityButton.Activate.ImageColor3 = Color3.fromRGB(128, 128, 128)
			InvisibilityButton.Activate.Icon.ImageColor3 = Color3.fromRGB(128, 128, 128)
			InvisibilityButton.Activate.Txt.TextColor3 = Color3.fromRGB(128, 128, 128)
			InvisibilityButton.Activate.Cooldown.Text = string.format("%0.1f", cooldownVal)
			InvisibilityButton.Activate.Cooldown.Visible = true
		else
			InvisibilityButton.Activate.ImageColor3 = Color3.fromRGB(255, 255, 255)
			InvisibilityButton.Activate.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
			InvisibilityButton.Activate.Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
			InvisibilityButton.Activate.Cooldown.Visible = false
		end
	end

	Tool:GetAttributeChangedSignal("CooldownTime"):Connect(UpdateCooldown)
	UpdateCooldown()
end