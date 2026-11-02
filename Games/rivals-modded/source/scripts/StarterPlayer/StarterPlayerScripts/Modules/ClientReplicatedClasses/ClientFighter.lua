-- A fighter as the client sees it: one per player, replicated by the server through
-- Remotes.Replication.Fighter (see Modules.ReplicatedController).
--
-- The original was obfuscated (the untouched source is in ServerStorage.ObfuscatedOriginals)
-- and did not compile once decompiled. This version covers what the lobby reads:
--
--   :Get(field) / :GetDataChangedSignal(field)   (ReplicatedClass)  IsInDuel, IsInShootingRange,
--                                                 IsSpectating, ThirdPersonOverride, DecodedNetworkID...
--   .Player, .IsLocalPlayer                       FighterController:GetFighter / WaitForLocalFighter
--   .Entity, .EntityAdded, .EntityRemoved         the character (ClientFighterCharacter)
--   .Died, .ItemAdded, .EquippedItemChanged...    see SIGNALS
--   :Update(dt), :IsAlive(), :GetHealth()         SpectateController / EmoteController
--
-- Weapons (fighter changes, see the server's ItemService):
--   .Items (by slot order), .EquippedItem, :GetItem(objectID)
--   :EquipItem(slot, fromQuickAttack) / :EquipIncrement(step)    MechanicsController, hotbar
--   :Input(action, ...)                                          -> EquippedItem:Input
--   :QuickAttackDown(kind) / :QuickAttackUp(kind)                QuickAttackSystem
--   :GetCameraData(whitelist?, spread?, raw?)   what a shot aims at: { ["\0"] = origin, ["\1"] = camera,
--                                         ["\2"] = part hit?, ["\3"] = offset on it? }, raycast;
--                                         CFrames are Utility:EncodeCFrame'd (for the server)
--                                         unless raw
--   .FighterInterface                     the HUD (health, hotbar, ammo) while this fighter is
--                                         the one being watched (IsSpectating)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))
local Signal = require(Modules:WaitForChild("Signal"))

-- Required on first use: it pulls in the fighter interface and other controllers.
local ClientFighterCharacter = nil
local function characterClass()
	ClientFighterCharacter = ClientFighterCharacter or require(script:WaitForChild("ClientFighterCharacter"))
	return ClientFighterCharacter
end

local ClientFighter = setmetatable({}, ReplicatedClass)
ClientFighter.__index = ClientFighter

-- Signals the readable client connects to on a fighter. Died and HealthChanged come from the
-- character (see _SetEntity); some of the rest never fire yet.
local SIGNALS = {
	"EntityAdded",
	"EntityRemoved",
	"Died",
	"Eliminated",
	"Elimination",
	"EquippedItemChanged",
	"HealthChanged",
	"InterfaceAdded",
	"InterfaceRemoved",
	"ItemAdded",
	"ItemRemoved",
	"StopSliding",
	"Interrupted",
	"InvincibilityChanged",
}

function ClientFighter.new(serial)
	local self = setmetatable(ReplicatedClass.new(serial), ClientFighter)
	self.ClassName = "ClientFighter"
	self.Player = self:Get("Player") or Players:GetPlayerByUserId(tonumber(self:Get("UserID")) or 0)
	self.IsLocalPlayer = self.Player ~= nil and self.Player == Players.LocalPlayer
	self.Entity = nil
	self.EquippedItem = nil
	self.FighterInterface = nil
	self.Items = {}
	self._items_by_id = {}
	for _, name in SIGNALS do
		self[name] = Signal.new()
	end

	-- A fighter that already has a character (and weapons) arrives with them at the top level.
	if type(serial) == "table" and type(serial.Entity) == "table" then
		task.defer(self._SetEntity, self, serial.Entity)
	end
	if type(serial) == "table" and type(serial.Items) == "table" then
		task.defer(function()
			for _, itemSerial in serial.Items do
				self:_AddItem(itemSerial)
			end
		end)
	end

	self:GetDataChangedSignal("EquippedItemID"):Connect(function()
		self:_SyncEquippedItem()
	end)
	self:GetDataChangedSignal("IsSpectating"):Connect(function()
		self:_SyncInterface()
	end)
	task.defer(self._SyncInterface, self)
	return self
end

-- The fighter's character, built as ClientFighterCharacter (nametag, animations, arms...).
-- A serial field, whether its key is still an enum or already decoded.
local function field(serial, name: string)
	local key = EnumLibrary:ToEnum(name, true)
	if serial[name] ~= nil then
		return serial[name], name
	end
	return key and serial[key], key
end

-- The character may still be on its way when its serial arrives (the Instance then comes
-- through as nil); fill Model / RootPart / Humanoid in from Player.Character once it is here.
local function completeCharacter(self, entitySerial): boolean
	local model, modelKey = field(entitySerial, "Model")
	if model then
		return true
	end
	local player = self.Player
	local character = player and (player.Character or player.CharacterAdded:Wait())
	local root = character and character:WaitForChild("HumanoidRootPart", 10)
	local humanoid = character and character:WaitForChild("Humanoid", 10)
	if not (root and humanoid) then
		return false
	end
	entitySerial[modelKey or "Model"] = character
	entitySerial[select(2, field(entitySerial, "RootPart")) or "RootPart"] = root
	entitySerial[select(2, field(entitySerial, "Humanoid")) or "Humanoid"] = humanoid
	return true
end

function ClientFighter._SetEntity(self, entitySerial)
	if not completeCharacter(self, entitySerial) then
		warn("[ClientFighter] no character for " .. tostring(self.Player))
		return
	end
	self:_RemoveEntity()
	local ok, entity = pcall(characterClass().new, entitySerial, self)
	if not ok then
		warn("[ClientFighter] character failed to build: " .. tostring(entity))
		return
	end
	self.Entity = entity
	-- The duel interface, spectating and the scoreboard listen on the fighter.
	self._entity_connections = {
		entity.Died:Connect(function(...)
			self.Died:Fire(...)
		end),
		entity.HealthChanged:Connect(function(...)
			self.HealthChanged:Fire(...)
		end),
	}
	self.EntityAdded:Fire(entity)
	self.HealthChanged:Fire()
	self:_SyncArms()
end

-- The character's arms (ClientFighterCharacter.Arms) reach for the hands of the equipped
-- item's viewmodel with IKControls: seen from outside, a fighter holds its weapon and its arms
-- follow the weapon's animations. The original fighter told the character which item that is.
function ClientFighter._SyncArms(self)
	local entity = self.Entity
	if entity and entity.SetIKControlTargetItem then
		local ok, err = pcall(entity.SetIKControlTargetItem, entity, self.EquippedItem)
		if not ok and not self._arms_warned then
			self._arms_warned = true
			warn("[ClientFighter] arms: " .. tostring(err))
		end
	end
end

function ClientFighter._RemoveEntity(self)
	local entity = self.Entity
	if not entity then
		return
	end
	for _, connection in self._entity_connections or {} do
		connection:Disconnect()
	end
	self._entity_connections = nil
	self.Entity = nil
	self.EntityRemoved:Fire(entity)
	entity:Destroy()
end

function ClientFighter.IsA(self, className: string): boolean
	return className == "ClientFighter" or className == "ReplicatedClass"
end

function ClientFighter.GetItem(self, itemID)
	return self._items_by_id[itemID]
end

-- The per-frame state the character's parts and the items read (Sounds, Joints, the
-- viewmodel, the crosshair...), rebuilt every frame from the character and the camera.
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local FLAT = Vector3.new(1, 0, 1)

function ClientFighter._FrameState(self)
	local entity = self.Entity
	local humanoid = entity and entity.Humanoid
	local root = entity and entity.RootPart
	local velocity = root and root.AssemblyLinearVelocity or Vector3.zero
	local moveVelocity = velocity * FLAT
	local humanoidState = humanoid and humanoid:GetState()
	local grounded = humanoid ~= nil and humanoid.FloorMaterial ~= Enum.Material.Air
	local justLanded = grounded and self._was_grounded == false
	self._was_grounded = grounded

	local firstPerson = self:IsActuallyFirstPerson()
	local rotation = nil
	if self.IsLocalPlayer then
		local ok, value = pcall(function()
			return camera().Rotation
		end)
		rotation = ok and value or nil
	else
		rotation = self:_SmoothedRotation()
	end

	return {
		IsAlive = humanoid ~= nil and humanoid.Health > 0,
		IsGrounded = grounded,
		JustLanded = justLanded,
		IsClimbing = humanoidState == Enum.HumanoidStateType.Climbing,
		IsCrouching = self:IsCrouching(),
		IsSliding = self:IsSliding(),
		IsBeingKnockedBack = false,
		IsHiddenByCutscene = false,
		IsHiddenByEmotes = self:Get("IsHiddenByEmotes") == true,
		IsSpectating = self:Get("IsSpectating") == true,
		IsFirstPerson = firstPerson,
		IsActuallyFirstPerson = firstPerson,
		IsActuallySprinting = self:IsSprinting(),
		PlayerVelocity = velocity,
		MoveVelocity = moveVelocity,
		MoveSpeed = moveVelocity.Magnitude,
		CameraRotationRaw = typeof(rotation) == "Vector2" and rotation or Vector2.zero,
		CameraLean = self:GetCameraLean(),
		-- In GUI space (below the topbar inset), where ItemInterface.Mouse places the crosshair;
		-- GetMouseLocation counts from the top of the screen.
		MouseLocation = self.IsLocalPlayer and UserInputService:GetMouseLocation() - GuiService:GetGuiInset() or Vector2.zero,
	}
end

-- SpectateController calls this on every fighter every frame; the character steps with it.
function ClientFighter.Update(self, deltaTime: number)
	if not self.Entity then
		return
	end
	local state = self:_FrameState()
	self.FrameState = state
	self.Entity:Update(deltaTime, state)
	for _, item in self.Items do
		item:Update(deltaTime, state)
	end
	if self.FighterInterface then
		local ok, err = pcall(self.FighterInterface.Update, self.FighterInterface, deltaTime, state)
		if not ok and not self._interface_warned then
			self._interface_warned = true
			warn("[ClientFighter] interface: " .. tostring(err))
		end
	end
end

-- Callers such as EmoteController read Entity right after a true here.
function ClientFighter.IsAlive(self, ...): boolean
	return self.Entity ~= nil and self.Entity:IsAlive(...)
end

local BASE_HEALTH = require(Modules:WaitForChild("CONSTANTS")).BASE_HEALTH

-- The character's Humanoid carries the health (ClientHumanoidEntity).
function ClientFighter.GetMaxHealth(self): number
	return self.Entity and self.Entity:GetMaxHealth() or BASE_HEALTH
end

function ClientFighter.GetHealth(self): number
	return self.Entity and self.Entity:GetHealth() or BASE_HEALTH
end

-- MechanicsController reads movement off the fighter every frame (walking, sprinting, sliding,
-- dashes), from the plain Roblox character.
local function humanoid(self): Humanoid?
	local character = self.Player and self.Player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

-- Where the player is steering. flat drops the vertical part; with `fallback` (a direction),
-- standing still answers the fallback instead of zero (slides and dashes then go forward).
function ClientFighter.GetMoveVector(self, flat: boolean?, _normalized: boolean?, fallback: Vector3?): Vector3
	local h = humanoid(self)
	local move = h and h.MoveDirection or Vector3.zero
	if flat then
		move = move * Vector3.new(1, 0, 1)
	end
	if move.Magnitude < 0.01 and fallback then
		move = flat and fallback * Vector3.new(1, 0, 1) or fallback
	end
	return move.Magnitude > 0.01 and move.Unit or Vector3.zero
end

function ClientFighter.IsGrounded(self): boolean
	local h = humanoid(self)
	return h ~= nil and h.FloorMaterial ~= Enum.Material.Air
end

function ClientFighter.GetFloor(self)
	local h = humanoid(self)
	local root = h and h.RootPart
	if not root then
		return nil
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { self.Player.Character }
	local hit = workspace:Raycast(root.Position, Vector3.new(0, -(root.Size.Y / 2 + h.HipHeight + 1), 0), params)
	return hit and hit.Instance
end

local function isFrozen(self): boolean
	return self.Entity ~= nil and self.Entity:Get("IsFrozen") == true
end

function ClientFighter.CanSprint(self): boolean
	return self:IsAlive() and not isFrozen(self) and not self:Get("SprintingDisabled")
end

function ClientFighter.CanSlide(self): boolean
	return self:IsAlive() and not isFrozen(self) and not self:Get("SlidingDisabled")
end

-- Items (and the moves that need them free, like sliding) are locked while dead or when the
-- server says so.
function ClientFighter.AreItemsLocked(self): boolean
	return not self:IsAlive() or self:Get("ItemsLocked") == true
end

-- Seconds before this fighter may join a duel again (ArcadeController, the Play button).
function ClientFighter.GetJoinCooldown(self): number
	return 0
end

-- What ClientFighterCharacter's parts (Visibility, Animations, Sounds, Visuals, the
-- nametag...) ask of their fighter.
local CameraController = nil
local function camera()
	CameraController = CameraController or require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController)
	return CameraController
end

local Utility = require(Modules:WaitForChild("Utility"))
-- Assigned further down (lazy getters).
local GameplayUtility
local DamageNumbers

-- First person is whoever the camera follows while it is in first person: the local player, or
-- the player being spectated (then their weapon is drawn on the camera and their body hidden,
-- as they see it themselves).
function ClientFighter.IsActuallyFirstPerson(self): boolean
	local ok, firstPerson = pcall(function()
		local controller = camera()
		return controller:GetPublicState() == "FirstPerson" and controller:GetCurrentSubject() == self
	end)
	return ok and firstPerson == true
end

-- In combat: armed and alive. The first-person camera (CameraController) and hiding one's own
-- body in it (Visibility) key off this; in the hub, unarmed, the normal camera stays.
function ClientFighter.IsActive(self): boolean
	return #self.Items > 0 and self:IsAlive()
end

-- Movement states: MechanicsController sets the *Locally fields on the local fighter at once;
-- everyone else's arrive as fighter data (the server's UpdateState handler).
local function movementState(self, localField: string, dataField: string)
	if self.IsLocalPlayer then
		return self[localField]
	end
	return self:Get(dataField)
end

function ClientFighter.IsSliding(self): boolean
	return movementState(self, "IsSlidingLocally", "IsSliding") == true
end

-- Items equipped right now, as a set { [item] = true }.
function ClientFighter.GetEquippedItems(self)
	return self.EquippedItem and { [self.EquippedItem] = true } or {}
end

-- What a raycast may hit. With entities: the environment's tagged geometry plus the hitboxes
-- of every valid target in it (what shots use); without: the ground the character walks on.
function ClientFighter.GetRaycastWhitelist(self, withEntities: boolean?)
	if withEntities then
		return (GameplayUtility():GetRaycastWhitelist(self:Get("EnvironmentID"), self:GetEntityLookupParams()))
	end
	local list = {}
	for _, name in { "Lobby", "Map", "Maps" } do
		local folder = workspace:FindFirstChild(name)
		if folder then
			table.insert(list, folder)
		end
	end
	return list
end

-- Other players' rotation arrives ten times a second in 256ths of a turn; drawn as is, their
-- weapon (and the camera, when spectating them) would step. It is eased towards the last value
-- received instead, once per frame.
local ROTATION_SMOOTHING = 18

local function smoothedRotation(self): Vector2?
	local target = self:Get("CameraRotation")
	if typeof(target) ~= "Vector2" then
		return nil
	end
	local now = os.clock()
	local current = self._smoothed_rotation
	if not current then
		self._smoothed_rotation, self._smoothed_at = target, now
		return target
	end
	local elapsed = now - (self._smoothed_at or now)
	if elapsed > 0 then
		self._smoothed_at = now
		local alpha = 1 - math.exp(-ROTATION_SMOOTHING * math.min(elapsed, 0.25))
		-- The shortest way round for the yaw.
		local yaw = (target.Y - current.Y + math.pi) % (2 * math.pi) - math.pi
		current = Vector2.new(current.X + (target.X - current.X) * alpha, current.Y + yaw * alpha)
		self._smoothed_rotation = current
	end
	return current
end
ClientFighter._SmoothedRotation = smoothedRotation

-- Where the fighter looks: the camera for the local player, the replicated rotation for others.
function ClientFighter.GetRotationCFrame(self)
	local ok, rotation = pcall(function()
		if self.IsLocalPlayer then
			return camera():GetRotationCFrame()
		end
		local replicated = smoothedRotation(self)
		return replicated and camera():GetRotationCFrame(replicated) or nil
	end)
	if ok and rotation then
		return rotation
	end
	local root = self.Entity and self.Entity.RootPart
	return root and root.CFrame.Rotation or CFrame.identity
end

-- CreateSound(soundId, volume, pitch, ..., lifetime), played from the character.
function ClientFighter.CreateSound(self, soundId, volume, pitch, ...)
	local root = self.Entity and self.Entity.RootPart
	if not root then
		return nil
	end
	return Utility:CreateSound(soundId, volume, pitch, root, ...)
end

-- Change types this fighter does not know are ignored rather than asserting like the base class.
function ClientFighter.ReplicateFromServer(self, changeType, ...)
	if changeType == "DataValueChanged" then
		return ReplicatedClass.ReplicateFromServer(self, changeType, ...)
	end

	if changeType == "ItemAdded" then
		self:_AddItem(...)
	elseif changeType == "ItemRemoved" then
		self:_RemoveItem(...)
	elseif changeType == "ItemChanged" then
		local itemID, itemChange = ...
		local item = self._items_by_id[itemID]
		if item then
			item:ReplicateFromServer(EnumLibrary:FromEnum(itemChange, true) or itemChange, select(3, ...))
		end
	elseif changeType == "PlayMechanicsSound" then
		if not self.IsLocalPlayer and type((...)) == "string" then
			self:PlayMechanicsSound((...))
		end
	elseif changeType == "HitEffect" then
		-- { ["\0"] = damage, ["\1"] = critical, ["\2"] = model hit, ["\3"] = killed, ["\4"] = where }
		local hit = ...
		local interface = self.EquippedItem and self.EquippedItem.ItemInterface
		if interface then
			pcall(interface.DamageEffect, interface, hit, 1)
		end
		-- Damage numbers only go on characters (players, range dummies). Range targets and other
		-- breakables (ClientDestructable: Target, rubble, spleef tiles) have no Humanoid -- their
		-- health lives in Health/MaxHealth attributes -- so they get the hitmarker but no number.
		local model = type(hit) == "table" and hit[utf8.char(2)]
		local isCharacter = typeof(model) == "Instance" and model:FindFirstChildOfClass("Humanoid") ~= nil
		if self.IsLocalPlayer and isCharacter then
			pcall(DamageNumbers().Show, model, hit[utf8.char(0)], hit[utf8.char(1)] == true, hit[utf8.char(4)])
		end
	elseif changeType == "EntityAdded" then
		self:_SetEntity(...)
	elseif changeType == "EntityRemoved" then
		self:_RemoveEntity()
	elseif changeType == "EntityChanged" and self.Entity then
		local entityChange = ...
		self.Entity:ReplicateFromServer(EnumLibrary:FromEnum(entityChange, true) or entityChange, select(2, ...))
	end
end

--------------------------------------------------------------------------------
-- Weapons
--------------------------------------------------------------------------------

local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
local EntityLookupParams = require(Modules:WaitForChild("EntityLookupParams"))
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))

local FighterRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter")
local ClientModules = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules")

-- Required on first use, like the character: they pull in controllers and the HUD.
local cache = {}
local function lazy(key: string, get: () -> any)
	return function()
		if cache[key] == nil then
			cache[key] = get()
		end
		return cache[key]
	end
end
GameplayUtility = lazy("GameplayUtility", function()
	return require(Modules:WaitForChild("GameplayUtility"))
end)
local ClientItem = lazy("ClientItem", function()
	return require(script:WaitForChild("ClientItem"))
end)
local FighterInterfaceClass = lazy("FighterInterface", function()
	return require(script:WaitForChild("FighterInterface"))
end)
local QuickAttackSystemClass = lazy("QuickAttackSystem", function()
	return require(script:WaitForChild("QuickAttackSystem"))
end)
DamageNumbers = lazy("DamageNumbers", function()
	return require(ClientModules:WaitForChild("DamageNumbers"))
end)
local PlayerDataController = lazy("PlayerDataController", function()
	return require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
end)

-- Modules.Items[weapon] when the weapon has its own class, else Modules.ItemTypes[Info.Type].
local function itemClass(name: string)
	local own = ClientModules:FindFirstChild("Items") and ClientModules.Items:FindFirstChild(name)
	local info = ItemLibrary.Items[name]
	local byType = info and ClientModules:FindFirstChild("ItemTypes") and ClientModules.ItemTypes:FindFirstChild(info.Type)
	for _, module in { own, byType } do
		if module then
			local ok, class = pcall(require, module)
			if ok and type(class) == "table" and class.new then
				return class
			end
			warn("[ClientFighter] item class " .. module.Name .. " failed: " .. tostring(class))
		end
	end
	return ClientItem()
end

local function quickAttacks(self)
	if not self._quick_attack_system then
		self._quick_attack_system = QuickAttackSystemClass().new(self)
	end
	return self._quick_attack_system
end

function ClientFighter._AddItem(self, encodedSerial)
	if type(encodedSerial) ~= "table" then
		return
	end
	local serial = ClientItem().DecodeSerialKeys(encodedSerial)
	local data = serial.Data or {}
	local name = data[EnumLibrary:ToEnum("Name")]
	local objectID = data[EnumLibrary:ToEnum("ObjectID")]
	if not name or not objectID or self._items_by_id[objectID] then
		return
	end
	quickAttacks(self)

	local ok, item = pcall(function()
		return itemClass(name).new(serial, self)
	end)
	if not ok then
		warn("[ClientFighter] item " .. tostring(name) .. " failed to build: " .. tostring(item))
		return
	end

	self._items_by_id[objectID] = item
	table.insert(self.Items, item)
	table.sort(self.Items, function(a, b)
		return (a:Get("ItemIndex") or 0) < (b:Get("ItemIndex") or 0)
	end)
	self.ItemAdded:Fire(item)
	if self:Get("EquippedItemID") == objectID then
		self:_SyncEquippedItem()
	end
end

function ClientFighter._RemoveItem(self, objectID)
	local item = self._items_by_id[objectID]
	if not item then
		return
	end
	if self.EquippedItem == item then
		self:_SetEquippedItem(nil)
	end
	self._items_by_id[objectID] = nil
	local index = table.find(self.Items, item)
	if index then
		table.remove(self.Items, index)
	end
	self.ItemRemoved:Fire(item)
	item:Destroy()
end

function ClientFighter._SetEquippedItem(self, item, skipAnimation: boolean?)
	if self.EquippedItem == item then
		return
	end
	local previous = self.EquippedItem
	self.EquippedItem = item
	if previous then
		pcall(previous.Unequip, previous)
	end
	if item then
		local ok, err = pcall(item.Equip, item, skipAnimation)
		if not ok then
			warn("[ClientFighter] equip " .. item.Name .. ": " .. tostring(err))
		end
	end
	self:_SyncArms()
	self.EquippedItemChanged:Fire(item)
end

-- The server's EquippedItemID wins for everyone else; the local player equips at once and
-- only follows the server when it moves on its own (a new loadout, a removed item).
function ClientFighter._SyncEquippedItem(self)
	local item = self._items_by_id[self:Get("EquippedItemID")]
	if self.IsLocalPlayer and self._pending_equip and tick() < self._pending_equip then
		return
	end
	self:_SetEquippedItem(item)
end

-- The second argument is only ever passed by QuickAttackSystem, for its own two swaps (out to the
-- quick-attack item, then back to the weapon the player had). It is NOT "skip the animation":
-- QuickAttackSystem marks what to skip itself (QuickAttackQueued on the quick item,
-- SkipEquipAnimation on the original) and ShouldSkipEquipAnimation reads those flags.
-- IsEquippingLocked stops the PLAYER switching weapons mid quick-attack; applying it to the
-- system's own swap-back is what left the melee stuck in hand after a quick melee.
function ClientFighter.EquipItem(self, index: number, fromQuickAttack: boolean?)
	local item = self.Items[index]
	if not item or item == self.EquippedItem or not self:IsAlive() then
		return
	end
	local system = quickAttacks(self)
	if not fromQuickAttack and system:IsEquippingLocked(item:Get("ObjectID")) then
		return
	end
	local skipAnimation = system:ShouldSkipEquipAnimation(item) and true or nil
	self._pending_equip = tick() + 1
	self:_SetEquippedItem(item, skipAnimation)
	task.spawn(function()
		pcall(FighterRemotes.EquipItemFeedback.InvokeServer, FighterRemotes.EquipItemFeedback, item:Get("ObjectID"))
		self._pending_equip = nil
	end)
end

-- Scroll / next-previous weapon (MechanicsController).
function ClientFighter.EquipIncrement(self, step: number)
	local count = #self.Items
	if count == 0 then
		return
	end
	local index = table.find(self.Items, self.EquippedItem) or 1
	self:EquipItem((index - 1 + step) % count + 1)
end

function ClientFighter.Input(self, action: string, ...)
	if self.EquippedItem then
		return self.EquippedItem:Input(action, ...)
	end
	return false
end

function ClientFighter.QuickAttackDown(self, kind: string, ...)
	return quickAttacks(self):InputDown(kind, ...)
end

function ClientFighter.QuickAttackUp(self, kind: string, ...)
	return quickAttacks(self):InputUp(kind, ...)
end

function ClientFighter.GetQuickAttackIndex(self, kind: string)
	return quickAttacks(self):GetQuickAttackIndex(kind)
end

function ClientFighter.GetMaxEquippableWeapons(self): number
	return #ItemLibrary.SlotToClass
end

function ClientFighter.CanUseWeapon(self, weapon: string, slot: number?): boolean
	local ok, allowed = pcall(GameplayUtility().CanUseWeapon, GameplayUtility(), self, PlayerDataController(), weapon, slot)
	return ok and allowed == true
end

function ClientFighter.GetEntityLookupParams(self)
	local params = EntityLookupParams.new(self:Get("TeamID"), false, false)
	params.SourceEntity = self.Entity
	return params
end

function ClientFighter.IsCrouching(self): boolean
	return movementState(self, "IsCrouchingLocally", "IsCrouching") == true
end

-- What CameraController reads off its subject every frame.
function ClientFighter.IsSprinting(self): boolean
	return movementState(self, "IsSprintingLocally", "IsSprinting") == true
end

function ClientFighter.GetCameraLean(self): number
	return tonumber(movementState(self, "LocalCameraLean", "CameraLean")) or 0
end

-- How fast the camera zooms in when aiming, and by how much (the equipped item's FOVOffset).
function ClientFighter.GetAimSpeed(self): number
	return self.EquippedItem and self.EquippedItem:GetAimSpeed() or 1
end

function ClientFighter.GetFOVOffset(self): number
	return self.EquippedItem and self.EquippedItem:Get("FOVOffset") or 0
end

function ClientFighter.IsRendered(self): boolean
	return self.Entity ~= nil
end

function ClientFighter.GetCameraSway(self): Vector2
	return Vector2.zero
end

function ClientFighter.GetMouseLocation(self): Vector2
	return UserInputService:GetMouseLocation()
end

-- Where a shot from this fighter goes: through the crosshair (the mouse), optionally turned by
-- a spread CFrame, against `whitelist` (default: the environment and its targets).
function ClientFighter.GetCameraData(self, whitelist, spread: CFrame?, raw: boolean?)
	local viewport = workspace.CurrentCamera
	local mouse = UserInputService:GetMouseLocation()
	local ray = viewport:ViewportPointToRay(mouse.X, mouse.Y)
	local aim = CFrame.lookAt(ray.Origin, ray.Origin + ray.Direction)
	if spread then
		aim = aim * spread
	end

	local list = whitelist or self:GetRaycastWhitelist(true)
	local result = Utility:Raycast(aim.Position, aim.Position + aim.LookVector, CONSTANTS.MAX_RAYCAST_DISTANCE, list, Enum.RaycastFilterType.Include)

	local head = self.Entity and (self.Entity.Head or self.Entity.RootPart)
	local data = {
		[utf8.char(0)] = CFrame.new(head and head.Position or aim.Position) * aim.Rotation,
		[utf8.char(1)] = aim,
	}
	if result.Instance then
		data[utf8.char(2)] = result.Instance
		data[utf8.char(3)] = result.Instance.CFrame:ToObjectSpace(CFrame.new(result.Position))
	end
	if not raw then
		for _, key in { utf8.char(0), utf8.char(1), utf8.char(3) } do
			if data[key] then
				data[key] = Utility:EncodeCFrame(data[key])
			end
		end
	end
	return data, result
end

-- The fighter HUD (health, hotbar, ammo...) exists while this fighter is the one watched.
function ClientFighter._SyncInterface(self)
	if self:Get("IsSpectating") and self.Player then
		if not self.FighterInterface then
			local ok, interface = pcall(function()
				return FighterInterfaceClass().new(self)
			end)
			if not ok then
				warn("[ClientFighter] interface failed to build: " .. tostring(interface))
				return
			end
			self.FighterInterface = interface
			self.InterfaceAdded:Fire(interface)
		end
	else
		self:ClearInterface()
	end
end

function ClientFighter.ClearInterface(self)
	local interface = self.FighterInterface
	if not interface then
		return
	end
	self.FighterInterface = nil
	self.InterfaceRemoved:Fire()
	pcall(interface.Destroy, interface)
end

function ClientFighter.ClearSounds(self) end

function ClientFighter.Ping(self) end

-- PlayMechanicsSound(name): the movement sounds (MechanicsController, portals). The slide keeps
-- the Sound it gets back and fades it itself, so there is always one.
local MECHANICS_SOUNDS = {
	Slide = { "rbxassetid://16736552098", 0.375 },
	DoubleJump = { "rbxassetid://16492958314", 0.75 },
	Warp = { "rbxassetid://16492958314", 1 },
}

function ClientFighter.PlayMechanicsSound(self, name: string)
	local sound = MECHANICS_SOUNDS[name]
	local root = self.Entity and self.Entity.RootPart
	if not sound or not root then
		local silent = Instance.new("Sound")
		silent.Name = tostring(name)
		return silent
	end
	return Utility:CreateSound(sound[1], sound[2], 1, root, true, 5)
end

function ClientFighter.Destroy(self)
	for index = #self.Items, 1, -1 do
		self:_RemoveItem(self.Items[index]:Get("ObjectID"))
	end
	self:ClearInterface()
	self:_RemoveEntity()
	for _, name in SIGNALS do
		self[name]:Destroy()
	end
	ReplicatedClass.Destroy(self)
end

return ClientFighter
