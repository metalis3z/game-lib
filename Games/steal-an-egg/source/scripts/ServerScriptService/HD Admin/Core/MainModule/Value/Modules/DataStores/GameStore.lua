-- We load this on start for all servers because it holds essential game data

-- !strict
-- LOCAL
local DataTemplates = require(script.Parent)
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local config = modules.Parent.Services.Config
local configSettings = require(config.Settings)
local User = require(modules.Objects.User)
local DataStore = {}


-- PUBLIC
DataStore.dataStoreName = DataTemplates.dataStoreName
DataStore.dataKeyFormatter = `{DataTemplates.dataGroupName}/{script.Name}/%s`
DataStore.options = {
	sessionLocking = false,
	crossServerCommunication = true,
	compressData = false,
	partitionData = true, -- If the data is loaded for ALL servers, this is essential
} :: User.Options


-- FUNCTIONS
function DataStore.generateTemplate(user: User.Class?)
	-- We only save the RoleInfo fields that actually changed, not the whole role - the Roles
	-- service fills the DEFAULT_ROLE fields back in at read-time (see Roles/init.luau updateRoles).
	-- Hydrating here would bloat _savedChanges into a full role object on every save
	return {

		-- Data that is private and saved
		{"perm", "private", {
			Settings = deepCopyTable(configSettings),
			RoleInfo = {},
			RolesOrder = {}, -- Array of role keys defining display order, rank is derived from position
			Tasks = {},
			VettedCommands = {},
			VetUnacked = {},
		}},

		-- Data that is private but not saved
		{"temp", "private", {

		}},

	}
end


return DataStore