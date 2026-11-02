-- Ban Hammer.lua (MADE BY TVMM!!!)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CombatService = require(ServerScriptService.Services.CombatService)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)

local BanHammer = {}
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local Config = {
	NormalHitDamage = 15,
	SlamDamage = 25,
	BigSlamDamage = 40,
	NormalKnockback = 50,
	SlamKnockback = 100,
	BigSlamKnockback = 150,
	BigSlamUpForce = 230,
	NormalCooldown = 0.5,
	SlamCooldown = 1,
	BigSlamCooldown = 4,
	RagdollDuration = 1.5,
	RagdollImmunityTime = 2.5,
}

local HitDebounce = {}
local PlayerCooldowns = {}

local function IsOnCooldown(player, cooldownType)
	local key = player.UserId .. "_" .. cooldownType
	if PlayerCooldowns[key] then
		local timeElapsed = tick() - PlayerCooldowns[key]
		local cooldownTime = Config[cooldownType .. "Cooldown"]
		if timeElapsed < cooldownTime then
			return true, cooldownTime - timeElapsed
		end
	end
	return false, 0
end

local function SetCooldown(player, cooldownType)
	local key = player.UserId .. "_" .. cooldownType
	PlayerCooldowns[key] = tick()

	local cooldownTime = Config[cooldownType .. "Cooldown"]
	ToolsCooldown:FireClient(player, player.Character:FindFirstChildOfClass("Tool"), cooldownTime)
end

function BanHammer.HandleNormalHit(player, character, hitCharacter)
	if not player or not character or not hitCharacter then return end
	if hitCharacter == character then return end

	local onCooldown, _ = IsOnCooldown(player, "Normal")
	if onCooldown then return end

	local targetId = hitCharacter.Name
	local hitPlayer = Players:GetPlayerFromCharacter(hitCharacter)
	if hitPlayer then
		targetId = tostring(hitPlayer.UserId)
	end

	local debounceKey = player.UserId .. "_" .. targetId
	if HitDebounce[debounceKey] then return end
	HitDebounce[debounceKey] = true

	local rootPart = hitCharacter:FindFirstChild("HumanoidRootPart")
	if rootPart then
		CombatService.ProcessHit(rootPart, player, character, nil, nil, {
			Force = Config.NormalKnockback,
			RagdollDuration = Config.RagdollDuration
		})
	end

	SetCooldown(player, "Normal")
	task.delay(0.3, function() HitDebounce[debounceKey] = nil end)
end

function BanHammer.HandleSlam(player, character, hitCenter, radius)
	SetCooldown(player, "Slam")
end

function BanHammer.HandleBigSlam(player, character, hitCenter, radius)
	SetCooldown(player, "BigSlam")
end

function BanHammer.OnExecution(Player, Character, Tool)
end

return BanHammer