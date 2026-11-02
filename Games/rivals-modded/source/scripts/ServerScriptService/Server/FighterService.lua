-- One Fighter per player, replicated to every client (Remotes.Replication.Fighter).
--
-- FighterController on the client waits for the local player's fighter before the lobby
-- HUD (Play, shop, loadout...) shows at all, and hides it again while IsInDuel or
-- IsInShootingRange is set.
--
-- A fighter's character is its Entity, built on the client as ClientFighterCharacter (the
-- nametag, animations, arms, sounds...). It travels inside the fighter:
--
--   fighter serial        top-level Entity = the entity's serial, for anyone who asks late
--   fighter change        ("EntityAdded", entitySerial) / ("EntityRemoved")
--   fighter change        ("EntityChanged", <enum changeType>, ...)   the entity's own changes
--
-- The entity serial carries Model, RootPart, Humanoid and Player at its top level, which is
-- where ClientEntity / ClientHumanoidEntity / ClientFighterCharacter read them from.
--
--   Replication.Fighter.SetControls(scheme)   -> Controls ("MouseKeyboard", "Touch", ...)
--   Replication.Fighter.UpdateState(<enum state>, value)   movement from MechanicsController:
--        IsCrouching / IsSprinting / IsSliding (bool), CameraLean (-1..1) -> fighter data, which
--        is how other clients animate and pose this fighter. A slide counts for its task.
--   Replication.Fighter.PlayMechanicsSound(name)   -> fighter change ("PlayMechanicsSound", name)
--        for the other clients (the sender already played it).
--   Replication.Fighter.UpdateCameraRotation(xy)   where the player looks, 2 utf8 chars (X, Y in
--        256ths of a turn, Utility:EncodeCameraRotation). Every CAMERA_INTERVAL the changes go to
--        everyone as UpdateCameraRotations(utf8(DecodedNetworkID) .. xy ..): other players'
--        weapons (third-person viewmodel), heads and torsos aim with it.
--   Replication.Fighter.SpectateDuel(duelObjectID | nil)   the duel the client wants to watch
--        (its own, once it is a dueler) -> fighter SpectatingDuelObjectID, which is what shows
--        that duel's map and interface (SpectateController).
--
-- A character is an entity like the range's dummies: the model is tagged Entity and its body
-- parts EntityHitbox, which is how GameplayUtility (server and client) finds what a shot hit.
-- Hits only count between fighters of the same EnvironmentID and different TeamID.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))

local ReplicatedCollection = require(script.Parent.ReplicatedCollection)

local FighterRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter")

local CONTROLS = { MouseKeyboard = true, Touch = true, Gamepad = true, VR = true }
local BOOLEAN_STATES = { IsCrouching = true, IsSprinting = true, IsSliding = true }
local MECHANICS_SOUNDS = { Slide = true, DoubleJump = true, Warp = true }
local SOUND_INTERVAL = 0.1
local CAMERA_INTERVAL = 0.1

local FighterService = {}

-- Set by ItemService (which requires this module): the item serials a late client needs, and
-- what to do when a fighter's character goes away.
FighterService.SerializeItems = function(_fighter)
	return nil
end
FighterService.EntityRemovedCallbacks = {}

local collection = nil
local byPlayer: { [Player]: any } = {}

-- Small numbers, reused once their fighter is gone: each travels as a single utf8 char.
local nextNetworkID = 1
local freeNetworkIDs: { number } = {}

function FighterService.Get(player: Player)
	return byPlayer[player]
end

function FighterService.GetEntity(player: Player)
	local fighter = byPlayer[player]
	return fighter and fighter._entity
end

-- GameplayUtility calls FighterService:GetFighter(model) (method style) on the server, with
-- a character model or a player.
function FighterService.GetFighter(_self, thing: Instance?)
	if typeof(thing) ~= "Instance" then
		return nil
	end
	if thing:IsA("Player") then
		return byPlayer[thing]
	end
	local player = Players:GetPlayerFromCharacter(thing)
	return player and byPlayer[player]
end

-- Where a fighter is: nil in the hub, the range's EnvironmentID inside it. Hits only land on
-- entities of the same environment (GameplayUtility.GetRaycastWhitelist).
function FighterService.SetEnvironment(player: Player, environmentID: string?)
	local fighter = byPlayer[player]
	if not fighter then
		return
	end
	fighter:SetReplicate("EnvironmentID", environmentID)
	-- Some client code (portals) reads it off the player.
	player:SetAttribute("EnvironmentID", environmentID)
	if fighter._entity then
		fighter._entity:SetReplicate("EnvironmentID", environmentID)
	end
end

local CollectionService = game:GetService("CollectionService")

local function entityHitboxes(self, small: boolean?)
	local hitboxes, smallHitboxes = {}, {}
	for _, part in self._model:GetDescendants() do
		if part:IsA("BasePart") and CollectionService:HasTag(part, "EntityHitbox") then
			table.insert(part:GetAttribute("IsSmallHitbox") and smallHitboxes or hitboxes, part)
		end
	end
	return small and #smallHitboxes > 0 and smallHitboxes or hitboxes
end

local function entityIsAlive(self): boolean
	return self._humanoid ~= nil and self._humanoid.Health > 0 and self._model.Parent ~= nil
end

local function serializeEntity(entity)
	return entity:_EncodeSerial({
		ClientReplicatedClassType = "ClientFighterCharacter",
		Data = entity:_SerializeData(),
		Model = entity._model,
		RootPart = entity._root,
		Humanoid = entity._humanoid,
		Player = entity._player,
	})
end

local function serializeFighter(fighter)
	return fighter:_EncodeSerial({
		ClientReplicatedClassType = "ClientFighter",
		Data = fighter:_SerializeData(),
		Entity = fighter._entity and serializeEntity(fighter._entity) or nil,
		Items = FighterService.SerializeItems(fighter),
	})
end

local HITBOX_PARTS = {
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
	Torso = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
}

local function tagHitboxes(character: Model)
	CollectionService:AddTag(character, "Entity")
	for _, part in character:GetChildren() do
		if part:IsA("BasePart") and HITBOX_PARTS[part.Name] then
			CollectionService:AddTag(part, "EntityHitbox")
		end
	end
end

-- Which duel team a fighter is on (nil outside duels), on the fighter, its character and the
-- player (the elimination feed colours names from the player's TeamID attribute).
function FighterService.SetTeam(player: Player, teamID: string?)
	local fighter = byPlayer[player]
	if not fighter then
		return
	end
	if fighter:Get("TeamID") ~= teamID then
		fighter:SetReplicate("TeamID", teamID)
	end
	player:SetAttribute("TeamID", teamID)
	if fighter._entity and fighter._entity:Get("TeamID") ~= teamID then
		fighter._entity:SetReplicate("TeamID", teamID)
	end
end

-- Set by DuelService: whether a player may watch the duel with this ObjectID.
FighterService.CanSpectateDuel = function(_player: Player, _duelObjectID: string): boolean
	return false
end

local function removeEntity(fighter)
	local entity = fighter._entity
	if not entity then
		return
	end
	fighter._entity = nil
	fighter.Entity = nil
	for _, connection in fighter._entity_connections or {} do
		connection:Disconnect()
	end
	fighter._entity_connections = nil
	fighter.ReplicateToClient:Fire("EntityRemoved")
	entity:Destroy()
	for _, callback in FighterService.EntityRemovedCallbacks do
		task.spawn(callback, fighter)
	end
end

local function addEntity(player: Player, fighter, character: Model)
	local humanoid = character:WaitForChild("Humanoid", 10)
	local root = character:WaitForChild("HumanoidRootPart", 10)
	if not humanoid or not root or player.Character ~= character then
		return
	end

	-- CharacterAdded can fire before the model is in the Workspace; an Instance a client does
	-- not have yet arrives in a remote as nil, so the entity waits until it is there.
	while character.Parent and not character:IsDescendantOf(workspace) do
		character.AncestryChanged:Wait()
	end
	task.wait()
	if player.Character ~= character then
		return
	end

	removeEntity(fighter)

	local entity = ReplicatedClass.new()
	entity._model = character
	entity._root = root
	entity._humanoid = humanoid
	entity._player = player
	entity.Model = character
	entity.RootPart = root
	entity.Humanoid = humanoid
	entity.Serialize = serializeEntity
	entity.GetHitboxes = entityHitboxes
	entity.IsAlive = entityIsAlive
	entity:Set("EnvironmentID", fighter:Get("EnvironmentID"))
	entity:Set("TeamID", fighter:Get("TeamID"))
	tagHitboxes(character)

	fighter._entity = entity
	fighter.Entity = entity
	fighter._entity_connections = {
		-- The entity's own changes ride on the fighter's channel.
		entity.ReplicateToClient:Connect(function(changeType: string, ...)
			fighter.ReplicateToClient:Fire("EntityChanged", EnumLibrary:ToEnum(changeType), ...)
		end),
		entity.ReplicateToClientUnreliable:Connect(function(changeType: string, ...)
			fighter.ReplicateToClientUnreliable:Fire("EntityChanged", EnumLibrary:ToEnum(changeType), ...)
		end),
	}

	fighter.ReplicateToClient:Fire("EntityAdded", serializeEntity(entity))

	character.AncestryChanged:Connect(function(_, parent)
		if parent == nil and fighter._entity == entity then
			removeEntity(fighter)
		end
	end)
end

local function create(player: Player)
	if byPlayer[player] then
		return byPlayer[player]
	end

	local fighter = ReplicatedClass.new()
	fighter.Serialize = serializeFighter
	fighter:Set("Player", player)
	fighter:Set("UserID", player.UserId)
	fighter:Set("IsInDuel", false)
	fighter:Set("IsInShootingRange", false)
	fighter:Set("IsSpectating", false)
	fighter:Set("NumSpectators", 0)
	fighter:Set("Controls", "MouseKeyboard")
	local networkID = table.remove(freeNetworkIDs)
	if not networkID then
		networkID = nextNetworkID
		nextNetworkID += 1
	end
	fighter:Set("DecodedNetworkID", networkID)
	fighter:Set("NetworkID", utf8.char(networkID))

	byPlayer[player] = fighter
	collection:Add(fighter)

	player.CharacterAdded:Connect(function(character)
		addEntity(player, fighter, character)
	end)
	if player.Character then
		task.spawn(addEntity, player, fighter, player.Character)
	end

	return fighter
end

function FighterService.Start()
	collection = ReplicatedCollection.new("Fighter")
	FighterService.Collection = collection

	FighterRemotes.SetControls.OnServerEvent:Connect(function(player: Player, scheme: any)
		local fighter = byPlayer[player]
		if fighter and typeof(scheme) == "string" and CONTROLS[scheme] and fighter:Get("Controls") ~= scheme then
			fighter:SetReplicate("Controls", scheme)
		end
	end)

	FighterRemotes.UpdateState.OnServerEvent:Connect(function(player: Player, state: any, value: any)
		local fighter = byPlayer[player]
		state = type(state) == "string" and EnumLibrary:FromEnum(state, true)
		if not fighter or not state then
			return
		end
		if BOOLEAN_STATES[state] then
			value = value == true
			if fighter:Get(state) == value then
				return
			end
			fighter:SetReplicate(state, value)
			if state == "IsSliding" and value then
				require(script.Parent.TaskService).Record(player, "Slide", 1)
			end
		elseif state == "CameraLean" and type(value) == "number" and value == value then
			fighter:SetReplicate(state, math.clamp(value, -1, 1))
		end
	end)

	local lastSound: { [Player]: number } = {}
	FighterRemotes.PlayMechanicsSound.OnServerEvent:Connect(function(player: Player, name: any)
		local fighter = byPlayer[player]
		local now = os.clock()
		if not fighter or not MECHANICS_SOUNDS[name] or now - (lastSound[player] or 0) < SOUND_INTERVAL then
			return
		end
		lastSound[player] = now
		fighter.ReplicateToClient:Fire("PlayMechanicsSound", name)
	end)
	Players.PlayerRemoving:Connect(function(player: Player)
		lastSound[player] = nil
	end)

	local pendingRotations: { [Player]: string } = {}
	FighterRemotes.UpdateCameraRotation.OnServerEvent:Connect(function(player: Player, encoded: any)
		if not byPlayer[player] or type(encoded) ~= "string" or utf8.len(encoded) ~= 2 then
			return
		end
		local x, y = utf8.codepoint(encoded, 1, -1)
		if x <= 255 and y <= 255 then
			pendingRotations[player] = encoded
		end
	end)
	Players.PlayerRemoving:Connect(function(player: Player)
		pendingRotations[player] = nil
	end)
	task.spawn(function()
		while true do
			task.wait(CAMERA_INTERVAL)
			if next(pendingRotations) then
				local parts = {}
				for player, encoded in pendingRotations do
					local fighter = byPlayer[player]
					if fighter then
						table.insert(parts, utf8.char(fighter:Get("DecodedNetworkID")) .. encoded)
					end
				end
				table.clear(pendingRotations)
				if #parts > 0 then
					FighterRemotes.UpdateCameraRotations:FireAllClients(table.concat(parts))
				end
			end
		end
	end)

	FighterRemotes.SpectateDuel.OnServerEvent:Connect(function(player: Player, duelObjectID: any)
		local fighter = byPlayer[player]
		if not fighter then
			return
		end
		if duelObjectID ~= nil and (type(duelObjectID) ~= "string" or not FighterService.CanSpectateDuel(player, duelObjectID)) then
			return
		end
		if fighter:Get("SpectatingDuelObjectID") ~= duelObjectID then
			fighter:SetReplicate("SpectatingDuelObjectID", duelObjectID)
		end
	end)
	-- Who the client's camera follows while spectating; nothing depends on it here.
	FighterRemotes.Spectating.OnServerEvent:Connect(function() end)

	Players.PlayerAdded:Connect(create)
	for _, player in Players:GetPlayers() do
		create(player)
	end

	Players.PlayerRemoving:Connect(function(player: Player)
		local fighter = byPlayer[player]
		byPlayer[player] = nil
		if fighter then
			table.insert(freeNetworkIDs, fighter:Get("DecodedNetworkID"))
			removeEntity(fighter)
			collection:Remove(fighter)
			fighter:Destroy()
		end
	end)
end

FighterService.Remotes = { FighterRemotes.SetControls, FighterRemotes.UpdateState, FighterRemotes.PlayMechanicsSound, FighterRemotes.UpdateCameraRotation, FighterRemotes.SpectateDuel, FighterRemotes.Spectating }

return FighterService
