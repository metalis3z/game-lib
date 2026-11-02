local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net         = require(ReplicatedStorage.Packages.Net)
local Animals     = require(ReplicatedStorage.Datas.Animals)
local Mutations   = require(ReplicatedStorage.Datas.Mutations)
local blacklisted = require(ReplicatedStorage.GameData)
local IsAdmin     = require(ReplicatedStorage.Shared.IsAdmin)

local CodesService
repeat
	task.wait()
	CodesService = _G.CodesService
until CodesService





Net:RemoteFunction("AdminService/CreateCode").OnServerInvoke = function(player, codeName, brainrotKey, mutation, quantity)
	if typeof(codeName) ~= "string" or codeName == "" then
		return false, "Invalid code name"
	end

	local cleanCode = string.upper(string.gsub(codeName, "[^%w]", ""))
	if #cleanCode < 1 then
		return false, "Code name must contain at least one alphanumeric character"
	end

	if typeof(brainrotKey) ~= "string" or not Animals[brainrotKey] then
		return false, "Invalid brainrot: " .. tostring(brainrotKey)
	end

	if blacklisted.UnSpawnableBrainrots[brainrotKey] and not IsAdmin(player.UserId) then
		return false, "Animal '" .. brainrotKey .. "' is blacklisted"
	end

	if mutation == "" or mutation == "None" then
		mutation = nil
	end

	if mutation ~= nil then
		if typeof(mutation) ~= "string" then
			return false, "Invalid mutation type"
		end
		if not Mutations[mutation] then
			return false, "Mutation '" .. mutation .. "' does not exist"
		end
	end

	if typeof(quantity) ~= "number" then
		return false, "Quantity must be a number"
	end

	if quantity ~= math.huge and quantity < 1 then
		return false, "Quantity must be at least 1 or infinite"
	end

	local existingCodes = CodesService.GetCodes()
	if existingCodes[cleanCode] then
		return false, "Code '" .. cleanCode .. "' already exists!"
	end

	local finalQuantity = (quantity == math.huge) and nil or quantity

	local persist = IsAdmin(player.UserId)

	local success = CodesService.RegisterCode(
		cleanCode,
		brainrotKey,
		mutation,
		finalQuantity,
		persist
	)

	if not success then
		return false, "Failed to save code to DataStore"
	end

	print(("[AdminCodeService] %s created %s code '%s': %s x%s%s"):format(
		player.Name,
		persist and "global" or "server-local",
		cleanCode,
		brainrotKey,
		(quantity == math.huge) and "∞" or tostring(quantity),
		mutation and (" [" .. mutation .. "]") or ""
		))

	local qtyDisplay = (quantity == math.huge) and "Infinite" or tostring(math.floor(quantity))

	return true, string.format(
		"Code '%s' created! (%s x%s%s)",
		cleanCode,
		Animals[brainrotKey].DisplayName,
		qtyDisplay,
		mutation and (" [" .. mutation .. "]") or ""
	)
end


Net:RemoteFunction("AdminService/DeleteCode").OnServerInvoke = function(player, codeName)


	if typeof(codeName) ~= "string" or codeName == "" then
		return false, "Invalid code name"
	end

	local cleanCode = string.upper(string.gsub(codeName, "[^%w]", ""))
	if #cleanCode < 1 then
		return false, "Code name must contain at least one alphanumeric character"
	end

	local existingCodes = CodesService.GetCodes()
	if not existingCodes[cleanCode] then
		return false, "Code '" .. cleanCode .. "' does not exist"
	end

	local codeInfo = existingCodes[cleanCode]

	local success, reason = CodesService.RemoveCode(cleanCode, player.UserId)

	if not success then
		return false, reason or "Failed to remove code from DataStore"
	end

	print(("[AdminCodeService] %s deleted code '%s' (%s)"):format(
		player.Name,
		cleanCode,
		codeInfo.BrainrotKey
		))

	return true, "Code '" .. cleanCode .. "' deleted successfully!"
end


print("[AdminCodeService] Loaded successfully")
