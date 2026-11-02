--!strict

--[[

	This provides the ability to sell ugradable command args

--]]


-- LOCAL
local ArgProducts = {}
local MarketplaceService = game:GetService("MarketplaceService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local products = require(modules.References.products)
local ownsAssetAsync = require(modules.AssetUtil.ownsAssetAsync)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)
local displayNameCache: {[string]: string} = {}


-- LOCAL FUNCTIONS
local function getUserTemp(player: Player): any?
	local User = require(modules.Objects.User) :: any
	local user = User.getUser(player)
	return if user then user.temp else nil
end

local function escapeRich(text: string): string
	return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function resolveDisplayName(productName: string): string
	local cached = displayNameCache[productName]
	if cached then
		return cached
	end
	local productInfo = products[productName :: any]
	if not productInfo then
		return productName
	end
	local ok, marketInfo = pcall(function()
		return MarketplaceService:GetProductInfo(productInfo.id, productInfo.infoType)
	end)
	local resolved = productName
	if ok and typeof(marketInfo) == "table" and typeof((marketInfo :: any).Name) == "string" then
		resolved = (marketInfo :: any).Name
	end
	displayNameCache[productName] = resolved
	return resolved
end


-- FUNCTIONS
function ArgProducts.getProducts(argDetail: any): {string}?
	local list = if typeof(argDetail) == "table" then (argDetail :: any).products else nil
	if typeof(list) ~= "table" or #list == 0 then
		return nil
	end
	return list
end

function ArgProducts.matchesDefault(argDetail: any, value: any): boolean
	local detail = argDetail :: any
	local default = detail.default
	if default == nil and typeof(detail.inputObject) == "table" then
		default = detail.inputObject.default
	end
	return areValuesEqual(value, default)
end

function ArgProducts.ownsAnyAsync(player: Player, productNames: {string}): boolean
	local User = require(modules.Objects.User) :: any
	local Roles = require(modules.Parent.Services.Roles) :: any
	if Roles.qualifiesForAutoUnlock(User.getUser(player)) then
		return true
	end
	local temp = getUserTemp(player)
	local owned = if temp then temp:get("OwnedArgProducts") else nil
	if typeof(owned) == "table" then
		for _, productName in productNames do
			if owned[productName] == true then
				return true
			end
		end
	end
	for _, productName in productNames do
		local success, owns = ownsAssetAsync(productName :: any, player)
		if success and owns == true then
			if temp then
				local record = if typeof(owned) == "table" then owned else {}
				record[productName] = true
				temp:set("OwnedArgProducts", record)
			end
			return true
		end
	end
	return false
end

function ArgProducts.sendUnlockNoticeAsync(player: Player, productNames: {string}, argDetail: any, commandName: string?)
	local temp = getUserTemp(player)
	local clockNow = os.clock()
	if temp then
		local lastDeny = temp:get("ArgProductsDenyClock")
		if typeof(lastDeny) == "number" and clockNow - lastDeny < 2 then
			return
		end
		temp:set("ArgProductsDenyClock", clockNow)
	end
	local firstName = productNames[1]
	local detail = argDetail :: any
	local argName = if typeof(detail) == "table" then (detail.display or detail.key) else nil
	local commandLabel = if typeof(commandName) == "string" and #commandName > 0 then escapeRich(commandName) else "this command"
	local neededFor = if typeof(argName) == "string" then `{commandLabel}'s {escapeRich(argName)}` else commandLabel
	local Prompt = require(modules.Prompt) :: any
	local message = `You need <b>{escapeRich(resolveDisplayName(firstName))}</b> to use {neededFor}. Click to unlock.`
	Prompt.info(player, message, {promptProduct = firstName, duration = 0})
end


return ArgProducts
