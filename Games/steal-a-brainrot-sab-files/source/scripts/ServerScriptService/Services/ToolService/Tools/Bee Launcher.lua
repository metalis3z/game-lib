local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local Net = require(ReplicatedStorage.Packages.Net)

local UseItem = Net:RemoteEvent("UseItem")
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local BeeLauncher = {}

local COOLDOWN = 10
local MAX_RANGE = 30
local BEE_DURATION = 5

local PlayerCooldowns = {}

function BeeLauncher.OnExecution(Player: Player, Character: Model, Tool: Tool, TargetPlayer: Player)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end

	if not TargetPlayer or not TargetPlayer.Character then
		return
	end

	local TargetCharacter = TargetPlayer.Character
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

	local TargetHead = TargetCharacter:FindFirstChild("Head")
	if TargetHead then
		for _, child in ipairs(script:GetChildren()) do
			local clonedChild = child:Clone()
			clonedChild.Parent = TargetHead
			Debris:AddItem(clonedChild, BEE_DURATION)
		end
	end

	UseItem:FireClient(TargetPlayer, "Bee Attack")
end

return BeeLauncher