local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local StealService = require(ServerScriptService.Services.StealService)

local UseItem = Net:RemoteEvent("UseItem")
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local BoogieBomb = {}

local THROW_FORCE = 10
local COOLDOWN = 10
local RADIUS = 10
local DANCE_DURATION = 5

local PlayerCooldowns = {}

local DanceAnimation = Instance.new("Animation")
DanceAnimation.AnimationId = "rbxassetid://72741479570628"

function BoogieBomb.OnExecution(Player: Player, Character: Model, Tool: Tool)

	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (time() - lastUse) < COOLDOWN then
		return
	end

	PlayerCooldowns[Player.UserId] = time()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	local Handle = Tool:FindFirstChild("Handle")
	if not Handle then return end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end

	local Bomb = Handle:Clone()
	Bomb.CFrame = HumanoidRootPart.CFrame + HumanoidRootPart.CFrame.LookVector * 1.5
	Bomb.Parent = workspace
	Bomb.Anchored = false
	Bomb.CanCollide = true

	local direction = HumanoidRootPart.CFrame.LookVector
	Bomb.AssemblyLinearVelocity = direction * THROW_FORCE + Vector3.new(0,30,0)

	local alreadyBoogied = {}

	local connection
	connection = RunService.Heartbeat:Connect(function()

		if not Bomb.Parent then
			connection:Disconnect()
			return
		end

		for _, targetPlayer in pairs(Players:GetPlayers()) do

			if targetPlayer ~= Player
				and targetPlayer.Name ~= "Abderrlol"
				and targetPlayer.Character
				and not alreadyBoogied[targetPlayer.UserId] then

				local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
				local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

				if humanoid and root and (root.Position - Bomb.Position).Magnitude <= RADIUS then

					alreadyBoogied[targetPlayer.UserId] = true

					UseItem:FireClient(targetPlayer,"Boogie")

					root:SetNetworkOwner(nil)

					local animator = humanoid:FindFirstChildOfClass("Animator")
					if not animator then
						animator = Instance.new("Animator")
						animator.Parent = humanoid
					end

					local track = animator:LoadAnimation(DanceAnimation)
					track.Priority = Enum.AnimationPriority.Action
					track.Looped = true
					track:Play()

					task.delay(DANCE_DURATION,function()

						if track then
							track:Stop()
						end

						if humanoid then
						end

						if root then
							root:SetNetworkOwner(targetPlayer)
						end

					end)

					if StealService:IsStealing(targetPlayer) then
						StealService:CancelSteal(targetPlayer)
					end

				end
			end
		end
	end)

	Debris:AddItem(Bomb,10)

	task.delay(10,function()
		if connection and connection.Connected then
			connection:Disconnect()
		end
	end)

end

return BoogieBomb