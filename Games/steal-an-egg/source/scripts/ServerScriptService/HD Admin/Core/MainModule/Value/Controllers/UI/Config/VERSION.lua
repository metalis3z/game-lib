--!strict
-- CONFIG
local VERSION = {}
local DEVELOPMENT_PLACE_ID = 79941590401581
local OUTDATED_TEXT = "A new version of HD Admin%s is available. Get a new model by clicking here."
local OUTDATED_TEXT_ENABLE_AUTO = "A new version of HD Admin%s is available. Set 'AutoUpdate' to 'true' on 'HD Admin' to receive the latest changes, or get a new model by clicking here."
local OUTDATED_TEXT_AUTO_FAILED = "A new version of HD Admin%s is available. Updates couldn't be retrieved so you're running the built-in-copy. Get a new model by clicking here."


-- PUBLIC
VERSION.appVersion = "v2.0.0"
VERSION.latestVersion = nil :: string?
VERSION.updatesUrl = "create.roblox.com/store/asset/857927023/HD"


-- LOCAL 
local fetchInFlight = false


-- LOCAL FUNCTIONS
-- The dev place keeps advertising v1 for a while so games move over gradually.
-- A latest version only counts once it looks like v2, otherwise we'd nag every
-- v2 install as outdated during that window
local function isV2Version(version: string?): boolean
	if type(version) ~= "string" then
		return false
	end
	local major = string.match(version, "^v(%d+)")
	return major ~= nil and tonumber(major) :: number >= 2
end


-- FUNCTIONS
function VERSION.getLatestVersion(): string?
	if VERSION.latestVersion then
		return VERSION.latestVersion
	end

	-- AboutPreload may already be loading, so wait on that instead of starting a second loop
	if fetchInFlight then
		repeat task.wait() until not fetchInFlight
		return VERSION.latestVersion
	end
	fetchInFlight = true

	local placeName = ""

	while true do
		local success, details = pcall(function()
			local MarketplaceService = game:GetService("MarketplaceService")
			return MarketplaceService:GetProductInfo(DEVELOPMENT_PLACE_ID)
		end)
		if success and type(details) == "table" and type(details.Name) == "string" then
			placeName = details.Name
			break
		end
		task.wait(1)
	end

	local extracted = string.match(placeName, "^HD Admin%s+(.+)$")
	if extracted then
			extracted = extracted:match("^%s*(.-)%s*$")
	end

	VERSION.latestVersion = extracted
	fetchInFlight = false
	return extracted
end

function VERSION.getAppVersion(): string
	return VERSION.appVersion
end

function VERSION.isOutdatedVersion(latest: string?): boolean
	return isV2Version(latest) and latest ~= VERSION.appVersion
end

function VERSION.isUpToDate(): boolean
	return not VERSION.isOutdatedVersion(VERSION.getLatestVersion())
end

function VERSION.getOutdatedText(handshake: {[string]: any}?): string
	local autoUpdate = handshake ~= nil and handshake.autoUpdate == true
	local updateSource = if handshake then handshake.updateSource else nil
	local template = OUTDATED_TEXT_ENABLE_AUTO
	if autoUpdate then
		template = if updateSource == "live" then OUTDATED_TEXT else OUTDATED_TEXT_AUTO_FAILED
	end
	local latest = VERSION.latestVersion
	local versionSuffix = if typeof(latest) == "string" then ` ({latest})` else ""
	return string.format(template, versionSuffix)
end


return VERSION