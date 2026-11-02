local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local Heatseeker = {}
local COOLDOWN = 10
local MISSILE_SPEED = 60
local MISSILE_LIFETIME = 5
local EXPLOSION_RADIUS = 10
local PlayerCooldowns = {}

local function FireMissile(origin, targetCharacter, shooter, tool)
	local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetHRP then return end

	local missile = Instance.new("Part")
	missile.Size = Vector3.new(1, 1, 3)
	missile.CFrame = CFrame.new(origin, targetHRP.Position)
	missile.Material = Enum.Material.Metal
	missile.BrickColor = BrickColor.new("Bright red")
	missile.CanCollide = false
	missile.Anchored = false
	missile.Parent = workspace

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bodyVelocity.Velocity = missile.CFrame.LookVector * MISSILE_SPEED
	bodyVelocity.Parent = missile

	local startTime = tick()
	local connection
	local exploded = false

	local function Explode()
		if exploded then return end
		exploded = true
		if connection then connection:Disconnect() end
		if not missile or not missile.Parent then return end
		missile:Destroy()

		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			if not character then continue end
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if not hrp then continue end
			if (hrp.Position - missile.Position).Magnitude <= EXPLOSION_RADIUS then
				Ragdoll.Ragdoll(character)
				task.delay(3, function()
					if character and character.Parent then
						Ragdoll.Unragdoll(character)
					end
				end)
			end
		end
	end

	connection = RunService.Heartbeat:Connect(function()
		if not missile or not missile.Parent then
			if connection then connection:Disconnect() end
			return
		end

		if tick() - startTime >= MISSILE_LIFETIME then
			exploded = true
			connection:Disconnect()
			missile:Destroy()
			return
		end

		local currentTarget = targetCharacter:FindFirstChild("HumanoidRootPart")
		if currentTarget then
			local direction = (currentTarget.Position - missile.Position).Unit
			bodyVelocity.Velocity = direction * MISSILE_SPEED
			missile.CFrame = CFrame.new(missile.Position, missile.Position + direction)
		end

		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			if not character then continue end
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp and (hrp.Position - missile.Position).Magnitude <= 3 then
				Explode()
				return
			end
		end
	end)
end

function Heatseeker.OnExecution(Player: Player, Character: Model, Tool: Tool, targetPlayer: Player)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return nil
	end

	local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end

	local targetCharacter = targetPlayer and targetPlayer.Character
	if not targetCharacter then
		return nil
	end

	PlayerCooldowns[Player.UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	FireMissile(humanoidRootPart.Position, targetCharacter, Player, Tool)

	return tick() + COOLDOWN
end

return Heatseeker