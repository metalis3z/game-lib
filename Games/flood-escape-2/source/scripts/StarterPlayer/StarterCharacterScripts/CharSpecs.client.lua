local function WaitForChild(Object : Instance, ItemName : string)
	local obj
	repeat task.wait() until Object:FindFirstChild(ItemName) ~= nil
	obj = Object:FindFirstChild(ItemName)
	return obj
end
local userInputService = game:GetService("UserInputService")
local Character = game.Players.LocalPlayer.Character :: Model
local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid
local RootPart = WaitForChild(Character, "HumanoidRootPart") :: BasePart
local character = game.Players.LocalPlayer.Character :: Model
local humanoid = Character:WaitForChild("Humanoid") :: Humanoid
local rootpart = WaitForChild(Character, "HumanoidRootPart") :: BasePart
local RootAttachment = WaitForChild(RootPart,"RootAttachment")
local Animations = game.ReplicatedStorage:WaitForChild("Animations")
local WallGripDuration = 1
local JumpCooldown = 0.1
local GrabCooldown = 0.1
local AnimateScript = script.Parent:WaitForChild("Animate")
local WallJumpAnim = Instance.new("Animation")
WallJumpAnim.AnimationId = "rbxassetid://" .. tostring(Animations.AnimIDs.WallHang.Value)
local WallJumpAnimTrack = Humanoid:FindFirstChild("Animator"):LoadAnimation(WallJumpAnim)
WallJumpAnimTrack.Priority = Enum.AnimationPriority.Action
local CurrentConstraint = nil
local CurrentAttachment = nil
local OldWalkspeed = 0
local lastJump = tick()
local riding = false
local canJump = false
local jumpedOff = false
local JumpFix = false
local Superfix = false
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Player_Character = script.Parent
local rem = game.ReplicatedStorage.Remote
local Shadow = nil
local ignoreList = {
	script.Parent
}

local function CreateShadow()
	local New_Shadow = Instance.new("Part")
	New_Shadow.Size = Vector3.new(1, 1, 0.05)
	New_Shadow.Transparency = 1
	New_Shadow.CanCollide = false
	New_Shadow.Anchored = true
	New_Shadow.Material = Enum.Material.Concrete
	New_Shadow.Name = "ShadowPt"
	local DropShadowUI = script.DropShadowUI:Clone()
	DropShadowUI.Parent = New_Shadow
	return New_Shadow
end

task.spawn(function()
	Shadow = workspace.CurrentCamera:FindFirstChild("ShadowPt")
	if not Shadow then
		Shadow = CreateShadow()
		Shadow.Parent = workspace.CurrentCamera
	end
	Humanoid.Died:Connect(function()
		if Shadow then
			Shadow:Destroy()
		end
	end)
	table.insert(ignoreList, Shadow)
	while game:GetService("RunService").Heartbeat:wait() do
		local ray = Ray.new(Humanoid.RootPart.Position, Vector3.new(0, -300, 0))
		local ignore = {
			Shadow,
			script.Parent
		}
		local part, pos, normal = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
		if pos then
			Shadow.CFrame = CFrame.new(pos, pos + normal)
		end
	end
end)

workspace.ChildAdded:connect(function(item)
	if game.Players:FindFirstChild(item.Name) then
		table.insert(ignoreList, item)
	end
end)

for _, c in pairs(game.Players:GetPlayers()) do
	if c.Character then
		table.insert(ignoreList, c.Character)
	end
end

local function getModelMass(model: Model): number
	local mass = 0
	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA('BasePart') then
			mass += v:GetMass()
		end
	end
	return mass
end

local humRtPt = Humanoid.RootPart
humRtPt.Touched:Connect(function()
	local notSwimming = game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.isSwimming:Invoke()
	local HumanoidState = Humanoid:GetState()
	if not notSwimming and (HumanoidState == Enum.HumanoidStateType.Freefall or HumanoidState == Enum.HumanoidStateType.Jumping) then
		local ray = Ray.new(humRtPt.Position, (humRtPt.Position + humRtPt.CFrame.lookVector - humRtPt.Position).unit * 2.5)
		local part : BasePart?, pos, normal = workspace:FindPartOnRay(ray, script.Parent)
		if part and part:FindFirstChild("_Wall") and tick() > lastJump + 0.15 then
			game.Players.LocalPlayer.PlayerScripts.SFX_Folder.Wall_Latch:Play()
			humRtPt.CFrame = CFrame.new(humRtPt.Position, humRtPt.Position + normal) -- [disable for old walljump]
			local Weld = Instance.new("ManualWeld") -- [disable for old walljump]
			Weld.Part0 = part -- [disable for old walljump]
			Weld.Part1 = humRtPt -- [disable for old walljump]
			Weld.C0 = part.CFrame:ToObjectSpace(humRtPt.CFrame) -- [disable for old walljump]
			Weld.Parent = humRtPt -- [disable for old walljump]
			WallJumpAnimTrack:Play()
			local latchTick = tick()
			local jumped = nil
			spawn(function()
				game:GetService("UserInputService").JumpRequest:wait()
				jumped = true
			end)
			while not jumped do
				wait()
				--humRtPt.Anchored = true -- [enable for old walljump]
				Weld.C0 = part.CFrame:ToObjectSpace(humRtPt.CFrame) -- [disable for old walljump]
			end
			WallJumpAnimTrack:Stop()
			--humRtPt.Anchored = false -- [enable for old walljump]
			Weld:Destroy() -- [disable for old walljump]
			if jumped then
				humRtPt.Velocity = Vector3.new(normal.X * 52, 50 + normal.Y * 52, normal.Z * 52)
				game.Players.LocalPlayer.PlayerScripts.SFX_Folder.Wall_Jump:Play()
			else
				humRtPt.Velocity = Vector3.new()
			end
			lastJump = tick()
		end
	end
end)
local UIS = game:GetService('UserInputService')
local CAS = game:GetService("ContextActionService")
local CurrentCamera = workspace.CurrentCamera
local canslide = true
local isJumping = false
local v12
local tickFunction = tick()
local u2 = false

Character.ChildAdded:connect(function(a1)
	if a1:IsA("Accessory") then
		a1:WaitForChild("Handle")
		a1.Handle.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
	end
end)

Character:WaitForChild("Humanoid").Jumping:Connect(function(s)
	if s then
		--print(s)
		for _, buddy in next, workspace.Buddies:GetChildren() do
			buddy.Follow.Jump:FireServer()
		end
	end
end)
local function TrussJump()
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	tickFunction = tick()
	humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, 0, humRtPt.Velocity.Z)
	if Humanoid:GetStateEnabled(Enum.HumanoidStateType.Climbing) == false then
		delay(0.2, function()
			if tick() - tickFunction >= 0.2 then
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			end
		end)
	end
	humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, 55, humRtPt.Velocity.Z)
end
function TrussJump_2()
	if tick() < tickFunction + 0.1 then
		humRtPt.CFrame = humRtPt.CFrame * CFrame.new(0, 0, 0.1)
		humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, Humanoid.JumpPower * 1.1, humRtPt.Velocity.Z)
	end
end

game:GetService("RunService").PostSimulation:connect(function()
	if Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
		if Humanoid:GetStateEnabled(Enum.HumanoidStateType.Climbing) == true then
			TrussJump()
			TrussJump_2()
			humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, math.clamp(humRtPt.Velocity.Y, -100000, 55), humRtPt.Velocity.Z)
		end
	end
end)

Character:WaitForChild("Humanoid").Jumping:Connect(function(p3)
	if p3 then
		if Humanoid:GetStateEnabled(Enum.HumanoidStateType.Climbing) == true then
			TrussJump()
			TrussJump_2()
			humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, math.clamp(humRtPt.Velocity.Y, -100000, 55), humRtPt.Velocity.Z)
		end
	end
end)

Humanoid.Climbing:Connect(function()
	tickFunction = tick()
end)

Humanoid.FallingDown:Connect(function(active)
	RootPart.Velocity = Vector3.new()
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)

local f = false
local isSliding = false
local r2 = nil
local u1 = true;
local slideDiving = false
local keyState = {}
local UserInputService = game:GetService("UserInputService")

-- Function to handle when a key is pressed
local function onKeyPress(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		keyState[input.KeyCode] = true
	end
end

-- Function to handle when a key is released
local function onKeyRelease(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		keyState[input.KeyCode] = false
	end
end
local function isKeyDown(keyCode)
	return keyState[keyCode] or false
end
UserInputService.InputBegan:Connect(onKeyPress)
UserInputService.InputEnded:Connect(onKeyRelease)

--game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.Slide.Event:Connect(slideFunc)