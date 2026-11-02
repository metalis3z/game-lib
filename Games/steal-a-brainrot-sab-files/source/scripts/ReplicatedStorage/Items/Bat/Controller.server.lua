--!strict

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
local CollectionService = game:GetService("CollectionService")
local Net = require(ReplicatedStorage.Packages.Net)

local pinataEventModule = nil
local function getPinataModule()
	if not pinataEventModule then
		local success, module = pcall(function()
			return require(ServerScriptService.Services.EventService.Events.PinataEvent)
		end)
		if success then
			pinataEventModule = module
		end
	end
	return pinataEventModule
end


local ItemData = Items[Tool.Name]
local CanHit = true
local AlreadyHit = false

if not (Humanoid and Animator) then
	return
end

local HitAnim = Animator:LoadAnimation(Tool.HitAnim)
local Slash = script.Parent.Slash
local Hit = script.Parent.Hit

Tool.Activated:Connect(function()
	if not CanHit then return end
	AlreadyHit = false
	CanHit = false

	Slash:Play()
	HitAnim:Play()

	task.wait(0.7)
	CanHit = true
end)

Handle.Touched:Connect(function(Other)
	if not HitAnim.IsPlaying then return end

	if CollectionService:HasTag(Other, "Pinata") then
		if AlreadyHit then return end
		AlreadyHit = true
		local module = getPinataModule()
		if module then
			module:HandleHit(Player, Handle)
		end
		return
	end

	local TargetPlayer = Players:GetPlayerFromCharacter(Other.Parent)
	if not TargetPlayer or TargetPlayer == Player or TargetPlayer:GetAttribute("Ragdolled") or AlreadyHit then
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
	
	Ragdoll.Ragdoll(TargetCharacter)
	task.wait(3)
	Ragdoll.Unragdoll(TargetCharacter)

	TargetPlayer:SetAttribute("Ragdolled", nil)
	TargetHumanoid.PlatformStand = false
end)