-- Reference copy for study. Game: Steal a Brainrot (SAB files) (steal-a-brainrot-sab-files)
-- Original: ServerScriptService/Services/CodesService.lua  (559 lines)
-- What it does: Codes with limited stock redeemed atomically in UpdateAsync (already-redeemed / out-of-stock reasons), global codes broadcast with MessagingService and stock kept in a MemoryStore sorted map, 5s cooldown.

local CodesService = {}
local Players             = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService    = game:GetService("DataStoreService")
local MemoryStoreService  = game:GetService("MemoryStoreService")

local Net              = require(ReplicatedStorage.Packages.Net)
local Synchronizer     = require(ReplicatedStorage.Packages.Synchronizer)
local Animals          = require(ReplicatedStorage.Datas.Animals)
local MessagingService = require(ServerScriptService.Services.MessagingService)
local IsAdmin          = require(ReplicatedStorage.Shared.IsAdmin)

local CodesDataStore       = DataStoreService:GetDataStore("Codes_V2")
local CodeDefinitionsStore = DataStoreService:GetDataStore("CodeDefinitions_V2")

local CodeStockStore       = MemoryStoreService:GetSortedMap("GlobalCodeStock_V1")
local GLOBAL_CODE_TOPIC    = "CodesService/GlobalCode"
local GLOBAL_CODE_EXPIRY   = 86400 * 7

local FFlagCodesEnabled = true

local COOLDOWN_SECONDS = 5
local ActiveCodes      = {}
local PlayerCooldowns  = {}

local RequestRedemption = Net:RemoteFunction("RequestRedemption")


local function dsKey(code)
	return "Codes-" .. code
end

local function dsDefinitionKey(code)
	return "Def-" .. code
end


local function canRedeem(userId)
	local last = PlayerCooldowns[userId]
	if last and (os.clock() - last) < COOLDOWN_SECONDS then
		return false
	end
	return true
end

local function stampCooldown(userId)
	PlayerCooldowns[userId] = os.clock()
end


local function tryRedeemAtomic(code, userId, maxQuantity)
	local redeemSuccess = false
	local failReason    = nil

	local updateOk = pcall(function()
		CodesDataStore:UpdateAsync(dsKey(code), function(current)
			redeemSuccess = false
			failReason    = nil

			local data = (type(current) == "table") and current or { Redeemed = 0, Users = {} }

			if data.Users[tostring(userId)] then
				failReason = "You already redeemed this code"
				return nil
			end

			if maxQuantity ~= math.huge and data.Redeemed >= maxQuantity then
				failReason = "This code is out of stock"
				return nil
			end

			data.Redeemed += 1
			data.Users[tostring(userId)] = true
			redeemSuccess = true
			return data
		end)
	end)

	if not updateOk then
		return false, "Request failed"
	end

	if redeemSuccess then
		return true
	else
		return false, failReason or "Request failed"
	end
end


local function tryRedeemLocal(codeData, userId, maxQuantity)
	codeData.Redeemed = codeData.Redeemed or 0
	codeData.Users    = codeData.Users or {}

	if codeData.Users[tostring(userId)] then
		return false, "You already redeemed this code"
	end

	if maxQuantity ~= math.huge and codeData.Redeemed >= maxQuantity then
		return false, "This code is out of stock"
	end

	codeData.Redeemed += 1
	codeData.Users[tostring(userId)] = true
	return true
end

local function tryRedeemGlobalShared(code, userId, maxQuantity)
	local upperCode       = string.upper(code)
	local hasLimitedStock = (maxQuantity ~= nil and maxQuantity ~= math.huge)

	if hasLimitedStock then
		local newStock
		local memOk, memErr = pcall(function()
			newStock = CodeStockStore:UpdateAsync(upperCode, function(current)
				if current == nil  then return nil end
				if current <= 0    then return nil end
				return current - 1
			end, GLOBAL_CODE_EXPIRY)
		end)
		if not memOk then
			warn("[CodesService] Global stock UpdateAsync failed, falling back to DataStore-only check:", memErr)
			newStock = nil
			hasLimitedStock = false
		elseif newStock == nil then
			return false, "This code is out of stock"
		end
	end

	local capIsFinite = (maxQuantity ~= nil and maxQuantity ~= math.huge)

	local userAlreadyRedeemed = false
	local stockExceeded       = false
	local dsOk = pcall(function()
		CodesDataStore:UpdateAsync(dsKey(upperCode), function(current)
			local data = (type(current) == "table") and current or { Redeemed = 0, Users = {} }
			if data.Users[tostring(userId)] then
				userAlreadyRedeemed = true
				return nil
			end
			if capIsFinite and (data.Redeemed or 0) >= maxQuantity then
				stockExceeded = true
				return nil
			end
			data.Redeemed = (data.Redeemed or 0) + 1
			data.Users[tostring(userId)] = true
			return data
		end)
	end)

	if hasLimitedStock and (not dsOk or userAlreadyRedeemed or stockExceeded) then
		pcall(function()
			CodeStockStore:UpdateAsync(upperCode, function(current)
				return (current or 0) + 1
			end, GLOBAL_CODE_EXPIRY)
		end)
	end

	if not dsOk            then return false, "Request failed" end
	if userAlreadyRedeemed then return false, "You already redeemed this code" end
	if stockExceeded       then return false, "This code is out of stock" end
	return true
end


function CodesService.RegisterCode(code, brainrotKey, mutation, quantity, persist)
	if not FFlagCodesEnabled then
		return false, "Codes are currently disabled"
	end

	local finalMutation  = (mutation  ~= nil and mutation  ~= "") and mutation  or nil
	local finalQuantity  = (quantity  ~= nil and quantity  > 0)   and quantity  or math.huge

	local upperCode = string.upper(code)

	local entry = {
		BrainrotKey = brainrotKey,
		Mutation    = finalMutation,
		Quantity    = finalQuantity,
		Persisted   = persist and true or false,
	}

	if not entry.Persisted then
		entry.Redeemed = 0
		entry.Users    = {}
	end

	ActiveCodes[upperCode] = entry

	if not entry.Persisted then
		return true
	end

	local success, err = pcall(function()
		CodeDefinitionsStore:SetAsync(dsDefinitionKey(upperCode), {
			BrainrotKey = brainrotKey,
			Mutation    = finalMutation,
			Quantity    = (finalQuantity == math.huge) and nil or finalQuantity,
			CreatedAt   = os.time(),
		})
	end)

	if not success then
		warn("Failed to persist code to DataStore:", err)
	end

	return success
end


local function applyGlobalCodeLocally(codeData)
	if type(codeData) ~= "table" or type(codeData.Code) ~= "string" then return end

	local upperCode = string.upper(codeData.Code)
	local quantity  = codeData.Quantity
	if quantity == nil then quantity = math.huge end

	ActiveCodes[upperCode] = {
		BrainrotKey  = codeData.BrainrotKey,
		Mutation     = codeData.Mutation,
		Quantity     = quantity,
		Persisted    = true,
		GlobalShared = true,
	}
end

local function removeGlobalCodeLocally(code)
	if type(code) ~= "string" then return end
	ActiveCodes[string.upper(code)] = nil
end

function CodesService.CreateGlobalCode(code, brainrotKey, mutation, quantity)
	if not FFlagCodesEnabled then
		return false, "Codes are currently disabled"
	end

	if type(code) ~= "string" or code == "" then
		return false, "Code must be a non-empty string"
	end
	if type(brainrotKey) ~= "string" or not Animals[brainrotKey] then
		return false, ("Brainrot not found in AnimalsDB: %s"):format(tostring(brainrotKey))
	end

	local upperCode = string.upper(code)
	local cleanMutation = (mutation ~= nil and mutation ~= "") and mutation or nil

	local numericQuantity = tonumber(quantity)
	if numericQuantity ~= nil and numericQuantity <= 0 then
		numericQuantity = nil
	end

	if numericQuantity ~= nil then
		local seedOk, seedErr = pcall(function()
			CodeStockStore:SetAsync(upperCode, numericQuantity, GLOBAL_CODE_EXPIRY)
		end)
		if not seedOk then
			return false, ("Failed to seed shared stock: %s"):format(tostring(seedErr))
		end
	end

	local definitionPayload = {
		BrainrotKey  = brainrotKey,
		Mutation     = cleanMutation,
		Quantity     = numericQuantity,
		GlobalShared = true,
		CreatedAt    = os.time(),
	}
	local defOk, defErr = pcall(function()
		CodeDefinitionsStore:SetAsync(dsDefinitionKey(upperCode), definitionPayload)
	end)
	if not defOk then
		warn("[CodesService] Failed to persist global code definition:", defErr)
	end

	local envelope = {
		Code        = upperCode,
		BrainrotKey = brainrotKey,
		Mutation    = cleanMutation,
		Quantity    = numericQuantity,
	}

	applyGlobalCodeLocally(envelope)

	pcall(function()
		MessagingService:PublishAsync(GLOBAL_CODE_TOPIC, {
			Action = "Set",
			Data   = envelope,
		})
	end)

	return true
end

local function subscribeGlobalCodeMessages()
	pcall(function()
		MessagingService:SubscribeAsync(GLOBAL_CODE_TOPIC, function(payload)
			if type(payload) ~= "table" then return end
			if payload.Action == "Set" then
				applyGlobalCodeLocally(payload.Data)
			elseif payload.Action == "Remove" then
				removeGlobalCodeLocally(payload.Data)
			end
		end)
	end)
end

function CodesService.RemoveCode(code, requesterUserId)
	local upperCode = string.upper(code)

	local existing = ActiveCodes[upperCode]

	local isGlobal = (existing ~= nil) and (existing.GlobalShared == true)
	local defOk, defData = pcall(function()
		return CodeDefinitionsStore:GetAsync(dsDefinitionKey(upperCode))
	 end)
	if defOk and type(defData) == "table" and defData.GlobalShared then
		isGlobal = true
	end

	if isGlobal and not (requesterUserId ~= nil and IsAdmin(requesterUserId)) then
		return false, "Only admins can remove global codes"
	end

	local wasPersisted = (existing == nil) or (existing.Persisted == true)

	ActiveCodes[upperCode] = nil

	if not wasPersisted then
		return true
	end

	local success1, err1 = pcall(function()
		CodeDefinitionsStore:RemoveAsync(dsDefinitionKey(upperCode))
	end)

	if not success1 then
		warn("Failed to remove code definition from DataStore:", err1)
	end

	local success2, err2 = pcall(function()
		CodesDataStore:RemoveAsync(dsKey(upperCode))
	end)

	if not success2 then
		warn("Failed to remove code redemption data from DataStore:", err2)
	end

	if isGlobal then
		pcall(function() CodeStockStore:RemoveAsync(upperCode) end)
		pcall(function()
			MessagingService:PublishAsync(GLOBAL_CODE_TOPIC, {
				Action = "Remove",
				Data   = upperCode,
			})
		end)
	end

	return success1 and success2
end

function CodesService.GetCodes()
	return ActiveCodes
end

function CodesService.SetEnabled(enabled)
	FFlagCodesEnabled = enabled and true or false
end

function CodesService.IsEnabled()
	return FFlagCodesEnabled
end

function CodesService.GetCodeInfo(code)
	local upperCode = string.upper(code)
	return ActiveCodes[upperCode]
end

function CodesService.GetRedemptionStats(code)
	local upperCode = string.upper(code)

	local entry = ActiveCodes[upperCode]
	if entry and not entry.Persisted then
		return {
			Redeemed    = entry.Redeemed or 0,
			UniqueUsers = 0,
		}
	end

	local success, data = pcall(function()
		return CodesDataStore:GetAsync(dsKey(upperCode))
	end)

	if success and type(data) == "table" then
		return {
			Redeemed = data.Redeemed or 0,
			UniqueUsers = 0,
		}
	end

	return {
		Redeemed = 0,
		UniqueUsers = 0,
	}
end


local function loadCodesFromDataStore()
	print("[CodesService] Loading codes from DataStore...")

	local success, result = pcall(function()
		local pages = CodeDefinitionsStore:ListKeysAsync("Def-", 100)
		local loaded = 0

		while true do
			local keys = pages:GetCurrentPage()

			for _, keyInfo in ipairs(keys) do
				local code = keyInfo.KeyName:gsub("^Def%-", "")

				local dataSuccess, codeData = pcall(function()
					return CodeDefinitionsStore:GetAsync(keyInfo.KeyName)
				end)

				if dataSuccess and type(codeData) == "table" then
					ActiveCodes[code] = {
						BrainrotKey  = codeData.BrainrotKey,
						Mutation     = codeData.Mutation,
						Quantity     = codeData.Quantity or math.huge,
						Persisted    = true,
						GlobalShared = codeData.GlobalShared and true or false,
					}
					loaded += 1
				else
					warn("[CodesService] Failed to load code:", code)
				end
			end

			if pages.IsFinished then
				break
			end

			pages:AdvanceToNextPageAsync()
		end

		return loaded
	end)

	if success then
		print(("[CodesService] Loaded %d codes"):format(result))
	else
		warn("[CodesService] Failed to load codes:", result)
	end
end

function CodesService:Start()
	task.spawn(function()

		Players.PlayerRemoving:Connect(function(player)
			PlayerCooldowns[player.UserId] = nil
		end)


		RequestRedemption.OnServerInvoke = function(player, rawCode)
			if not FFlagCodesEnabled then
				return false, "Codes are currently disabled"
			end

			if typeof(rawCode) ~= "string" then
				return false, "Invalid Code"
			end

			local userId = player.UserId
			local code   = string.upper(string.gsub(rawCode, "[^%w]", ""))

			if #code < 1 then
				return false, "Invalid Code"
			end

			if not canRedeem(userId) then
				return false, "Please wait before trying to redeem another code"
			end

			stampCooldown(userId)

			local codeData = ActiveCodes[code]
			if not codeData then
				local defOk, defData = pcall(function()
					return CodeDefinitionsStore:GetAsync(dsDefinitionKey(code))
				end)
				if defOk and type(defData) == "table" then
					ActiveCodes[code] = {
						BrainrotKey  = defData.BrainrotKey,
						Mutation     = defData.Mutation,
						Quantity     = defData.Quantity or math.huge,
						Persisted    = true,
						GlobalShared = defData.GlobalShared and true or false,
					}
					codeData = ActiveCodes[code]
				end
			end

			if not codeData then
				local dsOk, dsData = pcall(function()
					return CodesDataStore:GetAsync(dsKey(code))
				end)
				if dsOk and type(dsData) == "table" then
					if dsData.Users and dsData.Users[tostring(userId)] then
						return false, "You already redeemed this code"
					else
						return false, "This code is out of stock"
					end
				end
				return false, "Invalid Code"
			end

			local animalData = Animals[codeData.BrainrotKey]
			if not animalData then
				return false, "Invalid Code"
			end

			local successSvc, AnimalService = pcall(function()
				return require(ServerScriptService.Services.AnimalService)
			end)
			if not successSvc or not AnimalService then
				return false, "Request failed"
			end

			local PlayerChannel = Synchronizer:Get(player)
			if not PlayerChannel then
				return false, "Request failed"
			end

			local ok, reason
			if codeData.GlobalShared then
				ok, reason = tryRedeemGlobalShared(code, userId, codeData.Quantity)
			elseif codeData.Persisted then
				ok, reason = tryRedeemAtomic(code, userId, codeData.Quantity)
			else
				ok, reason = tryRedeemLocal(codeData, userId, codeData.Quantity)
			end
			if not ok then
				return false, reason
			end

			AnimalService.spawnAnimalCustom(animalData, codeData.Mutation, nil, nil, nil, nil)

			return true, string.format("%s spawned!", animalData.DisplayName)
		end


		task.spawn(loadCodesFromDataStore)
		task.spawn(subscribeGlobalCodeMessages)

		_G.CodesService = CodesService
	end)
end

return CodesService
