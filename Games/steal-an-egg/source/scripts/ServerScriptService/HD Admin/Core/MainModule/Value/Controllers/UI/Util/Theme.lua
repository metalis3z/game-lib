--!strict


-- CONFIG
local SCALEABLE_GROUPS = { TextSize = true, Layout = true }
local NON_SCALEABLE_KEYS: {[string]: boolean} = { ContentScale = true } -- keys exempt from ContentScale multiplication
local EXCLUDED_THEME_NAMES: {[string]: boolean} = {}
local LOCK_MAP: {[string]: {[string]: string}} = {
	Color = { Primary = "LockPrimaryColor" },
	Font = { Body = "LockFont", Heading = "LockFont" },
	Layout = { ContentScale = "LockContentScale" },
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local Fusion = require(packages.Fusion)
local Contextual = Fusion.Contextual
local BaseTheme = require(script.BaseTheme)
local fuseState = require(modules.DataUtil.fuseState)
local bindScope = Fusion.scoped({Value = Fusion.Value, Fuse = fuseState, Observer = Fusion.Observer}) -- bindScope created first so Values outlive scope's Computeds (avoids possiblyOutlives)
local scope = Fusion.scoped({Value = Fusion.Value, Computed = Fusion.Computed, Fuse = fuseState})
local peek = Fusion.peek
local themesContainer = script:FindFirstAncestor("HD Admin").Config.Themes
local Theme = {}


-- LOCAL FUNCTIONS
local function resolveFallbackTheme(): string
	local bestName: string? = nil
	local bestOrder: number = math.huge
	for _, child in themesContainer:GetChildren() do
		if child:IsA("ModuleScript") and not EXCLUDED_THEME_NAMES[child.Name] then
			local ok, themeData = pcall(require, child)
			if ok and typeof(themeData) == "table" then
				local settings = (themeData :: any).Settings
				local enabled = if settings and settings.ShowInYouSettings ~= nil then settings.ShowInYouSettings else true
				if enabled then
					local order = if settings and typeof(settings.LayoutOrder) == "number" then settings.LayoutOrder else math.huge
					if order < bestOrder then
						bestOrder = order
						bestName = child.Name
					end
				end
			end
		end
	end
	return bestName or "Dark"
end

-- gameVal ~= gameDefault detects "admin set", otherwise a theme's
-- colour would always lose to the template value
local themeValue = bindScope:Value(resolveFallbackTheme() :: any)
local settingSlots: { [string]: Fusion.Value<any> } = {}
local gameValueSlots: { [string]: Fusion.Value<any> } = {}
local gameDefaultSlots: { [string]: Fusion.Value<any> } = {}
local gameLockSlots: { [string]: Fusion.Value<any> } = {}
local function getSlot(groupKey: string, subgroupKey: string): Fusion.Value<any>
	local key = groupKey .. "." .. subgroupKey
	if not settingSlots[key] then
		settingSlots[key] = bindScope:Value(nil :: any)
	end
	return settingSlots[key]
end

local function getGameValueSlot(groupKey: string, subgroupKey: string): Fusion.Value<any>
	local key = groupKey .. "." .. subgroupKey
	if not gameValueSlots[key] then
		gameValueSlots[key] = bindScope:Value(nil :: any)
	end
	return gameValueSlots[key]
end

local function getGameDefaultSlot(groupKey: string, subgroupKey: string): Fusion.Value<any>
	local key = groupKey .. "." .. subgroupKey
	if not gameDefaultSlots[key] then
		gameDefaultSlots[key] = bindScope:Value(nil :: any)
	end
	return gameDefaultSlots[key]
end

local function getGameLockSlot(groupKey: string, subgroupKey: string): Fusion.Value<any>
	local key = groupKey .. "." .. subgroupKey
	if not gameLockSlots[key] then
		gameLockSlots[key] = bindScope:Value(nil :: any)
	end
	return gameLockSlots[key]
end


-- LOCAL FUNCTIONS
local function getBaseThemeValue(use: any, groupKey: string, subgroupKey: string)
	local theme = use(themeValue)
	local base = (BaseTheme :: any)
	local themeModule = themesContainer:FindFirstChild(theme)
	if themeModule == nil then
		return base[groupKey][subgroupKey]
	end
	local themeData = require(themeModule :: ModuleScript) :: any
	local group = themeData[groupKey]
	if group ~= nil and group[subgroupKey] ~= nil then
		return group[subgroupKey]
	end
	return base[groupKey][subgroupKey]
end

local function isLocked(use: any, groupKey: string, subgroupKey: string): boolean
	local groupLocks = LOCK_MAP[groupKey]
	if not groupLocks then return false end
	local lockKey = groupLocks[subgroupKey]
	if not lockKey then return false end
	return getBaseThemeValue(use, "Settings", lockKey) == true
end

local function isGameLocked(use: any, groupKey: string, subgroupKey: string): boolean
	local lockSlot = gameLockSlots[groupKey .. "." .. subgroupKey]
	if not lockSlot then return false end
	local lockFuse = use(lockSlot)
	if lockFuse == nil then return false end
	return use(lockFuse) == false
end

local function readGameValue(use: any, groupKey: string, subgroupKey: string): any
	local gameSlot = gameValueSlots[groupKey .. "." .. subgroupKey]
	if not gameSlot then return nil end
	local gameFuse = use(gameSlot)
	if gameFuse == nil then return nil end
	return use(gameFuse)
end

local function readGameDefault(use: any, groupKey: string, subgroupKey: string): any
	local defSlot = gameDefaultSlots[groupKey .. "." .. subgroupKey]
	if not defSlot then return nil end
	local defFuse = use(defSlot)
	if defFuse == nil then return nil end
	return use(defFuse)
end

local function areValuesEqual(a: any, b: any): boolean
	if a == b then return true end
	if typeof(a) ~= typeof(b) then return false end
	if typeof(a) == "Color3" then
		return a.R == b.R and a.G == b.G and a.B == b.B
	end
	return false
end

local function computeValue(groupKey: string, subgroupKey: string): (Fusion.Value<any> | Fusion.Computed<any>)
	local slot = getSlot(groupKey, subgroupKey)
	local scaleable = SCALEABLE_GROUPS[groupKey] == true
	return (scope :: any):Computed(function(use: any)
		-- Theme-locked is final. Game-locked means the admin's own value wins if
		-- present, otherwise baseline. Unlocked goes user, admin, baseline
		local baseline = getBaseThemeValue(use, groupKey, subgroupKey)
		local value = baseline

		if isLocked(use, groupKey, subgroupKey) then
			-- Theme lock short-circuits, the ContentScale logic below still runs
		else
			local gameVal = readGameValue(use, groupKey, subgroupKey)
			local gameDef = readGameDefault(use, groupKey, subgroupKey)
			local adminExplicit = gameVal ~= nil and not areValuesEqual(gameVal, gameDef)

			if isGameLocked(use, groupKey, subgroupKey) then
				if adminExplicit then
					value = gameVal
				end
			else
				local fusedValue = use(slot)
				local userVal = if fusedValue ~= nil then use(fusedValue) else nil
				if userVal ~= nil then
					value = userVal
				elseif adminExplicit then
					value = gameVal
				end
			end
		end
		if typeof(value) ~= typeof(baseline) then
			value = baseline
		end
		if scaleable and typeof(value) == "number" and not NON_SCALEABLE_KEYS[subgroupKey] then
			local baseScale = getBaseThemeValue(use, "Layout", "ContentScale")
			if not isLocked(use, "Layout", "ContentScale") then
				local gameScale = readGameValue(use, "Layout", "ContentScale")
				local defScale = readGameDefault(use, "Layout", "ContentScale")
				local adminExplicitScale = gameScale ~= nil and not areValuesEqual(gameScale, defScale)
				if isGameLocked(use, "Layout", "ContentScale") then
					if adminExplicitScale then
						baseScale = gameScale
					end
				else
					local scaleSlot = getSlot("Layout", "ContentScale")
					local scaleFused = use(scaleSlot)
					local userScale = if scaleFused ~= nil then use(scaleFused) else nil
					if userScale ~= nil then
						baseScale = userScale
					elseif adminExplicitScale then
						baseScale = gameScale
					end
				end
			end
			value = math.round(value * baseScale)
		end
		return value
	end)
end


-- TYPES
type Theme = typeof(BaseTheme)


-- SETUP THEME
for groupKey, themeGroupValue in BaseTheme :: {[string]: any} do
	local thisGroup: {[string]: any} = {}
	Theme[groupKey] = thisGroup
	for subgroupKey, subgroupValue in themeGroupValue do
		local computed = computeValue(groupKey, subgroupKey)
		thisGroup[subgroupKey] = computed
	end
end

-- Auto white/black based on primary luminance
do
	local ColorUtil = require(modules.ColorUtil);
	local LIGHT_CONTENT = Color3.new(1, 1, 1)
	local DARK_CONTENT = Color3.new(0, 0, 0);
	(Theme :: any).Color.PrimaryContent = scope:Computed(function(use)
		local primary: Color3 = use((Theme :: any).Color.Primary)
		return if ColorUtil.getLuminance(primary) > 0.4 then DARK_CONTENT else LIGHT_CONTENT
	end)
end


-- FUNCTIONS
function Theme.isThemeSelectable(themeName: string): boolean
	local child = themesContainer:FindFirstChild(themeName)
	if child == nil or not child:IsA("ModuleScript") or EXCLUDED_THEME_NAMES[themeName] then
		return false
	end
	local ok, themeData = pcall(require, child)
	if not ok or typeof(themeData) ~= "table" then return false end
	local settings = (themeData :: any).Settings
	if settings and settings.ShowInYouSettings == false then return false end
	return true
end

-- Resolves to fallback if nil/unknown/disabled
function Theme.resolveTheme(themeName: string?): string
	if themeName == nil then return resolveFallbackTheme() end
	if not Theme.isThemeSelectable(themeName :: string) then return resolveFallbackTheme() end
	return themeName :: string
end

function Theme.setTheme(themeName: string)
	local resolved = Theme.resolveTheme(themeName)
	themeValue:set(resolved)
end

function Theme.getTheme()
	return peek(themeValue)
end

-- gameOverride layers a game-wide forced value on top. While its lock is false the
-- user's override is replaced but stays on disk to reactivate when the lock flips
type GameOverride = { gamePath: {string}, gameLockPath: {string} }
function Theme.bindSetting(groupKey: string, subgroupKey: string, settingPath: {string}, gameOverride: GameOverride?)
	local slot = getSlot(groupKey, subgroupKey)
	if peek(slot) == nil then
		local fusedValue = bindScope:Fuse("perm", settingPath)
		slot:set(fusedValue)
	end
	if gameOverride then
		local gameSlot = getGameValueSlot(groupKey, subgroupKey)
		if peek(gameSlot) == nil then
			gameSlot:set(bindScope:Fuse("everyone", gameOverride.gamePath))
		end
		-- The default path swaps the first segment to DefaultGameSettings
		local defSlot = getGameDefaultSlot(groupKey, subgroupKey)
		if peek(defSlot) == nil then
			local defaultPath = table.clone(gameOverride.gamePath)
			defaultPath[1] = "DefaultGameSettings"
			defSlot:set(bindScope:Fuse("everyone", defaultPath))
		end
		local lockSlot = getGameLockSlot(groupKey, subgroupKey)
		if peek(lockSlot) == nil then
			lockSlot:set(bindScope:Fuse("everyone", gameOverride.gameLockPath))
		end
	end
end

-- When the game lock is false the gamePath value wins, otherwise the
-- userPath value (or the fallback when nil)
function Theme.bindThemeName(userPath: {string}, gamePath: {string}, gameLockPath: {string})
	local userFuse = bindScope:Fuse("perm", userPath)
	local gameFuse = bindScope:Fuse("everyone", gamePath)
	local gameLockFuse = bindScope:Fuse("everyone", gameLockPath)

	local function unwrap(v: any): string?
		-- ItemSelector wraps the picked value in a single-element array
		if typeof(v) == "table" and #(v :: {any}) == 1 then
			v = (v :: {any})[1]
		end
		return if typeof(v) == "string" then v else nil
	end

	local function apply()
		local gameVal = unwrap(peek(gameFuse))
		local userVal = unwrap(peek(userFuse))
		local effective: string?
		if peek(gameLockFuse) == false then
			-- Admin disabled theme switching so the game's chosen theme always wins
			effective = gameVal
		else
			-- The user override wins, otherwise whatever the game has
			effective = userVal or gameVal
		end
		if effective ~= nil then
			Theme.setTheme(effective)
		end
	end

	-- onBind catches Fuses that are nil at first call and fill in as state replicates
	bindScope:Observer(userFuse):onBind(apply)
	bindScope:Observer(gameFuse):onBind(apply)
	bindScope:Observer(gameLockFuse):onBind(apply)
end


return Theme :: Theme & typeof(Theme)