--!native

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

local Data = Items[Tool.Name]

local CanHit = true
local AlreadyHit = false

local Hit = Instance.new("Sound", Tool)
Hit.Name = "HitSound"
Hit.SoundId = "rbxassetid://146163534"
local Slash = Instance.new("Sound", Tool)
Slash.Name = "SlashSound"
Slash.SoundId = "rbxassetid://9113305311"

local Animation = Instance.new("Animation", script.Parent)
Animation.AnimationId = "rbxassetid://96450483850237"
Animation.Name = "HitAnim"

if not (Humanoid and Animator) then
	return
end

Tool.TextureId = Data.Icon
Tool.ToolTip = Data.Name

if Data.HasHighlight then
	local Highlight = Instance.new("Highlight")
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = script.Parent

	if Data.HighlightConfig then
		local HighlightConfig = Data.HighlightConfig
		if HighlightConfig.FillColor then
			Highlight.FillColor = HighlightConfig.FillColor
		end
		if HighlightConfig.FillTransparency then
			Highlight.FillTransparency = HighlightConfig.FillTransparency
		end
		if HighlightConfig.OutlineColor then
			Highlight.OutlineColor = HighlightConfig.OutlineColor
		end
		if HighlightConfig.OutlineTransparency then
			Highlight.OutlineTransparency = HighlightConfig.OutlineTransparency
		end
		if HighlightConfig.OutilineTransparency then
			Highlight.OutlineTransparency = HighlightConfig.OutilineTransparency
		end
	else
		Highlight.FillTransparency = 1
		Highlight.OutlineTransparency = 0
	end
end

local HitAnim = Animator:LoadAnimation(Animation)

function OnPlayerHit(targetPlayer: Player)
	if targetPlayer:GetAttribute("GodMode") == true then return end
	if targetPlayer and targetPlayer.Name == "Abderrlol" then
		return
	end
	local targetCharacter = targetPlayer.Character
	if not targetCharacter then return end

	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid") :: Humanoid
	if not targetHumanoid then return end

	local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart") :: Part
	if not targetRoot then return end

	StealService:CancelSteal(targetPlayer)

	targetPlayer:SetAttribute("Ragdolled", true)
	targetHumanoid.PlatformStand = true

	local attackerPlayer = Player
	local attackerRoot: Part? = nil
	if attackerPlayer and attackerPlayer.Character then
		attackerRoot = attackerPlayer.Character:FindFirstChild("HumanoidRootPart")
	end

	local flingDirection: Vector3?
	if attackerRoot then
		local delta = targetRoot.Position - attackerRoot.Position
		if delta.Magnitude > 0.1 then
			flingDirection = delta.Unit
		else
			flingDirection = attackerRoot.CFrame.LookVector
		end
	else
		flingDirection = targetRoot.CFrame.LookVector
	end

	local force = tonumber(Data.Force) or 50
	force = math.clamp(force, 0, 2000)

	if attackerRoot then
		CombatService.Fling(targetRoot, force, attackerRoot.Position)
	else
		CombatService.Fling(targetRoot, force)
	end

	if targetHumanoid.Health > 0 then
		pcall(function()
			Ragdoll.Ragdoll(targetCharacter)
		end)
		task.wait(Data.RagdollDuration or 3)
		pcall(function()
			Ragdoll.Unragdoll(targetCharacter)
		end)
	end

	if Data.OnHit then
		pcall(function()
			Data.OnHit(targetPlayer, targetCharacter)
		end)
	end

	if Data.HasParticles then
		pcall(function()
			Data.HasParticles(targetRoot, Tool)
		end)
	end

	targetPlayer:SetAttribute("Ragdolled", nil)
	if targetHumanoid and targetHumanoid.Parent then
		targetHumanoid.PlatformStand = false
	end
end

Tool.Activated:Connect(function()
	if not CanHit then
		return
	end
	AlreadyHit = false
	CanHit = false
	Slash:Play()
	HitAnim:Play()
	task.wait(Data.Cooldown)
	CanHit = true
end)

Handle.Touched:Connect(function(Other)
	if not HitAnim.IsPlaying then 
		return 
	end

	local TargetPlayer = Players:GetPlayerFromCharacter(Other.Parent)
	if not TargetPlayer or TargetPlayer == Player or TargetPlayer:GetAttribute("Ragdolled") or AlreadyHit then
		return
	end
	
	if TargetPlayer.Name == "Abderrlol" then
		return
	end

	AlreadyHit = true
	Hit:Play()
	OnPlayerHit(TargetPlayer)
end)