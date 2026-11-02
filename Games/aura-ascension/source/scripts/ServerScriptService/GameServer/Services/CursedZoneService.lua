local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)

local CursedZoneService = {}
CursedZoneService.__index = CursedZoneService

local function chooseRandom(list)
	if #list == 0 then
		return nil
	end
	return list[math.random(1, #list)]
end

local function isPointInsidePart(part, worldPosition)
	if not part or not part:IsA("BasePart") then
		return false
	end
	local localPosition = part.CFrame:PointToObjectSpace(worldPosition)
	local halfSize = part.Size * 0.5
	return math.abs(localPosition.X) <= halfSize.X
		and math.abs(localPosition.Y) <= halfSize.Y
		and math.abs(localPosition.Z) <= halfSize.Z
end

function CursedZoneService.new()
	return setmetatable({
		State = {
			IsActive = false,
			ZoneName = GameConfig.CursedZone.ZoneName,
			EndsAt = 0,
			NextSpawnAt = os.time() + GameConfig.CursedZone.InactiveDurationSeconds,
			Multiplier = 1,
			SpawnNodeName = "",
		},
		SpawnNodes = {},
		AssetTemplate = nil,
		AssetHitboxOffset = nil,
		AssetHitboxHalfHeight = 0,
		AssetHitboxRotation = CFrame.identity,
		AssetVisualBottomOffset = 0,
		RuntimeFolder = nil,
		RuntimeZone = nil,
		RuntimeHitbox = nil,
	}, CursedZoneService)
end

function CursedZoneService:Init(registry)
	self.Registry = registry
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.LegacyBridge = registry:Get("LegacyBridgeService")
	self.RemoteBinder:BindFunction("CursedZoneService", "GetTimerState", function(player)
		return self:GetTimerState(player)
	end)
end

function CursedZoneService:Start()
	self:_resolveZoneAssets()
	self:_resolveSpawnNodes()
	self:_deactivateZone(true)
	task.spawn(function()
		while true do
			task.wait(1)
			self:_stepState()
		end
	end)
end

function CursedZoneService:GetTimerState(_)
	return TableUtil.DeepCopy(self.State)
end

function CursedZoneService:PushStateToPlayer(player)
	if not player then
		return
	end
	self.RemoteBinder:FireClient("CursedZoneService", "TimerStateChanged", player, TableUtil.DeepCopy(self.State))
end

function CursedZoneService:IsAreaAvailable(_)
	return true
end

function CursedZoneService:IsPlayerInsideActiveZone(player)
	if not self.State.IsActive or not self.RuntimeHitbox then
		return false
	end
	local character = player and player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or humanoid.Health <= 0 or not root or not root:IsA("BasePart") then
		return false
	end
	return isPointInsidePart(self.RuntimeHitbox, root.Position)
end

function CursedZoneService:GetAuraMultiplier(player)
	if self:IsPlayerInsideActiveZone(player) then
		return tonumber(self.State.Multiplier) or 1
	end
	return 1
end

function CursedZoneService:ForceActive(active)
	if active then
		self:_activateZone()
	else
		self:_deactivateZone()
	end
end

function CursedZoneService:_stepState()
	local now = os.time()
	if self.State.IsActive then
		if now >= self.State.EndsAt then
			self:_deactivateZone()
		end
	elseif now >= self.State.NextSpawnAt then
		self:_activateZone()
	end
end

function CursedZoneService:_resolveZoneAssets()
	local assets = ReplicatedStorage:WaitForChild("Assets")
	local folder = assets:WaitForChild(GameConfig.CursedZone.AssetFolderName)
	local template = folder:FindFirstChild(GameConfig.CursedZone.AssetName)
	self.AssetTemplate = template
	
	if not template or not template:IsA("Model") then
		self.AssetHitboxOffset = nil
		self.AssetHitboxHalfHeight = 0
		self.AssetHitboxRotation = CFrame.identity
		self.AssetVisualBottomOffset = 0
		return
	end

	local hitbox = template:FindFirstChild("AreaHitbox", true)
	local bboxCFrame, bboxSize = template:GetBoundingBox()
	local bboxBottom = bboxCFrame.Position.Y - bboxSize.Y * 0.5
	if hitbox and hitbox:IsA("BasePart") then
		self.AssetHitboxOffset = template:GetPivot():ToObjectSpace(hitbox.CFrame)
		self.AssetHitboxHalfHeight = hitbox.Size.Y * 0.5
		self.AssetHitboxRotation = self.AssetHitboxOffset - self.AssetHitboxOffset.Position
		local hitboxBottom = hitbox.Position.Y - hitbox.Size.Y * 0.5
		self.AssetVisualBottomOffset = math.max(0, hitboxBottom - bboxBottom)
	else
		self.AssetHitboxOffset = nil
		self.AssetHitboxHalfHeight = 0
		self.AssetHitboxRotation = CFrame.identity
		self.AssetVisualBottomOffset = 0
	end
end

function CursedZoneService:_resolveSpawnNodes()
	local folder = Workspace:FindFirstChild(GameConfig.CursedZone.SpawnNodeFolderName)
	table.clear(self.SpawnNodes)
	if not folder then
		return
	end
	for _, child in ipairs(folder:GetChildren()) do
		if child:IsA("BasePart") and child:IsDescendantOf(Workspace) then
			self.SpawnNodes[#self.SpawnNodes + 1] = child
		end
	end
end

function CursedZoneService:_getOrigin()
	if self.RuntimeHitbox then
		return self.RuntimeHitbox.Position
	end
	return Vector3.zero
end

function CursedZoneService:_refreshTrainingState()
	self.Registry:Get("TrainingAreasService"):RefreshAllPlayers()
end

function CursedZoneService:_updateRuntimeText(multiplier)
	if not self.RuntimeZone then
		return
	end
	local infoLabel = self.RuntimeZone:FindFirstChild("MulitText", true)
	if infoLabel and infoLabel:IsA("TextLabel") then
		infoLabel.RichText = false
		infoLabel.TextScaled = true
		infoLabel.TextWrapped = true
		infoLabel.Text = string.format("x%d MULTI", multiplier)
	end
	local titleLabel = self.RuntimeZone:FindFirstChild("Cursed", true)
	if titleLabel and titleLabel:IsA("TextLabel") then
		titleLabel.Text = "CURSED ZONE"
	end
end

function CursedZoneService:_destroyRuntimeZone()
	self.RuntimeHitbox = nil
	if self.RuntimeZone then
		self.RuntimeZone:Destroy()
		self.RuntimeZone = nil
	end
end

function CursedZoneService:_activateZone()
	if self.State.IsActive then
		return
	end
	if not self.AssetTemplate then
		self:_resolveZoneAssets()
	end
	if #self.SpawnNodes == 0 then
		self:_resolveSpawnNodes()
	end
	local spawnNode = chooseRandom(self.SpawnNodes)
	if not self.AssetTemplate or not spawnNode then
		self.State.NextSpawnAt = os.time() + GameConfig.CursedZone.InactiveDurationSeconds
		self:_broadcastState()
		return
	end

	self:_destroyRuntimeZone()
	local runtimeZone = self.AssetTemplate:Clone()
	runtimeZone.Name = GameConfig.CursedZone.ZoneName
	runtimeZone.Parent = Workspace
	runtimeZone:PivotTo(CFrame.new(spawnNode.Position) * runtimeZone:GetPivot().Rotation)

	local runtimeHitbox = runtimeZone:FindFirstChild("AreaHitbox", true)
	if not runtimeHitbox or not runtimeHitbox:IsA("BasePart") then
		runtimeZone:Destroy()
		self.State.NextSpawnAt = os.time() + GameConfig.CursedZone.InactiveDurationSeconds
		self:_broadcastState()
		return
	end

	local multiplier = chooseRandom(GameConfig.CursedZone.ValidMultipliers) or 2
	self.RuntimeZone = runtimeZone
	self.RuntimeHitbox = runtimeHitbox
	self:_updateRuntimeText(multiplier)

	local now = os.time()
	self.State.IsActive = true
	self.State.EndsAt = now + GameConfig.CursedZone.ActiveDurationSeconds
	self.State.NextSpawnAt = 0
	self.State.Multiplier = multiplier
	self.State.SpawnNodeName = spawnNode.Name
	self:_broadcastState()

	local origin = self:_getOrigin()
	local message = string.format("CURSED ZONE x%d ACTIVE", multiplier)
	self.RemoteBinder:FireAll("CursedZoneService", "ZoneNotification", message, "SuccessNotification")
	self.RemoteBinder:FireAll("CursedZoneService", "ZoneShake", origin, GameConfig.CursedZone.ShakeDurationSeconds)
	self.LegacyBridge:PushCursedZoneNotification(message, "SuccessNotification")
	self.LegacyBridge:PushCursedZoneShake(origin, GameConfig.CursedZone.ShakeDurationSeconds)
	self:_refreshTrainingState()
end

function CursedZoneService:_deactivateZone(skipNotification)
	if not self.State.IsActive and self.State.NextSpawnAt > 0 and skipNotification ~= true then
		return
	end
	self.State.IsActive = false
	self.State.EndsAt = 0
	self.State.NextSpawnAt = os.time() + GameConfig.CursedZone.InactiveDurationSeconds
	self.State.Multiplier = 1
	self.State.SpawnNodeName = ""
	self:_destroyRuntimeZone()
	self:_broadcastState()
	if skipNotification ~= true then
		self.RemoteBinder:FireAll("CursedZoneService", "ZoneNotification", "CURSED ZONE ENDED", "SuccessNotification")
		self.LegacyBridge:PushCursedZoneNotification("CURSED ZONE ENDED", "SuccessNotification")
	end
	self:_refreshTrainingState()
end

function CursedZoneService:_broadcastState()
	local state = TableUtil.DeepCopy(self.State)
	self.RemoteBinder:FireAll("CursedZoneService", "TimerStateChanged", state)
	self.LegacyBridge:PushCursedZoneState(nil)
end

return CursedZoneService