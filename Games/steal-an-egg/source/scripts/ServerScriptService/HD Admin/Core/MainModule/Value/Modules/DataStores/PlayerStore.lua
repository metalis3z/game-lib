-- !strict
-- LOCAL
local DataTemplates = require(script.Parent)
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local RunService = game:GetService("RunService")
local User = require(modules.Objects.User)
local DataStore = {}


-- LOCAL FUNCTIONS
local function applyScopeFilter(user: any)
	local thisJobId = if RunService:IsStudio() then "Studio" else game.JobId
	local nowSeconds = os.time()
	local allPerm = user.perm:getAll()
	if typeof(allPerm) ~= "table" then return end
	-- We clear the matching entries out of _savedChanges by hand because beforeLoading
	-- fires before trackingChanges turns on, so perm:set(path, nil) on its own won't
	-- reach _savedChanges. The autosave tracker would spot no diff and the stale
	-- entries would stick around in the DataStore
	local savedChanges = (user :: any)._savedChanges
	for fieldName, entries in allPerm do
		if not string.match(fieldName, "^Permanent") then continue end
		if typeof(entries) ~= "table" then continue end
		for key, entry in entries do
			if typeof(entry) ~= "table" then continue end
			local entryType = entry.type or "perm"
			local mismatched = false
			if entryType == "temp" then
				-- Thsese are Legacy "temp" entries from older builds which we drop on load so they
				-- don't linger in storage forever
				mismatched = true
			elseif entryType == "server" and entry.grantedOnJobId ~= thisJobId then
				mismatched = true
			elseif entryType == "expire" then
				local expiresAt = entry.expiresAt
				-- Drop it if expiresAt is malformed or has passed. A stale "expire" with
				-- no valid expiresAt would otherwise live forever
				if typeof(expiresAt) ~= "number" or expiresAt <= nowSeconds then
					mismatched = true
				end
			end
			if mismatched then
				user.perm:set({fieldName, key}, nil)
				if typeof(savedChanges) == "table" and typeof(savedChanges[fieldName]) == "table" then
					savedChanges[fieldName][key] = nil
					if next(savedChanges[fieldName]) == nil then
						savedChanges[fieldName] = nil
					end
				end
			end
		end
	end
end


-- PUBLIC
DataStore.dataStoreName = DataTemplates.dataStoreName
DataStore.dataKeyFormatter = `{DataTemplates.dataGroupName}/{script.Name}/%s/Profile`
DataStore.options = {
	sessionLocking = true,
	compressData = false,
} :: User.Options


-- FUNCTIONS
function DataStore.generateTemplate(user: User.Class?)
	if user then
		user.beforeSaving:Connect(function()
			-- Set details on last session, playtime, etc
			local perm = user.perm
			local temp = user.temp
			local timeNow = os.time()
			local latestSession = temp:get("LatestSession")
			local timeElapsed = timeNow - latestSession
			temp:set("LatestSession", timeNow)
			perm:set("LastSession", timeNow)
			perm:update("TotalPlayTime", function(value)
				return value + timeElapsed
			end)
		end)
		-- At load we scan every top-level perm key starting with "Permanent" and drop
		-- the scope-tagged entries (type="temp"|"server") that no longer apply here
		user.beforeLoading:Connect(function()
			applyScopeFilter(user)
		end)
	end

	local timeNow = os.time()
	local clockNow = os.clock()
	return {

		{"perm", "public", {
			Cash = 0,
			FavoritedEmotes = {},
			PermanentRoles = {},
			PermanentBans = {},
			PermanentWarns = {},
			YouSettings = {},
			RecentCommands = {}, -- cmdbar history, most-recent first
			OfferStartTime = 0, -- when the booster discount window began, 0 until offered
			SeenUpdateTime = 0, -- the newest update log entry they've dismissed the banner for
		}},

		-- Data that is saved *but not* retrievable by the client
		{"perm", "private", {
			FirstSession = timeNow,
			LastSession = 0,
			TotalPlayTime = 0,
			CommandsThisMinute = 0,
			CommandsThisMinuteStartStamp = timeNow,
			AssetOwnership = {},
			AddedToChartsNotice = false, -- so the charts success notice only ever shows once per player
		}},

		-- Data that is not saved *but* retrievable by the client
		{"temp", "public", {
			PolicyInfo = {},
			Roles = {},
			YouMember = {},
			PreviewingRoles = {},
		}},

		-- Data that is not saved *and* not retrievable by the client
		{"temp", "private", {
			LatestSession = timeNow,
			RequestsThisSecond = 0,
			RequestsThisSecondStartClock = clockNow,
			CommandsThisSecond = 0,
			CommandsThisSecondStartClock = clockNow,
			RolesReady = false, -- Without this, Members and Users race on PlayerAdded. if Members runs first it publishes a YouMember built from perm.PermanentRoles only, then the corrected publish from the temp.Roles onChange listener can land out of order on the client through State.fetchAsync
		}},

	}
end


return DataStore