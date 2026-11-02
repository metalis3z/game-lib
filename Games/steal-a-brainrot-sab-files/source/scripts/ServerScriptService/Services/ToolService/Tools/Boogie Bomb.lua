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

function BoogieBomb.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end
	PlayerCooldowns[Player.UserId] = tick()
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
	Bomb.AssemblyLinearVelocity = direction * THROW_FORCE + Vector3.new(0, 30, 0)

	local alreadyBoogied = {}

	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function()
		if not Bomb.Parent then
			HeartbeatConnection:Disconnect()
			return
		end

		for _, targetPlayer in pairs(Players:GetPlayers()) do
			if targetPlayer ~= Player and targetPlayer.Character and not alreadyBoogied[targetPlayer.UserId] then
				local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
				local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
				if humanoid and root and (root.Position - Bomb.Position).Magnitude <= RADIUS then

					UseItem:FireClient(targetPlayer, "Boogie")

					local anim = Instance.new("Animation")
					anim.AnimationId = "rbxassetid://10906198388712"
					local track = humanoid:LoadAnimation(anim)
					track:Play()
					task.delay(DANCE_DURATION, function()
						track:Stop()
						anim:Destroy()
					end)

					alreadyBoogied[targetPlayer.UserId] = true

					if StealService:IsStealing(targetPlayer) then
						StealService:CancelSteal(targetPlayer)
					end
				end
			end
		end
	end)

	Debris:AddItem(Bomb, 10)
	task.delay(10, function()
		if HeartbeatConnection.Connected then
			HeartbeatConnection:Disconnect()
		end
	end)
end

return BoogieBomb