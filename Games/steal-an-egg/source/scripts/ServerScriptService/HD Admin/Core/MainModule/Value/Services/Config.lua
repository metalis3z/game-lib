-- CONFIG
local HIGHER_POWER_FLAGS = {"UseDefaultGameSettings", "UseDefaultRoles"}
local CLIENT_EXPOSED_ALWAYS_INCLUDE = {
	"UseDefaultGameSettings",
	"UseDefaultRoles",
}
local ACCESSIBLE = {
	["Args"] = true,
	["Themes"] = true,
}


-- LOCAL
local Config = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local config = modules.Parent.Services.Config
local User = require(modules.Objects.User)
local State = require(modules.Objects.State)
local Janitor = require(modules.Objects.Janitor)
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local configSettings = require(config.Settings)
local Remote = require(modules.Objects.Remote)
local configRequiresUpdating = true
local updateJanitor = Janitor.new()


-- LOCAL FUNCTIONS
local clientAllowlist: {string}? = nil
local function getClientAllowlist(): {string}
	if clientAllowlist then return clientAllowlist end
	local uiConfig = modules.Parent.Controllers.UI.Config
	local SettingsGame = require(uiConfig.SettingsGame :: ModuleScript) :: any
	local SettingsYou = require(uiConfig.SettingsYou :: ModuleScript) :: any
	local set: {[string]: true} = {}
	local function collect(list: any)
		if typeof(list) ~= "table" then return end
		for _, category in list do
			if typeof(category) == "table" and typeof(category.objects) == "table" then
				for _, obj in category.objects do
					for _, pathKey in {"settingPath", "defaultFromEveryone"} do
						local path = (obj :: any)[pathKey]
						if typeof(path) == "table" and #path >= 3 then
							set[path[3]] = true
						end
					end
				end
			end
		end
	end
	collect(SettingsGame)
	collect(SettingsYou)
	for _, settingKey in CLIENT_EXPOSED_ALWAYS_INCLUDE do
		set[settingKey] = true
	end
	local result: {string} = {}
	for settingKey in set do table.insert(result, settingKey) end
	clientAllowlist = result
	return result
end

local settingPathMap: {[string]: {[string]: {string}}}? = nil
local function getSettingPathMap(): {[string]: {[string]: {string}}}
	if settingPathMap then return settingPathMap end
	local settingsYouModule = modules.Parent.Controllers.UI.Config.SettingsYou
	local SettingsYou = require(settingsYouModule :: ModuleScript) :: any
	local map: {[string]: {[string]: {string}}} = {}
	for _, category in SettingsYou do
		local heading = category.heading
		if typeof(heading) ~= "string" then continue end
		local headingMap: {[string]: {string}} = {}
		for _, obj in category.objects do
			local title = obj.title
			local path = obj.settingPath
			if typeof(title) == "string" and typeof(path) == "table" then
				headingMap[title] = path
			end
		end
		map[heading] = headingMap
	end
	settingPathMap = map
	return map
end

local function findInNested(container: any, settingName: string): any
	if typeof(container) ~= "table" then return nil end
	if container.PlayerSettings and container.PlayerSettings[settingName] ~= nil then
		return container.PlayerSettings[settingName]
	end
	if container.SystemSettings and container.SystemSettings[settingName] ~= nil then
		return container.SystemSettings[settingName]
	end
	return container[settingName]
end

local function computeEveryoneGameSettings(loadedSettings: any, defaultSettings: any): any
	if typeof(loadedSettings) ~= "table" then return defaultSettings end
	local sys = (loadedSettings :: any).SystemSettings
	if not (typeof(sys) == "table" and sys.UseDefaultGameSettings == true) then
		return loadedSettings
	end
	local forced: any = deepCopyTable(defaultSettings)
	if typeof(forced.SystemSettings) ~= "table" then
		forced.SystemSettings = {}
	end
	for _, flag in HIGHER_POWER_FLAGS do
		if sys[flag] ~= nil then
			forced.SystemSettings[flag] = sys[flag]
		end
	end
	return forced
end


-- TYPES
export type PlayerSearch = configSettings.PlayerSearch
export type SettingType = "Player" | "System"
export type Setting = keyof<typeof(configSettings.PlayerSettings)> | keyof<typeof(configSettings.SystemSettings)>


-- FUNCTIONS
function Config.isAccessible(moduleName: string): boolean
	return ACCESSIBLE[moduleName] == true
end

function Config.getAccessible()
	return ACCESSIBLE
end

function Config.updateConfig(forceUpdate: boolean?): boolean
	if not configRequiresUpdating and not forceUpdate then
		return false
	end
	configRequiresUpdating = false
	updateJanitor:cleanup()

	local defaultSettings = deepCopyTable(configSettings)

	local success, gameUser = User.getUserAsync("Game")
	local loadedSettings: any = defaultSettings
	if success and gameUser then
		local loadedValue = gameUser.perm:get("Settings")
		if loadedValue then
			loadedSettings = loadedValue
		end
	else
		configRequiresUpdating = true
	end

	User.everyone:set("GameSettings", computeEveryoneGameSettings(loadedSettings, defaultSettings))
	User.everyone:set("DefaultGameSettings", defaultSettings)
	User.everyone:set("SavedGameSettings", loadedSettings)

	if success and gameUser then
		local pendingPropagation = false
		updateJanitor:add(gameUser.perm:onChange("Settings", function()
			if pendingPropagation then return end
			pendingPropagation = true
			task.defer(function()
				pendingPropagation = false
				local latest = gameUser.perm:get("Settings")
				local computed = computeEveryoneGameSettings(latest, defaultSettings)
				User.everyone:set("GameSettings", computed)
				User.everyone:set("SavedGameSettings", latest)
			end)
		end))
	end

	return true
end

function Config.getSetting(settingName: Setting, optionalUser: User.Class?): any
	Config.updateConfig()
	local gameSettings = User.everyone:get("GameSettings")
	local isLocked = false
	if typeof(gameSettings) == "table" then
		local systemSettings = (gameSettings :: any).SystemSettings
		if typeof(systemSettings) == "table" then
			isLocked = systemSettings["CanChangeYouSettings" .. tostring(settingName)] == false
		end
	end
	local youSettings = if not isLocked and typeof(optionalUser) == "table" and optionalUser.isLoaded then optionalUser.perm:get("YouSettings") else nil
	local value: any = nil
	if youSettings then
		value = findInNested(youSettings, settingName :: string)
	end
	if value == nil then
		value = findInNested(gameSettings, settingName :: string)
	end
	if value == nil then
		value = findInNested(configSettings, settingName :: string)
	end
	return value
end


-- SETUP
-- Start the Game user so essential cross-server data can be loaded
task.spawn(function()
	local Framework = require(modules.Framework)
	Framework.waitUntilLoaded()
	User.new("Game", "GameStore")
	Config.updateConfig(true)
end)

-- We build GameSettings up front so perm:onChange("Settings") is registered, and
-- cross-server updates reach clients right away instead of waiting for a client to
-- fetch GameSettings first
task.defer(function()
	local Framework = require(modules.Framework)
	Framework.waitUntilLoaded()
	Config.updateConfig()
end)

local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)
local allowlist = getClientAllowlist()
for _, firstKey in {"GameSettings", "SavedGameSettings", "DefaultGameSettings"} do
	User.everyone:verify(getStateVerifier(firstKey, "OnlyInclude", allowlist))
end

local SettingsYou = require(modules.Parent.Controllers.UI.Config.SettingsYou)
local validateSettingChange = require(modules.VerifyUtil.validateSettingChange)
Remote.new("ChangeYouSetting", "Function", "Low"):onServerInvoke(function(player: Player, heading: unknown, title: unknown, newValue: unknown): (boolean, string?)
	local callerUser = User.getUser(player)
	if not callerUser then return false, "User not loaded" end
	local Roles = require(modules.Parent.Services.Roles) :: any
	if not Roles.hasPermission(callerUser, "mayEditSettingsYou") then
		return false, "You don't have permission to edit your settings"
	end
	if typeof(heading) ~= "string" or typeof(title) ~= "string" then
		return false, "Invalid heading or title"
	end
	local row = validateSettingChange.findRowByHeadingTitle(SettingsYou, heading :: string, title :: string)
	if not row then return false, `Unknown setting '{heading}/{title}'` end
	local ok, coercedOrErr = validateSettingChange.run(row, newValue, {
		callerUserId = player.UserId,
		source = "server",
	})
	if not ok then return false, tostring(coercedOrErr) end
	callerUser.perm:set(row.settingPath, coercedOrErr)
	return true
end)

Remote.new("GetDefaultYouSettings", "Function", "High"):onServerInvoke(function(player: Player)
	Config.updateConfig() -- make sure everyone.GameSettings has loaded
	local everyone = User.everyone
	local playerSettings = everyone:get("GameSettings", "PlayerSettings")
	if typeof(playerSettings) ~= "table" then
		playerSettings = configSettings.PlayerSettings
	end
	local map = getSettingPathMap()
	local defaults: {[string]: {[string]: any}} = {}
	for heading, titleMap in map do
		local headingDefaults: {[string]: any} = {}
		for title, settingPath in titleMap do
			local value: any = playerSettings
			for pathIndex = 2, #settingPath do
				if typeof(value) ~= "table" then
					value = nil
					break
				end
				value = (value :: any)[settingPath[pathIndex]]
			end
			headingDefaults[title] = value
		end
		defaults[heading] = headingDefaults
	end
	return true, defaults
end)

local SettingsGame = require(modules.Parent.Controllers.UI.Config.SettingsGame)
Remote.new("ChangeGameSetting", "Function", "Low"):onServerInvoke(function(player: Player, pathway: unknown, newValue: unknown)
	local playerUser = User.getUser(player)
	if not playerUser then
		return false, "User not loaded"
	end
	local Roles = require(modules.Parent.Services.Roles) :: any
	if not Roles.hasPermission(playerUser, "mayEditSettingsGame") then
		return false, "You don't have permission to edit game settings"
	end
	local gameUser = User.getUser("Game")
	if not gameUser then
		return false, "Game user not loaded"
	end
	if typeof(pathway) ~= "table" then
		return false, "Invalid pathway"
	end
	for _, key in pathway :: {any} do
		if typeof(key) ~= "string" then
			return false, "Pathway keys must be strings"
		end
	end
	local rowSettingPath: {string} = {"GameSettings"}
	for _, pathKey in pathway :: {string} do table.insert(rowSettingPath, pathKey) end
	local row = validateSettingChange.findRowByPath(SettingsGame, rowSettingPath)
	if not row then return false, "Unknown game setting" end
	local ok, coercedOrErr = validateSettingChange.run(row, newValue, {
		callerUserId = player.UserId,
		source = "server",
	})
	if not ok then return false, tostring(coercedOrErr) end
	local permPathway = {"Settings", table.unpack(pathway :: {string})}
	gameUser.perm:set(permPathway, coercedOrErr)
	return true
end)

State.verifyFirstFetch("GameSettings", Config.updateConfig)
State.verifyFirstFetch("DefaultGameSettings", Config.updateConfig)
State.verifyFirstFetch("SavedGameSettings", Config.updateConfig)




return Config
