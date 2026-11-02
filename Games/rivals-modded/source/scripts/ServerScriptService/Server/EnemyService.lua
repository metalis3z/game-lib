-- The Shooting Range's targets and dummies, replicated as "Enemy" objects (the client's
-- EnemyController builds them with the ClientEntity classes).
--
-- Every model in Workspace.ShootingRangeEntities (tagged Entity) becomes one object:
--
--   Target     -> ClientDestructable   health in the model's Health / MaxHealth attributes
--   Dummy      -> ClientEnemy          health is the Humanoid's
--   DPS Dummy  -> ClientDPSDummy       same, plus RegisterDPS(damage) for its damage counter
--
-- The client reads Model, RootPart and Humanoid from the top of the serial (outside Data),
-- and ClientReplicatedClassType picks the class, so objects here serialize those too.
-- Damage goes through EnemyService.Damage; broken targets and beaten dummies come back.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))

local ReplicatedCollection = require(script.Parent.ReplicatedCollection)

local FOLDER_NAME = "ShootingRangeEntities"
local CLASS_BY_NAME = {
	Target = "ClientDestructable",
	Dummy = "ClientEnemy",
	["DPS Dummy"] = "ClientDPSDummy",
}
local TARGET_RESPAWN_SECONDS = 3
-- A beaten dummy ragdolls (the game's default "Ragdoll" finisher, played on the server so every
-- client sees the same body), lies there -- the finisher anchors it and makes it non-colliding
-- after 3s -- and is then replaced by a fresh copy. 7s is what the gun game place used.
local DUMMY_RESPAWN_SECONDS = 7
local DEATH_FINISHER = "Ragdoll"

local EnemyService = {}

local collection = nil
local byModel: { [Model]: any } = {}
-- [dummy model] = an untouched copy, taken the first time it registers. A ragdoll destroys the
-- rig's Motor6Ds and a Humanoid that died can't be brought back, so a beaten dummy is replaced by
-- a clone of this rather than healed in place.
local templates: { [Model]: Model } = {}

-- The finisher classes require ServerStorage.Services.CollisionsService on the server; loaded on
-- first use so a problem there can only cost the death animation, never the range.
local finisherClasses = {}
local function finisherClass(name: string)
	if finisherClasses[name] == nil then
		local ok, class = pcall(function()
			return require(Modules:WaitForChild("Finishers"):WaitForChild(name))
		 end)
		if not ok then
			warn("[Enemies] finisher " .. name .. " failed to load: " .. tostring(class))
		end
		finisherClasses[name] = ok and class or false
	end
	return finisherClasses[name] or nil
end

local function serialize(self)
	return self:_EncodeSerial({
		ClientReplicatedClassType = self._client_class,
		Data = self:_SerializeData(),
		Model = self._model,
		RootPart = self._root,
		Humanoid = self._humanoid,
	})
end

local health

-- What GameplayUtility (shared with the client) asks of an entity when it resolves hits:
-- its EntityHitbox-tagged parts (IsSmallHitbox ones apart), whether it is alive, and
-- Get("EnvironmentID") / Get("TeamID") through ReplicatedClass.
local CollectionService = game:GetService("CollectionService")

local function getHitboxes(self, small: boolean?)
	if not self._hitboxes then
		self._hitboxes, self._hitboxes_small = {}, {}
		for _, part in self._model:GetDescendants() do
			if part:IsA("BasePart") and CollectionService:HasTag(part, "EntityHitbox") then
				table.insert(part:GetAttribute("IsSmallHitbox") and self._hitboxes_small or self._hitboxes, part)
			end
		end
	end
	return small and #self._hitboxes_small > 0 and self._hitboxes_small or self._hitboxes
end

local function isAlive(self): boolean
	return not self._respawning and health(self) > 0
end

-- Roblox's own R15 idle and run: they play in any place. Replaceable per place through
-- ServerStorage.AnimationOverrides (Dummy_Idle / Dummy_Run).
local AnimationOverrides = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("AnimationOverrides"))
local DEFAULT_IDLE_ANIMATION = "rbxassetid://507766388"
local DEFAULT_RUN_ANIMATION = "rbxassetid://913376220"

local function register(model: Model)
	local clientClass = CLASS_BY_NAME[model.Name]
	if not clientClass or byModel[model] then
		return
	end

	local humanoid = model:FindFirstChildOfClass("Humanoid")
	local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)

	local object = ReplicatedClass.new()
	object._client_class = clientClass
	object._model = model
	object._root = root
	object._humanoid = humanoid
	object.Model = model
	object.RootPart = root
	object.Serialize = serialize
	object.GetHitboxes = getHitboxes
	object.IsAlive = isAlive
	object:Set("EnvironmentID", model:GetAttribute("EnvironmentID"))
	-- ClientEnemy plays these on the dummy (idle always, run while it moves).
	if humanoid then
		object:Set("IdleAnimation", AnimationOverrides.Get("Dummy_Idle", DEFAULT_IDLE_ANIMATION))
		object:Set("RunAnimation", AnimationOverrides.Get("Dummy_Run", DEFAULT_RUN_ANIMATION))
	end

	-- Start whole: the dump caught some mid-fight (a target at Health -9).
	if humanoid then
		humanoid.Health = humanoid.MaxHealth
	elseif model:GetAttribute("MaxHealth") then
		model:SetAttribute("Health", model:GetAttribute("MaxHealth"))
	end

	if humanoid and not templates[model] then
		local ok, copy = pcall(model.Clone, model)
		if ok and copy then
			templates[model] = copy
		end
	end

	byModel[model] = object
	collection:Add(object)
end

-- The dummy's death: the game's own Ragdoll finisher does the work on the server (Motor6Ds become
-- BallSocketConstraints, then _AnchorModel pins the body and puts it in Noclip after 3s), and the
-- clients get the same "FinisherEffect" the live server sent (ClientEntity._PlayFinisher builds the
-- finisher and runs its PlayClient -- empty for Ragdoll, but it keeps other finishers possible).
local function playDeath(object, attacker: Player?)
	local humanoid = object._humanoid
	if not humanoid or not humanoid.Parent then
		return
	end
	local Finisher = finisherClass(DEATH_FINISHER)
	if not Finisher then
		return
	end
	local ok, err = pcall(function()
		-- A ragdoll breaks the neck joint; RequiresNeck would keep re-killing the Humanoid.
		humanoid.RequiresNeck = false
		local finisher = Finisher.new(humanoid, false, attacker)
		finisher:PlayServer()
		object._finisher = finisher
		local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
		local code = EnumLibrary:ToEnum(DEATH_FINISHER)
		if code then
			object.ReplicateToClient:Fire("FinisherEffect", code, false, attacker, finisher:Serialize())
		end
	end)
	if not ok then
		warn("[Enemies] death finisher failed: " .. tostring(err))
	end
end

function EnemyService.Get(model: Instance)
	return byModel[model]
end

-- GameplayUtility calls EnemyService:GetEnemy(model) (method style) on the server.
function EnemyService.GetEnemy(_self, model: Instance)
	return byModel[model]
end

function EnemyService.GetFromPart(part: Instance)
	local model = part and part:FindFirstAncestorWhichIsA("Model")
	while model do
		if byModel[model] then
			return byModel[model], model
		end
		model = model:FindFirstAncestorWhichIsA("Model")
	end
	return nil
end

function health(object): (number, number)
	if object._humanoid then
		return object._humanoid.Health, object._humanoid.MaxHealth
	end
	local model = object._model
	return tonumber(model:GetAttribute("Health")) or 0, tonumber(model:GetAttribute("MaxHealth")) or 1
end

local function setHealth(object, value: number)
	if object._humanoid then
		object._humanoid.Health = value
	else
		object._model:SetAttribute("Health", value)
	end
end

-- A client marks an entity dead for good on "Died", so coming back is a fresh object for the
-- same model: removed, healed, registered again.
local function respawn(object, delaySeconds: number)
	object._respawning = true
	task.delay(delaySeconds, function()
		local model = object._model
		local parent = model.Parent
		collection:Remove(object)
		byModel[model] = nil
		if object._finisher then
			pcall(object._finisher.Destroy, object._finisher)
			object._finisher = nil
		end
		object:Destroy()

		-- A dummy comes back as a fresh copy of itself (the folder's ChildAdded registers it).
		local template = templates[model]
		if template and parent then
			templates[model] = nil
			local fresh = template:Clone()
			templates[fresh] = template
			model:Destroy()
			fresh.Parent = parent
			return
		end

		if model.Parent then
			register(model)
		end
	end)
end

-- Deals damage to a range entity. Returns the damage actually dealt and whether it died.
function EnemyService.Damage(model: Model, amount: number, _attacker: Player?, headshot: boolean?): (number, boolean)
	local object = byModel[model]
	if not object or object._respawning or amount <= 0 then
		return 0, false
	end

	local current = health(object)
	if current <= 0 then
		return 0, false
	end

	local dealt = math.min(amount, current)
	setHealth(object, current - dealt)

	-- ClientEntity._HurtEffect reads { ["\0"] = damage, ["\1"] = headshot }.
	object.ReplicateToClient:Fire("HurtEffect", { [utf8.char(0)] = dealt, [utf8.char(1)] = headshot == true })
	if object._client_class == "ClientDPSDummy" then
		object.ReplicateToClient:Fire("RegisterDPS", amount)
	end

	if current - dealt <= 0 then
		playDeath(object, _attacker)
		object.ReplicateToClient:Fire("Died")
		respawn(object, object._humanoid and DUMMY_RESPAWN_SECONDS or TARGET_RESPAWN_SECONDS)
		return dealt, true
	end

	return dealt, false
end

function EnemyService.Start()
	collection = ReplicatedCollection.new("Enemy")
	EnemyService.Collection = collection

	local folder = workspace:FindFirstChild(FOLDER_NAME)
	if not folder then
		warn("[Enemies] Workspace." .. FOLDER_NAME .. " is missing")
		return
	end

	for _, model in folder:GetChildren() do
		if model:IsA("Model") then
			register(model)
		end
	end
	folder.ChildAdded:Connect(function(model)
		if model:IsA("Model") then
			register(model)
		end
	end)

	-- In Studio, ServerStorage.EnemyDebug (BindableFunction), like DuelService's DuelDebug:
	--   Invoke("Hurt", modelName?, damage?, playerName?)  the entity of that name nearest the player
	--   ("Dummy" by default) takes damage through EnemyService.Damage -- a big number kills it.
	if game:GetService("RunService"):IsStudio() then
		local old = game:GetService("ServerStorage"):FindFirstChild("EnemyDebug")
		if old then
			old:Destroy()
		end
		local debug = Instance.new("BindableFunction")
		debug.Name = "EnemyDebug"
		debug.OnInvoke = function(action: string, name: any, value: any, playerName: any)
			if action ~= "Hurt" then
				return "unknown action"
			end
			local Players = game:GetService("Players")
			local player = playerName and Players:FindFirstChild(playerName) or Players:GetPlayers()[1]
			local from = player and player.Character and player.Character:GetPivot().Position or Vector3.zero
			local best, bestDistance
			for model, object in byModel do
				if model.Name == (name or "Dummy") and not object._respawning then
					local distance = (model:GetPivot().Position - from).Magnitude
					if not bestDistance or distance < bestDistance then
						best, bestDistance = model, distance
					end
				end
			end
			if not best then
				return "no " .. tostring(name or "Dummy")
			end
			local dealt, killed = EnemyService.Damage(best, tonumber(value) or 1e6, player, false)
			return string.format("%s at %.0f studs: dealt=%s killed=%s", best:GetFullName(), bestDistance, tostring(dealt), tostring(killed))
		end
		debug.Parent = game:GetService("ServerStorage")
	end
end

return EnemyService
