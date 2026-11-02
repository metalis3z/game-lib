--!native

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)

local Items = require(ReplicatedStorage.Datas.Items)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

local Player = Tool.Parent.Parent :: Player
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

local Data = Items["Dev Slap"]

if not Humanoid then return end

local Hitbox = Instance.new("Part")
Hitbox.Name = "Hitbox"
Hitbox.Size = Vector3.new(10, 10, 10)
Hitbox.Transparency = 1
Hitbox.CanCollide = false
Hitbox.CanTouch = true
Hitbox.Massless = true
Hitbox.Parent = Tool
Hitbox.CFrame = Handle.CFrame

task.spawn(function()
	while Tool.Parent == Player.Backpack or Tool.Parent == Character do
		if Handle then
			Hitbox.CFrame = Handle.CFrame
		end
		task.wait()
	end
end)

local CanHit = true
local HitBufferActive = false
local BufferDuration = 1

local RecentlyHit = {}

local function ResetHit(target)
	RecentlyHit[target] = nil
end

function OnPlayerHit(targetPlayer: Player)
	RecentlyHit[targetPlayer] = true
	task.delay(0.5, function() ResetHit(targetPlayer) end)

	local targetCharacter = targetPlayer.Character
	if not targetCharacter then return end

	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not targetHumanoid then return end

	local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetRoot then return end

	StealService:CancelSteal(targetPlayer)

	targetPlayer:SetAttribute("Ragdolled", true)
	targetHumanoid.PlatformStand = true

	local attackerRoot = Character:FindFirstChild("HumanoidRootPart")

	local delta = attackerRoot and (targetRoot.Position - attackerRoot.Position)
	local flingDirection = (delta and delta.Magnitude > 0.1) and delta.Unit or attackerRoot.CFrame.LookVector

	local force = tonumber(2500)
	CombatService.Fling(targetRoot, force, attackerRoot and attackerRoot.Position)

	if targetHumanoid.Health > 0 then
		pcall(function() Ragdoll.Ragdoll(targetCharacter) end)
		task.wait(3)
		pcall(function() Ragdoll.Unragdoll(targetCharacter) end)
	end

	if Data.OnHit then
		pcall(function() Data.OnHit(targetPlayer, targetCharacter) end)
	end

	targetPlayer:SetAttribute("Ragdolled", nil)
	targetHumanoid.PlatformStand = false
end

Tool.Activated:Connect(function()
	local pinataEventModule = require(ServerScriptService.Services.EventService.Events:WaitForChild("PinataEvent"))
	pinataEventModule:HandleHit(Player, Handle)


	if not CanHit then return end

	CanHit = false
	HitBufferActive = true

	task.delay(BufferDuration, function()
		HitBufferActive = false
	end)

	task.delay(Data.Cooldown, function()
		CanHit = true
	end)
end)

Hitbox.Touched:Connect(function(hit)
	local targetPlayer = Players:GetPlayerFromCharacter(hit.Parent)
	if not targetPlayer then return end
	if targetPlayer == Player then return end
	if RecentlyHit[targetPlayer] then return end

	if not HitBufferActive then return end

	OnPlayerHit(targetPlayer)
end)
