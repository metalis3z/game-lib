local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local RagdollService = {}

local DEFAULTS = {
	FolderName = "Ragdolls",

	AliveCollisionGroup = "AliveCharacters",
	RagdollCollisionGroup = "ServerRagdolls",

	Lifetime = false,
	ServerOwned = true,
	SyncClients = true,
	HideOriginalCharacter = true,

	DisableCorpseTouch = true,
	DisableCorpseQueries = false,

	RemoveNonAvatarObjects = true,
	PreserveVisibleCustomCosmetics = true,
	RemoveInvisibleCustomParts = true,

	InitialAngularVelocity = 4.5,
	R6InitialAngularVelocity = 7,

	FreezeWhenSettled = true,
	MinimumFreezeDelay = 1.5,
	MaximumFreezeDelay = 5,
	SettleDuration = 0.6,
	LinearVelocityThreshold = 0.35,
	AngularVelocityThreshold = 0.8,
	DisableConstraintsWhenFrozen = true,

	Debug = false,
}

local R6_BODY_PARTS = {
	HumanoidRootPart = true,
	Head = true,
	Torso = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
}

local R15_BODY_PARTS = {
	Head = true,
	UpperTorso = true,
	LowerTorso = true,

	LeftUpperArm = true,
	LeftLowerArm = true,
	LeftHand = true,

	RightUpperArm = true,
	RightLowerArm = true,
	RightHand = true,

	LeftUpperLeg = true,
	LeftLowerLeg = true,
	LeftFoot = true,

	RightUpperLeg = true,
	RightLowerLeg = true,
	RightFoot = true,
}

local JOINT_PROFILES = {
	Neck = {
		UpperAngle = 80,
		TwistLowerAngle = -75,
		TwistUpperAngle = 75,
	},

	Waist = {
		UpperAngle = 55,
		TwistLowerAngle = -45,
		TwistUpperAngle = 45,
	},

	LeftShoulder = {
		UpperAngle = 125,
		TwistLowerAngle = -100,
		TwistUpperAngle = 100,
	},

	RightShoulder = {
		UpperAngle = 125,
		TwistLowerAngle = -100,
		TwistUpperAngle = 100,
	},

	LeftHip = {
		UpperAngle = 105,
		TwistLowerAngle = -75,
		TwistUpperAngle = 75,
	},

	RightHip = {
		UpperAngle = 105,
		TwistLowerAngle = -75,
		TwistUpperAngle = 75,
	},

	LeftElbow = {
		UpperAngle = 105,
		TwistLowerAngle = -18,
		TwistUpperAngle = 18,
	},

	RightElbow = {
		UpperAngle = 105,
		TwistLowerAngle = -18,
		TwistUpperAngle = 18,
	},

	LeftKnee = {
		UpperAngle = 115,
		TwistLowerAngle = -15,
		TwistUpperAngle = 15,
	},

	RightKnee = {
		UpperAngle = 115,
		TwistLowerAngle = -15,
		TwistUpperAngle = 15,
	},

	LeftWrist = {
		UpperAngle = 60,
		TwistLowerAngle = -45,
		TwistUpperAngle = 45,
	},

	RightWrist = {
		UpperAngle = 60,
		TwistLowerAngle = -45,
		TwistUpperAngle = 45,
	},

	LeftAnkle = {
		UpperAngle = 55,
		TwistLowerAngle = -35,
		TwistUpperAngle = 35,
	},

	RightAnkle = {
		UpperAngle = 55,
		TwistLowerAngle = -35,
		TwistUpperAngle = 35,
	},

	LeftShoulderR6 = {
		UpperAngle = 140,
		TwistLowerAngle = -120,
		TwistUpperAngle = 120,
	},

	RightShoulderR6 = {
		UpperAngle = 140,
		TwistLowerAngle = -120,
		TwistUpperAngle = 120,
	},

	LeftHipR6 = {
		UpperAngle = 115,
		TwistLowerAngle = -85,
		TwistUpperAngle = 85,
	},

	RightHipR6 = {
		UpperAngle = 115,
		TwistLowerAngle = -85,
		TwistUpperAngle = 85,
	},
}

local DEFAULT_JOINT_PROFILE = {
	UpperAngle = 100,
	TwistLowerAngle = -75,
	TwistUpperAngle = 75,
}

local KNOWN_GAMEPLAY_OBJECT_NAMES = {
	["knifedisplay"] = true,
	["gundisplay"] = true,
	["knifehitbox"] = true,
	["gunhitbox"] = true,
	["hitbox"] = true,
	["hurtbox"] = true,
	["damagebox"] = true,
	["combatbox"] = true,
	["collisionbox"] = true,
	["serverhitbox"] = true,
}

local initialized = false
local randomGenerator = Random.new()
local activeCorpses = {}
local corpseSettings = setmetatable({}, { __mode = "k" })
local ragdollFolders = {}

local function warnf(message, ...)
	warn(("[RagdollService] " .. message):format(...))
end

local function debugf(settings, message, ...)
	if settings and settings.Debug then
		print(("[RagdollService] " .. message):format(...))
	end
end

local function normalizeJointName(name)
	return tostring(name)
		:gsub("[%s_%-]", "")
		:gsub("Constraint$", "")
		:gsub("Motor6D$", "")
		:gsub("Joint$", "")
end

local function getJointProfile(jointName, rigType)
	local normalized = normalizeJointName(jointName)

	if rigType == Enum.HumanoidRigType.R6 then
		if normalized == "LeftShoulder" then
			return JOINT_PROFILES.LeftShoulderR6
		elseif normalized == "RightShoulder" then
			return JOINT_PROFILES.RightShoulderR6
		elseif normalized == "LeftHip" then
			return JOINT_PROFILES.LeftHipR6
		elseif normalized == "RightHip" then
			return JOINT_PROFILES.RightHipR6
		end
	end

	return JOINT_PROFILES[normalized] or DEFAULT_JOINT_PROFILE
end

local function mergeOptions(options)
	local settings = table.clone(DEFAULTS)

	if type(options) == "table" then
		for key, value in pairs(options) do
			if DEFAULTS[key] ~= nil then
				settings[key] = value
			end
		end
	end

	settings.FolderName = type(settings.FolderName) == "string"
		and settings.FolderName ~= ""
		and settings.FolderName
		or DEFAULTS.FolderName

	settings.AliveCollisionGroup = type(settings.AliveCollisionGroup) == "string"
		and settings.AliveCollisionGroup ~= ""
		and settings.AliveCollisionGroup
		or DEFAULTS.AliveCollisionGroup

	settings.RagdollCollisionGroup = type(settings.RagdollCollisionGroup) == "string"
		and settings.RagdollCollisionGroup ~= ""
		and settings.RagdollCollisionGroup
		or DEFAULTS.RagdollCollisionGroup

	settings.Lifetime = tonumber(settings.Lifetime)
	if settings.Lifetime then
		settings.Lifetime = math.max(1, settings.Lifetime)
	end
	settings.InitialAngularVelocity = math.max(
		0,
		tonumber(settings.InitialAngularVelocity) or DEFAULTS.InitialAngularVelocity
	)
	settings.R6InitialAngularVelocity = math.max(
		0,
		tonumber(settings.R6InitialAngularVelocity) or DEFAULTS.R6InitialAngularVelocity
	)

	settings.MinimumFreezeDelay = math.max(
		0,
		tonumber(settings.MinimumFreezeDelay) or DEFAULTS.MinimumFreezeDelay
	)
	settings.MaximumFreezeDelay = math.max(
		settings.MinimumFreezeDelay,
		tonumber(settings.MaximumFreezeDelay) or DEFAULTS.MaximumFreezeDelay
	)
	settings.SettleDuration = math.max(
		0.05,
		tonumber(settings.SettleDuration) or DEFAULTS.SettleDuration
	)
	settings.LinearVelocityThreshold = math.max(
		0,
		tonumber(settings.LinearVelocityThreshold) or DEFAULTS.LinearVelocityThreshold
	)
	settings.AngularVelocityThreshold = math.max(
		0,
		tonumber(settings.AngularVelocityThreshold) or DEFAULTS.AngularVelocityThreshold
	)

	return settings
end

local function registerCollisionGroup(groupName)
	local success, errorMessage = pcall(function()
		PhysicsService:RegisterCollisionGroup(groupName)
	end)

	if success then
		return
	end

	local loweredMessage = string.lower(tostring(errorMessage))
	if not string.find(loweredMessage, "already exists", 1, true) then
		warnf(
			"Could not register collision group '%s': %s",
			groupName,
			tostring(errorMessage)
		)
	end
end

local function configureCollisionGroups(aliveGroup, ragdollGroup)
	registerCollisionGroup(aliveGroup)
	registerCollisionGroup(ragdollGroup)

	local success, errorMessage = pcall(function()
		PhysicsService:CollisionGroupSetCollidable(aliveGroup, aliveGroup, true)
		PhysicsService:CollisionGroupSetCollidable(aliveGroup, "Default", true)
		PhysicsService:CollisionGroupSetCollidable(ragdollGroup, aliveGroup, false)
		PhysicsService:CollisionGroupSetCollidable(ragdollGroup, ragdollGroup, false)
		PhysicsService:CollisionGroupSetCollidable(ragdollGroup, "Default", true)
	end)

	if not success then
		warnf("Could not configure collision groups: %s", tostring(errorMessage))
	end
end

local function setCollisionGroup(part, groupName)
	local success, errorMessage = pcall(function()
		part.CollisionGroup = groupName
	end)

	if not success then
		warnf(
			"Could not assign %s to collision group '%s': %s",
			part:GetFullName(),
			groupName,
			tostring(errorMessage)
		)
	end
end

local SOLID_CHARACTER_PARTS = {
	HumanoidRootPart = true,
	Head = true,
	Torso = true,
	UpperTorso = true,
	LowerTorso = true,
	LeftArm = true,
	RightArm = true,
	LeftLeg = true,
	RightLeg = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	LeftUpperArm = true,
	LeftLowerArm = true,
	LeftHand = true,
	RightUpperArm = true,
	RightLowerArm = true,
	RightHand = true,
	LeftUpperLeg = true,
	LeftLowerLeg = true,
	LeftFoot = true,
	RightUpperLeg = true,
	RightLowerLeg = true,
	RightFoot = true,
}

local function configureAliveCharacterPart(part, aliveGroup)
	if not part or not part:IsA("BasePart") then
		return
	end

	if part.Name == "PlayerCollisionBox" then
		part:Destroy()
		return
	end

	if part:FindFirstAncestorWhichIsA("Accessory")
		or part:FindFirstAncestorWhichIsA("Tool")
	then
		setCollisionGroup(part, "PlayerNoCollision")
		part.CanCollide = false
		part.CanTouch = false
		return
	end

	setCollisionGroup(part, "Default")
end

local function connectPlayer(player)
	player.CharacterAdded:Connect(function(character)
		local aliveGroup = DEFAULTS.AliveCollisionGroup
		character.DescendantAdded:Connect(function(descendant)
			if not character:GetAttribute("ServerRagdolled") then
				configureAliveCharacterPart(descendant, aliveGroup)
			end
		end)

		task.defer(function()
			if character.Parent then
				RagdollService.MarkCharacterAlive(character)
			end
		end)
	end)

	if player.Character then
		task.defer(function()
			if player.Character then
				RagdollService.MarkCharacterAlive(player.Character)
			end
		end)
	end
end

function RagdollService.Initialize()
	if initialized then
		return
	end

	initialized = true
	configureCollisionGroups(
		DEFAULTS.AliveCollisionGroup,
		DEFAULTS.RagdollCollisionGroup
	)

	Players.PlayerAdded:Connect(connectPlayer)

	for _, player in ipairs(Players:GetPlayers()) do
		connectPlayer(player)
	end
end

function RagdollService.MarkCharacterAlive(character, collisionGroupName)
	if not character or not character:IsA("Model") then
		return false
	end

	RagdollService.Initialize()

	local aliveGroup = type(collisionGroupName) == "string"
		and collisionGroupName ~= ""
		and collisionGroupName
		or DEFAULTS.AliveCollisionGroup

	registerCollisionGroup(aliveGroup)

	character:SetAttribute("ServerRagdolled", nil)
	character:SetAttribute("CreatingServerRagdoll", nil)

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.BreakJointsOnDeath = false
	end

	for _, descendant in ipairs(character:GetDescendants()) do
		configureAliveCharacterPart(descendant, aliveGroup)
	end

	return true
end

local function getRagdollFolder(folderName)
	local cachedFolder = ragdollFolders[folderName]

	if cachedFolder and cachedFolder.Parent == workspace then
		return cachedFolder
	end

	for _, child in ipairs(workspace:GetChildren()) do
		if child.Name == folderName and child:IsA("Folder") then
			ragdollFolders[folderName] = child
			return child
		end
	end

	local folder = Instance.new("Folder")
	folder.Name = folderName
	folder.Parent = workspace

	ragdollFolders[folderName] = folder
	return folder
end

local function getRagdollSyncRemote()
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local gameplay = remotes and remotes:FindFirstChild("Gameplay")

	if not gameplay then
		return nil
	end

	local existing = gameplay:FindFirstChild("RagdollSync")
	if existing and existing:IsA("RemoteEvent") then
		return existing
	end

	if existing then
		warnf("Gameplay.RagdollSync exists but is not a RemoteEvent.")
		return nil
	end

	local remote = Instance.new("RemoteEvent")
	remote.Name = "RagdollSync"
	remote.Parent = gameplay

	return remote
end

local function syncRagdollToClients(player, ragdoll, settings)
	if not settings.SyncClients then
		return
	end

	local remote = getRagdollSyncRemote()
	if remote then
		remote:FireAllClients(player.UserId, ragdoll.Name)
	end
end

local function getRelativeKey(instance, root)
	local segments = {}
	local current = instance

	while current and current ~= root do
		local parent = current.Parent
		if not parent then
			break
		end

		local occurrence = 0

		for _, sibling in ipairs(parent:GetChildren()) do
			if sibling.ClassName == current.ClassName and sibling.Name == current.Name then
				occurrence += 1
			end

			if sibling == current then
				break
			end
		end

		table.insert(
			segments,
			1,
			string.format(
				"%s|%s|%d",
				current.ClassName,
				current.Name,
				occurrence
			)
		)

		current = parent
	end

	return table.concat(segments, "/")
end

local function captureVelocities(character)
	local velocities = {}

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			velocities[getRelativeKey(descendant, character)] = {
				Linear = descendant.AssemblyLinearVelocity,
				Angular = descendant.AssemblyAngularVelocity,
			}
		end
	end

	return velocities
end

local function cloneCharacterCompletely(character)
	local originalArchivableStates = {}
	local instances = { character }

	for _, descendant in ipairs(character:GetDescendants()) do
		table.insert(instances, descendant)
	end

	for _, instance in ipairs(instances) do
		originalArchivableStates[instance] = instance.Archivable
		instance.Archivable = true
	end

	local success, result = xpcall(function()
		return character:Clone()
	end, debug.traceback)

	for instance, originalValue in pairs(originalArchivableStates) do
		if instance == character or instance.Parent then
			pcall(function()
				instance.Archivable = originalValue
			end)
		end
	end

	return success, result
end

local function isInsideModel(instance, model)
	return instance ~= nil and instance:IsDescendantOf(model)
end

local function isPhysicsActuator(instance)
	return instance:IsA("BodyMover")
		or instance:IsA("AlignPosition")
		or instance:IsA("AlignOrientation")
		or instance:IsA("LinearVelocity")
		or instance:IsA("AngularVelocity")
		or instance:IsA("VectorForce")
		or instance:IsA("Torque")
		or instance:IsA("LineForce")
		or instance:IsA("RocketPropulsion")
end

local function sanitizeExternalPhysicalLinks(model)
	local removedCount = 0

	for _, descendant in ipairs(model:GetDescendants()) do
		local shouldDestroy = false

		if isPhysicsActuator(descendant) then
			shouldDestroy = true
		elseif descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") then
			local part0 = descendant.Part0
			local part1 = descendant.Part1

			if (part0 and not isInsideModel(part0, model))
				or (part1 and not isInsideModel(part1, model))
			then
				shouldDestroy = true
			end
		elseif descendant:IsA("Constraint") then
			local attachment0 = descendant.Attachment0
			local attachment1 = descendant.Attachment1

			if (attachment0 and not isInsideModel(attachment0, model))
				or (attachment1 and not isInsideModel(attachment1, model))
			then
				shouldDestroy = true
			end
		end

		if shouldDestroy and descendant.Parent then
			removedCount += 1
			descendant:Destroy()
		end
	end

	return removedCount
end

local function removeUnsafeInstances(model)
	local removedCount = 0

	for _, descendant in ipairs(model:GetDescendants()) do
		local shouldDestroy = descendant:IsA("Script")
			or descendant:IsA("LocalScript")
			or descendant:IsA("ModuleScript")
			or descendant:IsA("Tool")
			or descendant:IsA("ForceField")
			or descendant:IsA("Animator")
			or isPhysicsActuator(descendant)

		if shouldDestroy and descendant.Parent then
			removedCount += 1
			descendant:Destroy()
		elseif descendant:IsA("ParticleEmitter")
			or descendant:IsA("Trail")
			or descendant:IsA("Beam")
		then
			descendant.Enabled = false
		end
	end

	return removedCount
end

local function getBodyNameSet(rigType)
	if rigType == Enum.HumanoidRigType.R6 then
		return R6_BODY_PARTS
	end

	return R15_BODY_PARTS
end

local function isBodyPart(part, model, bodyNameSet)
	return part.Parent == model
		and (
			bodyNameSet[part.Name]
			or part.Name == "HumanoidRootPart"
		)
end

local function isKnownGameplayObject(instance)
	local loweredName = string.lower(instance.Name)

	if KNOWN_GAMEPLAY_OBJECT_NAMES[loweredName] then
		return true
	end

	return loweredName:find("hitbox", 1, true) ~= nil
		or loweredName:find("hurtbox", 1, true) ~= nil
		or loweredName:find("damagebox", 1, true) ~= nil
end

local function hasVisiblePart(instance)
	if instance:IsA("BasePart") then
		return instance.Transparency < 0.95
	end

	for _, descendant in ipairs(instance:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Transparency < 0.95 then
			return true
		end
	end

	return false
end

local function shouldKeepTopLevelChild(child, model, bodyNameSet, settings)
	if child:IsA("Humanoid")
		or child:IsA("Accessory")
		or child:IsA("CharacterAppearance")
		or child:IsA("HumanoidDescription")
	then
		return true
	end

	if child:IsA("BasePart") and isBodyPart(child, model, bodyNameSet) then
		return true
	end

	if child:GetAttribute("KeepInRagdoll") == true
		or child:GetAttribute("RagdollCosmetic") == true
	then
		return true
	end

	if child:GetAttribute("ExcludeFromRagdoll") == true
		or child:GetAttribute("RagdollExclude") == true
		or isKnownGameplayObject(child)
	then
		return false
	end

	if settings.PreserveVisibleCustomCosmetics and hasVisiblePart(child) then
		return true
	end

	return false
end

local function stripNonAvatarObjects(model, rigType, settings)
	local bodyNameSet = getBodyNameSet(rigType)
	local removedDescriptions = {}

	for _, descendant in ipairs(model:GetDescendants()) do
		if not descendant.Parent then
			continue
		end

		if descendant:IsA("BasePart") then
			local accessory = descendant:FindFirstAncestorOfClass("Accessory")
			local standardBodyPart = isBodyPart(descendant, model, bodyNameSet)
			local explicitlyKept = descendant:GetAttribute("KeepInRagdoll") == true
				or descendant:GetAttribute("RagdollCosmetic") == true
			local explicitlyRemoved = descendant:GetAttribute("ExcludeFromRagdoll") == true
				or descendant:GetAttribute("RagdollExclude") == true
				or isKnownGameplayObject(descendant)

			local invisibleCustomPart = settings.RemoveInvisibleCustomParts
				and not accessory
				and not standardBodyPart
				and descendant.Transparency >= 0.95

			if not explicitlyKept and (explicitlyRemoved or invisibleCustomPart) then
				table.insert(
					removedDescriptions,
					string.format(
						"%s [%s]",
						descendant:GetFullName(),
						descendant.ClassName
					)
				)
				descendant:Destroy()
			end
		end
	end

	for _, child in ipairs(model:GetChildren()) do
		if child.Parent
			and not shouldKeepTopLevelChild(child, model, bodyNameSet, settings)
		then
			table.insert(
				removedDescriptions,
				string.format("%s [%s]", child:GetFullName(), child.ClassName)
			)
			child:Destroy()
		end
	end

	if settings.Debug then
		for _, description in ipairs(removedDescriptions) do
			print(
				"[RagdollService] Removed non-avatar corpse object: "
					.. description
			)
		end
	end

	return #removedDescriptions
end

local function configureCorpseHumanoid(ragdoll)
	local humanoid = ragdoll:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil
	end

	humanoid.BreakJointsOnDeath = false
	humanoid.RequiresNeck = false
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.NameDisplayDistance = 0
	humanoid.HealthDisplayDistance = 0

	if humanoid.Health <= 0 then
		humanoid.Health = math.max(1, humanoid.MaxHealth)
	end

	pcall(function()
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end)

	pcall(function()
		humanoid.EvaluateStateMachine = false
	end)

	return humanoid
end

local function collectBodyParts(model, rigType)
	local nameSet = getBodyNameSet(rigType)
	local bodyParts = {}

	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("BasePart") and nameSet[child.Name] then
			bodyParts[child] = true
		end
	end

	return bodyParts
end

local function createSocket(
	jointName,
	part0,
	part1,
	attachment0,
	attachment1,
	constraintFolder,
	rigType
)
	if not part0
		or not part1
		or not attachment0
		or not attachment1
	then
		return false
	end

	local profile = getJointProfile(jointName, rigType)

	local socket = Instance.new("BallSocketConstraint")
	socket.Name = jointName .. "_RagdollSocket"
	socket.Attachment0 = attachment0
	socket.Attachment1 = attachment1
	socket.Enabled = true
	socket.LimitsEnabled = true
	socket.UpperAngle = profile.UpperAngle
	socket.TwistLimitsEnabled = true
	socket.TwistLowerAngle = profile.TwistLowerAngle
	socket.TwistUpperAngle = profile.TwistUpperAngle
	socket.MaxFrictionTorque = 0
	socket.Restitution = 0
	socket.Parent = constraintFolder

	local noCollision = Instance.new("NoCollisionConstraint")
	noCollision.Name = jointName .. "_NoCollision"
	noCollision.Part0 = part0
	noCollision.Part1 = part1
	noCollision.Parent = constraintFolder

	return true
end

local function createConstraintFromMotor(
	motor,
	bodyParts,
	constraintFolder,
	rigType
)
	local part0 = motor.Part0
	local part1 = motor.Part1

	if not part0 or not part1 then
		motor:Destroy()
		return false
	end

	if part0.Name == "HumanoidRootPart"
		or part1.Name == "HumanoidRootPart"
	then
		motor.Enabled = false
		motor:Destroy()
		return false
	end

	if not bodyParts[part0] or not bodyParts[part1] then
		return false
	end

	local attachment0 = Instance.new("Attachment")
	attachment0.Name = motor.Name .. "_RagdollA0"
	attachment0.CFrame = motor.C0 * motor.Transform
	attachment0.Parent = part0

	local attachment1 = Instance.new("Attachment")
	attachment1.Name = motor.Name .. "_RagdollA1"
	attachment1.CFrame = motor.C1
	attachment1.Parent = part1

	local created = createSocket(
		motor.Name,
		part0,
		part1,
		attachment0,
		attachment1,
		constraintFolder,
		rigType
	)

	motor.Enabled = false
	motor:Destroy()

	return created
end

local function createConstraintFromAnimationConstraint(
	animationConstraint,
	bodyParts,
	constraintFolder,
	rigType
)
	local attachment0
	local attachment1

	local success = pcall(function()
		attachment0 = animationConstraint.Attachment0
		attachment1 = animationConstraint.Attachment1
	end)

	if not success or not attachment0 or not attachment1 then
		return false
	end

	local part0 = attachment0.Parent
	local part1 = attachment1.Parent

	if not part0
		or not part1
		or not part0:IsA("BasePart")
		or not part1:IsA("BasePart")
	then
		return false
	end

	if part0.Name == "HumanoidRootPart"
		or part1.Name == "HumanoidRootPart"
	then
		animationConstraint:Destroy()
		return false
	end

	if not bodyParts[part0] or not bodyParts[part1] then
		return false
	end

	local created = createSocket(
		animationConstraint.Name,
		part0,
		part1,
		attachment0,
		attachment1,
		constraintFolder,
		rigType
	)

	animationConstraint:Destroy()
	return created
end

local function convertCharacterJoints(
	ragdoll,
	bodyParts,
	constraintFolder,
	rigType
)
	local motors = {}
	local animationConstraints = {}

	for _, descendant in ipairs(ragdoll:GetDescendants()) do
		if descendant:IsA("Motor6D") then
			table.insert(motors, descendant)
		elseif descendant:IsA("AnimationConstraint") then
			table.insert(animationConstraints, descendant)
		end
	end

	local convertedMotorCount = 0
	local convertedAnimationCount = 0

	for _, motor in ipairs(motors) do
		if motor.Parent
			and createConstraintFromMotor(
				motor,
				bodyParts,
				constraintFolder,
				rigType
			)
		then
			convertedMotorCount += 1
		end
	end

	for _, animationConstraint in ipairs(animationConstraints) do
		if animationConstraint.Parent
			and createConstraintFromAnimationConstraint(
				animationConstraint,
				bodyParts,
				constraintFolder,
				rigType
			)
		then
			convertedAnimationCount += 1
		end
	end

	return convertedMotorCount, convertedAnimationCount
end

local function removeRemainingBodyConnections(model, bodyParts)
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("Motor6D")
			or descendant:IsA("JointInstance")
			or descendant:IsA("WeldConstraint")
		then
			local part0 = descendant.Part0
			local part1 = descendant.Part1

			if part0
				and part1
				and bodyParts[part0]
				and bodyParts[part1]
			then
				if descendant:IsA("Motor6D") then
					descendant.Enabled = false
				end

				descendant:Destroy()
			end
		elseif descendant:IsA("AnimationConstraint") then
			local attachment0
			local attachment1

			local success = pcall(function()
				attachment0 = descendant.Attachment0
				attachment1 = descendant.Attachment1
			end)

			local part0 = success and attachment0 and attachment0.Parent
			local part1 = success and attachment1 and attachment1.Parent

			if part0
				and part1
				and bodyParts[part0]
				and bodyParts[part1]
			then
				descendant:Destroy()
			end
		end
	end
end

local function removeRootPart(ragdoll)
	local rootPart = ragdoll:FindFirstChild("HumanoidRootPart")

	if not rootPart or not rootPart:IsA("BasePart") then
		return
	end

	for _, descendant in ipairs(ragdoll:GetDescendants()) do
		if descendant:IsA("JointInstance")
			or descendant:IsA("WeldConstraint")
		then
			if descendant.Part0 == rootPart or descendant.Part1 == rootPart then
				descendant:Destroy()
			end
		elseif descendant:IsA("Constraint") then
			local attachment0 = descendant.Attachment0
			local attachment1 = descendant.Attachment1

			if (attachment0 and attachment0:IsDescendantOf(rootPart))
				or (attachment1 and attachment1:IsDescendantOf(rootPart))
			then
				descendant:Destroy()
			end
		end
	end

	rootPart:Destroy()
end

local function configureParts(ragdoll, bodyParts, settings)
	for _, descendant in ipairs(ragdoll:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
			descendant.CanTouch = not settings.DisableCorpseTouch
			descendant.CanQuery = not settings.DisableCorpseQueries

			setCollisionGroup(
				descendant,
				settings.RagdollCollisionGroup
			)

			if bodyParts[descendant] then
				descendant.CanCollide = true
				descendant.Massless = false
			else
				descendant.CanCollide = false
				descendant.Massless = true
			end
		end
	end
end

local function setServerOwnership(part)
	local success, canSetOwnership = pcall(function()
		return part:CanSetNetworkOwnership()
	end)

	if success and canSetOwnership then
		pcall(function()
			part:SetNetworkOwner(nil)
		end)

		part:SetAttribute("ServerPhysicsOwned", true)
	end
end

local function forceServerOwnership(model)
	if not model or not model.Parent then
		return
	end

	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("BasePart") and not descendant.Anchored then
			setServerOwnership(descendant)
		end
	end
end

local function randomDirection()
	local direction = Vector3.new(
		randomGenerator:NextNumber(-1, 1),
		randomGenerator:NextNumber(-1, 1),
		randomGenerator:NextNumber(-1, 1)
	)

	if direction.Magnitude < 0.05 then
		return Vector3.new(0.4, 0.8, -0.3).Unit
	end

	return direction.Unit
end

local function applyPhysics(
	ragdoll,
	bodyParts,
	velocities,
	rigType,
	settings
)
	local angularTarget = if rigType == Enum.HumanoidRigType.R6
		then settings.R6InitialAngularVelocity
		else settings.InitialAngularVelocity

	for _, descendant in ipairs(ragdoll:GetDescendants()) do
		if not descendant:IsA("BasePart") or descendant.Anchored then
			continue
		end

		local savedVelocity = velocities[getRelativeKey(descendant, ragdoll)]

		if savedVelocity then
			descendant.AssemblyLinearVelocity = savedVelocity.Linear
			descendant.AssemblyAngularVelocity = savedVelocity.Angular
		end

		local isTorso = descendant.Name == "Torso"
			or descendant.Name == "UpperTorso"
			or descendant.Name == "LowerTorso"

		if bodyParts[descendant] and not isTorso then
			local currentAngularVelocity =
				descendant.AssemblyAngularVelocity

			local currentMagnitude = currentAngularVelocity.Magnitude

			if currentMagnitude < angularTarget then
				local missingVelocity =
					angularTarget - currentMagnitude

				descendant.AssemblyAngularVelocity +=
					randomDirection() * missingVelocity
			end
		end
	end
	
	if settings.ServerOwned then
		forceServerOwnership(ragdoll)
	end
end

local function hideOriginalCharacter(character)
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 1
			descendant.CanCollide = false
			descendant.CanTouch = false
			descendant.CanQuery = false
			descendant.CastShadow = false
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant.Transparency = 1
		elseif descendant:IsA("ParticleEmitter")
			or descendant:IsA("Trail")
			or descendant:IsA("Beam")
		then
			descendant.Enabled = false
		end
	end
end

local function freezeCorpse(ragdoll, settings, reason)
	if not ragdoll
		or not ragdoll.Parent
		or ragdoll:GetAttribute("Frozen")
	then
		return false
	end

	if settings.ServerOwned then
		forceServerOwnership(ragdoll)
	end

	for _, descendant in ipairs(ragdoll:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
			descendant.Anchored = true
			descendant.CanCollide = false
			descendant.CanTouch = false
			descendant.CanQuery = false
		end
	end

	if settings.DisableConstraintsWhenFrozen then
		local constraintFolder = ragdoll:FindFirstChild(
			"RagdollConstraints"
		)

		if constraintFolder then
			for _, descendant in ipairs(
				constraintFolder:GetDescendants()
				) do
				if descendant:IsA("Constraint") then
					descendant.Enabled = false
				end
			end
		end
	end

	ragdoll:SetAttribute("Frozen", true)
	ragdoll:SetAttribute("FreezeReason", reason or "Unknown")
	ragdoll:SetAttribute(
		"FrozenAt",
		workspace:GetServerTimeNow()
	)

	debugf(
		settings,
		"Froze %s | Reason=%s",
		ragdoll.Name,
		tostring(reason)
	)

	return true
end

function RagdollService.Freeze(ragdoll, reason)
	if not ragdoll or not ragdoll:IsA("Model") then
		return false
	end

	local settings = corpseSettings[ragdoll] or DEFAULTS
	return freezeCorpse(ragdoll, settings, reason or "Manual")
end

local function scheduleCorpseFreeze(ragdoll, bodyParts, settings)
	if not settings.FreezeWhenSettled then
		return
	end

	task.spawn(function()
		local startedAt = os.clock()
		local settledSince = nil

		while ragdoll.Parent and not ragdoll:GetAttribute("Frozen") do
			RunService.Heartbeat:Wait()

			local elapsed = os.clock() - startedAt

			if elapsed >= settings.MaximumFreezeDelay then
				freezeCorpse(ragdoll, settings, "MaximumDelay")
				return
			end

			if elapsed < settings.MinimumFreezeDelay then
				continue
			end

			local maxLinearSpeed = 0
			local maxAngularSpeed = 0
			local hasMovingBodyPart = false

			for bodyPart in pairs(bodyParts) do
				if bodyPart.Parent and not bodyPart.Anchored then
					hasMovingBodyPart = true

					maxLinearSpeed = math.max(
						maxLinearSpeed,
						bodyPart.AssemblyLinearVelocity.Magnitude
					)

					maxAngularSpeed = math.max(
						maxAngularSpeed,
						bodyPart.AssemblyAngularVelocity.Magnitude
					)
				end
			end

			if not hasMovingBodyPart then
				return
			end

			local isSettled =
				maxLinearSpeed <= settings.LinearVelocityThreshold
				and maxAngularSpeed
				<= settings.AngularVelocityThreshold

			if isSettled then
				settledSince = settledSince or os.clock()

				if os.clock() - settledSince
					>= settings.SettleDuration
				then
					freezeCorpse(ragdoll, settings, "Settled")
					return
				end
			else
				settledSince = nil
			end
		end
	end)
end

local function countAppearanceObjects(model)
	local count = 0

	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("CharacterAppearance")
			or descendant:IsA("Accessory")
		then
			count += 1
		end
	end

	return count
end

local function selectPrimaryPart(ragdoll)
	local torso = ragdoll:FindFirstChild("LowerTorso")
		or ragdoll:FindFirstChild("Torso")
		or ragdoll:FindFirstChild("UpperTorso")
		or ragdoll:FindFirstChild("Head")

	if torso and torso:IsA("BasePart") then
		ragdoll.PrimaryPart = torso
	end
end

local function createCorpseName(player)
	local compactGuid = HttpService:GenerateGUID(false):gsub("%-", "")

	return string.format(
		"ServerCorpse_%d_%s",
		player.UserId,
		compactGuid:sub(1, 10)
	)
end

local function setCorpseAttributes(
	ragdoll,
	player,
	rigType,
	settings
)
	ragdoll:SetAttribute("VictimName", player.Name)
	ragdoll:SetAttribute("VictimUserId", player.UserId)
	ragdoll:SetAttribute("RigType", rigType.Name)
	ragdoll:SetAttribute("CreatedAt", workspace:GetServerTimeNow())
	ragdoll:SetAttribute("ServerCreated", true)
	ragdoll:SetAttribute(
		"ServerPhysicsOwned",
		settings.ServerOwned == true
	)
	ragdoll:SetAttribute("Frozen", false)
end

local function cleanupFailedCreation(character, ragdoll, errorMessage)
	if character and character.Parent then
		character:SetAttribute("CreatingServerRagdoll", nil)
		character:SetAttribute("ServerRagdolled", nil)
	end

	if ragdoll and ragdoll.Parent then
		ragdoll:Destroy()
	end

	warnf("Ragdoll creation failed: %s", tostring(errorMessage))
end

function RagdollService.GetLatestCorpse(playerOrUserId)
	local userId

	if typeof(playerOrUserId) == "Instance"
		and playerOrUserId:IsA("Player")
	then
		userId = playerOrUserId.UserId
	else
		userId = tonumber(playerOrUserId)
	end

	if not userId then
		return nil
	end

	local corpse = activeCorpses[userId]

	if corpse and corpse.Parent then
		return corpse
	end

	activeCorpses[userId] = nil
	return nil
end

function RagdollService.DestroyCorpse(playerOrCorpse)
	local corpse

	if typeof(playerOrCorpse) == "Instance"
		and playerOrCorpse:IsA("Model")
	then
		corpse = playerOrCorpse
	else
		corpse = RagdollService.GetLatestCorpse(playerOrCorpse)
	end

	if not corpse then
		return false
	end

	corpse:Destroy()
	return true
end

function RagdollService.Create(player, sourceHumanoid, options)
	if not player or not player:IsA("Player") then
		return nil
	end

	if not sourceHumanoid or not sourceHumanoid:IsA("Humanoid") then
		return nil
	end

	local character = player.Character

	if not character or sourceHumanoid.Parent ~= character then
		return nil
	end

	if character:GetAttribute("ServerRagdolled")
		or character:GetAttribute("CreatingServerRagdoll")
	then
		return nil
	end

	local settings = mergeOptions(options)
	local rigType = sourceHumanoid.RigType
	local ragdoll

	RagdollService.Initialize()
	configureCollisionGroups(
		settings.AliveCollisionGroup,
		settings.RagdollCollisionGroup
	)

	character:SetAttribute("CreatingServerRagdoll", true)

	local creationSuccess, creationResult = xpcall(function()
		local sourcePivot = character:GetPivot()
		local velocities = captureVelocities(character)
		local sourceAppearanceCount = countAppearanceObjects(character)

		local cloneSuccess, cloneOrError =
			cloneCharacterCompletely(character)

		if not cloneSuccess or not cloneOrError then
			error(
				("Failed to clone %s's character: %s"):format(
					player.Name,
					tostring(cloneOrError)
				)
			)
		end

		ragdoll = cloneOrError
		ragdoll.Name = createCorpseName(player)

		setCorpseAttributes(
			ragdoll,
			player,
			rigType,
			settings
		)

		local removedNonAvatarCount = 0

		if settings.RemoveNonAvatarObjects then
			removedNonAvatarCount = stripNonAvatarObjects(
				ragdoll,
				rigType,
				settings
			)
		end

		local removedExternalLinkCount =
			sanitizeExternalPhysicalLinks(ragdoll)
		local removedUnsafeCount = removeUnsafeInstances(ragdoll)

		configureCorpseHumanoid(ragdoll)

		local bodyParts = collectBodyParts(ragdoll, rigType)

		if next(bodyParts) == nil then
			error(
				("No valid %s body parts were found in %s's clone."):format(
					rigType.Name,
					player.Name
				)
			)
		end

		local constraintFolder = Instance.new("Folder")
		constraintFolder.Name = "RagdollConstraints"
		constraintFolder.Parent = ragdoll

		local convertedMotorCount, convertedAnimationCount =
			convertCharacterJoints(
				ragdoll,
				bodyParts,
				constraintFolder,
				rigType
			)

		removeRootPart(ragdoll)
		removeRemainingBodyConnections(ragdoll, bodyParts)
		configureParts(ragdoll, bodyParts, settings)
		selectPrimaryPart(ragdoll)

		ragdoll.Parent = getRagdollFolder(settings.FolderName)

		pcall(function()
			ragdoll.ModelStreamingMode =
				Enum.ModelStreamingMode.Persistent
		end)

		ragdoll:PivotTo(sourcePivot)

		applyPhysics(
			ragdoll,
			bodyParts,
			velocities,
			rigType,
			settings
		)

		activeCorpses[player.UserId] = ragdoll
		corpseSettings[ragdoll] = settings

		ragdoll.Destroying:Connect(function()
			if activeCorpses[player.UserId] == ragdoll then
				activeCorpses[player.UserId] = nil
			end

			corpseSettings[ragdoll] = nil
		end)

		local syncSuccess, syncError = pcall(function()
			syncRagdollToClients(player, ragdoll, settings)
		end)

		if not syncSuccess then
			warnf(
				"Could not synchronize %s to clients: %s",
				ragdoll.Name,
				tostring(syncError)
			)
		end

		scheduleCorpseFreeze(ragdoll, bodyParts, settings)

		task.defer(function()
			RunService.Heartbeat:Wait()

			if not ragdoll.Parent
				or ragdoll:GetAttribute("Frozen")
			then
				return
			end

			configureParts(ragdoll, bodyParts, settings)
			applyPhysics(
				ragdoll,
				bodyParts,
				velocities,
				rigType,
				settings
			)
		end)

		local corpseAppearanceCount =
			countAppearanceObjects(ragdoll)

		if corpseAppearanceCount < sourceAppearanceCount then
			warnf(
				"Corpse appearance count is lower than the source for %s (%d -> %d)",
				player.Name,
				sourceAppearanceCount,
				corpseAppearanceCount
			)
		end

		if convertedMotorCount == 0
			and convertedAnimationCount == 0
		then
			warnf(
				"No Motor6Ds or AnimationConstraints were converted for %s. The rig may use custom welds.",
				player.Name
			)
		end

		debugf(
			settings,
			"%s | Rig=%s | Motors=%d | AnimationConstraints=%d | Appearance=%d | NonAvatarRemoved=%d | UnsafeRemoved=%d | ExternalLinksRemoved=%d",
			ragdoll.Name,
			rigType.Name,
			convertedMotorCount,
			convertedAnimationCount,
			corpseAppearanceCount,
			removedNonAvatarCount,
			removedUnsafeCount,
			removedExternalLinkCount
		)

		if settings.Lifetime then
			Debris:AddItem(ragdoll, settings.Lifetime)
		end

		if settings.HideOriginalCharacter then
			hideOriginalCharacter(character)
		end

		character:SetAttribute("ServerRagdolled", true)
		character:SetAttribute("CreatingServerRagdoll", nil)

		return ragdoll
	end, debug.traceback)

	if not creationSuccess then
		cleanupFailedCreation(
			character,
			ragdoll,
			creationResult
		)
		return nil
	end

	return creationResult
end

RagdollService.Initialize()

return RagdollService