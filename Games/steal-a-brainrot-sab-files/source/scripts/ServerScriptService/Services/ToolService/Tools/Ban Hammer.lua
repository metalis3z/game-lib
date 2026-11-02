local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Ragdoll = require(Packages.Ragdoll)
local Net = require(Packages.Net)

local BanHammer = {}

local BanHammerHit = Net:RemoteEvent("Tools/BanHammerHit")
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
local RagdollImmunity = {}
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

local function RagdollPlayer(character, direction, force)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	local player = Players:GetPlayerFromCharacter(character)
	if not player then return end

	local currentTime = tick()
	if RagdollImmunity[player] and currentTime - RagdollImmunity[player] < Config.RagdollImmunityTime then
		return
	end
	RagdollImmunity[player] = currentTime

	pcall(function()
		if StealService and StealService:IsStealing(player) then
			StealService:CancelSteal(player)
		end
	end)

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		local velocity = direction * force
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.Velocity = velocity
		bv.Parent = rootPart
		Debris:AddItem(bv, 0.2)
	end

	pcall(function()
		Ragdoll.Ragdoll(character)
		task.delay(Config.RagdollDuration, function()
			if character and character.Parent then
				Ragdoll.Unragdoll(character)
			end
		end)
	end)
end

function BanHammer.HandleNormalHit(player, character, hitCharacter)
	if not player or not character or not hitCharacter then return end

	local onCooldown, timeLeft = IsOnCooldown(player, "Normal")
	if onCooldown then return end

	local hitPlayer = Players:GetPlayerFromCharacter(hitCharacter)
	if not hitPlayer or hitPlayer == player then return end

	local debounceKey = player.UserId .. "_" .. hitPlayer.UserId
	if HitDebounce[debounceKey] then return end
	HitDebounce[debounceKey] = true

	local humanoid = hitCharacter:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		humanoid:TakeDamage(Config.NormalHitDamage)

		local direction = (hitCharacter.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Unit
		local rootPart = hitCharacter:FindFirstChild("HumanoidRootPart")
		if rootPart then
			local velocity = direction * Config.NormalKnockback
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			bv.Velocity = velocity
			bv.Parent = rootPart
			Debris:AddItem(bv, 0.15)
		end
	end

	SetCooldown(player, "Normal")

	task.delay(0.3, function()
		HitDebounce[debounceKey] = nil
	end)
end

function BanHammer.HandleSlam(player, character, hitCenter, radius)
	if not player or not character then return end

	local onCooldown, timeLeft = IsOnCooldown(player, "Slam")
	if onCooldown then return end

	for _, otherPlayer in pairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local enemyRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = otherPlayer.Character:FindFirstChildOfClass("Humanoid")

			if enemyRoot and humanoid and humanoid.Health > 0 then
				local distance = (enemyRoot.Position - hitCenter).Magnitude

				if distance <= radius then
					humanoid:TakeDamage(Config.SlamDamage)

					local direction = (enemyRoot.Position - hitCenter).Unit
					RagdollPlayer(otherPlayer.Character, direction, Config.SlamKnockback)
				end
			end
		end
	end

	SetCooldown(player, "Slam")
end

function BanHammer.HandleBigSlam(player, character, hitCenter, radius)
	if not player or not character then return end

	local onCooldown, timeLeft = IsOnCooldown(player, "BigSlam")
	if onCooldown then return end

	for _, otherPlayer in pairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local enemyRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = otherPlayer.Character:FindFirstChildOfClass("Humanoid")

			if enemyRoot and humanoid and humanoid.Health > 0 then
				local distance = (enemyRoot.Position - hitCenter).Magnitude

				if distance <= radius then
					humanoid:TakeDamage(Config.BigSlamDamage)

					local direction = (enemyRoot.Position - hitCenter).Unit
					local velocity = (direction * Config.BigSlamKnockback) + Vector3.new(0, Config.BigSlamUpForce, 0)

					local bv = Instance.new("BodyVelocity")
					bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
					bv.Velocity = velocity
					bv.Parent = enemyRoot
					Debris:AddItem(bv, 0.2)

					RagdollPlayer(otherPlayer.Character, direction, 0)
				end
			end
		end
	end

	SetCooldown(player, "BigSlam")
end

function BanHammer.OnExecution(Player: Player, Character: Model, Tool: Tool)

end

return BanHammer