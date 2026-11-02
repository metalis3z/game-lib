local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)
local Items = require(ReplicatedStorage.Datas.Items)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local Tool = script.Parent
local Handle = Tool.Handle
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

local HitAnim = Animator:LoadAnimation(Tool.HitAnim)
local Slash = script.Parent.Slash
local Hit = script.Parent.Hit

Tool.Unequipped:Connect(function()
	if HitAnim and HitAnim.IsPlaying then
		HitAnim:Stop()
	end
	if Slash.IsPlaying then
		Slash:Stop()
	end
	if Hit.IsPlaying then
		Hit:Stop()
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

	task.wait(0.7)
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
	Hit:Play()

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

	local oldMax = TargetHumanoid.MaxHealth
	TargetHumanoid.MaxHealth = math.huge
	TargetHumanoid.Health = math.huge
	TargetHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

	Ragdoll.Ragdoll(TargetCharacter)
	task.wait(3)
	Ragdoll.Unragdoll(TargetCharacter)

	if TargetHumanoid and TargetHumanoid.Parent then
		TargetHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		TargetHumanoid.MaxHealth = oldMax
		TargetHumanoid.Health = math.max(oldMax * 0.5, 1)
	end
	TargetPlayer:SetAttribute("Ragdolled", nil)
	TargetHumanoid.PlatformStand = false
end)