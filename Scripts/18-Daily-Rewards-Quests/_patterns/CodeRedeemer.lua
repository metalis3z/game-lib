--[[
	CodeRedeemer  (ModuleScript, server only)

	Social-media style promo codes:
	  * case- and space-insensitive ("  welcome " == "WELCOME")
	  * expiry date per code, optional minimum level/requirement check
	  * once per player, remembered in the player's SAVED data (not a server-memory table)
	  * optional limited global uses ("first 500 players"), counted atomically with UpdateAsync
	  * per-player cooldown so the remote cannot be spammed into DataStore throttling
	  * returns a short status string the UI can show

	Credit: steal-a-brainrot-sab-files CodesService (atomic UpdateAsync stock with
	"already redeemed" / "out of stock" reasons, 5s cooldown), rivals-modded ClaimService
	(RedeemedCodes in profile, lower-cased lookup), uno CodeHandler (expire timestamps),
	steal-a-brainrot CodeService (normalizeCode trim + upper).

	Usage (server):
		local CodeRedeemer = require(game.ServerScriptService.CodeRedeemer)

		CodeRedeemer.Configure({
			GetData = function(player) return MyData:Get(player) end, -- must persist data.RedeemedCodes
			Grant = function(player, rewards, code) -- return true when given
				local data = MyData:Get(player)
				data.Coins += rewards.Coins or 0
				return true
			end,
			Codes = {
				WELCOME = { Rewards = { Coins = 500 } },
				UPDATE5 = { Rewards = { Coins = 5000 }, Expires = os.time({ year = 2026, month = 12, day = 31 }) },
				FIRST500 = { Rewards = { Gems = 50 }, MaxUses = 500 },
				LEVEL10 = { Rewards = { Gems = 10 }, Requires = function(player, data)
					return (data.Level or 1) >= 10, "Reach level 10 first!"
				end },
			},
		})

		RedeemRemote.OnServerInvoke = function(player, text)
			return CodeRedeemer.Redeem(player, text) -- "Success" | reason
		end
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local CodeRedeemer = {}

local COOLDOWN = 3
local MAX_LENGTH = 40

local config = nil
local codes = {} -- [NORMALIZED] = definition
local usesStore = nil
local lastTry = {}

local function normalize(text)
	if type(text) ~= "string" or #text > MAX_LENGTH then
		return nil
	end
	local trimmed = string.upper((text:gsub("^%s+", ""):gsub("%s+$", "")))
	if trimmed == "" then
		return nil
	end
	return trimmed
end

function CodeRedeemer.Configure(options)
	config = options
	table.clear(codes)
	for name, definition in pairs(options.Codes) do
		codes[normalize(name)] = definition
	end
	usesStore = DataStoreService:GetDataStore(options.UsesStoreName or "CodeUses_v1")
	Players.PlayerRemoving:Connect(function(player)
		lastTry[player] = nil
	end)
end

-- Takes one global use. Returns true, or false + reason.
local function takeUse(code, maxUses)
	local taken, full = false, false
	local ok = pcall(function()
		usesStore:UpdateAsync(code, function(current)
			current = tonumber(current) or 0
			if current >= maxUses then
				full = true
				return nil
			end
			full = false
			taken = true
			return current + 1
		end)
	end)
	if not ok then
		return false, "Try again in a moment"
	end
	if full or not taken then
		return false, "This code has run out"
	end
	return true
end

local function giveBackUse(code)
	pcall(function()
		usesStore:UpdateAsync(code, function(current)
			return math.max(0, (tonumber(current) or 1) - 1)
		end)
	end)
end

function CodeRedeemer.Redeem(player, text)
	local now = os.clock()
	if now - (lastTry[player] or 0) < COOLDOWN then
		return "Slow down!"
	end
	lastTry[player] = now

	local code = normalize(text)
	local definition = code and codes[code]
	if not definition then
		return "Invalid code"
	end
	if definition.Expires and os.time() > definition.Expires then
		return "This code has expired"
	end

	local data = config.GetData(player)
	if not data then
		return "Your data is still loading"
	end
	data.RedeemedCodes = data.RedeemedCodes or {}
	if data.RedeemedCodes[code] then
		return "Already redeemed"
	end
	if definition.Requires then
		local ok, allowed, reason = pcall(definition.Requires, player, data)
		if not ok or not allowed then
			return reason or "You can't use this code yet"
		end
	end

	if definition.MaxUses then
		local ok, reason = takeUse(code, definition.MaxUses)
		if not ok then
			return reason
		end
	end

	-- Mark first so a yield inside Grant cannot let a second request through.
	data.RedeemedCodes[code] = os.time()
	local ok, given = pcall(config.Grant, player, definition.Rewards, code)
	if not ok or not given then
		data.RedeemedCodes[code] = nil
		if definition.MaxUses then
			giveBackUse(code)
		end
		warn("[CodeRedeemer] Grant failed for " .. code .. ": " .. tostring(given))
		return "Something went wrong, try again"
	end
	return "Success"
end

-- For a codes UI: active (not expired) code names. Do not send hidden codes to clients.
function CodeRedeemer.ListActive()
	local list = {}
	for code, definition in pairs(codes) do
		if not definition.Hidden and not (definition.Expires and os.time() > definition.Expires) then
			table.insert(list, code)
		end
	end
	table.sort(list)
	return list
end

return CodeRedeemer
