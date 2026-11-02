local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local Net = require(ReplicatedStorage.Packages.Net)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local StealService = require(ServerScriptService.Services.StealService)

local BodySwap = {}

local COOLDOWN = 30
local MAX_RANGE = 50
local EFFECT_DURATION = 0.5

local PlayerCooldowns = {}

function BodySwap.OnExecution(Player: Player, Character: Model, Tool: Tool, TargetPlayer: Player)
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
	if StealService:IsStealing(TargetPlayer) then
		StealService:CancelSteal(TargetPlayer)
	end
	
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://136029417452204"
	Sound.Parent = TargetCharacter:WaitForChild("HumanoidRootPart")
	Sound:Play()

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://136029417452204"
	Sound.Parent = Character:WaitForChild("HumanoidRootPart")
	Sound:Play()

	local playerPosition = HumanoidRootPart.CFrame
	local targetPosition = TargetRoot.CFrame

	HumanoidRootPart.CFrame = targetPosition
	TargetRoot.CFrame = playerPosition

	local partsToClone = {"HumanoidRootPart", "LeftFoot", "RightFoot"}

	for _, partName in ipairs(partsToClone) do
		local playerPart = Character:FindFirstChild(partName)
		local targetPart = TargetCharacter:FindFirstChild(partName)

		if playerPart then
			for _, child in ipairs(script:GetChildren()) do
				local clonedChild = child:Clone()
				clonedChild.Parent = playerPart
				Debris:AddItem(clonedChild, EFFECT_DURATION)
			end
		end

		if targetPart then
			for _, child in ipairs(script:GetChildren()) do
				local clonedChild = child:Clone()
				clonedChild.Parent = targetPart
				Debris:AddItem(clonedChild, EFFECT_DURATION)
			end
		end
	end
end

return BodySwap