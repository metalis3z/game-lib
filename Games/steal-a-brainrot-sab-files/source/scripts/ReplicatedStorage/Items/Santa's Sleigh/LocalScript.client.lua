local Players = game:GetService("Players")

game:GetService("RunService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local tool = script.Parent
local localPlayer = if not tool.Parent:IsA("Model") then tool.Parent.Parent else Players:GetPlayerFromCharacter(tool.Parent)

assert(localPlayer and localPlayer:IsA("Player"))

if localPlayer ~= Players.LocalPlayer then
	return
end

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = assert(character:WaitForChild("HumanoidRootPart", 5))
local humanoid = assert(character:WaitForChild("Humanoid", 5))

tool:WaitForChild("Handle")

local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("SantasSleigh")
local FlyingIcon = ToolAssets:WaitForChild("FlyingIcon")
local RegularIcon = ToolAssets:WaitForChild("RegularIcon")

local sleighGui = localPlayer.PlayerGui:WaitForChild("ToolsFrames"):WaitForChild("SantasSleighPresent")

local flightSpeed = {
	X = 66,
	Z = 99
}

local keyBindings = {
	Forward = {
		Mode = false,
		Keys = {
			Key = "w",
			ByteKey = 17
		}
	},
	Backward = {
		Mode = false,
		Keys = {
			Key = "s",
			ByteKey = 18
		}
	},
	Left = {
		Mode = false,
		Keys = {
			Key = "a",
			ByteKey = 20
		}
	},
	Right = {
		Mode = false,
		Keys = {
			Key = "d",
			ByteKey = 19
		}
	}
}

local isFlying = false
local isEquipped = false
local jumpBlockConnection = nil
local flightHoldConnection = nil

local function UpdateIcon(flying)
	local slot = tool:GetAttribute("CurrentSlot")
	if not slot then return end
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	if not playerGui then return end
	local backpackGui = playerGui:FindFirstChild("BackpackGui")
	if not backpackGui then return end
	local hotbar = backpackGui:FindFirstChild("Backpack") and backpackGui.Backpack:FindFirstChild("Hotbar")
	if not hotbar then return end
	local slotFrame = hotbar:FindFirstChild(tostring(slot))
	if not slotFrame then return end
	local icon = slotFrame:FindFirstChild("Icon")
	if not icon then return end
	icon.Image = flying and FlyingIcon.Image or RegularIcon.Image
end

local function HandleFlightControl()
	if not character or (not character.Parent or (not humanoid or (not humanoid.Parent or (not (humanoid.Health > 0) or (not rootPart or (not rootPart.Parent or (not localPlayer or not localPlayer.Parent))))))) then
		return
	end

	if flightHoldConnection then
		flightHoldConnection:Disconnect()
	end

	flightHoldConnection = rootPart.ChildAdded:Connect(function(child)
		if isFlying then
			return
		end

		if child.Name == "FlightHold" then
			local flightSpin = rootPart:FindFirstChild("FlightSpin")
			local flightPower = rootPart:FindFirstChild("FlightPower")
			local flightHold = rootPart:FindFirstChild("FlightHold")

			if not flightSpin or not flightPower or not flightHold then
				return
			end

			isFlying = true
			sleighGui.Visible = true
			humanoid.WalkSpeed = 0
			humanoid.PlatformStand = true
			humanoid.AutoRotate = false

			if jumpBlockConnection then
				jumpBlockConnection:Disconnect()
			end

			jumpBlockConnection = humanoid.Changed:Connect(function(property)
				if property == "Jump" then
					humanoid.Jump = false
				end
			end)

			rootPart.Velocity = Vector3.new(0, 0, 0)
			rootPart.RotVelocity = Vector3.new(0, 0, 0)

			local camera = assert(workspace.CurrentCamera)

			while isFlying and flightSpin.Parent and flightPower.Parent and flightHold.Parent and (character and (character.Parent and (humanoid and (humanoid.Parent and (humanoid.Health > 0 and (rootPart and (rootPart.Parent and (localPlayer and localPlayer.Parent)))))))) do
				local zeroVector = Vector3.new(0, 0, 0)
				local cameraCFrame = camera.CFrame
				local forwardDirection = cameraCFrame:VectorToWorldSpace((Vector3.new(0, 0, -1)))
				local leftDirection = cameraCFrame:VectorToWorldSpace((Vector3.new(-1, 0, 0)))
				local moveInput = CFrame.new(Vector3.new(0, 0, 0), cameraCFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(humanoid.MoveDirection)
				local forwardVelocity = zeroVector + (forwardDirection * flightSpeed.Z * -moveInput.Z or zeroVector)
				local totalVelocity = forwardVelocity + (leftDirection * flightSpeed.X * -moveInput.X or forwardVelocity)

				flightSpin.CFrame = CFrame.new(Vector3.new(0, 0, 0), forwardDirection)

				if totalVelocity.Magnitude < 1 then
					flightHold.MaxForce = Vector3.new(flightHold.P, flightHold.P, flightHold.P)
					flightPower.MaxForce = Vector3.new(0, 0, 0)
					flightHold.Position = rootPart.Position
				else
					flightHold.MaxForce = Vector3.new(0, 0, 0)
					flightPower.MaxForce = Vector3.new(flightPower.P * 100, flightPower.P * 100, flightPower.P * 100)
				end

				flightPower.Velocity = totalVelocity
				task.wait(0.016666666666666666)
			end

			isFlying = false
			sleighGui.Visible = false

			if character and (character.Parent and (humanoid and (humanoid.Parent and (humanoid.Health > 0 and (rootPart and (rootPart.Parent and (localPlayer and localPlayer.Parent))))))) then
				rootPart.Velocity = Vector3.new(0, 0, 0)
				rootPart.RotVelocity = Vector3.new(0, 0, 0)
				humanoid.WalkSpeed = 34
				humanoid.PlatformStand = false
				humanoid.AutoRotate = true

				if jumpBlockConnection then
					jumpBlockConnection:Disconnect()
				end

				humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
			end
		end
	end)
end

local function KeyPress(key: string, isPressed: boolean)
	local lowerKey = string.lower(key)
	local keyByte = string.byte(lowerKey)

	for direction, binding in pairs(keyBindings) do
		if lowerKey == binding.Keys.Key or keyByte == binding.Keys.ByteKey then
			keyBindings[direction].Mode = isPressed
		end
	end
end

tool.Equipped:Connect(function(mouse)
	if not character or (not character.Parent or (not humanoid or (not humanoid.Parent or (not (humanoid.Health > 0) or (not rootPart or (not rootPart.Parent or (not localPlayer or not localPlayer.Parent))))))) then
		return
	end

	isEquipped = true
	UpdateIcon(tool:GetAttribute("WingsFlying") == true)

	mouse.KeyDown:Connect(function(keyDown)
		KeyPress(keyDown, true)
	end)

	mouse.KeyUp:Connect(function(keyUp)
		KeyPress(keyUp, false)
	end)

	task.spawn(HandleFlightControl)
end)

tool.Unequipped:Connect(function()
	if not isEquipped then
		return
	end

	isFlying = false
	sleighGui.Visible = false
	UpdateIcon(false)

	for _, conn in pairs({ jumpBlockConnection, flightHoldConnection }) do
		if conn then
			conn:Disconnect()
		end
	end

	for direction, _ in pairs(keyBindings) do
		keyBindings[direction].Mode = false
	end

	isEquipped = false
end)

tool:GetAttributeChangedSignal("WingsFlying"):Connect(function()
	UpdateIcon(tool:GetAttribute("WingsFlying") == true)
end)

tool:GetAttributeChangedSignal("CurrentSlot"):Connect(function()
	UpdateIcon(tool:GetAttribute("WingsFlying") == true)
end)

sleighGui.Activate.MouseButton1Up:Connect(function()
	Net:RemoteEvent("Tools/SantasSleigh/DropPresent"):FireServer()
end)

local function UpdateCooldown()
	local cooldownTime = tonumber(tool:GetAttribute("CooldownTime") or 0) or 0

	if cooldownTime > 0 then
		sleighGui.Activate.ImageColor3 = Color3.fromRGB(128, 128, 128)
		sleighGui.Activate.Icon.ImageColor3 = Color3.fromRGB(128, 128, 128)
		sleighGui.Activate.Txt.TextColor3 = Color3.fromRGB(128, 128, 128)
		sleighGui.Activate.Cooldown.Text = string.format("%0.1f", cooldownTime)
		sleighGui.Activate.Cooldown.Visible = true
		return
	end

	sleighGui.Activate.ImageColor3 = Color3.fromRGB(255, 255, 255)
	sleighGui.Activate.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	sleighGui.Activate.Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
	sleighGui.Activate.Cooldown.Visible = false
end

tool:GetAttributeChangedSignal("CooldownTime"):Connect(UpdateCooldown)
UpdateCooldown()