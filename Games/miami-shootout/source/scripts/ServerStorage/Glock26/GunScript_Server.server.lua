local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
--local Player
--local Character
--local Humanoid
local Module = require(Tool:WaitForChild("Setting"))
local ChangeMagAndAmmo = script:WaitForChild("ChangeMagAndAmmo")
local PlayServerSound = script:WaitForChild("PlayServerSound")

local Grip2
local Handle2

if Module.DualEnabled then
	Handle2 = Tool:WaitForChild("Handle2",1)
	if Handle2 == nil and Module.DualEnabled then error("\"Dual\" setting is enabled but \"Handle2\" is missing!") end
end

local MagValue = script:FindFirstChild("Mag") or Instance.new("NumberValue",script)
MagValue.Name = "Mag"
MagValue.Value = Module.AmmoPerMag
local AmmoValue = script:FindFirstChild("Ammo") or Instance.new("NumberValue",script)
AmmoValue.Name = "Ammo"
AmmoValue.Value = Module.LimitedAmmoEnabled and Module.Ammo or 0

if Module.IdleAnimationID ~= nil or Module.DualEnabled then
	local IdleAnim = Instance.new("Animation",Tool)
	IdleAnim.Name = "IdleAnim"
	IdleAnim.AnimationId = "rbxassetid://"..(Module.DualEnabled and 53610688 or Module.IdleAnimationID)
end
if Module.FireAnimationID ~= nil then
	local FireAnim = Instance.new("Animation",Tool)
	FireAnim.Name = "FireAnim"
	FireAnim.AnimationId = "rbxassetid://"..Module.FireAnimationID
end
if Module.ReloadAnimationID ~= nil then
	local ReloadAnim = Instance.new("Animation",Tool)
	ReloadAnim.Name = "ReloadAnim"
	ReloadAnim.AnimationId = "rbxassetid://"..Module.ReloadAnimationID
end
if Module.ShotgunClipinAnimationID ~= nil then
	local ShotgunClipinAnim = Instance.new("Animation",Tool)
	ShotgunClipinAnim.Name = "ShotgunClipinAnim"
	ShotgunClipinAnim.AnimationId = "rbxassetid://"..Module.ShotgunClipinAnimationID
end
if Module.HoldDownAnimationID ~= nil then
	local HoldDownAnim = Instance.new("Animation",Tool)
	HoldDownAnim.Name = "HoldDownAnim"
	HoldDownAnim.AnimationId = "rbxassetid://"..Module.HoldDownAnimationID
end
if Module.EquippedAnimationID ~= nil then
	local EquippedAnimation = Instance.new("Animation",Tool)
	EquippedAnimation.Name = "EquippedAnimation"
	EquippedAnimation.AnimationId = "rbxassetid://"..Module.EquippedAnimationID
end

local slideEnabled = true

if slideEnabled then
	local SlideAnim = Instance.new("Animation",Tool)
	SlideAnim.Name = "SlideAnim"
	SlideAnim.AnimationId = "rbxassetid://11814248451"
end

ChangeMagAndAmmo.OnServerEvent:connect(function(Player,Mag,Ammo)
	MagValue.Value = Mag
	AmmoValue.Value = Ammo
end)

local debounce = false
PlayServerSound.OnServerEvent:Connect(function(Player,Sound)
	if debounce then return end
	if Sound then
		Sound:Play()
		debounce = true
		delay(0.1,function() debounce = false end)
	end
end)

Tool.Equipped:connect(function()
	--Player = game.Players:GetPlayerFromCharacter(Tool.Parent)
	--Character = Tool.Parent
	--Humanoid = Character:FindFirstChild("Humanoid")
	if Module.DualEnabled and workspace.FilteringEnabled then
		Handle2.CanCollide = false
		local LeftArm = Tool.Parent:FindFirstChild("Left Arm") or Tool.Parent:FindFirstChild("LeftHand")
		local RightArm = Tool.Parent:FindFirstChild("Right Arm") or Tool.Parent:FindFirstChild("RightHand")
		if RightArm then
			local Grip = RightArm:WaitForChild("RightGrip",0.01)
			if Grip then
				Grip2 = Grip:Clone()
				Grip2.Name = "LeftGrip"
				Grip2.Part0 = LeftArm
				Grip2.Part1 = Handle2
				--Grip2.C1 = Grip2.C1:inverse()
				Grip2.Parent = LeftArm
			end
		end
	end
end)

Tool.Unequipped:connect(function()
	if Module.DualEnabled and workspace.FilteringEnabled then
		Handle2.CanCollide = true
		if Grip2 then Grip2:Destroy() end
	end
end)