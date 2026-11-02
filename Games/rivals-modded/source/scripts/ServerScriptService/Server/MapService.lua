-- Duel maps. The templates live in ServerStorage.Maps (one Model per map, named as in
-- DuelLibrary.Maps); a running duel gets its own clone in the Workspace.
--
-- Every map directly in there, and in the folders listed in MAP_FOLDERS (BigMaps, Legacy), can be
-- voted on and played, in DuelLibrary.HiddenMapOrder, except the names in DISABLED. Big maps (the
-- BigMaps folder, or "Big ..." in the name) join the vote when the teams have
-- BIG_MAPS_MIN_TEAM_SIZE players or more. Other folders (PSOnlyMaps: private servers only) stay
-- out. A duel only gets the maps with a spawn for each of its teams.
--
-- Some maps (Museum) have several sets of spawns, Spawns.Batch<n>.<team>: PickSpawnBatch picks one
-- for the whole round, so every team starts from the same set.
--
-- The templates sit wherever the dump left them (most at the same spot, Battleground inside
-- the hub), so each clone is centred on a slot of its own, SLOT_SPACING apart, far from the
-- lobby: two duels never share space whatever maps they play.
--
-- A template carries what the client reads off a map model:
--   Spawns.<team>.<Part>   where each team starts a round
--   Spectate               ClientMap:GetSpectatePart()
--   Winners                the final results scene
--   Extra / Barriers       tagged RaycastWhitelist: shots and throws collide with them
--   Entities               breakable props (tagged Entity)
--
-- A duel lives in its own environment: the clone's RaycastWhitelist tags become
-- RaycastWhitelist<EnvironmentID> and every EnvironmentID attribute in it is set, which is how
-- GameplayUtility keeps hits inside one duel. The templates still carry the environment the
-- original server gave them ("RaycastWhitelist\7"), so any RaycastWhitelist* tag is replaced.

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local DuelLibrary = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("DuelLibrary"))

-- Maps that stay out of the vote even though their template is in ServerStorage.Maps.
local DISABLED: { string } = {}
local BIG_MAPS_FOLDER = "BigMaps"
local MAP_FOLDERS = { BIG_MAPS_FOLDER, "Legacy" }
local BIG_MAPS_MIN_TEAM_SIZE = 3
-- Teammates stand on a grid around their team's spawn part, this many studs apart: the spots
-- beside it first, then the rows behind, then in front, skipping any behind a wall or over the
-- void.
local SPREAD = 4
local GRID_COLUMNS = 3
local GRID_ROWS = 3
local GRID_ROWS_IN_FRONT = 2
local SLOT_ORIGIN = Vector3.new(20000, 3000, 20000)
local SLOT_SPACING = 6000
local SLOTS_PER_ROW = 8

local MapService = {}
MapService.DISABLED = DISABLED

local templates = ServerStorage:WaitForChild("Maps")
local usedSlots: { [number]: boolean } = {}
local slotOf: { [Model]: number } = {}
local centerOf: { [Instance]: Vector3 } = {}

-- The folder holding one spawn folder per team: Spawns itself, or the chosen Spawns.Batch<n>.
local function spawnSet(model: Instance): Instance?
	local spawns = model:FindFirstChild("Spawns")
	if not spawns then
		return nil
	end
	local batch = model:GetAttribute("SpawnBatch")
	return batch and spawns:FindFirstChild(batch) or spawns:FindFirstChild("Batch1") or spawns
end

local function spawnFolders(model: Instance): { Instance }
	local set = spawnSet(model)
	local list = {}
	for _, folder in set and set:GetChildren() or {} do
		if tonumber(folder.Name) then
			table.insert(list, folder)
		end
	end
	return list
end

local function findTemplate(name: string): Model?
	local template = templates:FindFirstChild(name)
	if template and template:IsA("Model") then
		return template
	end
	for _, folderName in MAP_FOLDERS do
		local folder = templates:FindFirstChild(folderName)
		template = folder and folder:FindFirstChild(name)
		if template and template:IsA("Model") then
			return template
		end
	end
	return nil
end

local function isBig(template: Instance): boolean
	return (template.Parent ~= nil and template.Parent.Name == BIG_MAPS_FOLDER) or string.find(template.Name, "Big ", 1, true) ~= nil
end

local function isPlayable(name: string): boolean
	return findTemplate(name) ~= nil and DuelLibrary.Maps[name] ~= nil and not table.find(DISABLED, name)
end

-- The maps a duel with this many teams (of up to teamSize players) can be played on.
function MapService.GetPool(numTeams: number, teamSize: number?): { string }
	local pool = {}
	local function consider(name: string)
		local template = isPlayable(name) and findTemplate(name)
		if not template or table.find(pool, name) or #spawnFolders(template) < numTeams then
			return
		end
		if isBig(template) and (teamSize or 1) < BIG_MAPS_MIN_TEAM_SIZE then
			return
		end
		table.insert(pool, name)
	end
	for _, name in DuelLibrary.HiddenMapOrder do
		consider(name)
	end
	for _, template in templates:GetChildren() do
		consider(template.Name)
	end
	for _, folderName in MAP_FOLDERS do
		local folder = templates:FindFirstChild(folderName)
		for _, template in folder and folder:GetChildren() or {} do
			consider(template.Name)
		end
	end
	return pool
end

-- A new set of spawns for the round, on maps that have several (Spawns.Batch<n>).
function MapService.PickSpawnBatch(model: Model, random: Random?)
	local spawns = model:FindFirstChild("Spawns")
	local batches = {}
	for _, folder in spawns and spawns:GetChildren() or {} do
		if string.match(folder.Name, "^Batch%d+$") then
			table.insert(batches, folder.Name)
		end
	end
	if #batches > 0 then
		model:SetAttribute("SpawnBatch", batches[(random or Random.new()):NextInteger(1, #batches)])
	end
end

local function claimSlot(): number
	local slot = 0
	while usedSlots[slot] do
		slot += 1
	end
	usedSlots[slot] = true
	return slot
end

local function slotPosition(slot: number): Vector3
	return SLOT_ORIGIN + Vector3.new(slot % SLOTS_PER_ROW, 0, slot // SLOTS_PER_ROW) * SLOT_SPACING
end

local function templateCenter(template: Model): Vector3
	if not centerOf[template] then
		centerOf[template] = template:GetBoundingBox().Position
	end
	return centerOf[template]
end

local function intoEnvironment(model: Model, environmentID: string)
	local whitelistTag = "RaycastWhitelist" .. environmentID
	local instances = model:GetDescendants()
	table.insert(instances, model)
	for _, instance in instances do
		for _, tag in CollectionService:GetTags(instance) do
			if string.sub(tag, 1, #"RaycastWhitelist") == "RaycastWhitelist" and tag ~= whitelistTag then
				CollectionService:RemoveTag(instance, tag)
				CollectionService:AddTag(instance, whitelistTag)
			end
		end
		if instance:GetAttribute("EnvironmentID") ~= nil then
			instance:SetAttribute("EnvironmentID", environmentID)
		end
	end
	model:SetAttribute("EnvironmentID", environmentID)
end

-- A fresh copy of the map for one duel, in the Workspace.
function MapService.Load(name: string, environmentID: string): Model?
	if not isPlayable(name) then
		return nil
	end
	local template = findTemplate(name) :: Model

	local model = template:Clone() :: Model
	local slot = claimSlot()
	slotOf[model] = slot
	model:PivotTo(template:GetPivot() + (slotPosition(slot) - templateCenter(template)))
	intoEnvironment(model, environmentID)
	model.Parent = workspace
	return model
end

function MapService.Unload(model: Model?)
	if not model then
		return
	end
	local slot = slotOf[model]
	slotOf[model] = nil
	if slot then
		usedSlots[slot] = nil
	end
	model:Destroy()
end

-- A teammate's spot is usable when nothing solid stands between it and the spawn part and
-- there is floor under it.
local function isClear(model: Model, part: BasePart, spot: CFrame): boolean
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { model }
	local offset = spot.Position - part.Position
	if offset.Magnitude > 0.1 then
		local wall = workspace:Raycast(part.Position, offset, params)
		if wall and wall.Instance.CanCollide then
			return false
		end
	end
	return workspace:Raycast(spot.Position, Vector3.new(0, -12, 0), params) ~= nil
end

-- Where each player of a team starts a round: the team's spawn part (a character-sized
-- invisible marker, turned the way the map's author wants the team to face) and clear spots
-- around it, one per player; [1] is the part itself.
function MapService.GetTeamSpawns(model: Model, teamIndex: number, teamSize: number): { CFrame }
	local set = spawnSet(model)
	local folder = set and set:FindFirstChild(tostring(teamIndex))
	local part = folder and folder:FindFirstChildWhichIsA("BasePart")
	local spots = {}
	if not part then
		local center = (model:FindFirstChild("Primary") :: BasePart?) and model.Primary.Position or model:GetPivot().Position
		for _ = 1, teamSize do
			table.insert(spots, CFrame.new(center + Vector3.new(0, 5, 0)))
		end
		return spots
	end

	-- Nearest first: the sides, then behind (+Z, the part faces -Z), then in front.
	local candidates = {}
	for row = -GRID_ROWS_IN_FRONT, GRID_ROWS do
		for column = -GRID_COLUMNS, GRID_COLUMNS do
			table.insert(candidates, Vector3.new(column * SPREAD, 0.5, row * SPREAD))
		end
	end
	local function cost(offset: Vector3): number
		return math.abs(offset.X) + (offset.Z >= 0 and offset.Z * 1.5 or -offset.Z * 2.5)
	end
	table.sort(candidates, function(a, b)
		local da, db = cost(a), cost(b)
		if da ~= db then
			return da < db
		end
		return a.X < b.X
	end)

	for _, offset in candidates do
		if #spots >= teamSize then
			break
		end
		local spot = part.CFrame * CFrame.new(offset)
		if offset.Magnitude < 1 or isClear(model, part, spot) then
			table.insert(spots, spot)
		end
	end
	-- Not enough room around it: the rest start on the part itself.
	while #spots < teamSize do
		table.insert(spots, part.CFrame * CFrame.new(0, 0.5, 0))
	end
	return spots
end

return MapService
