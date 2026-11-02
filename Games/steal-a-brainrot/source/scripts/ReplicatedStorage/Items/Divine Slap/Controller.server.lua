local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)
local Items = require(ReplicatedStorage.Datas.Items)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local Tool = script.Parent
local Handle = Tool.Handle

-- Attendre que le tool soit équipé par un joueur
local Player, Character, Humanoid, Animator

local function setup()
	-- Tool.Parent = Character quand équipé, Backpack quand dans sac
	local parent = Tool.Parent
	if parent:IsA("Model") then
		Character = parent
		Humanoid = Character:FindFirstChildOfClass("Humanoid")
		Animator = Humanoid and Humanoid:FindFirstChildWhichIsA("Animator")
		Player = Players:GetPlayerFromCharacter(Character)
	elseif parent:IsA("Backpack") then
		Player = parent.Parent
		Character = Player.Character
		Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		Animator = Humanoid and Humanoid:FindFirstChildWhichIsA("Animator")
	end
end

setup()
Tool.AncestryChanged:Connect(setup)

local Data = Items[Tool.Name]
if not Data then
	warn("[Divine Slap] Item data introuvable:", Tool.Name)
	return
end

local CanHit = true
local AlreadyHit = false

local HitSound = Instance.new("Sound", Tool)
HitSound.SoundId = "rbxassetid://146163534"

local SlashSound = Instance.new("Sound", Tool)
SlashSound.SoundId = "rbxassetid://9113305311"

local Animation = Instance.new("Animation", Tool)
Animation.AnimationId = "rbxassetid://96450483850237"
Animation.Name = "HitAnim"

Tool.TextureId = Data.Icon
Tool.ToolTip = Data.Name

-- Highlight
if Data.HasHighlight then
	local Highlight = Instance.new("Highlight", Tool)
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	if Data.HighlightConfig then
		local cfg = Data.HighlightConfig
		if cfg.FillColor then Highlight.FillColor = cfg.FillColor end
		if cfg.FillTransparency then Highlight.FillTransparency = cfg.FillTransparency end
		if cfg.OutlineColor then Highlight.OutlineColor = cfg.OutlineColor end
		if cfg.OutlineTransparency then Highlight.OutlineTransparency = cfg.OutlineTransparency end
	else
		Highlight.FillTransparency = 1
		Highlight.OutlineTransparency = 0
	end
end

local HitAnim

local function getAnim()
	if HitAnim then return HitAnim end
	if Animator then
		HitAnim = Animator:LoadAnimation(Animation)
	end
	return HitAnim
end

local function OnPlayerHit(targetPlayer: Player)
	if targetPlayer:GetAttribute("GodMode") == true then return end
	local targetCharacter = targetPlayer.Character
	if not targetCharacter then return end
	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not targetHumanoid then return end
	local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetRoot then return end

	StealService:CancelSteal(targetPlayer)
	targetPlayer:SetAttribute("Ragdolled", true)
	targetHumanoid.PlatformStand = true

	local attackerRoot = Character and Character:FindFirstChild("HumanoidRootPart")
	local force = math.clamp(tonumber(Data.Force) or 50, 0, 2000)

	if attackerRoot then
		CombatService.Fling(targetRoot, force, attackerRoot.Position)
	else
		CombatService.Fling(targetRoot, force)
	end

	if targetHumanoid.Health > 0 then
		pcall(function() Ragdoll.Ragdoll(targetCharacter) end)
		task.wait(Data.RagdollDuration or 3)
		pcall(function() Ragdoll.Unragdoll(targetCharacter) end)
	end

	if Data.OnHit then
		pcall(function() Data.OnHit(targetPlayer, targetCharacter) end)
	end
	if Data.HasParticles then
		pcall(function() Data.HasParticles(targetRoot, Tool) end)
	end

	targetPlayer:SetAttribute("Ragdolled", nil)
	if targetHumanoid and targetHumanoid.Parent then
		targetHumanoid.PlatformStand = false
	end
end

Tool.Activated:Connect(function()
	if not CanHit then return end
	if not Animator then setup() end
	local anim = getAnim()
	if not anim then return end
	AlreadyHit = false
	CanHit = false
	SlashSound:Play()
	anim:Play()
	task.wait(Data.Cooldown or 1)
	CanHit = true
end)

Handle.Touched:Connect(function(Other)
	local anim = getAnim()
	if not anim or not anim.IsPlaying then return end
	local TargetPlayer = Players:GetPlayerFromCharacter(Other.Parent)
	if not TargetPlayer or TargetPlayer == Player
		or TargetPlayer:GetAttribute("Ragdolled") or AlreadyHit then
		return
	end
	AlreadyHit = true
	HitSound:Play()
	OnPlayerHit(TargetPlayer)
end)

Tool.Unequipped:Connect(function()
	local anim = getAnim()
	if anim then anim:Stop() end
	AlreadyHit = false
	CanHit = true
end)
