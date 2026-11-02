local tool = script.Parent

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local StealService = require(ServerScriptService.Services.StealService)

local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local COOLDOWN = 20
local FEAR_DURATION = 5
local RADIUS = 30
local KNOCKBACK_FORCE = 50

local lastUsed = 0

tool.Activated:Connect(function()
	local player = Players:GetPlayerFromCharacter(tool.Parent)
	if not player then return end

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local now = os.clock()
	if now - lastUsed < COOLDOWN then return end

	lastUsed = now
	ToolsCooldown:FireClient(player, tool, COOLDOWN)

	local handle = tool:FindFirstChild("Handle")
	if not handle then return end

	local scream = handle:FindFirstChild("Screams")
	if scream then
		scream:Play()
	end

	local particles = {}

	local fx = handle:FindFirstChild("fx")
	if fx then
		for _,v in pairs(fx:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
				table.insert(particles,v)
			end
		end
	end

	local start = os.clock()

	while os.clock() - start < FEAR_DURATION do

		for _,targetPlayer in pairs(Players:GetPlayers()) do

			if targetPlayer ~= player then

				local targetChar = targetPlayer.Character
				if not targetChar then continue end

				local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
				local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")

				if not targetHum or not targetRoot then continue end
				if targetPlayer:GetAttribute("Ragdolled") then continue end

				local distance = (targetRoot.Position - root.Position).Magnitude

				if distance <= RADIUS then
					
					StealService:CancelSteal(targetPlayer)
					targetPlayer:SetAttribute("Ragdolled",true)

					local direction = (targetRoot.Position - root.Position).Unit

					local velocity = Instance.new("BodyVelocity")
					velocity.MaxForce = Vector3.new(100000,100000,100000)
					velocity.Velocity = direction * KNOCKBACK_FORCE + Vector3.new(0,50,0)
					velocity.Parent = targetRoot

					game.Debris:AddItem(velocity,0.3)

					targetHum:ChangeState(Enum.HumanoidStateType.Physics)

					pcall(function()
						Ragdoll.Ragdoll(targetChar)
					end)

					task.delay(FEAR_DURATION,function()

						local newChar = targetPlayer.Character
						if newChar then
							pcall(function()
								Ragdoll.Unragdoll(newChar)
							end)
						end

						targetPlayer:SetAttribute("Ragdolled",nil)

					end)

				end
			end
		end

		task.wait(0.2)
	end

	for _,p in pairs(particles) do
		if p and p.Parent then
			p.Enabled = false
		end
	end
end)