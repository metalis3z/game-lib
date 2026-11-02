-- This is only loaded on request by admins who enter the server


-- !strict
-- LOCAL
local DataTemplates = require(script.Parent)
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local DataStore = {}


-- PUBLIC
DataStore.dataStoreName = DataTemplates.dataStoreName
DataStore.dataKeyFormatter = `{DataTemplates.dataGroupName}/GameStore/%s`
DataStore.options = {
	sessionLocking = false,
	crossServerCommunication = true,
	compressData = false,
	partitionData = false,
} :: User.Options


-- FUNCTIONS
function DataStore.generateTemplate(user: User.Class?)
	if user then
		user.beforeSaving:Connect(function()

		end)
	end

	return {

		-- Data that is private and saved
		{"perm", "private", {

		}},

		-- Data that is private but not saved
		{"temp", "private", {

		}},

	}
end


return DataStore