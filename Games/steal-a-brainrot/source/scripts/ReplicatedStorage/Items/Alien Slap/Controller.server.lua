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
		if HighlightConfig.FillColor then Highlight.FillColor = HighlightConfig.FillColor end
		if HighlightConfig.FillTransparency then Highlight.FillTransparency = HighlightConfig.FillTransparency end
		if HighlightConfig.OutlineColor then Highlight.OutlineColor = HighlightConfig.OutlineColor end
		if HighlightConfig.OutlineTransparency then Highlight.OutlineTransparency = HighlightConfig.OutlineTransparency end
		if HighlightConfig.OutilineTransparency then Highlight.OutlineTransparency = HighlightConfig.OutilineTransparency end
	else
		Highlight.FillTransparency = 1
		Highlight.OutlineTransparency = 0
	end
end

local HitAnim = Animator:LoadAnimation(Animation)

function OnPlayerHit(TargetPlayer: Player)
	-- GodMode : immunité totale aux items
	if TargetPlayer:GetAttribute("GodMode") == true then return end
	local OnHitScheduled = false
	local TargetCharacter = TargetPlayer.Character
	if not TargetCharacter then return end

	local TargetHumanoid = TargetCharacter:FindFirstChildOfClass("Humanoid")
	if not TargetHumanoid then return end

	local TargetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
	if not TargetRoot then return end

	StealService:CancelSteal(TargetPlayer)

	TargetPlayer:SetAttribute("Ragdolled", true)
	TargetHumanoid.PlatformStand = true

	local AttackerPlayer = Player
	local AttackerRoot = AttackerPlayer.Character and AttackerPlayer.Character:FindFirstChild("HumanoidRootPart")

	local FlingDirection
	if AttackerRoot then
		local Delta = TargetRoot.Position - AttackerRoot.Position
		if Delta.Magnitude > 0.1 then
			FlingDirection = Delta.Unit
		else
			FlingDirection = AttackerRoot.CFrame.LookVector
		end
	else
		FlingDirection = TargetRoot.CFrame.LookVector
	end

	local Force = tonumber(Data.Force) or 50
	Force = math.clamp(Force, 0, 2000)

	if AttackerRoot then
		CombatService.Fling(TargetRoot, Force, AttackerRoot.Position)
	else
		CombatService.Fling(TargetRoot, Force)
	end

	if Data.OnHit and not OnHitScheduled then
		OnHitScheduled = true

		task.delay(3, function()
			if TargetCharacter and TargetCharacter.Parent then
				pcall(function()
					Data.OnHit(TargetPlayer, TargetCharacter)
				end)
			end
		end)
	end

	if TargetHumanoid.Health > 0 then
		pcall(function() Ragdoll.Ragdoll(TargetCharacter) end)
		task.wait(Data.RagdollDuration or 3)
		pcall(function() Ragdoll.Unragdoll(TargetCharacter) end)
	end

	if Data.HasParticles then
		pcall(function() Data.HasParticles(TargetRoot, Tool) end)
	end

	TargetPlayer:SetAttribute("Ragdolled", nil)
	if TargetHumanoid and TargetHumanoid.Parent then
		TargetHumanoid.PlatformStand = false
	end
end

Tool.Activated:Connect(function()
	if not CanHit then return end
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
	if TargetPlayer and TargetPlayer.Name == "Abderrlol" then
		return
	end

	if not TargetPlayer 
		or TargetPlayer == Player
		or TargetPlayer:GetAttribute("Ragdolled") 
		or AlreadyHit 
	then
		return
	end

	AlreadyHit = true
	Hit:Play()
	OnPlayerHit(TargetPlayer)
end)
Tool.Unequipped:Connect(function()
	if HitAnim then
		HitAnim:Stop()
	end

	AlreadyHit = false
	CanHit = true
end)