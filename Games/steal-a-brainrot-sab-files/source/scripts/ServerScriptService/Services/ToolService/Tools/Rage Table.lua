local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local RageTable = {}

local COOLDOWN = 4
local THROW_DURATION = 6
local RAGDOLL_DURATION = 3
local FREEZE_DURATION = 1.5

local PlayerCooldowns = {}

local function FindAttachedHumanoid(part)
	local current = part
	while current and current.Parent do
		if current.Parent:FindFirstChild("Humanoid") then
			return current.Parent
		end
		current = current.Parent
	end
	return nil
end

function RageTable.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end

	local humanoid = Character:FindFirstChildOfClass("Humanoid")
	local torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
	if not humanoid or humanoid.Health <= 0 or not torso then
		return
	end

	PlayerCooldowns[Player.UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	humanoid.WalkSpeed = 0

	local lookGyro = Instance.new("BodyGyro")
	lookGyro.MaxTorque = Vector3.new(0, math.huge, 0)
	lookGyro.CFrame = torso.CFrame - torso.CFrame.Position
	lookGyro.Parent = torso

	local tableTemplate = ServerScriptService.ToolsCode.AdditonalItems:FindFirstChild("TableModel")
	if not tableTemplate then
		return
	end

	local tableClone = tableTemplate:Clone()
	tableClone:PivotTo(torso.CFrame + torso.CFrame.LookVector * 3)
	tableClone.Parent = workspace

	local tablePrimaryPart = tableClone.PrimaryPart or tableClone:FindFirstChildWhichIsA("BasePart")
	if not tablePrimaryPart then
		tableClone:Destroy()
		return
	end

	local angularVelocity = Instance.new("BodyAngularVelocity")
	angularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	angularVelocity.AngularVelocity = (torso.CFrame * CFrame.Angles(0, math.pi / 2, 0)).LookVector * 5
	angularVelocity.Parent = tablePrimaryPart

	local velocity = Instance.new("BodyVelocity")
	velocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
	velocity.Velocity = torso.CFrame.LookVector * 15
	velocity.Parent = tablePrimaryPart

	local touched = false
	local connection
	connection = tablePrimaryPart.Touched:Connect(function(part)
		if touched then return end
		if part:IsDescendantOf(Character) then return end
		if part.Parent == workspace.Terrain or part.Anchored then return end

		local targetCharacter = FindAttachedHumanoid(part)
		if targetCharacter and targetCharacter ~= Character then
			touched = true
			local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
			if targetHumanoid and targetHumanoid.Health > 0 then
				local root = targetCharacter:FindFirstChild("HumanoidRootPart")
				if root then
					local wasAnchored = root.Anchored
					root.Anchored = true
					task.delay(FREEZE_DURATION, function()
						if root then root.Anchored = wasAnchored end
					end)
				end

				targetHumanoid.BreakJointsOnDeath = false
				Ragdoll.TimedRagdoll(targetCharacter, RAGDOLL_DURATION)
				task.delay(RAGDOLL_DURATION, function()
					if targetHumanoid then
						targetHumanoid.BreakJointsOnDeath = true
					end
				end)

				tablePrimaryPart.Velocity = Vector3.new(0, 0, 0)
				angularVelocity:Destroy()
				velocity:Destroy()
				if connection then connection:Disconnect() end

				task.delay(2, function()
					if tableClone then tableClone:Destroy() end
				end)
			end
		end
	end)

	task.delay(THROW_DURATION, function()
		if lookGyro then lookGyro:Destroy() end
		humanoid.WalkSpeed = 34
	end)

	task.delay(THROW_DURATION + 2, function()
		if connection then connection:Disconnect() end
		if tableClone and tableClone.Parent then
			tableClone:Destroy()
		end
	end)
end

return RageTable