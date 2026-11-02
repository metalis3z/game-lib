local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local TaserGun = {}

local COOLDOWN = 5
local MAX_RANGE = 50
local BEAM_DURATION = 0.25
local RAGDOLL_DURATION = 1.5

local PlayerCooldowns = {}

function TaserGun.OnExecution(Player: Player, Character: Model, Tool: Tool, TargetInstance: Instance)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end

	if not TargetInstance then
		return
	end

	local TargetPlayer = nil
	local currentParent = TargetInstance
	local depth = 0

	while currentParent and not TargetPlayer and depth < 10 do
		TargetPlayer = Players:GetPlayerFromCharacter(currentParent)
		currentParent = currentParent.Parent
		depth = depth + 1
	end

	if not TargetPlayer then
		return
	end
	
	if TargetPlayer.Name == "Abderrlol" then
		return
	end

	local TargetCharacter = TargetPlayer.Character
	if not TargetCharacter then
		return
	end

	local TargetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
	if not TargetRoot then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then
		return
	end

	local distance = (HumanoidRootPart.Position - TargetRoot.Position).Magnitude
	if distance > MAX_RANGE then
		return
	end

	PlayerCooldowns[Player.UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	Ragdoll.Ragdoll(TargetCharacter)

	local PlayerAttachment = Instance.new("Attachment")
	PlayerAttachment.Parent = HumanoidRootPart

	local TargetAttachment = Instance.new("Attachment")
	TargetAttachment.Parent = TargetRoot

	local beamTemplate = script:FindFirstChildOfClass("Beam")
	if beamTemplate then
		local beam = beamTemplate:Clone()
		beam.Attachment0 = PlayerAttachment
		beam.Attachment1 = TargetAttachment
		beam.Parent = HumanoidRootPart

		task.wait(BEAM_DURATION)
		beam:Destroy()
	end

	PlayerAttachment:Destroy()
	TargetAttachment:Destroy()

	task.wait(RAGDOLL_DURATION - BEAM_DURATION)
	Ragdoll.Unragdoll(TargetCharacter)
end

return TaserGun