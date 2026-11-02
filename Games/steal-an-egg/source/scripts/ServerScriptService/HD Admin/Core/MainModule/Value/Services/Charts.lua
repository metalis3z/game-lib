--!strict

--[[

	This is what enables your game to join the "HD Admin Charts":
	https://www.roblox.com/games/94572088206087/HD-Admin-Charts

--]]


-- CONFIG
local URL = "https://charts.nanoblox.com/advertise"
local TOKEN = "9wBvsg7pM7nt" -- This is to limit web scrapers
local CHARTS_KEY = "AlreadyPromptedCharts"
local CHARTS_EXPIRY = 86400
local INSTRUCTION_IMAGE = "rbxassetid://104732421923477"
local INSTRUCTION_IMAGE_RATIO = 629 / 432
local QUALIFYING_PERMISSIONS = {"mayEditAll", "mayEditRoles", "mayEditSettingsGame"}


-- LOCAL
local Charts = {}
local HttpService = game:GetService("HttpService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local Config = require(modules.Parent.Services.Config)
local User = require(modules.Objects.User)
local Prompt = require(modules.Prompt)
local isStudio = RunService:IsStudio()


-- LOCAL FUNCTIONS
local function retryIndefinitely(callback: () -> any): any
	local retryWaitTime = 3
	while true do
		local success, result = pcall(callback)
		if success or isStudio then
			return result
		end
		task.wait(retryWaitTime)
		retryWaitTime *= 2
	end
end

local function notifyQualifying(wasSuccess: boolean)
	local Roles = require(services.Roles) :: any
	local watchedUserIds: {[string]: boolean} = {}
	local handledUserIds: {[string]: boolean} = {}
	local function checkUser(user: User.Class)
		local player = user.player
		local userIdKey = tostring(user.userId)
		if not player or handledUserIds[userIdKey] then
			return
		end
		local rolesReady = user.temp:get("RolesReady")
		local qualifies = rolesReady == true and Roles.hasAnyPermission(user, QUALIFYING_PERMISSIONS)
		if not qualifies then
			return
		end
		if not wasSuccess and not Roles.hasPermission(user, "promptWarnings") then
			return
		end
		handledUserIds[userIdKey] = true
		if wasSuccess then
			local alreadySeen = user.perm:get("AddedToChartsNotice") == true
			if alreadySeen then
				return
			end
			user.perm:set("AddedToChartsNotice", true)
			Prompt.success(player, "Your game was successfully added to the HD Admin Charts!")
		else
			Prompt.warn(player, "HttpService disabled: Unable to join HD Admin Charts. Click here to fix.", {
				duration = 0,
				openImage = {image = INSTRUCTION_IMAGE, title = "Join the HD Admin Charts", ratio = INSTRUCTION_IMAGE_RATIO},
			})
		end
	end
	local function watchUser(user: User.Class)
		if not user.player or watchedUserIds[tostring(user.userId)] then
			return
		end
		watchedUserIds[tostring(user.userId)] = true
		-- Roles land just after the user loads and can change at any point after, so
		-- we re-check on both
		user.janitor:add(user.temp:onBind("RolesReady", function()
			checkUser(user)
		end))
		user.janitor:add(user.temp:onChange("Roles", function()
			checkUser(user)
		end))
	end
	User.userLoaded:Connect(watchUser)
	for _, user in User.getUsers() do
		watchUser(user)
	end
end


-- SETUP
task.defer(function()
	-- An unpublished place has no experience to advertise
	if game.GameId == 0 then
		return
	end
	local hashMapSuccess, hashMap = pcall(function()
		return MemoryStoreService:GetHashMap("HDAdminCharts")
	end)
	if not hashMapSuccess then
		return
	end
	if not isStudio then
		local hasPrompted = retryIndefinitely(function()
			return hashMap:GetAsync(CHARTS_KEY)
		end)
		if hasPrompted == true then
			return
		end
	end
	local requestBody = HttpService:JSONEncode({experience_id = game.GameId})
	local success, result = pcall(function()
		return HttpService:PostAsync(URL, requestBody, Enum.HttpContentType.ApplicationJson, false, {["Authorization"] = TOKEN})
	end)
	if not success then
		local chartsNotice = Config.getSetting("ChartsNotice")
		local httpIsDisabled = tostring(result):lower():match("http requests are not enabled") ~= nil
		if httpIsDisabled and chartsNotice ~= false then
			notifyQualifying(false)
		end
		return
	end
	if not isStudio then
		retryIndefinitely(function()
			return hashMap:SetAsync(CHARTS_KEY, true, CHARTS_EXPIRY)
		end)
	end
	notifyQualifying(true)
end)


return Charts
