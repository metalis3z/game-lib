--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PhysicsService = game:GetService("PhysicsService")

local Network = require(script.Parent.Core_Network)
local SharedGuardComponent = require(ReplicatedStorage.Library.Modules.GuardAreas.GuardComponent)
local GuardDirectory = require(ReplicatedStorage.Directory.Guards)
local CollisionGroups = require(ReplicatedStorage.Library.Types.CollisionGroups)

local Guards = {}
local Eggs
local components: {[string]: any} = {}
local registeredAreaByUid: {[string]: string} = {}
local accumulator = 0

local function isInsideXZ(bounds: BasePart, position: Vector3): boolean
	local localPosition = bounds.CFrame:PointToObjectSpace(position)
	local half = bounds.Size * 0.5
	return math.abs(localPosition.X) <= half.X + 3 and math.abs(localPosition.Z) <= half.Z + 3
end

local function clearRegistration(uid: string)
	local areaId = registeredAreaByUid[uid]
	if not areaId then
		return
	end
	registeredAreaByUid[uid] = nil
	local component = components[areaId]
	if component then
		pcall(function()
			component:ClearStolenEgg(uid)
		end)
	end
end

local function syncRecord(record)
	clearRegistration(record.Uid)
	if record.State ~= "Carried" or record.AreaId == "Forest" or not record.CarrierUserId then
		return
	end
	local component = components[record.AreaId]
	local player = Players:GetPlayerByUserId(record.CarrierUserId)
	if not component or not player then
		return
	end
	local ok, registered = pcall(function()
		return component:RegisterStolenEgg(player, record.Uid)
	end)
	if ok and registered ~= false then
		registeredAreaByUid[record.Uid] = record.AreaId
	elseif not ok then
		warn(("[Guards] Failed to register %s thief: %s"):format(record.AreaId, tostring(registered)))
	end
end

local function setupServerGuard(area: Model, ground: BasePart)
	if components[area.Name] then
		return
	end
	local guardModel = area:FindFirstChild("Guard")
	if guardModel and guardModel:IsA("Model") then
		local collider = guardModel:FindFirstChild("Collider", true)
		if collider and collider:IsA("BasePart") then
			collider.CanCollide = false
		end
	end
	if area.Name == "Forest" then
		return
	end
	local bounds = area:FindFirstChild("Bounds")
	local config = GuardDirectory.Directory[area.Name]
	if not guardModel or not guardModel:IsA("Model") or not bounds or not bounds:IsA("BasePart") or not config then
		warn(("[Guards] Area %s is missing Guard, Bounds, or config"):format(area.Name))
		return
	end

	local component
	local ok, err = xpcall(function()
		component = SharedGuardComponent.new(
			area.Name,
			guardModel,
			bounds,
			ground,
			config,
			function(player)
				return Eggs.IsPlayerCarryingFromArea(player, area.Name)
			end,
			{
				ServerOwnsPhysics = true,
				Attack = function(payload)
					if payload.EggUid then
						Eggs.GuardHit(payload.Player, payload.EggUid, payload.GuardRoot.CFrame)
					end
				end,
				Wake = function(model)
					Network.FireAll("Guards: WakeUp", model)
				end,
			}
		)
	end, debug.traceback)
	if not ok then
		warn(("[Guards] Failed to initialize %s guard: %s"):format(area.Name, tostring(err)))
		return
	end
	components[area.Name] = component
end

function Guards.Init(eggService)
	Eggs = eggService
	pcall(function()
		PhysicsService:RegisterCollisionGroup(CollisionGroups.GUARD_COLLISION_GROUP)
	end)
	pcall(function()
		PhysicsService:RegisterCollisionGroup(CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP)
	end)
	PhysicsService:CollisionGroupSetCollidable(
		CollisionGroups.GUARD_COLLISION_GROUP,
		CollisionGroups.GUARD_COLLISION_GROUP,
		false
	)
	PhysicsService:CollisionGroupSetCollidable(
		CollisionGroups.GUARD_COLLISION_GROUP,
		CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP,
		false
	)
	PhysicsService:CollisionGroupSetCollidable(
		"Default",
		CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP,
		true
	)
	pcall(function()
		PhysicsService:CollisionGroupSetCollidable(
			CollisionGroups.PLAYER_COLLISION_GROUP,
			CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP,
			true
		)
	end)

	local objects = Workspace:WaitForChild("__OBJECTS")
	local areas = objects:WaitForChild("Areas")
	local function assignResetWallCollisionGroup(instance: Instance)
		if instance:IsA("BasePart") then
			instance.CollisionGroup = CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP
		end
		for _, descendant in ipairs(instance:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.CollisionGroup = CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP
			end
		end
		instance.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("BasePart") then
				descendant.CollisionGroup = CollisionGroups.AREA_RESET_WALL_COLLISION_GROUP
			end
		end)
	end
	for _, wallName in ipairs({"WallStartVisual", "WallStartCollision"}) do
		local wall = areas:FindFirstChild(wallName)
		if wall then
			assignResetWallCollisionGroup(wall)
		end
	end
	local guardAreas = areas:WaitForChild("GuardAreas")
	local ground = areas:WaitForChild("Ground")
	assert(guardAreas:IsA("Folder"), "GuardAreas must be a Folder")
	assert(ground:IsA("BasePart"), "Areas.Ground must be a BasePart")

	for _, area in ipairs(guardAreas:GetChildren()) do
		if area:IsA("Model") then
			setupServerGuard(area, ground)
		end
	end
	guardAreas.ChildAdded:Connect(function(area)
		if area:IsA("Model") then
			task.defer(setupServerGuard, area, ground)
		end
	end)

	Eggs.AreaChanged.Event:Connect(function(kind, value)
		if kind == "Updated" and typeof(value) == "table" then
			syncRecord(value)
		elseif kind == "Removed" and typeof(value) == "string" then
			clearRegistration(value)
		end
	end)
	for _, record in ipairs(Eggs.GetAreaRecords()) do
		syncRecord(record)
	end

	Network.BindEvent("Guards: ForestHit", function(player, request)
		if typeof(request) ~= "table" or typeof(request.EggUid) ~= "string" or typeof(request.GuardCFrame) ~= "CFrame" then
			return
		end
		local record = Eggs.GetAreaRecord(request.EggUid)
		if not record or record.AreaId ~= "Forest" or record.State ~= "Carried" or record.CarrierUserId ~= player.UserId then
			return
		end
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local forest = guardAreas:FindFirstChild("Forest")
		local bounds = forest and forest:FindFirstChild("Bounds")
		if not root or not root:IsA("BasePart") or not bounds or not bounds:IsA("BasePart") then
			return
		end
		if (root.Position - request.GuardCFrame.Position).Magnitude > 14 or not isInsideXZ(bounds, request.GuardCFrame.Position) then
			return
		end
		Eggs.GuardHit(player, request.EggUid, request.GuardCFrame)
	end)

	Network.BindEvent("Guards: ForestDeposit", function(player, request)
		if typeof(request) ~= "table" or typeof(request.EggUid) ~= "string" then
			return
		end
		if request.Kind ~= "Attached" and request.Kind ~= "Deposited" then
			return
		end
		local ownerId = tonumber(string.match(request.EggUid, "^FirstAreaEgg_(-?%d+)_"))
		local record = Eggs.GetAreaRecord(request.EggUid)
		if ownerId ~= player.UserId or not record or record.AreaId ~= "Forest" then
			return
		end
		if request.Kind == "Attached" then
			Eggs.MarkGuardCarried(request.EggUid)
		else
			Eggs.ResetAreaEgg(request.EggUid)
		end
	end)

	RunService.Heartbeat:Connect(function(delta)
		accumulator += delta
		if accumulator < 0.05 then
			return
		end
		accumulator = 0
		local now = os.clock()
		for areaId, component in pairs(components) do
			local ok, err = xpcall(function()
				component:Step(now)
			end, debug.traceback)
			if not ok then
				warn(("[Guards] %s guard step failed: %s"):format(areaId, tostring(err)))
			end
		end
	end)
end

return Guards
