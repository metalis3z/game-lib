--!strict

-- CONFIG
local POPUP_OFFSET: Vector2 = Vector2.new(10, -10)
local POPUP_PANEL_WIDTH: number = 320
local POPUP_MIN_VISIBLE_HEIGHT: number = 80


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)


-- TYPES
export type ProfilePanel = {
	id: string,
	kind: ("profile" | "preview" | "task" | "emotes" | "commands" | "booster" | "outfits")?,
	spawnDragSnapshot: Vector2,
	dragOffset: Fusion.Value<Vector2>,
	cascadeMultiplier: number,
	userId: number?,
	giverIdentity: any?,
	previewCommandKey: string?,
	previewArgTokens: {string}?,
	previewModifierTokens: {string}?,
	taskUID: string?,
	taskSnapshot: any?,
	commandDisplay: {[string]: any}?,
}


-- LOCAL STATE
local panelsScope: Fusion.Scope? = nil
local panelsValue: Fusion.Value<{ ProfilePanel }>? = nil
local mainDragOffset: Fusion.Value<Vector2>? = nil
local nextId = 0


-- FUNCTIONS
local Panels = {}
Panels.POPUP_OFFSET = POPUP_OFFSET
Panels.POPUP_PANEL_WIDTH = POPUP_PANEL_WIDTH
Panels.POPUP_MIN_VISIBLE_HEIGHT = POPUP_MIN_VISIBLE_HEIGHT

function Panels.init(scope: Fusion.Scope, mainDrag: Fusion.Value<Vector2>)
	panelsScope = scope
	panelsValue = scope:Value({} :: { ProfilePanel })
	mainDragOffset = mainDrag
end

function Panels.getState(): Fusion.Value<{ ProfilePanel }>?
	return panelsValue
end

local function peekMainDrag(): Vector2
	if mainDragOffset then
		return Fusion.peek(mainDragOffset) :: Vector2
	end
	return Vector2.zero
end

-- A moved popup frees its slot for the next open
local function nextCascadeMultiplier(): number
	if not panelsValue then return 1 end
	local cur = Fusion.peek(panelsValue)
	local maxMult = 0
	for _, panel in cur do
		if Fusion.peek(panel.dragOffset) == Vector2.zero then
			if panel.cascadeMultiplier > maxMult then
				maxMult = panel.cascadeMultiplier
			end
		end
	end
	return maxMult + 1
end

-- The factory only runs when actually adding so a toggle-close doesn't leak Values
local function toggleUnique(isDup: (existing: ProfilePanel) -> boolean, build: () -> ProfilePanel)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList: {ProfilePanel} = {}
	local foundDup = false
	for _, existing in cur do
		if isDup(existing) then
			foundDup = true
		else
			table.insert(newList, existing)
		end
	end
	if not foundDup then
		table.insert(newList, build())
	end
	-- Deferred, the [Out] fires during construction would trip Fusion's loop bail
	local target = panelsValue
	task.defer(function()
		if target then target:set(newList) end
	end)
end

local function newDragValue(): Fusion.Value<Vector2>
	if not panelsScope then
		-- Return a detached Value so a too-early call doesn't crash
		return Fusion.Value(Fusion.scoped({Value = Fusion.Value}), Vector2.zero) :: any
	end
	return (panelsScope :: any):Value(Vector2.zero)
end

-- The new popup copies the other's drag Value so the stacked pair moves together
local function boosterStackSpawn(list: {ProfilePanel}): {dragOffset: Fusion.Value<Vector2>, cascadeMultiplier: number, spawnDragSnapshot: Vector2}
	for _, panel in list do
		if panel.kind == "booster" or panel.kind == "commands" then
			return {
				dragOffset = panel.dragOffset,
				cascadeMultiplier = panel.cascadeMultiplier,
				spawnDragSnapshot = panel.spawnDragSnapshot,
			}
		end
	end
	return {
		dragOffset = newDragValue(),
		cascadeMultiplier = nextCascadeMultiplier(),
		spawnDragSnapshot = peekMainDrag(),
	}
end

function Panels.openProfile(userId: number)
	toggleUnique(
		function(existing)
			return existing.userId == userId and existing.giverIdentity == nil
		end,
		function()
			nextId += 1
			return {
				id = "profile_" .. nextId,
				spawnDragSnapshot = peekMainDrag(),
				dragOffset = newDragValue(),
				cascadeMultiplier = nextCascadeMultiplier(),
				userId = userId,
			}
		end
	)
end

function Panels.openGiverProfile(giver: any)
	toggleUnique(
		function(existing)
			local existingGiver = existing.giverIdentity
			if typeof(existingGiver) ~= "table" or typeof(giver) ~= "table" then return false end
			return existingGiver.type == giver.type and existingGiver.id == giver.id
		end,
		function()
			nextId += 1
			return {
				id = "giver_" .. nextId,
				spawnDragSnapshot = peekMainDrag(),
				dragOffset = newDragValue(),
				cascadeMultiplier = nextCascadeMultiplier(),
				giverIdentity = giver,
			}
		end
	)
end

function Panels.openTask(taskUID: string, snapshot: any?)
	toggleUnique(
		function(existing)
			return existing.kind == "task" and existing.taskUID == taskUID
		end,
		function()
			nextId += 1
			return {
				id = "task_" .. nextId,
				kind = "task" :: any,
				spawnDragSnapshot = peekMainDrag(),
				dragOffset = newDragValue(),
				cascadeMultiplier = nextCascadeMultiplier(),
				taskUID = taskUID,
				taskSnapshot = snapshot,
			}
		end
	)
end

function Panels.openEmotes()
	toggleUnique(
		function(existing)
			return existing.kind == "emotes"
		end,
		function()
			nextId += 1
			return {
				id = "emotes_" .. nextId,
				kind = "emotes" :: any,
				spawnDragSnapshot = peekMainDrag(),
				dragOffset = newDragValue(),
				cascadeMultiplier = nextCascadeMultiplier(),
			}
		end
	)
end

function Panels.openOutfits()
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = {}
	local alreadyOpen = false
	for _, panel in cur do
		if panel.kind == "outfits" then
			alreadyOpen = true
		else
			table.insert(newList, panel)
		end
	end
	local target = panelsValue
	if alreadyOpen then
		task.defer(function()
			if target then target:set(newList) end
		end)
		return
	end
	local stack = boosterStackSpawn(newList)
	nextId += 1
	table.insert(newList, {
		id = "outfits_" .. nextId,
		kind = "outfits" :: any,
		spawnDragSnapshot = stack.spawnDragSnapshot,
		dragOffset = stack.dragOffset,
		cascadeMultiplier = stack.cascadeMultiplier,
	})
	task.defer(function()
		if target then target:set(newList) end
	end)
end

-- ensureOpen never closes, an already-open grid re-adds to come back to the front
function Panels.openCommands(display: {[string]: any}?, ensureOpen: boolean?)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = {}
	local alreadyOpen = false
	for _, panel in cur do
		if panel.kind == "commands" then
			alreadyOpen = true
		else
			table.insert(newList, panel)
		end
	end
	local target = panelsValue
	if alreadyOpen and not ensureOpen then
		task.defer(function()
			if target then target:set(newList) end
		end)
		return
	end
	local stack = boosterStackSpawn(newList)
	nextId += 1
	table.insert(newList, {
		id = "commands_" .. nextId,
		kind = "commands" :: any,
		spawnDragSnapshot = stack.spawnDragSnapshot,
		dragOffset = stack.dragOffset,
		cascadeMultiplier = stack.cascadeMultiplier,
		commandDisplay = display,
	})
	task.defer(function()
		if target then target:set(newList) end
	end)
end

local function pushPanel(panel: ProfilePanel)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = table.clone(cur)
	table.insert(newList, panel)
	local target = panelsValue
	task.defer(function()
		if target then target:set(newList) end
	end)
end

-- Set while a booster popup is being replaced so its close handler skips the offer notice
local boosterClosedSilently = false

function Panels.consumeBoosterSilentClose(): boolean
	local was = boosterClosedSilently
	boosterClosedSilently = false
	return was
end

function Panels.isBoosterOpen(): boolean
	if not panelsValue then return false end
	for _, panel in Fusion.peek(panelsValue) do
		if panel.kind == "booster" then
			return true
		end
	end
	return false
end

-- One write means no farewell offer notice and no close-then-open race
function Panels.swapBoosterToCommands(display: {[string]: any}?)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = {}
	for _, panel in cur do
		if panel.kind ~= "booster" and panel.kind ~= "commands" then
			table.insert(newList, panel)
		end
	end
	boosterClosedSilently = true
	local stack = boosterStackSpawn(newList)
	nextId += 1
	table.insert(newList, {
		id = "commands_" .. nextId,
		kind = "commands" :: any,
		spawnDragSnapshot = stack.spawnDragSnapshot,
		dragOffset = stack.dragOffset,
		cascadeMultiplier = stack.cascadeMultiplier,
		commandDisplay = display,
	})
	local target = panelsValue
	task.defer(function()
		if target then target:set(newList) end
	end)
end

-- Fires only once the whole booster stack is gone so we don't nag mid-browse
local boosterOfferArmed = false

local function boosterStackOpen(): boolean
	if not panelsValue then return false end
	for _, panel in Fusion.peek(panelsValue) do
		if panel.kind == "booster" or panel.kind == "commands" then
			return true
		end
	end
	return false
end

local function fireBoosterOfferNotice()
	-- The server picks the wording and skips booster owners
	require(modules.References.requestBoosterOfferRemote):fireServer()
end

function Panels.notifyBoosterStackClosed(which: string)
	if which == "booster" then
		boosterOfferArmed = true
	end
	if boosterOfferArmed and not boosterStackOpen() then
		boosterOfferArmed = false
		fireBoosterOfferNotice()
	end
end

-- forceReopen closes any open copy first so a denied booster command brings it back
function Panels.openBooster(forceReopen: boolean?)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = {}
	local alreadyOpen = false
	for _, panel in cur do
		if panel.kind == "booster" then
			alreadyOpen = true
			if not forceReopen then
				table.insert(newList, panel)
			end
		else
			table.insert(newList, panel)
		end
	end
	if alreadyOpen and not forceReopen then
		return
	end
	if alreadyOpen then
		boosterClosedSilently = true
	end
	local stack = boosterStackSpawn(newList)
	nextId += 1
	table.insert(newList, {
		id = "booster_" .. nextId,
		kind = "booster" :: any,
		spawnDragSnapshot = stack.spawnDragSnapshot,
		dragOffset = stack.dragOffset,
		cascadeMultiplier = stack.cascadeMultiplier,
	})
	local target = panelsValue
	task.defer(function()
		if target then target:set(newList) end
	end)
end

-- Each call stacks its own preview, never deduped
function Panels.openPreview(commandKey: string, argTokens: {string}?, modifierTokens: {string}?)
	nextId += 1
	pushPanel({
		id = "preview_" .. nextId,
		kind = "preview",
		spawnDragSnapshot = peekMainDrag(),
		dragOffset = newDragValue(),
		cascadeMultiplier = nextCascadeMultiplier(),
		previewCommandKey = commandKey,
		previewArgTokens = argTokens,
		previewModifierTokens = modifierTokens,
	})
end

function Panels.close(id: string)
	if not panelsValue then return end
	local cur = Fusion.peek(panelsValue)
	local newList = {}
	for _, panel in cur do
		if panel.id ~= id then
			table.insert(newList, panel)
		end
	end
	local target = panelsValue
	task.defer(function()
		if target then target:set(newList) end
	end)
end


return Panels
