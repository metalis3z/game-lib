local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local CodeServiceUtils = require(ReplicatedStorage.Source.Features.Codes.CodeServiceUtils)

local ENUMS = CodeServiceUtils.REDEEM_ENUMS

local CODES = {
	["RELEASE"] = {
		maxUses = 0,   
		expiry  = 0,   
		reward  = function(player, data)
			local coins = data:get("coins") or 0
			DataService:set(player, "coins", coins + 5000)
			print("[CodeService] RELEASE: gave 5000 coins to", player.Name)
		end,
	},

	["SLIMETIME"] = {
		maxUses = 0,
		expiry  = 0,
		reward  = function(player, data)
			local coins = data:get("coins") or 0
			DataService:set(player, "coins", coins + 10000)
			print("[CodeService] SLIMETIME: gave 10000 coins to", player.Name)
		end,
	},

	["BOOST100"] = {
		maxUses = 0,
		expiry  = 0,
		reward  = function(player, data)
			local boosts = data:get("boosts") or {}
			local existing = type(boosts["luck"]) == "table" and boosts["luck"] or {}
			local currentAmount = type(existing.amount) == "number" and existing.amount or 0
			local currentExpiry = type(existing.expirationTime) == "number" and existing.expirationTime or 0
			local now     = os.time()
			local newExpiry   = math.max(currentExpiry, now) + 3600
			local newRemaining = newExpiry - now
			DataService:set(player, { "boosts", "luck", "amount"          }, currentAmount + 1)
			DataService:set(player, { "boosts", "luck", "timeRemaining"   }, newRemaining)
			DataService:set(player, { "boosts", "luck", "expirationTime"  }, newExpiry)
			print("[CodeService] BOOST100: gave 1 luck boost charge to", player.Name)
		end,
	},
}

local CodeService = {}


local function normalizeCode(raw: string): string
	return string.upper(string.match(raw, "^%s*(.-)%s*$") or raw)
end

function CodeService:redeem(player: Player, rawCode: string)
	if type(rawCode) ~= "string" or #rawCode == 0 then
		return ENUMS.invalid
	end

	local code = normalizeCode(rawCode)
	local def  = CODES[code]

	if not def then
		return ENUMS.invalid
	end

	if def.expiry and def.expiry > 0 and os.time() > def.expiry then
		return ENUMS.expired
	end

	if def.onlyUserId and player.UserId ~= def.onlyUserId then
		return ENUMS.wrongUser
	end

	local data = DataService:waitForData(player)
	if not data then
		warn("[CodeService] No data for", player.Name)
		return ENUMS.err
	end

	local redeemed = data:get("__redeemedCodes") or {}
	if redeemed[code] then
		return ENUMS.alreadyRedeemed
	end

	if def.maxUses and def.maxUses > 0 then
		CodeService._useCounts = CodeService._useCounts or {}
		local uses = CodeService._useCounts[code] or 0
		if uses >= def.maxUses then
			return ENUMS.outOfUses
		end
		CodeService._useCounts[code] = uses + 1
	end

	local ok, err = pcall(def.reward, player, data)
	if not ok then
		warn("[CodeService] Reward error for code", code, "player", player.Name, ":", err)
		-- Roll back use count if we incremented it
		if def.maxUses and def.maxUses > 0 then
			CodeService._useCounts[code] = math.max((CodeService._useCounts[code] or 1) - 1, 0)
		end
		return ENUMS.err
	end

	local newRedeemed = table.clone(redeemed)
	newRedeemed[code] = true
	DataService:set(player, "__redeemedCodes", newRedeemed)

	print(string.format("[CodeService] '%s' redeemed by %s", code, player.Name))
	return ENUMS.success
end

function CodeService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[CodeService] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("CodeService", 10)
	if not svcRemotes then
		warn("[CodeService] CodeService remotes not found")
		return
	end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			print("[CodeService] Invoked:", method, "| player:", player.Name)
			if method == "redeem" then
				return self:redeem(player, ...)
			end
			warn("[CodeService] Unknown method:", method)
			return ENUMS.err
		end
		print("[CodeService] OnServerInvoke set")
	else
		warn("[CodeService] RemoteFunction not found in CodeService remotes")
	end

	self._useCounts = {}

	print("[CodeService] Initialized |", #(function()
		local t = {}
		for k in pairs(CODES) do table.insert(t, k) end
		return t
	end)(), "codes loaded")
end

return CodeService