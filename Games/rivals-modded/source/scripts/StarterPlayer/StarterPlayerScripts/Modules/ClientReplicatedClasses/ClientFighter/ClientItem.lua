-- One weapon of a fighter, as the client sees it. The item types (Modules.ItemTypes: Gun,
-- Melee, Throwable, Custom) and the per-weapon modules (Modules.Items) build on this.
--
-- The original was obfuscated (the untouched source is in ServerStorage.ObfuscatedOriginals).
-- This version provides what those readable subclasses, the viewmodel and the HUD use:
--
--   ClientItem.new(serial, clientFighter)   serial = { Data = {...}, ViewModel = vmSerial }
--   .ClientFighter .Name .Info .ViewModel .ItemInterface (local player only) .Cooldowns
--   :Input(action, ...)   calls self[action](self, ...); a true result goes to the server as
--                         Fighter.UseItem(objectID, <enum action>, <what the method returned>)
--   :Equip(skipAnimation) / :Unequip() / :Update(dt, frameState)
--   :GetAmmoVariables() -> ammo, reserve, infiniteAmmo, infiniteReserve   (hotbar, displays)
--   :CooldownEffect(image, duration, name, reversed) / :StopCooldownEffect(name)
--   :CreateSound(id, volume, pitch, play, lifetime, ...)   2D for the player being watched

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local BetterDebris = require(Modules:WaitForChild("BetterDebris"))
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))
local Signal = require(Modules:WaitForChild("Signal"))
local Utility = require(Modules:WaitForChild("Utility"))

local ClientViewModel = require(script:WaitForChild("ClientViewModel"))
local ItemInterface = require(script:WaitForChild("ItemInterface"))
local Cooldowns = require(script:WaitForChild("Cooldowns"))

local UseItem = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("UseItem")
local ViewModelClasses = Players.LocalPlayer.PlayerScripts:WaitForChild("Modules"):WaitForChild("ViewModels")
local ItemInterfaceClasses = Players.LocalPlayer.PlayerScripts:WaitForChild("Modules"):WaitForChild("ItemInterfaces")

local SIGNALS = {
	"EquippedChanged",
	"EquipFailedEffect",
	"StopSprinting",
	"AttemptToSprintAgain",
	"ToggleOffMobileInputButton",
	"ServerInputWorkDone",
	-- MobileInputs.Buttons listens here for an interface added later; ours is built with the
	-- item (Buttons also reads item.ItemInterface right away), so it never fires.
	"InterfaceAdded",
}

local IMPACT_MARKER_LIFETIME = 8

-- ServerInputWorkDone is how QuickAttackSystem knows the quick attack is over and it can swap
-- back to the weapon the player had out. The live server replicated it once it had finished
-- working on the input; the rebuild server doesn't, so the client stands in for it. For an input
-- sent as part of a quick attack (quick melee / quick utility), that stand-in waits this long,
-- which is how long the quick-attack item stays in hand before the swap back.
local QUICK_ATTACK_WORK_TIME = 0.5

local ClientItem = setmetatable({}, ReplicatedClass)
ClientItem.__index = ClientItem

-- Serials arrive with their top-level keys (Data, ViewModel...) as enums.
local function decodeTop(serial)
	local decoded = {}
	for key, value in serial do
		decoded[type(key) == "string" and EnumLibrary:FromEnum(key, true) or key] = value
	end
	return decoded
end
ClientItem.DecodeSerialKeys = decodeTop

-- A viewmodel (skin) may have its own class somewhere under Modules.ViewModels.
local function viewModelClass(name: string)
	local module = ViewModelClasses:FindFirstChild(name, true)
	if module and module:IsA("ModuleScript") then
		local ok, class = pcall(require, module)
		if ok and type(class) == "table" and class.new then
			return class
		end
	end
	return ClientViewModel
end

-- Some weapons have their own interface on top of the common one (Bow and Crossbow: the charge
-- bar their items drive through ItemInterface.Charge).
local function interfaceClass(name: string)
	local module = ItemInterfaceClasses:FindFirstChild(name)
	if module and module:IsA("ModuleScript") then
		local ok, class = pcall(require, module)
		if ok and type(class) == "table" and class.new then
			return class
		end
	end
	return ItemInterface
end

function ClientItem.new(serial, clientFighter)
	local self = setmetatable(ReplicatedClass.new(serial), ClientItem)
	self.ClientFighter = clientFighter
	self.Name = self:Get("Name")
	self.Info = ItemLibrary.Items[self.Name]
	self.IsEquipped = false
	for _, name in SIGNALS do
		self[name] = Signal.new()
	end
	self._connections = {}
	self._destroyed = false
	self._equip_finish = 0
	self._impact_markers = {}

	self.Cooldowns = Cooldowns.new(self)

	local vmSerial = serial.ViewModel and decodeTop(serial.ViewModel) or { Data = { [EnumLibrary:ToEnum("Name")] = self.Name } }
	local vmData = vmSerial.Data or {}
	local vmName = vmData.Name or vmData[EnumLibrary:ToEnum("Name", true)] or self.Name
	self.ViewModel = viewModelClass(vmName).new(vmSerial, self)
	self:_ApplyArms()

	if clientFighter.IsLocalPlayer then
		self.ItemInterface = interfaceClass(self.Name).new(self)
	end
	return self
end

-- The first-person arms wear the character's shirt and skin colour.
function ClientItem._ApplyArms(self)
	local character = self.ClientFighter.Player and self.ClientFighter.Player.Character
	local shirt = character and character:FindFirstChildOfClass("Shirt")
	local colors = character and character:FindFirstChildOfClass("BodyColors")
	pcall(self.ViewModel.SetArmsData, self.ViewModel, shirt and shirt.ShirtTemplate or nil, colors and colors.LeftArmColor3 or nil, colors and colors.RightArmColor3 or nil)
end

--------------------------------------------------------------------------------
-- Input
--------------------------------------------------------------------------------

function ClientItem.Input(self, action: string, ...)
	if self._destroyed or not self.IsEquipped then
		return false
	end
	-- A duel's round countdown and the break after each round set the fighter's ItemsLocked
	-- (DuelService). ItemService already drops every UseItem while it's set, but without this the
	-- client still fired, drew tracers and played the shot locally. Everything is refused, the
	-- Finish* actions too: for throwables and the Bow those ARE the throw / the shot. A charge
	-- held into the lock just ends with the round, when the next spawn builds fresh items.
	if self.ClientFighter.IsLocalPlayer and self.ClientFighter:AreItemsLocked() then
		return false
	end
	local method = self[action]
	if type(method) ~= "function" then
		return false
	end

	local result = table.pack(method(self, ...))
	if not result[1] then
		return false
	end

	local name = result[2] or action
	if self.ClientFighter.IsLocalPlayer then
		UseItem:FireServer(self:Get("ObjectID"), self:ToEnum(name), table.unpack(result, 3, result.n))
		local function workDone()
			if not self._destroyed then
				self.ServerInputWorkDone:Fire(name)
			end
		end
		if self:Get("QuickAttackQueued") then
			task.delay(QUICK_ATTACK_WORK_TIME, workDone)
		else
			task.defer(workDone)
		end
	end
	return true
end

-- An input caused by gameplay (running out of ammo, a cooked grenade...), not by a key.
function ClientItem.SimulateInputFromGameplayMechanic(self, action: string, ...)
	return self:Input(action, ...)
end

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

function ClientItem.IsEquipping(self): boolean
	return tick() < self._equip_finish
end

function ClientItem.IsMainItem(self): boolean
	return self.ClientFighter.EquippedItem == self
end

function ClientItem.IsRendered(self): boolean
	return self.ClientFighter:IsRendered()
end

function ClientItem.GetAmmoVariables(self)
	return self:Get("Ammo"), self:Get("AmmoReserve"), self.ClientFighter:Get("InfiniteAmmo") == true, self.ClientFighter:Get("InfiniteAmmoReserve") == true
end

function ClientItem.GetWrap(self)
	return self.ViewModel:GetWrap()
end

function ClientItem.GetMobileInputSettings(self)
	return self.Info.MobileInputSettings or {}
end

-- ClientDueler records these for the final results scene (StaticViewModel.new(ViewModelName)).
function ClientItem.GetViewModelDetails(self)
	return {
		ViewModelName = self.ViewModel.Name,
		Name = self.ViewModel.Name,
		Wrap = self.ViewModel:Get("Wrap"),
		Charm = self.ViewModel:Get("Charm"),
	}
end

function ClientItem.GetAimSpeed(self): number
	return 1
end

function ClientItem.GetAutoShootReach(self): number
	return CONSTANTS.MAX_RAYCAST_DISTANCE
end

function ClientItem.GetAutoShootReactionTime(self)
	return nil
end

function ClientItem.CanQuickAttack(self): boolean
	return not self:IsEquipping()
end

function ClientItem.CanEasyQuickAttack(self): boolean
	return self:CanQuickAttack()
end

function ClientItem.PlayEquipFailedEffect(self)
	self.EquipFailedEffect:Fire()
end

--------------------------------------------------------------------------------
-- Equipping and the per-frame step
--------------------------------------------------------------------------------

function ClientItem.Equip(self, skipAnimation: boolean?)
	if self.IsEquipped then
		return
	end
	self.IsEquipped = true
	self._equip_finish = tick() + (skipAnimation and 0 or (self.Info.EquipCooldown or 0))
	self.ViewModel:Equip(skipAnimation)
	if self.ItemInterface then
		self.ItemInterface:Equip()
	end
	self.EquippedChanged:Fire(true)
end

function ClientItem.Unequip(self)
	if not self.IsEquipped then
		return
	end
	self.IsEquipped = false
	self.ViewModel:Unequip()
	if self.ItemInterface then
		self.ItemInterface:Unequip()
	end
	self.EquippedChanged:Fire(false)
end

function ClientItem.Update(self, deltaTime: number, frameState)
	if self._destroyed then
		return
	end
	local active = self.IsEquipped and frameState.IsAlive and self:IsRendered() and not frameState.IsHiddenByEmotes
	local ok, err = pcall(self.ViewModel.Update, self.ViewModel, deltaTime, frameState, {
		IsActive = active,
		ViewModelOffset = CFrame.identity,
	})
	if not ok and not self._warned then
		self._warned = true
		warn("[ClientItem] " .. self.Name .. " viewmodel: " .. tostring(err))
	end
	if self.ItemInterface then
		self.ItemInterface:Update(deltaTime, frameState, { IsActive = active })
	end
end

-- What another player did with their item, relayed by the server (ItemService) so it can be
-- played on this client too: the item classes take (forced, ...) for exactly this, skipping
-- their own checks, and run the same animations, muzzle flash and sounds as for the player
-- doing it (their character's arms follow the viewmodel's hands).
local REPLAYED_ACTIONS = {
	StartShooting = true,
	StartReloading = true,
	StartAiming = true,
	FinishAiming = true,
	StartInspecting = true,
}

function ClientItem.ReplicateFromServer(self, changeType: string, ...)
	if changeType == "DataValueChanged" then
		return ReplicatedClass.ReplicateFromServer(self, changeType, ...)
	end
	if REPLAYED_ACTIONS[changeType] and not self.ClientFighter.IsLocalPlayer and self.IsEquipped and self:IsRendered() then
		local ok, err = pcall(self.Input, self, changeType, true, ...)
		if not ok and not self._replay_warned then
			self._replay_warned = true
			warn("[ClientItem] " .. self.Name .. " replaying " .. changeType .. ": " .. tostring(err))
		end
	end
end

--------------------------------------------------------------------------------
-- Effects
--------------------------------------------------------------------------------

function ClientItem.CooldownEffect(self, image: string, duration: number, name: string, reversed: boolean?)
	if duration and duration > 0 then
		self.Cooldowns:Create(image, duration, name, reversed)
	end
end

function ClientItem.StopCooldownEffect(self, name: string)
	self.Cooldowns:Clear(name)
end

-- CreateSound(id, volume, pitch, play, lifetime, ...): flat for the player whose view this is,
-- from the character for everyone else.
function ClientItem.CreateSound(self, soundId: string, volume: number?, pitch: number?, ...)
	if self.ClientFighter:Get("IsSpectating") and self.ItemInterface then
		return self.ItemInterface:CreateSound(soundId, volume, pitch, "script", ...)
	end
	local root = self.ClientFighter.Entity and self.ClientFighter.Entity.RootPart
	if root then
		return Utility:CreateSound(soundId, volume, pitch, root, ...)
	end
	return nil
end

-- Only heard by whoever is watching this fighter.
function ClientItem.CreateSpectatorSound(self, soundId: string, volume: number?, pitch: number?, ...)
	if not self.ClientFighter:Get("IsSpectating") then
		return nil
	end
	return Utility:CreateSound(soundId, volume, pitch, "script", ...)
end

function ClientItem._Recoil(self, multiplier: number?)
	local recoil = (self.Info.ShootRecoil or 1) * (multiplier or 1)
	self.ViewModel:ApplyRecoil(Vector3.new((math.random() - 0.5) * 0.05, 0.04, 0.08) * recoil)
end

function ClientItem._StartAimAssist(self) end

function ClientItem._FinishAimAssist(self) end

function ClientItem._Shake(self, _kind: string?) end

function ClientItem._ImpactMarkerSlash(self, _reach, _cameraData, _raycast) end

-- A small mark where a shot hit the world (entities show their own hurt effect).
function ClientItem._AddImpactMarker(self, position: Vector3, normal: Vector3, instance: Instance?)
	if not instance or CollectionService:HasTag(instance, "EntityHitbox") or not instance:IsA("BasePart") then
		return
	end
	local marker = Instance.new("Part")
	marker.Name = "ImpactMarker"
	marker.Anchored = true
	marker.CanCollide = false
	marker.CanQuery = false
	marker.CanTouch = false
	marker.CastShadow = false
	marker.Material = Enum.Material.SmoothPlastic
	marker.Color = Color3.fromRGB(25, 25, 25)
	marker.Shape = Enum.PartType.Cylinder
	marker.Size = Vector3.new(0.02, 0.25, 0.25)
	marker.CFrame = CFrame.lookAt(position + normal * 0.01, position + normal * 2) * CFrame.Angles(0, math.rad(90), 0)
	marker.Parent = workspace:FindFirstChild("Debris") or workspace
	BetterDebris:AddItem(marker, IMPACT_MARKER_LIFETIME)
end

function ClientItem._ImpactMarkers(self, results)
	for _, result in results do
		if result.Position and result.Normal then
			self:_AddImpactMarker(result.Position, result.Normal, result.Instance)
		end
	end
end

function ClientItem.Destroy(self)
	if self._destroyed then
		return
	end
	self._destroyed = true
	if self.IsEquipped then
		pcall(self.Unequip, self)
	end
	for _, connection in self._connections do
		connection:Disconnect()
	end
	self._connections = {}
	if self.ItemInterface then
		self.ItemInterface:Destroy()
	end
	self.Cooldowns:Destroy()
	self.ViewModel:Destroy()
	for _, name in SIGNALS do
		self[name]:Destroy()
	end
	ReplicatedClass.Destroy(self)
end

return ClientItem
