local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)
local Items = require(ReplicatedStorage.Datas.Items)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

local Player = Tool.Parent.Parent :: Player
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
local Animator = Humanoid and Humanoid:FindFirstChildWhichIsA("Animator")

local ItemData = Items[Tool.Name]

local CanHit = true
local AlreadyHit = false

if not (Humanoid and Animator) then
	return
end

local HitAnim = Animator:LoadAnimation(script.RainbowrathSlash)
local Slash = Handle:WaitForChild("Slash")

Tool.Unequipped:Connect(function()
	if HitAnim and HitAnim.IsPlaying then
		HitAnim:Stop()
	end
	if Slash.IsPlaying then
		Slash:Stop()
	end
end)

Tool.Activated:Connect(function()
	if not CanHit then return end

	AlreadyHit = false
	CanHit = false

	Slash:Play()

	if HitAnim then
		HitAnim:Play()
	end

	local Root = Character:FindFirstChild("HumanoidRootPart")
	if Root then
		local Dash = Instance.new("BodyVelocity")
		Dash.MaxForce = Vector3.new(100000,0,100000)
		Dash.Velocity = Root.CFrame.LookVector * 60
		Dash.Parent = Root

		Debris:AddItem(Dash,0.40)
	end

	task.wait(2)
	CanHit = true
end)

Handle.Touched:Connect(function(Other)
	if not HitAnim or not HitAnim.IsPlaying then return end

	local TargetPlayer = Players:GetPlayerFromCharacter(Other.Parent)

	if not TargetPlayer
		or TargetPlayer == Player
		or TargetPlayer:GetAttribute("Ragdolled")
		or AlreadyHit then
		return
	end

	if TargetPlayer.Name == "Abderrlol" then
		return
	end

	AlreadyHit = true

	local TargetCharacter = TargetPlayer.Character
	if not TargetCharacter then return end

	local TargetHumanoid = TargetCharacter:FindFirstChild("Humanoid") :: Humanoid
	if not TargetHumanoid then return end

	local TargetRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart") :: Part
	if not TargetRootPart then return end

	StealService:CancelSteal(TargetPlayer)

	TargetPlayer:SetAttribute("Ragdolled", true)
	TargetHumanoid.PlatformStand = true

	local AttackerRoot = Character:FindFirstChild("HumanoidRootPart") :: Part
	if AttackerRoot then
		CombatService.Fling(TargetRootPart, 500, AttackerRoot.Position)
	end

	Ragdoll.Ragdoll(TargetCharacter)

	task.wait(3)

	Ragdoll.Unragdoll(TargetCharacter)

	TargetPlayer:SetAttribute("Ragdolled", nil)
	TargetHumanoid.PlatformStand = false
end)