--!strict
-- LOCAL
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local defaultRole: any = require(modules.References.defaultRole)
local GroupGate = require(modules.Parent.Services.Roles.GroupGate)
local Grants = {}


-- TYPES
type Role = typeof(defaultRole)
export type Opts = GroupGate.Opts


-- FUNCTIONS
function Grants.qualifiesForRole(userId: number, role: Role, opts: GroupGate.Opts?): boolean
	if typeof(userId) ~= "number" or typeof(role) ~= "table" then return false end
	local roleAny = role :: any
	local function markError()
		if opts and (opts :: any).errorSink then (opts :: any).errorSink.failed = true end
	end

	if roleAny.giveToEveryone == true then return true end

	if roleAny.giveToPrivateServerOwner == true then
		local privateOwnerId = game.PrivateServerOwnerId
		if privateOwnerId ~= 0 and privateOwnerId == userId then return true end
	end

	local MarketplaceService = game:GetService("MarketplaceService")
	local Presets = require(modules.Parent.Controllers.UI.Config.Presets) :: any

	if typeof(roleAny.giveToUsers) == "table" then
		for _, entry in roleAny.giveToUsers :: {any} do
			if typeof(entry) ~= "table" then continue end
			local et = entry.type
			if et == "UserId" and typeof(entry.userId) == "number" then
				if entry.userId == userId then return true end
			elseif et == "Preset" and typeof(entry.preset) == "string" then
				local preset = Presets.users[entry.preset]
				if preset then
					local ok, ids = pcall(preset.resolveUserIds)
					if not ok then
						markError()
					elseif typeof(ids) == "table" then
						for _, id in ids :: {any} do
							if id == userId then return true end
						end
					end
				end
			end
		end
	end

	if GroupGate.qualifies(userId, roleAny.giveToGroups, opts) then return true end

	if typeof(roleAny.giveToProducts) == "table" then
		local assetOwnership = require(modules.PlayerUtil.assetOwnership)
		local function ownsProduct(infoType: any, id: number): boolean
			if infoType == Enum.InfoType.GamePass then
				local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, userId, id)
				if not ok then markError() end
				return ok and owns == true
			elseif infoType == Enum.InfoType.Asset then
				-- assetOwnership can answer for offline targets too
				return assetOwnership.check(userId, id)
			elseif infoType == Enum.InfoType.Bundle then
				local ok, owns = pcall(function()
					return (MarketplaceService :: any):UserOwnsBundle(userId, id)
				end)
				if not ok then markError() end
				return ok and owns == true
			end
			return false
		end
		for _, entry in roleAny.giveToProducts :: {any} do
			if typeof(entry) ~= "table" then continue end
			local et = entry.type
			local id = entry.id
			if et == "GamePass" and typeof(id) == "number" then
				if ownsProduct(Enum.InfoType.GamePass, id) then return true end
			elseif et == "Asset" and typeof(id) == "number" then
				if ownsProduct(Enum.InfoType.Asset, id) then return true end
			elseif et == "Bundle" and typeof(id) == "number" then
				if ownsProduct(Enum.InfoType.Bundle, id) then return true end
			elseif et == "Preset" and typeof(entry.preset) == "string" then
				local preset = Presets.products[entry.preset]
				if preset and typeof(preset.id) == "number" then
					if ownsProduct(preset.infoType, preset.id) then return true end
				end
			end
		end
	end

	return false
end

function Grants.resolveRolesForPlayer(player: Player, allRoles: {Role}, opts: GroupGate.Opts?): {string}
	local granted: {string} = {}
	if typeof(player) ~= "Instance" or not (player :: any):IsA("Player") then return granted end
	return Grants.resolveRolesForUserId((player :: Player).UserId, allRoles, opts)
end

function Grants.resolveRolesForUserId(userId: number, allRoles: {Role}, opts: GroupGate.Opts?): {string}
	local granted: {string} = {}
	if typeof(userId) ~= "number" then return granted end
	-- Studio test server clients have negative ids like -1
	if userId <= 0 and not (RunService:IsStudio() and userId < 0) then return granted end
	for _, role in allRoles do
		if Grants.qualifiesForRole(userId, role, opts) then
			table.insert(granted, (role :: any).key)
		end
	end
	return granted
end


return Grants
