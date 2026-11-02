-- Weapons: picking a loadout, equipping, and every use the client sends.
--
-- A fighter's items travel on the fighter's own channel (see FighterService):
--
--   ("ItemAdded", itemSerial)        itemSerial = { Data = { ObjectID, Name, ItemIndex, Ammo,
--                                     AmmoReserve, NumReloadsSoFar }, ViewModel = vmSerial }
--                                     vmSerial = { Data = { ObjectID, Name, Wrap?, Charm? } }
--   ("ItemRemoved", itemObjectID)
--   ("ItemChanged", itemObjectID, <enum changeType>, ...)    the item's own changes
--   ("HitEffect", { ["\0"] = damage, ["\1"] = critical, ["\2"] = model, ["\3"] = killed })
--                                                            the owner's hitmarker and damage number
--   fighter Data EquippedItemID / CanPickWeapons
--
-- The client class for an item is Modules.Items[Name] or Modules.ItemTypes[Info.Type].
--
--   Fighter.PickWeapons({ primary, secondary, melee, utility })   while CanPickWeapons
--   Fighter.EquipItemFeedback(itemObjectID) -> bool
--   Fighter.UseItem(itemObjectID, <enum action>, ...)   what the item's own method returned:
--        Gun        StartShooting(cameraData, aiming, quickShot)   StartReloading(<enum file>, <enum anim>)
--        Melee      StartShooting(cameraData, <enum animation>)
--                   StartAiming()   a dash (Scythe: DashSpeed/DashDuration); the client moves
--                                   its own character, the server counts it for the task
--        Throwable  FinishShooting / FinishAiming(encodedCFrame, charge 0-1, detonateDelayLeft)
--
-- Hits are resolved with the shared GameplayUtility, the same code the client draws its
-- tracers with: cameraData = { ["\0"] = origin, ["\1"] = camera, ["\2"] = aimed part?,
-- ["\3"] = offset on that part? }, the CFrames Utility:EncodeCFrame'd.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local EntityLookupParams = require(Modules:WaitForChild("EntityLookupParams"))
local GameplayUtility = require(Modules:WaitForChild("GameplayUtility"))
local ItemLibrary = require(Modules:WaitForChild("ItemLibrary"))
local AnimationLibrary = require(Modules:WaitForChild("AnimationLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))
local Utility = require(Modules:WaitForChild("Utility"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local FighterService = require(script.Parent.FighterService)
local EnemyService = require(script.Parent.EnemyService)
local TaskService = require(script.Parent.TaskService)
local Projectiles = require(script.Parent.Projectiles)

-- Defined with the damage helpers below; used by grenades and projectiles.
local explodeAt

local FighterRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter")

local NUM_SLOTS = #ItemLibrary.SlotToClass
-- A use may arrive a little early after the last one because of network jitter.
local COOLDOWN_TOLERANCE = 0.8
-- How far from the character a shot or throw may start.
local MAX_ORIGIN_DISTANCE = 25

local ItemService = {}

-- [fighter] = { items = { [slot] = item }, byID = { [objectID] = item } }
local loadouts = {}

local function enum(name: string): string
	return EnumLibrary:ToEnum(name)
end

local function decode(value)
	if type(value) == "string" then
		return EnumLibrary:FromEnum(value, true) or value
	end
	return value
end

local function weaponEntry(player: Player, weapon: string)
	for _, entry in PlayerDataService.Get(player, "WeaponInventory") or {} do
		if entry.Name == weapon then
			return entry
		end
	end
	return nil
end

--------------------------------------------------------------------------------
-- Items
--------------------------------------------------------------------------------

local function serializeItem(item)
	return item:_EncodeSerial({
		Data = item:_SerializeData(),
		ViewModel = item._view_model:Serialize(),
	})
end

-- Whether a viewmodel's animations play in this place: the game's own ids belong to the
-- original creator and load empty; only the ones re-uploaded into ServerStorage.AnimationOverrides
-- (see Modules.AnimationOverrides) move the arms. Its Idle stands for the whole set.
local function isAnimated(viewModelName: string): boolean
	local viewModelInfo = ItemLibrary.ViewModels[viewModelName]
	local key = viewModelInfo and viewModelInfo.Animations and viewModelInfo.Animations.Idle
	local animation = key and AnimationLibrary.Info[key]
	return animation ~= nil and animation.AnimationID ~= animation.OriginalAnimationID
end

local function createItem(player: Player, fighter, weapon: string, slot: number)
	local info = ItemLibrary.Items[weapon]
	local entry = weaponEntry(player, weapon)

	-- The viewmodel is the equipped skin, unless the skin's animations were not re-uploaded while
	-- the plain weapon's were: a skin frozen in its rest pose would cover the screen.
	local viewModel = ReplicatedClass.new()
	local skin = entry and entry.Skin
	skin = type(skin) == "table" and skin.Name or skin
	local useSkin = type(skin) == "string" and ItemLibrary.ViewModels[skin] ~= nil and (isAnimated(skin) or not isAnimated(weapon))
	viewModel:Set("Name", useSkin and skin or weapon)
	if entry and entry.Wrap ~= nil then
		viewModel:Set("Wrap", entry.Wrap)
	end
	if entry and entry.Charm ~= nil then
		viewModel:Set("Charm", entry.Charm)
	end

	local item = ReplicatedClass.new()
	item._player = player
	item._fighter = fighter
	item._info = info
	item._view_model = viewModel
	item._next_use = 0
	item._reload_thread = nil
	item.Serialize = serializeItem
	item.Name = weapon
	item.Info = info

	item:Set("Name", weapon)
	item:Set("ItemIndex", slot)
	item:Set("NumReloadsSoFar", 0)
	if info.MaxAmmo then
		item:Set("Ammo", info.MaxAmmo)
		item:Set("AmmoReserve", info.MaxAmmoReserve)
	elseif info.MaxAbsorption then
		-- Riot Shield: its "ammo" is the shield's health (AmmoType Shield). ViewModels.Riot Shield
		-- compares it every animation and errored on nil; > 0 shows the shield body.
		item:Set("Ammo", info.MaxAbsorption)
	end
	if weapon == "Satchel" then
		item:Set("NumSatchels", 0)
	end

	-- The item's own changes ride on the fighter's channel.
	item._connection = item.ReplicateToClient:Connect(function(changeType: string, ...)
		fighter.ReplicateToClient:Fire("ItemChanged", item:Get("ObjectID"), enum(changeType), ...)
	end)

	local loadout = loadouts[fighter] or { items = {}, byID = {} }
	loadouts[fighter] = loadout
	loadout.items[slot] = item
	loadout.byID[item:Get("ObjectID")] = item
	fighter.ReplicateToClient:Fire("ItemAdded", serializeItem(item))
	return item
end

function ItemService.ClearItems(fighter)
	local loadout = loadouts[fighter]
	loadouts[fighter] = nil
	if fighter:Get("EquippedItemID") ~= nil then
		fighter:SetReplicate("EquippedItemID", nil)
	end
	if not loadout then
		return
	end
	for _, item in loadout.items do
		if item._reload_thread then
			pcall(task.cancel, item._reload_thread)
		end
		for _, satchel in item._satchels or {} do
			satchel:Destroy()
		end
		item._flaming = false
		item._holding = false
		for _, object in table.clone(item._world_objects or {}) do
			object:Destroy()
		end
		item._connection:Disconnect()
		fighter.ReplicateToClient:Fire("ItemRemoved", item:Get("ObjectID"))
		item._view_model:Destroy()
		item:Destroy()
	end
end

function ItemService.HasItems(fighter): boolean
	local loadout = loadouts[fighter]
	return loadout ~= nil and next(loadout.items) ~= nil
end

-- Lets a fighter pick (again): used when entering the range or respawning inside it.
function ItemService.AllowPicking(fighter, allowed: boolean)
	if not allowed then
		ItemService.ClearItems(fighter)
	end
	if fighter:Get("CanPickWeapons") ~= allowed then
		fighter:SetReplicate("CanPickWeapons", allowed)
	end
end

-- FighterService's serial: every item a late client has to be told about.
local function serializeItems(fighter)
	local loadout = loadouts[fighter]
	if not loadout then
		return nil
	end
	local list = {}
	for slot = 1, NUM_SLOTS do
		if loadout.items[slot] then
			table.insert(list, serializeItem(loadout.items[slot]))
		end
	end
	return list
end

-- GameplayUtility:CanUseWeapon wants the player's data with GetWeaponData(name).
local function dataOf(player: Player)
	return {
		GetWeaponData = function(_self, weapon: string)
			return weaponEntry(player, weapon)
		end,
	}
end

local function defaultFor(slot: number): string?
	local class = ItemLibrary.SlotToClass[slot].Name
	for _, weapon in CONSTANTS.DEFAULT_WEAPONS do
		if ItemLibrary.Items[weapon] and ItemLibrary.Items[weapon].Class == class then
			return weapon
		end
	end
	return nil
end

local function giveLoadout(player: Player, fighter, chosen: { [number]: any })
	local data = dataOf(player)
	local picked = {}
	for slot = 1, NUM_SLOTS do
		local weapon = chosen[slot]
		local ok, allowed = pcall(GameplayUtility.CanUseWeapon, GameplayUtility, fighter, data, weapon, slot)
		if typeof(weapon) == "string" and ItemLibrary.Items[weapon] and ok and allowed then
			picked[slot] = weapon
		else
			picked[slot] = defaultFor(slot)
		end
	end

	for slot = 1, NUM_SLOTS do
		if picked[slot] then
			createItem(player, fighter, picked[slot], slot)
		end
	end
	fighter:SetReplicate("LastPickedWeapons", picked)
	if fighter:Get("CanPickWeapons") then
		fighter:SetReplicate("CanPickWeapons", false)
	end

	local first = loadouts[fighter] and loadouts[fighter].items[1]
	if first then
		fighter:SetReplicate("EquippedItemID", first:Get("ObjectID"))
		if first.Name == "Scythe" then
			TaskService.Record(player, "EquipScythe", 1)
		end
	end
end

local function pickWeapons(player: Player, chosen: any)
	local fighter = FighterService.Get(player)
	if not fighter or not fighter:Get("CanPickWeapons") or typeof(chosen) ~= "table" or ItemService.HasItems(fighter) then
		return
	end
	if not fighter.Entity or not fighter.Entity:IsAlive() then
		return
	end
	giveLoadout(player, fighter, chosen)
end

-- Arms a fighter with a loadout without the PickWeapons page: a duel's later rounds use the
-- weapons picked in the first (LastPickedWeapons), or the defaults if nothing was picked.
function ItemService.GiveLoadout(player: Player, chosen: { [number]: any }?)
	local fighter = FighterService.Get(player)
	if not fighter or ItemService.HasItems(fighter) or not fighter.Entity or not fighter.Entity:IsAlive() then
		return
	end
	giveLoadout(player, fighter, if type(chosen) == "table" then chosen else {})
end

--------------------------------------------------------------------------------
-- Damage
--------------------------------------------------------------------------------

local function lookupParams(fighter, grabSmall: boolean?)
	local params = EntityLookupParams.new(fighter:Get("TeamID"), false, grabSmall)
	params.SourceEntity = fighter.Entity
	return params
end

-- Set by DuelService: damage to another player's character. Returns the damage dealt and
-- whether it eliminated them (0 when the hit does not count: not in the same round, a teammate...).
ItemService.DamageFighter = function(_attacker: Player, _attackerFighter, _entity, _amount: number, _critical: boolean, _weapon: string?): (number, boolean)
	return 0, false
end

-- Every hit on the range's dummies and targets, and on other players, goes through here.
-- position: where the hit landed (the damage number starts there); the target's centre if nil.
local function damageEntity(player: Player, fighter, entity, amount: number, critical: boolean, position: Vector3?)
	local model = entity and entity.Model
	if not model or amount <= 0 then
		return
	end
	local enemy = EnemyService.Get(model)
	local dealt, killed
	if enemy then
		dealt, killed = EnemyService.Damage(model, amount, player, critical)
	else
		local equipped = fighter:Get("EquippedItemID")
		local loadout = loadouts[fighter]
		local item = equipped and loadout and loadout.byID[equipped]
		dealt, killed = ItemService.DamageFighter(player, fighter, entity, amount, critical, item and item._view_model:Get("Name"))
	end
	if dealt > 0 then
		-- The attacker's hitmarker and damage number: { ["\0"] = damage, ["\1"] = critical,
		-- ["\2"] = the model hit, ["\3"] = killed, ["\4"] = where it landed }.
		local root = entity.RootPart or (model:IsA("Model") and model.PrimaryPart)
		fighter.ReplicateToClient:Fire("HitEffect", {
			[utf8.char(0)] = dealt,
			[utf8.char(1)] = critical,
			[utf8.char(2)] = model,
			[utf8.char(3)] = killed,
			[utf8.char(4)] = position or (root and root.Position) or model:GetPivot().Position,
		})
	end
	if killed and enemy and enemy._client_class == "ClientDestructable" then
		TaskService.Record(player, "TargetBroken", 1)
	end
end

-- A CFrame from the client: Utility:EncodeCFrame'd, or plain.
local function readCFrame(value: any): CFrame?
	if typeof(value) == "CFrame" then
		return value
	end
	if type(value) ~= "table" then
		return nil
	end
	local ok, cframe = pcall(Utility.DecodeCFrame, Utility, value)
	if ok and typeof(cframe) == "CFrame" and cframe.Position == cframe.Position then
		return cframe
	end
	return nil
end

-- Area damage: full at the centre, half at the edge, behind walls nothing. quiet skips the
-- visual (a Flare Gun's burn ticks).
function explodeAt(player: Player, fighter, position: Vector3, radius: number, damage: number, quiet: boolean?)
	if not quiet then
		local explosion = Instance.new("Explosion")
		explosion.BlastPressure = 0
		explosion.BlastRadius = 0
		explosion.DestroyJointRadiusPercent = 0
		explosion.Position = position
		explosion.Parent = workspace
	end
	if radius <= 0 or damage <= 0 then
		return
	end
	GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), lookupParams(fighter, false), position, radius, false, nil, nil, nil, function(target, hitbox)
		local falloff = 1 - math.clamp((hitbox.Position - position).Magnitude / radius, 0, 1) * 0.5
		damageEntity(player, fighter, target, damage * falloff, false, hitbox.Position)
	end)
end

local function nearCharacter(fighter, position: Vector3): boolean
	local root = fighter.Entity and fighter.Entity.RootPart
	return root ~= nil and (position - root.Position).Magnitude <= MAX_ORIGIN_DISTANCE
end

-- The item may be used again at `cooldown` from now; false when it is still cooling down.
local function consumeCooldown(item, cooldown: number): boolean
	local now = os.clock()
	if now < item._next_use then
		return false
	end
	item._next_use = now + (cooldown or 0) * COOLDOWN_TOLERANCE
	return true
end

--------------------------------------------------------------------------------
-- Guns
--------------------------------------------------------------------------------

local function dropoff(info, distance: number): number
	local first = info.RaycastDamageDropoffStartDistance
	local last = info.RaycastDamageDropoffEndDistance
	if not first or not last or distance <= first then
		return 1
	end
	local t = math.clamp((distance - first) / math.max(last - first, 0.001), 0, 1)
	return 1 + ((info.RaycastDamageDropoffMultiplier or 1) - 1) * t
end

-- Projectile guns: one projectile per pellet, aimed like a hitscan shot (see Projectiles).
local function fireProjectiles(player: Player, fighter, item, cameraData: any, aiming: any, quickShot: any, overrides: any?)
	local info = item._info
	local origin = readCFrame(cameraData[utf8.char(0)])
	local cameraCFrame = readCFrame(cameraData[utf8.char(1)])
	local aimedPart = cameraData[utf8.char(2)]
	local aimedOffset = readCFrame(cameraData[utf8.char(3)])
	if not origin or not cameraCFrame or not nearCharacter(fighter, origin.Position) then
		return
	end

	local pellets = info.ShootPellets or 1
	for pellet = 1, pellets do
		local target
		if pellets == 1 and typeof(aimedPart) == "Instance" and aimedPart:IsA("BasePart") and aimedOffset then
			target = (aimedPart.CFrame * aimedOffset).Position
		else
			local spread = GameplayUtility:GetSpread(quickShot and info.QuickShotSpread or info.ShootSpread or 0, info.AimSpreadMultiplier, aiming == true, false, pellet, pellets, info.ShootSpreadConsistent)
			target = (cameraCFrame * spread * CFrame.new(0, 0, -CONSTANTS.MAX_RAYCAST_DISTANCE)).Position
		end
		Projectiles.Fire({
			player = player,
			fighter = fighter,
			item = item,
			info = info,
			params = lookupParams(fighter, info.RaycastGrabSmallHitboxes),
			environmentID = fighter:Get("EnvironmentID"),
			origin = CFrame.new(origin.Position) * cameraCFrame.Rotation,
			target = target,
			overrides = overrides,
		})
	end
end

local function shoot(player: Player, fighter, item, cameraData: any, aiming: any, quickShot: any)
	local info = item._info
	if typeof(cameraData) ~= "table" then
		return
	end

	local cooldown = quickShot and info.QuickShotCooldown or (info.BurstCount > 1 and info.BurstCooldown or info.ShootCooldown)
	local ammo = item:Get("Ammo")
	if (ammo and ammo <= 0 and not fighter:Get("InfiniteAmmo")) or not consumeCooldown(item, cooldown) then
		return
	end
	if item._reload_thread then
		pcall(task.cancel, item._reload_thread)
		item._reload_thread = nil
	end
	if ammo and not fighter:Get("InfiniteAmmo") then
		item:SetReplicate("Ammo", ammo - 1)
	end

	if not info.IsRaycast then
		if info.IsProjectile then
			fireProjectiles(player, fighter, item, cameraData, aiming, quickShot)
		end
		return
	end

	local origin = readCFrame(cameraData[utf8.char(0)])
	local cameraCFrame = readCFrame(cameraData[utf8.char(1)])
	local aimedPart = cameraData[utf8.char(2)]
	local aimedOffset = readCFrame(cameraData[utf8.char(3)])
	if not origin or not cameraCFrame or not nearCharacter(fighter, origin.Position) then
		return
	end

	local environmentID = fighter:Get("EnvironmentID")
	local params = lookupParams(fighter, info.RaycastGrabSmallHitboxes)
	local pellets = info.ShootPellets or 1
	local results = {}

	for pellet = 1, pellets do
		local target
		if pellets == 1 and typeof(aimedPart) == "Instance" and aimedPart:IsA("BasePart") and typeof(aimedOffset) == "CFrame" then
			target = (aimedPart.CFrame * aimedOffset).Position
		else
			local spread = GameplayUtility:GetSpread(quickShot and info.QuickShotSpread or info.ShootSpread, info.AimSpreadMultiplier, aiming == true, false, pellet, pellets, info.ShootSpreadConsistent)
			target = (cameraCFrame * spread * CFrame.new(0, 0, -CONSTANTS.MAX_RAYCAST_DISTANCE)).Position
		end

		local direction = (target - origin.Position).Unit
		if direction ~= direction then
			continue
		end

		local hits, raycast = GameplayUtility:GetEntitiesFromRaycast(environmentID, params, origin.Position, direction, CONSTANTS.MAX_RAYCAST_DISTANCE, info.RaycastPierceCount)
		table.insert(results, {
			[utf8.char(0)] = raycast.Position,
			[utf8.char(1)] = raycast.Instance,
			[utf8.char(2)] = raycast.Normal,
		})

		for _, hit in hits do
			local critical = hit.Hitbox ~= nil and string.find(hit.Hitbox.Name, "Head") ~= nil
			local distance = hit.RaycastResult and (hit.RaycastResult.Position - origin.Position).Magnitude or 0
			local damage = (critical and info.CriticalDamage or info.ShootDamage) * dropoff(info, distance)
			damageEntity(player, fighter, hit.Entity, damage, critical, hit.RaycastResult and hit.RaycastResult.Position or (hit.Hitbox and hit.Hitbox.Position))
		end
	end

	-- Gun._ShootEffect reads { ["\<index>"] = { ["\0"] = Position, ["\1"] = Instance, ["\2"] = Normal } }.
	local effect = {}
	for index, result in results do
		effect[utf8.char(index - 1)] = result
	end
	item.ReplicateToClient:Fire("ShootEffect", effect)
end

local function reload(player: Player, fighter, item, reloadFile: any)
	local info = item._info
	local ammo, reserve = item:Get("Ammo"), item:Get("AmmoReserve")
	if not info.ReloadType or not ammo or ammo >= info.MaxAmmo or item._reload_thread then
		return
	end
	local infiniteReserve = fighter:Get("InfiniteAmmoReserve")
	if reserve and reserve <= 0 and not infiniteReserve then
		return
	end

	-- The same file the client plays (Gun.StartReloading).
	local fileName = decode(reloadFile)
	if fileName ~= "Reload" and fileName ~= "EmptyReload" then
		fileName = "Reload"
	end
	local index = item:Get("NumReloadsSoFar") % math.max(info.NumReloadFiles or 1, 1) + 1
	local files = info.ReloadFiles and info.ReloadFiles[fileName]
	local file = files and files[index] or (info.ReloadFiles and info.ReloadFiles.Reload and info.ReloadFiles.Reload[1])
	local actionTime
	if info.ReloadType == "Segmented" and file then
		local missing = info.MaxAmmo - ammo
		actionTime = (file.StartLength or 0) + (file.SegmentLength or 0) * missing
	else
		actionTime = file and file.ActionTimestamp or 1
	end

	item._reload_thread = task.delay(actionTime * COOLDOWN_TOLERANCE, function()
		item._reload_thread = nil
		local current = item:Get("Ammo")
		local stock = item:Get("AmmoReserve")
		local wanted = info.MaxAmmo - current
		local moved = (infiniteReserve or not stock) and wanted or math.min(wanted, stock)
		item:SetReplicate("Ammo", current + moved)
		if stock and not infiniteReserve then
			item:SetReplicate("AmmoReserve", stock - moved)
		end
		item:SetReplicate("NumReloadsSoFar", item:Get("NumReloadsSoFar") + 1)
	end)
end

--------------------------------------------------------------------------------
-- Melee
--------------------------------------------------------------------------------

local function attack(player: Player, fighter, item, cameraData: any)
	local info = item._info
	if typeof(cameraData) ~= "table" then
		return
	end
	local cooldown = info.BurstCount > 1 and info.BurstCooldown or info.AttackCooldown
	if not consumeCooldown(item, cooldown) then
		return
	end

	local cameraCFrame = readCFrame(cameraData[utf8.char(1)])
	if not cameraCFrame then
		return
	end

	task.delay(info.AttackDelay or 0, function()
		local entity = fighter.Entity
		if not entity or not entity:IsAlive() then
			return
		end
		local head = entity.Model:FindFirstChild("Head") or entity.RootPart
		local found = {}
		GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), lookupParams(fighter, false), head.Position, info.AttackReach, false, cameraCFrame.LookVector, math.rad(info.AttackConeAngle or 90), 3, function(target, hitbox)
			table.insert(found, { Entity = target, Hitbox = hitbox })
		end)
		table.sort(found, function(a, b)
			return (a.Hitbox.Position - head.Position).Magnitude < (b.Hitbox.Position - head.Position).Magnitude
		end)
		for index, hit in found do
			if index > (info.AttackMaxHits or 1) then
				break
			end
			-- A revving Chainsaw hits harder.
			local multiplier = item._holding and (info.HoldDamageMultiplier or 1) or 1
			damageEntity(player, fighter, hit.Entity, (info.AttackDamage or 0) * multiplier, false, hit.Hitbox and hit.Hitbox.Position)
		end
	end)
end

--------------------------------------------------------------------------------
-- Throwables
--------------------------------------------------------------------------------

local function explode(player: Player, fighter, info, position: Vector3)
	explodeAt(player, fighter, position, info.ExplosionRadius or 0, info.ExplosionDamage or 0)
end

-- What each throwable does when it goes off. Those with a DetonateDelay (Grenade, Flashbang) go
-- off on their fuse; the rest on their first impact.
local CollectionService = game:GetService("CollectionService")

local function damageOverTime(player: Player, fighter, position: Vector3, radius: number, total: number, seconds: number, ticksPerSecond: number)
	local ticks = math.max(math.floor(seconds * ticksPerSecond), 1)
	task.spawn(function()
		for _ = 1, ticks do
			explodeAt(player, fighter, position, radius, total / ticks, true)
			task.wait(seconds / ticks)
		end
	end)
end

local function healOverTime(player: Player, amount: number, seconds: number)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local ticks = math.max(math.floor(seconds * 4), 1)
	task.spawn(function()
		for _ = 1, ticks do
			if humanoid.Health <= 0 then
				return
			end
			humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + amount / ticks)
			task.wait(seconds / ticks)
		end
	end)
end

local function detonate(player: Player, fighter, item, part: BasePart, hit: BasePart?)
	local info = item._info
	local name = item.Name
	local position = part.Position

	if name == "Flashbang" then
		item.ReplicateToClient:Fire("BlindEffect", position, part)
	elseif name == "Molotov" then
		item.ReplicateToClient:Fire("MolotovExplode", position)
		explodeAt(player, fighter, position, info.FireRadius or 0, info.SplashDamage or 0, true)
		damageOverTime(player, fighter, position, info.FireRadius or 0, (info.DamagePerSecond or 0) * (info.FireDuration or 0), info.FireDuration or 0, info.DamageTicksPerSecond or 4)
	elseif name == "Smoke Grenade" then
		local cloud = Instance.new("Part")
		cloud.Name = item._view_model:Get("Name") or name
		cloud.Shape = Enum.PartType.Ball
		cloud.Size = Vector3.one * (info.SmokeRadius or 16) * 2
		cloud.Anchored = true
		cloud.CanCollide = false
		cloud.CanTouch = false
		cloud.CastShadow = false
		cloud.Transparency = 1
		cloud.CFrame = CFrame.new(position)
		CollectionService:AddTag(cloud, "SmokeCloud")
		cloud.Parent = workspace
		task.delay(info.SmokeDuration or 10, function()
			cloud:Destroy()
		end)
	elseif name == "Elixir" then
		local radius = info.SplashRadius or 0
		damageOverTime(player, fighter, position, radius, info.Damage or 0, info.DamageDuration or 1, 4)
		local root = fighter.Entity and fighter.Entity.RootPart
		if root and (root.Position - position).Magnitude <= radius then
			healOverTime(player, info.Heal or 0, info.HealDuration or 1)
		end
	elseif name == "Warpstone" then
		local character = player.Character
		if character and fighter.Entity and fighter.Entity:IsAlive() then
			character:PivotTo(CFrame.new(position + Vector3.new(0, 3, 0)) * character:GetPivot().Rotation)
		end
	else
		explodeAt(player, fighter, position, info.ExplosionRadius or 0, info.ExplosionDamage or 0)
	end
	part:Destroy()
end

-- Satchels stick where they land and wait for the detonator (StartAiming).
local function attachSatchel(item, part: BasePart, hit: BasePart)
	part.AssemblyLinearVelocity = Vector3.zero
	part.Anchored = true
	if not hit.Anchored then
		part.Anchored = false
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = part
		weld.Part1 = hit
		weld.Parent = part
	end
	item.ReplicateToClient:Fire("SatchelAttached", part)
end

local function detonateSatchels(player: Player, fighter, item)
	local satchels = item._satchels or {}
	item._satchels = {}
	item:SetReplicate("NumSatchels", 0)
	for _, part in satchels do
		if part.Parent then
			detonate(player, fighter, item, part)
		end
	end
end

local function throw(player: Player, fighter, item, lob: boolean, encoded: any, charge: any, detonateLeft: any)
	local info = item._info
	if typeof(encoded) ~= "table" or not consumeCooldown(item, info.Cooldown or 1) then
		return
	end
	local start = readCFrame(encoded)
	if not start or not nearCharacter(fighter, start.Position) then
		item._next_use = 0
		return
	end

	local ammo = item:Get("Ammo")
	if ammo then
		if ammo <= 0 then
			return
		end
		item:SetReplicate("Ammo", ammo - 1)
	end

	local alpha = math.clamp(tonumber(charge) or 0, 0, 1)
	local minForce = lob and info.LobForceMin or info.ThrowForceMin or 50
	local maxForce = lob and info.LobForceMax or info.ThrowForceMax or 50
	local gravity = workspace.Gravity * 0.5 * (lob and info.LobGravity or info.ThrowGravity or 1)

	-- The server owns the projectile; clients draw the throwable's model over it (Throwable.ThrowEffect).
	local part = Instance.new("Part")
	part.Name = "Throwable"
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(1, 1, 1)
	part.Transparency = 1
	part.CanCollide = true
	part.CanTouch = true
	part.CanQuery = false
	part.CFrame = CFrame.new(start.Position)
	part.CustomPhysicalProperties = PhysicalProperties.new(1, 0.6, 0.3)
	local attachment = Instance.new("Attachment")
	attachment.Parent = part
	local lift = Instance.new("VectorForce")
	lift.Attachment0 = attachment
	lift.RelativeTo = Enum.ActuatorRelativeTo.World
	lift.ApplyAtCenterOfMass = true
	lift.Force = Vector3.new(0, part:GetMass() * (workspace.Gravity - gravity), 0)
	lift.Parent = part
	part.Parent = workspace
	part:SetNetworkOwner(nil)
	part.AssemblyLinearVelocity = start.LookVector * (minForce + (maxForce - minForce) * alpha)

	item.ReplicateToClient:Fire("ThrowEffect", part)
	if item.Name == "Grenade" then
		TaskService.Record(player, "GrenadeThrown", 1)
	end

	if info.DetonateDelay then
		local fuse = info.DetonateDelay
		if info.CanCook and tonumber(detonateLeft) then
			fuse = math.clamp(tonumber(detonateLeft), 0, fuse)
		end
		task.delay(fuse, function()
			if part.Parent then
				detonate(player, fighter, item, part)
			end
		end)
	else
		local character = player.Character
		local connection
		connection = part.Touched:Connect(function(hit: BasePart)
			if character and hit:IsDescendantOf(character) or not hit.CanCollide then
				return
			end
			connection:Disconnect()
			if item.Name == "Satchel" then
				attachSatchel(item, part, hit)
				item._satchels = item._satchels or {}
				table.insert(item._satchels, part)
				item:SetReplicate("NumSatchels", #item._satchels)
			else
				detonate(player, fighter, item, part, hit)
			end
		end)
	end

	task.delay(info.Lifetime or 10, function()
		if part.Parent then
			if item.Name == "Satchel" then
				local index = table.find(item._satchels or {}, part)
				if index then
					table.remove(item._satchels, index)
					item:SetReplicate("NumSatchels", #item._satchels)
				end
				part:Destroy()
			elseif not info.DetonateDelay then
				-- Never landed (thrown into the void or lodged somewhere): it goes off anyway.
				detonate(player, fighter, item, part)
			else
				part:Destroy()
			end
		end
	end)
end

--------------------------------------------------------------------------------
-- Custom items
--------------------------------------------------------------------------------

-- Grappler: the hook flies HookSpeed studs/s up to HookRange. On arrival the owner is told
-- ("GrapplerPull", point) and pulls itself there (the client's HardDash); a miss is
-- ("GrapplerMiss"). A pull puts the grappler on its full Cooldown ("GrapplerCooldown", seconds).
local function grapple(player: Player, fighter, item, cameraData: any)
	local info = item._info
	if typeof(cameraData) ~= "table" then
		return
	end
	local flight = (info.HookRange or 100) / (info.HookSpeed or 128)
	if not consumeCooldown(item, flight + (info.MissedCooldown or 1)) then
		return
	end

	local origin = readCFrame(cameraData[utf8.char(0)])
	local cameraCFrame = readCFrame(cameraData[utf8.char(1)])
	local aimedPart = cameraData[utf8.char(2)]
	local aimedOffset = readCFrame(cameraData[utf8.char(3)])
	if not origin or not cameraCFrame or not nearCharacter(fighter, origin.Position) then
		return
	end

	local target
	if typeof(aimedPart) == "Instance" and aimedPart:IsA("BasePart") and aimedOffset then
		target = (aimedPart.CFrame * aimedOffset).Position
	else
		target = (cameraCFrame * CFrame.new(0, 0, -(info.HookRange or 100))).Position
	end
	local direction = target - origin.Position
	if direction.Magnitude < 0.01 then
		return
	end

	local list = GameplayUtility:GetRaycastWhitelist(fighter:Get("EnvironmentID"), lookupParams(fighter, false))
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = list
	local result = workspace:Raycast(origin.Position, direction.Unit * (info.HookRange or 100), params)

	if not result then
		item.ReplicateToClient:Fire("GrapplerMiss")
		return
	end

	local arrival = (result.Position - origin.Position).Magnitude / (info.HookSpeed or 128)
	task.delay(arrival, function()
		if fighter:Get("EquippedItemID") ~= item:Get("ObjectID") or not fighter.Entity or not fighter.Entity:IsAlive() then
			return
		end
		-- A hook in a moving part (a dummy) keeps its spot relative to it.
		local hit = result.Instance
		local point = result.Position
		if hit and hit.Parent and not hit.Anchored then
			point = hit.Position + (result.Position - hit.Position)
		end
		item.ReplicateToClient:Fire("GrapplerPull", point)
		item._next_use = os.clock() + (info.Cooldown or 8) * COOLDOWN_TOLERANCE
		item.ReplicateToClient:Fire("GrapplerCooldown", info.Cooldown or 8)
	end)
end

-- Objects an item leaves in the world (jump pads, mines, portals), removed with the item.
local function track(item, instance: Instance)
	item._world_objects = item._world_objects or {}
	table.insert(item._world_objects, instance)
	instance.Destroying:Connect(function()
		local index = table.find(item._world_objects, instance)
		if index then
			table.remove(item._world_objects, index)
		end
	end)
end

local function isStillEquipped(fighter, item): boolean
	return fighter:Get("EquippedItemID") == item:Get("ObjectID") and fighter.Entity ~= nil and fighter.Entity:IsAlive()
end

local function aimOf(fighter, cameraData: any)
	if typeof(cameraData) ~= "table" then
		return nil
	end
	local origin = readCFrame(cameraData[utf8.char(0)])
	local cameraCFrame = readCFrame(cameraData[utf8.char(1)])
	if not origin or not cameraCFrame or not nearCharacter(fighter, origin.Position) then
		return nil
	end
	local aimedPart = cameraData[utf8.char(2)]
	if typeof(aimedPart) ~= "Instance" or not aimedPart:IsA("BasePart") then
		aimedPart = nil
	end
	return origin, cameraCFrame, aimedPart, readCFrame(cameraData[utf8.char(3)])
end

-- Medkit: StartShooting heals LongHeal at LongActionTimestamp, StartAiming QuickHeal at
-- QuickActionTimestamp; switching away cancels. Then ("SetCooldown").
local function useMedkit(player: Player, fighter, item, kind: string)
	local info = item._info
	local humanoid = fighter.Entity and fighter.Entity.Humanoid
	if item._using or os.clock() < item._next_use or not humanoid or humanoid.Health >= humanoid.MaxHealth then
		return
	end
	item._using = true
	item._use_hash = (item._use_hash or 0) + 1
	local hash = item._use_hash
	task.delay(info[kind .. "ActionTimestamp"] or 1, function()
		if item._use_hash ~= hash then
			return
		end
		item._using = false
		if not isStillEquipped(fighter, item) then
			item.ReplicateToClient:Fire("CancelUse")
			return
		end
		humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + (info[kind .. "Heal"] or 0))
		item._next_use = os.clock() + (info.Cooldown or 1) * COOLDOWN_TOLERANCE
		item.ReplicateToClient:Fire("SetCooldown")
	end)
end

-- War Horn: a speed boost for its user (Boosts on the character).
local function useWarHorn(player: Player, fighter, item)
	local info = item._info
	if not fighter.Entity or not consumeCooldown(item, info.Cooldown or 1) then
		return
	end
	fighter.Entity.ReplicateToClient:Fire("SetBoost", "Speed", "WarHorn", info.SpeedBoostDuration or 6, info.SpeedBoost or 0.25)
end

-- Jump Pad: placed where the player aims (within MaxReach); anyone touching it is launched away
-- from the surface (KnockbackEffect, applied by the owner of that character).
-- Launch speed along the pad's normal, same scale as the map's own pads (Velocity 0,50,0 / 0,75,0).
local JUMP_PAD_LAUNCH = 75
-- Pads on walls still throw the player upwards a bit.
local JUMP_PAD_MIN_UP = 40
local function placeJumpPad(player: Player, fighter, item, cameraData: any)
	local info = item._info
	local origin, cameraCFrame, aimedPart, aimedOffset = aimOf(fighter, cameraData)
	local ammo = item:Get("Ammo")
	if not origin or (ammo and ammo <= 0) or not consumeCooldown(item, info.Cooldown or 0.5) then
		return
	end
	local ok, result, placement = pcall(GameplayUtility.GetJumpPadPlacement, GameplayUtility, fighter:Get("EnvironmentID"), info.MaxReach or 32, origin, cameraCFrame, aimedPart, aimedOffset)
	if not ok or not placement then
		return
	end
	if ammo then
		item:SetReplicate("Ammo", ammo - 1)
	end

	-- The placement CFrame sits on the surface with LookVector = normal; the hitbox stands on it
	-- (JumpPads.lua puts the visual at hitbox * (0, 0, Size.Z / 2), back on the surface).
	local size = info.HitboxSize or Vector3.new(11, 11, 2)
	local pad = Instance.new("Part")
	pad.Name = "JumpPad"
	pad.Anchored = true
	pad.CanCollide = false
	pad.CanQuery = false
	pad.CanTouch = true
	pad.Transparency = 1
	pad.Size = size
	pad.CFrame = placement * CFrame.new(0, 0, -size.Z / 2)
	pad:SetAttribute("ViewModelName", item._view_model:Get("Name"))
	pad:SetAttribute("ObjectID", item:Get("ObjectID"))
	-- Each client launches its own character (CustomKnockbackParts -> Entity:AirborneTrigger),
	-- like the map's pads: no server round trip on touch.
	pad:SetAttribute("Velocity", Vector3.new(0, 0, -JUMP_PAD_LAUNCH * (info.Strength or 1)))
	pad:SetAttribute("LocalTo", "Rotation")
	pad:SetAttribute("MinimumYVelocity", JUMP_PAD_MIN_UP)
	pad:SetAttribute("HasToBeInFront", CFrame.new(0, 0, size.Z / 2))
	pad:SetAttribute("Override", true)
	pad:SetAttribute("MathHitboxCheckEnabled", true)
	CollectionService:AddTag(pad, "JumpPadHitbox")
	CollectionService:AddTag(pad, "CustomKnockbackPart")
	pad.Parent = workspace
	track(item, pad)
	task.delay(info.Lifetime or 90, function()
		pad:Destroy()
	end)
end

-- Subspace Tripmine: placed at the player's feet; after HitboxDelay it goes off on the first
-- target that comes near.
local TRIPMINE_TRIGGER_RADIUS = 5
local function placeTripmine(player: Player, fighter, item, aimed: any)
	local info = item._info
	local root = fighter.Entity and fighter.Entity.RootPart
	local ammo = item:Get("Ammo")
	if typeof(aimed) ~= "Vector3" or not root or (ammo and ammo <= 0) or not consumeCooldown(item, info.Cooldown or 0.5) then
		return
	end
	if (aimed - root.Position).Magnitude > MAX_ORIGIN_DISTANCE * 4 then
		return
	end
	if ammo then
		item:SetReplicate("Ammo", ammo - 1)
	end
	local placement = GameplayUtility:GetSubspaceTripminePlacement(info.MaxReach or 3, aimed, root.Position)

	local mine = Instance.new("Model")
	mine.Name = "SubspaceTripmine"
	local template = game:GetService("StarterPlayer").StarterPlayerScripts.Assets.ViewModels.Weapons:FindFirstChild("Subspace Tripmine")
	if template then
		local visual = template:Clone()
		for _, part in visual:GetDescendants() do
			if part:IsA("BasePart") then
				part.Anchored = true
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
			end
		end
		visual:PivotTo(placement)
		visual.Parent = mine
	end
	local hitbox = Instance.new("Part")
	hitbox.Name = "Hitbox"
	hitbox.Shape = Enum.PartType.Ball
	hitbox.Size = Vector3.one * TRIPMINE_TRIGGER_RADIUS * 2
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.CanQuery = false
	hitbox.CanTouch = false
	hitbox.Transparency = 1
	hitbox.CFrame = placement
	hitbox.Parent = mine
	mine.PrimaryPart = hitbox
	mine:SetAttribute("ObjectID", item:Get("ObjectID"))
	mine:SetAttribute("HitboxDelay", info.HitboxDelay or 1)
	mine:SetAttribute("PlacedByUserID", player.UserId)
	mine:SetAttribute("TeamID", fighter:Get("TeamID"))
	CollectionService:AddTag(mine, "SubspaceTripmine")
	mine.Parent = workspace
	track(item, mine)

	task.spawn(function()
		task.wait(info.HitboxDelay or 1)
		local params = lookupParams(fighter, false)
		while mine.Parent do
			local triggered = false
			GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), params, placement.Position, TRIPMINE_TRIGGER_RADIUS, true, nil, nil, nil, function()
				triggered = true
			end)
			if triggered then
				item.ReplicateToClient:Fire("MineExplosion", placement.Position)
				explodeAt(player, fighter, placement.Position, info.ExplosionRadius or 12, info.ExplosionDamage or 0)
				mine:Destroy()
				return
			end
			task.wait(0.1)
		end
	end)
end

-- Flamethrower: while held, DamagePerSecond to what is within Reach in front, burning fuel;
-- out of fuel it stops (("StopUsing")) and refills while not in use.
local FLAME_CONE = math.rad(35)
local FUEL_PER_SECOND = 10
local FUEL_REFILL_PER_SECOND = 20
local function startFlame(player: Player, fighter, item)
	local info = item._info
	if item._flaming or (item:Get("Ammo") or 0) <= 0 then
		return
	end
	item._flaming = true
	task.spawn(function()
		local ticks = math.max(info.DamageTicksPerSecond or 10, 1)
		while item._flaming do
			local ammo = item:Get("Ammo") or 0
			if ammo <= 0 or not isStillEquipped(fighter, item) then
				item._flaming = false
				item.ReplicateToClient:Fire("StopUsing")
				break
			end
			item:SetReplicate("Ammo", math.max(0, ammo - FUEL_PER_SECOND / ticks))
			local head = fighter.Entity.Model:FindFirstChild("Head") or fighter.Entity.RootPart
			local look = fighter.Entity.RootPart.CFrame.LookVector
			GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), lookupParams(fighter, false), head.Position, info.Reach or 26, false, look, FLAME_CONE, 3, function(target, hitbox)
				damageEntity(player, fighter, target, (info.DamagePerSecond or 0) / ticks, false, hitbox and hitbox.Position)
			end)
			task.wait(1 / ticks)
		end
		-- Fuel comes back while the flame is off.
		while not item._flaming and item:Get("Ammo") and item:Get("Ammo") < (info.MaxAmmo or 100) and item._fighter do
			task.wait(0.25)
			if item._flaming then
				break
			end
			item:SetReplicate("Ammo", math.min(info.MaxAmmo or 100, (item:Get("Ammo") or 0) + FUEL_REFILL_PER_SECOND * 0.25))
		end
	end)
end

-- RNG Dice: re-rolls the primary and secondary into random weapons of their class.
local ShopLibrary = require(Modules:WaitForChild("ShopLibrary"))
local function rollDice(player: Player, fighter, item)
	local info = item._info
	local loadout = loadouts[fighter]
	if not loadout or not consumeCooldown(item, info.Cooldown or 3) then
		return
	end
	local ok, pool = pcall(ShopLibrary.GetReleasedOwnableWeapons, ShopLibrary, CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)
	if not ok or type(pool) ~= "table" then
		pool = {}
		for name in ItemLibrary.Items do
			table.insert(pool, name)
		end
	end
	local rolled = nil
	for slot = 1, math.min(info.MaxItems or 2, 2) do
		local class = ItemLibrary.SlotToClass[slot].Name
		local current = loadout.items[slot]
		local choices = {}
		for _, name in pool do
			local weapon = ItemLibrary.Items[name]
			if weapon and weapon.Class == class and (not current or current.Name ~= name) then
				table.insert(choices, name)
			end
		end
		if #choices > 0 then
			local pick = choices[math.random(#choices)]
			if current then
				loadout.byID[current:Get("ObjectID")] = nil
				current._connection:Disconnect()
				fighter.ReplicateToClient:Fire("ItemRemoved", current:Get("ObjectID"))
				current._view_model:Destroy()
				current:Destroy()
			end
			createItem(player, fighter, pick, slot)
			rolled = rolled or pick
		end
	end
	if rolled then
		item.ReplicateToClient:Fire("RollResult", rolled, false)
	end
end

-- Warper: StartShooting opens portal 1, StartAiming portal 2, on the surface aimed at (up to
-- MaxPortalRange). The client warps its own character between two grown portals.
local PORTAL_SIZE = Vector3.new(5, 7, 1)
local function openPortal(player: Player, fighter, item, number: number, cameraData: any)
	local info = item._info
	local origin, cameraCFrame, aimedPart, aimedOffset = aimOf(fighter, cameraData)
	if not origin or not consumeCooldown(item, info.ShootCooldown or 0.25) then
		return
	end
	local target = aimedPart and aimedOffset and (aimedPart.CFrame * aimedOffset).Position or (cameraCFrame * CFrame.new(0, 0, -(info.MaxPortalRange or 512))).Position
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = GameplayUtility:GetRaycastWhitelist(fighter:Get("EnvironmentID"))
	local direction = target - origin.Position
	if direction.Magnitude < 0.01 then
		return
	end
	local result = workspace:Raycast(origin.Position, direction.Unit * (info.MaxPortalRange or 512), params)
	if not result then
		return
	end
	local distance = (result.Position - origin.Position).Magnitude
	if distance < (info.PortalDeadzone or 0) then
		return
	end

	local model = item._portal_model
	if not model or not model.Parent then
		model = Instance.new("Model")
		model.Name = "Portals"
		model:SetAttribute("ItemID", item:Get("ObjectID"))
		model:SetAttribute("UserID", player.UserId)
		CollectionService:AddTag(model, "PortalModel")
		model.Parent = workspace
		item._portal_model = model
		track(item, model)
	end
	local old = model:FindFirstChild(tostring(number))
	if old then
		old:Destroy()
	end

	local up = math.abs(result.Normal:Dot(Vector3.yAxis)) > 0.9 and cameraCFrame.LookVector or Vector3.yAxis
	local portal = Instance.new("Model")
	portal.Name = tostring(number)
	portal:SetAttribute("ViewModelName", item._view_model:Get("Name"))
	portal:SetAttribute("OwnerUserID", player.UserId)
	portal:SetAttribute("OwnerTeamID", fighter:Get("TeamID"))
	local threshold = info.PortalDelayedSpawnThreshold or 64
	portal:SetAttribute("SpawnDelay", distance > threshold and (distance - threshold) * (info.PortalDelayedSpawnSecondsPerStud or 0) or 0)
	local hitbox = Instance.new("Part")
	hitbox.Name = "Hitbox"
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.CanQuery = false
	hitbox.CanTouch = true
	hitbox.Transparency = 1
	hitbox.Size = PORTAL_SIZE
	hitbox.CFrame = CFrame.lookAt(result.Position + result.Normal * 0.6, result.Position + result.Normal * 2, up)
	hitbox.Parent = portal
	portal.PrimaryPart = hitbox
	portal.Parent = model
end

--------------------------------------------------------------------------------
-- Melee specials (StartAiming / FinishAiming)
--------------------------------------------------------------------------------

-- A timer of its own for each special, apart from the item's main use (`_next_use`): a Maul's
-- slam cooldown must not hold back its normal swings.
local function consumeTimer(item, key: string, cooldown: number): boolean
	item._timers = item._timers or {}
	local now = os.clock()
	if now < (item._timers[key] or 0) then
		return false
	end
	item._timers[key] = now + (cooldown or 0) * COOLDOWN_TOLERANCE
	return true
end

-- The first target in front of the fighter within `reach` (cone of `coneDegrees`).
local function firstInFront(fighter, cameraCFrame: CFrame, reach: number, coneDegrees: number)
	local entity = fighter.Entity
	local head = entity and (entity.Model:FindFirstChild("Head") or entity.RootPart)
	if not head then
		return nil
	end
	local found = {}
	GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), lookupParams(fighter, false), head.Position, reach, false, cameraCFrame.LookVector, math.rad(coneDegrees), 3, function(target, hitbox)
		table.insert(found, { Entity = target, Hitbox = hitbox })
	end)
	table.sort(found, function(a, b)
		return (a.Hitbox.Position - head.Position).Magnitude < (b.Hitbox.Position - head.Position).Magnitude
	end)
	return found[1], head
end

-- Knife: a heavy stab in front; from behind the target it is a backstab (CriticalDamage).
local function knifeHeavy(player: Player, fighter, item, cameraData: any)
	local info = item._info
	local _, cameraCFrame = aimOf(fighter, cameraData)
	if not cameraCFrame or not consumeTimer(item, "Heavy", info.HeavyAttackCooldown or 1) then
		return
	end
	task.delay(info.AttackDelay or 0, function()
		local hit, head = firstInFront(fighter, cameraCFrame, info.HeavyAttackReach or 7, info.AttackConeAngle or 90)
		if not hit then
			return
		end
		local targetRoot = hit.Entity.RootPart or hit.Hitbox
		local toAttacker = (head.Position - targetRoot.Position) * Vector3.new(1, 0, 1)
		local backstab = toAttacker.Magnitude > 0.01 and targetRoot.CFrame.LookVector:Dot(toAttacker.Unit) < -0.3
		if backstab then
			item.ReplicateToClient:Fire("BackstabEffect")
		end
		damageEntity(player, fighter, hit.Entity, backstab and (info.CriticalDamage or 150) or (info.HeavyAttackDamage or 40), backstab, hit.Hitbox.Position)
	end)
end

-- Spear: thrown (uses Ammo). It flies as a projectile carrying the spear model; stuck in a wall
-- it becomes a tightrope (Tightrope tag, drawn and walked on by the client) for
-- ThrownSpearLifetime, and touching it gives the owner the spear back.
local SPEAR_SPEED = 160
local SPEAR_GRAVITY = 0.25
local function throwSpear(player: Player, fighter, item, cameraData: any)
	local info = item._info
	local ammo = item:Get("Ammo") or 0
	local origin, cameraCFrame, aimedPart, aimedOffset = aimOf(fighter, cameraData)
	if not origin or ammo <= 0 or not consumeTimer(item, "Throw", info.ThrowCooldown or 1) then
		return
	end
	item:SetReplicate("Ammo", ammo - 1)

	local target = aimedPart and aimedOffset and (aimedPart.CFrame * aimedOffset).Position or (cameraCFrame * CFrame.new(0, 0, -CONSTANTS.MAX_RAYCAST_DISTANCE)).Position
	local viewModelName = item._view_model:Get("Name")
	local environmentID = fighter:Get("EnvironmentID")
	local length = info.ThrownSpearLength or 5

	local projectile = Projectiles.Fire({
		player = player,
		fighter = fighter,
		item = item,
		info = info,
		params = lookupParams(fighter, false),
		environmentID = environmentID,
		origin = CFrame.new(origin.Position) * cameraCFrame.Rotation,
		target = target,
		overrides = {
			ProjectileSpeed = SPEAR_SPEED,
			ProjectileGravity = SPEAR_GRAVITY,
			ProjectileRaycastRadius = 0.3,
			ProjectileLifetime = 5,
			ProjectileMaxHits = 1,
			ProjectileSpawnOffset = CFrame.new(0.5, -0.5, -1),
			ShootDamage = info.ThrowDamage or 25,
			CriticalDamage = info.CriticalThrowDamage or 50,
			ShootExplosionRadius = 0,
		},
		onStop = function(position: Vector3?, worldHit: RaycastResult?, velocity: Vector3)
			if not position or not worldHit or velocity.Magnitude < 0.01 then
				return
			end
			-- Stuck in the wall: the tightrope sticks out along the throw.
			local direction = velocity.Unit
			local rope = Instance.new("Part")
			rope.Name = "SpearTightrope"
			rope.Size = Vector3.new(0.4, 0.4, length)
			rope.CFrame = CFrame.lookAt(position - direction * (length / 2 - 0.5), position)
			rope.Anchored = true
			rope.CanCollide = true
			rope.CanQuery = false
			rope.Transparency = 1
			rope:SetAttribute("ObjectID", item:Get("ObjectID"))
			rope:SetAttribute("IsSpear", true)
			rope:SetAttribute("ViewModelName", viewModelName)
			local folder = workspace:FindFirstChild("Tightropes")
			if not folder then
				folder = Instance.new("Folder")
				folder.Name = "Tightropes"
				folder.Parent = workspace
			end
			folder:SetAttribute("EnvironmentID", environmentID)
			CollectionService:AddTag(rope, "Tightrope")
			rope.Parent = folder
			track(item, rope)
			rope.Touched:Connect(function(hit: BasePart)
				if player.Character and hit:IsDescendantOf(player.Character) and rope.Parent then
					rope:Destroy()
					item:SetReplicate("Ammo", math.min(info.MaxAmmo or 3, (item:Get("Ammo") or 0) + 1))
				end
			end)
			task.delay(info.ThrownSpearLifetime or 90, function()
				if rope.Parent then
					rope:Destroy()
					item:SetReplicate("Ammo", math.min(info.MaxAmmo or 3, (item:Get("Ammo") or 0) + 1))
				end
			end)
		end,
	})

	-- The spear model rides the projectile.
	local template = game:GetService("StarterPlayer").StarterPlayerScripts.Assets.SpearTightropes
	local model = template:FindFirstChild(viewModelName) or template:FindFirstChild("Spear")
	if model and projectile and projectile.part then
		local visual = model:Clone()
		for _, part in visual:GetDescendants() do
			if part:IsA("BasePart") then
				part.Anchored = false
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.Massless = true
			end
		end
		visual:PivotTo(projectile.part.CFrame)
		for _, part in visual:GetDescendants() do
			if part:IsA("BasePart") then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = projectile.part
				weld.Part1 = part
				weld.Parent = part
			end
		end
		visual.Parent = projectile.part
	end
end

-- Trowel: a wall of bricks at the point aimed at (within BuildReach), facing the builder. The
-- bricks join the environment's geometry, so they stop shots, and go away after BrickLifetime.
local BRICK_SIZE = Vector3.new(2.4, 1.2, 1.2)
local WALL_COLUMNS = 5
local function buildWall(player: Player, fighter, item, position: any)
	local info = item._info
	local root = fighter.Entity and fighter.Entity.RootPart
	if typeof(position) ~= "Vector3" or not root or (position - root.Position).Magnitude > (info.BuildReach or 50) + 5 then
		return
	end
	if not consumeTimer(item, "Build", info.BuildCooldown or 4) then
		return
	end
	local environmentID = fighter:Get("EnvironmentID")
	local geometry = CollectionService:GetTagged("RaycastWhitelist" .. (environmentID or ""))[1] or workspace
	local facing = (root.Position - position) * Vector3.new(1, 0, 1)
	facing = facing.Magnitude > 0.01 and facing.Unit or Vector3.zAxis
	local base = CFrame.lookAt(position, position + facing)
	local count = info.MaxBricks or 25
	local rows = math.ceil(count / WALL_COLUMNS)

	item.ReplicateToClient:Fire("ThrowEffect", position)
	local wall = Instance.new("Model")
	wall.Name = "TrowelWall"
	wall.Parent = geometry
	track(item, wall)
	task.spawn(function()
		for index = 0, count - 1 do
			if not wall.Parent then
				return
			end
			local column = index % WALL_COLUMNS
			local row = math.floor(index / WALL_COLUMNS)
			-- Every other row is offset by half a brick, like a real wall.
			local shift = (row % 2 == 1) and BRICK_SIZE.X / 2 or 0
			local x = (column - (WALL_COLUMNS - 1) / 2) * BRICK_SIZE.X + shift - BRICK_SIZE.X / 4
			local y = BRICK_SIZE.Y / 2 + row * BRICK_SIZE.Y
			local brick = Instance.new("Part")
			brick.Name = "Brick"
			brick.Size = BRICK_SIZE
			brick.Material = Enum.Material.Brick
			brick.Color = Color3.fromRGB(151, 0, 0)
			brick.Anchored = true
			brick.CFrame = base * CFrame.new(x, y, 0)
			CollectionService:AddTag(brick, "TrowelBrick")
			brick.Parent = wall
			if row == rows - 1 and column == WALL_COLUMNS - 1 then
				break
			end
			task.wait(0.02)
		end
		item.ReplicateToClient:Fire("HardenEffect", position)
	end)
	task.delay(info.BrickLifetime or 30, function()
		wall:Destroy()
	end)
end

-- Chainsaw: revving (StartAiming until FinishAiming) burns fuel and triples its hits; the client
-- handles the speed boost. Out of fuel it stops (("StopHolding")); fuel refills while idle.
local CHAINSAW_FUEL_PER_SECOND = 30
local CHAINSAW_REFILL_PER_SECOND = 25
local function startChainsaw(player: Player, fighter, item)
	if item._holding or (item:Get("Ammo") or 0) <= 0 then
		return
	end
	item._holding = true
	task.spawn(function()
		while item._holding do
			local ammo = item:Get("Ammo") or 0
			if ammo <= 0 or not isStillEquipped(fighter, item) then
				item._holding = false
				item.ReplicateToClient:Fire("StopHolding")
				break
			end
			item:SetReplicate("Ammo", math.max(0, ammo - CHAINSAW_FUEL_PER_SECOND * 0.1))
			task.wait(0.1)
		end
		while not item._holding and (item:Get("Ammo") or 0) < (item._info.MaxAmmo or 150) and item._fighter do
			task.wait(0.25)
			if item._holding then
				break
			end
			item:SetReplicate("Ammo", math.min(item._info.MaxAmmo or 150, (item:Get("Ammo") or 0) + CHAINSAW_REFILL_PER_SECOND * 0.25))
		end
	end)
end

-- Maul: StartAiming(true) is the slam (the client drives the fall); on landing it hits
-- everything within SlamRadius (("SlamAttack", position, radius)). A leap (false) is client-only.
local SLAM_TIMEOUT = 3
local function maulSlam(player: Player, fighter, item, isSlam: any)
	local info = item._info
	if isSlam ~= true or not fighter.Entity or not consumeTimer(item, "Slam", info.SlamCooldown or 6) then
		return
	end
	local humanoid = fighter.Entity.Humanoid
	local root = fighter.Entity.RootPart
	task.spawn(function()
		local started = os.clock()
		-- Wait until it leaves the ground (the slam starts in the air), then until it lands.
		while os.clock() - started < SLAM_TIMEOUT do
			task.wait()
			if not fighter.Entity or not humanoid.Parent or humanoid.Health <= 0 then
				item.ReplicateToClient:Fire("CancelSlam")
				return
			end
			if humanoid.FloorMaterial ~= Enum.Material.Air and os.clock() - started > 0.05 then
				local position = root.Position - Vector3.new(0, humanoid.HipHeight + root.Size.Y / 2, 0)
				item.ReplicateToClient:Fire("SlamAttack", position, info.SlamRadius or 24)
				explodeAt(player, fighter, position, info.SlamRadius or 24, info.SlamDamage or 50, true)
				return
			end
		end
		item.ReplicateToClient:Fire("CancelSlam")
	end)
end

-- Battle Axe: a spinning dash (client-driven) that hits everything within SpinRadius once.
local function axeSpin(player: Player, fighter, item)
	local info = item._info
	if not fighter.Entity or not consumeTimer(item, "Spin", info.SpinCooldown or 4) then
		return
	end
	local hitAlready = {}
	local function sweep()
		local root = fighter.Entity and fighter.Entity.RootPart
		if not root then
			return
		end
		GameplayUtility:GetEntitiesWithinSphere(fighter:Get("EnvironmentID"), lookupParams(fighter, false), root.Position, info.SpinRadius or 10, false, nil, nil, nil, function(target, hitbox)
			if not hitAlready[target] then
				hitAlready[target] = true
				damageEntity(player, fighter, target, info.SpinDamage or 30, false, hitbox.Position)
			end
		end)
	end
	task.delay(0.05, sweep)
	task.delay(info.SpinDuration or 0.25, sweep)
end

-- Katana: a deflect window (it only matters against other fighters' attacks).
local function katanaDeflect(player: Player, fighter, item)
	local info = item._info
	if not consumeTimer(item, "Deflect", (info.DeflectDuration or 1) + (info.DeflectCooldown or 4)) then
		return
	end
	item._deflect_until = os.clock() + (info.DeflectDuration or 1)
end

--------------------------------------------------------------------------------

-- Uses the other clients replay on this player's item (ClientItem.ReplicateFromServer ->
-- item:Input(action, true, ...)), so everyone sees the shot, the reload, the aim or the swing
-- animated on the weapon. [item type][action] = what the item's method takes after `forced`,
-- picked out of what the player's client sent.
local function none()
	return
end
local RELAYED = {
	Gun = {
		-- StartShooting(cameraData, aiming, quickShot) -> StartShooting(forced, quickShot)
		StartShooting = function(_cameraData, _aiming, quickShot)
			return quickShot == true
		end,
		-- StartReloading(<enum file>, <enum animation>) -> the same reload
		StartReloading = function(file, animation)
			return file, animation
		end,
		StartAiming = none,
		FinishAiming = none,
		StartInspecting = none,
	},
	Melee = {
		-- StartShooting(cameraData, <enum animation>) -> StartShooting(forced, <enum animation>)
		StartShooting = function(_cameraData, animation)
			return animation
		end,
		StartInspecting = none,
	},
	Throwable = {
		-- The wind-up; the throw itself is the server's ThrowEffect.
		StartShooting = none,
		StartAiming = none,
		StartInspecting = none,
	},
	Custom = {
		StartShooting = none,
		StartInspecting = none,
	},
}

local function useItem(player: Player, itemID: any, action: any, ...)
	local fighter = FighterService.Get(player)
	local loadout = fighter and loadouts[fighter]
	local item = loadout and loadout.byID[itemID]
	if not item or fighter:Get("EquippedItemID") ~= itemID or not fighter.Entity or not fighter.Entity:IsAlive() then
		return
	end
	-- A duel's countdown (ClientFighter:AreItemsLocked reads the same flag).
	if fighter:Get("ItemsLocked") then
		return
	end

	action = decode(action)
	local itemType = item._info.Type
	local relay = RELAYED[itemType] and RELAYED[itemType][action]
	if relay then
		item.ReplicateToClient:Fire(action, relay(...))
	end
	if itemType == "Gun" then
		if action == "StartShooting" then
			shoot(player, fighter, item, ...)
		elseif action == "StartReloading" then
			reload(player, fighter, item, ...)
		elseif action == "FinishAiming" and item.Name == "Bow" then
			-- The charged shot, released when aiming ends.
			shoot(player, fighter, item, ...)
		elseif action == "StartAiming" and item._info.GrenadeExplosionRadius then
			-- Paintball Gun: a paint grenade that bursts where it lands.
			local info = item._info
			local cameraData = ...
			if typeof(cameraData) == "table" and os.clock() >= (item._next_grenade or 0) then
				item._next_grenade = os.clock() + (info.GrenadeShootCooldown or 1) * COOLDOWN_TOLERANCE
				fireProjectiles(player, fighter, item, cameraData, false, false, {
					ProjectileNameOverride = "_paintballgun_grenade",
					ProjectileGravity = 1,
					ProjectileSpeed = 120,
					ShootExplosionRadius = info.GrenadeExplosionRadius,
					ShootExplosionDamage = info.ShootDamage,
				})
			end
		end
	elseif itemType == "Melee" then
		local name = item.Name
		if action == "StartShooting" then
			attack(player, fighter, item, ...)
		elseif action == "StartAiming" and name == "Knife" then
			knifeHeavy(player, fighter, item, ...)
		elseif action == "StartAiming" and name == "Spear" then
			throwSpear(player, fighter, item, ...)
		elseif action == "StartAiming" and name == "Trowel" then
			buildWall(player, fighter, item, ...)
		elseif action == "StartAiming" and name == "Chainsaw" then
			startChainsaw(player, fighter, item)
		elseif action == "FinishAiming" and name == "Chainsaw" then
			item._holding = false
		elseif action == "StartAiming" and name == "Maul" then
			maulSlam(player, fighter, item, ...)
		elseif action == "StartAiming" and name == "Battle Axe" then
			axeSpin(player, fighter, item)
		elseif action == "StartAiming" and name == "Katana" then
			katanaDeflect(player, fighter, item)
		elseif action == "StartAiming" and item._info.DashCooldown then
			local now = os.clock()
			if now >= (item._next_dash or 0) then
				item._next_dash = now + item._info.DashCooldown * COOLDOWN_TOLERANCE
				if item.Name == "Scythe" then
					TaskService.Record(player, "ScytheDash", 1)
				end
			end
		end
	elseif itemType == "Custom" then
		local name = item.Name
		if name == "Grappler" and action == "StartShooting" then
			grapple(player, fighter, item, ...)
		elseif name == "Medkit" and (action == "StartShooting" or action == "StartAiming") then
			useMedkit(player, fighter, item, action == "StartShooting" and "Long" or "Quick")
		elseif name == "War Horn" and action == "StartShooting" then
			useWarHorn(player, fighter, item)
		elseif name == "Jump Pad" and action == "StartShooting" then
			placeJumpPad(player, fighter, item, ...)
		elseif name == "Subspace Tripmine" and action == "StartShooting" then
			placeTripmine(player, fighter, item, ...)
		elseif name == "Flamethrower" then
			if action == "StartShooting" then
				startFlame(player, fighter, item)
			elseif action == "FinishShooting" then
				item._flaming = false
			end
		elseif name == "RNG Dice" and action == "StartShooting" then
			rollDice(player, fighter, item)
		elseif name == "Warper" and (action == "StartShooting" or action == "StartAiming") then
			openPortal(player, fighter, item, action == "StartShooting" and 1 or 2, ...)
		end
	elseif itemType == "Throwable" then
		if action == "FinishShooting" then
			throw(player, fighter, item, false, ...)
		elseif action == "FinishAiming" then
			throw(player, fighter, item, true, ...)
		elseif action == "StartAiming" and item.Name == "Satchel" then
			detonateSatchels(player, fighter, item)
		end
	end
end

function ItemService.Start()
	Projectiles.Init({
		damage = function(player, fighter, entity, amount, critical, position)
			damageEntity(player, fighter, entity, amount, critical, position)
		end,
		explode = function(...)
			explodeAt(...)
		end,
	})
	FighterService.SerializeItems = serializeItems
	table.insert(FighterService.EntityRemovedCallbacks, ItemService.ClearItems)

	FighterRemotes.PickWeapons.OnServerEvent:Connect(pickWeapons)
	-- The client warps itself through Warper portals and reports it; nothing to do here.
	FighterRemotes.JustWarped.OnServerEvent:Connect(function() end)
	FighterRemotes.UseItem.OnServerEvent:Connect(useItem)

	FighterRemotes.EquipItemFeedback.OnServerInvoke = function(player: Player, itemID: any)
		local fighter = FighterService.Get(player)
		local loadout = fighter and loadouts[fighter]
		if not loadout or not loadout.byID[itemID] then
			return false
		end
		if fighter:Get("EquippedItemID") ~= itemID then
			fighter:SetReplicate("EquippedItemID", itemID)
			if loadout.byID[itemID].Name == "Scythe" then
				TaskService.Record(player, "EquipScythe", 1)
			end
		end
		return true
	end

	Players.PlayerRemoving:Connect(function(player: Player)
		local fighter = FighterService.Get(player)
		if fighter then
			loadouts[fighter] = nil
		end
	end)
end

ItemService.Remotes = { FighterRemotes.PickWeapons, FighterRemotes.UseItem, FighterRemotes.EquipItemFeedback, FighterRemotes.JustWarped }

return ItemService
