--!strict

--[[

	only loaded on request by admins who enter the server

	  - Loader bans (source="loader") are NEVER persisted here. They get
	    merged in by Services/Moderation/Replication at publish time
	  - Per-target dict-keyed structure - safe concurrent CSC writes need
	    a dict. Never use plain arrays
	  - dataStoreName / Key format is identical to MemberStore's, so the
	    two stores live side-by-side under the same root DataStore

--]]


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

		{"perm", "private", {

		}},

		-- Reserved for runtime-only flags (sweep markers etc); empty for now
		{"temp", "private", {

		}},

	}
end


return DataStore