--[[
	Net  (ModuleScript in ReplicatedStorage, used by server and client)

	A thin remote wrapper that makes the safe thing the easy thing:
	  * remotes are created by the server on demand, inside one folder (client just waits)
	  * every server handler gets argument TYPE CHECKS before your code runs
	  * every server handler gets a per-player RATE LIMIT (token bucket)
	  * handlers are pcall'd, so one bad call cannot break the connection for everyone
	  * RemoteFunctions return (ok, ...) to the client instead of hanging forever on errors

	Credit: aura-ascension RemoteBinder (create remotes per service on demand) and RateLimiter
	(per-player per-key cooldown), punching-simulator Network (one API for remotes and
	bindables), drill-and-mine services (type checks at the top of every OnServerInvoke),
	rivals-modded RemoteFallbacks (never leave an InvokeServer waiting forever).

	Usage (server):
		local Net = require(game.ReplicatedStorage.Net)

		Net.OnEvent("BuyItem", { "string", "number?" }, function(player, itemId, amount)
			-- itemId is guaranteed to be a string, amount a number or nil
		end, { Rate = 5, Burst = 10 }) -- 5 calls/sec, bursts of 10

		Net.OnInvoke("GetInventory", {}, function(player)
			return MyData:Get(player).Inventory
		end)

		Net.Fire(player, "Notify", "Hello")       -- one player
		Net.FireAll("Announcement", "Event soon")

	Usage (client):
		local Net = require(game.ReplicatedStorage.Net)
		Net.Send("BuyItem", "Sword", 1)
		local ok, inventory = Net.Invoke("GetInventory")
		Net.On("Notify", function(text) print(text) end)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local IS_SERVER = RunService:IsServer()
local FOLDER_NAME = "NetRemotes"

local Net = {}

local folder
if IS_SERVER then
	folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME) or Instance.new("Folder")
	folder.Name = FOLDER_NAME
	folder.Parent = ReplicatedStorage
else
	folder = ReplicatedStorage:WaitForChild(FOLDER_NAME)
end

local function getRemote(name, className)
	local remote = folder:FindFirstChild(name)
	if remote then
		return remote
	end
	if not IS_SERVER then
		return folder:WaitForChild(name, 30) or error("Net: remote '" .. name .. "' never appeared")
	end
	remote = Instance.new(className)
	remote.Name = name
	remote.Parent = folder
	return remote
end

------------------------------------------------------------------------
-- Validation: a list of type names, "?" suffix = optional. Extra arguments are rejected.
-- Numbers are also rejected when NaN or infinite (a classic exploit input).
------------------------------------------------------------------------
local function validate(schema, ...)
	local count = select("#", ...)
	if count > #schema then
		return false
	end
	for index, rule in ipairs(schema) do
		local value = select(index, ...)
		local optional = string.sub(rule, -1) == "?"
		local kind = if optional then string.sub(rule, 1, -2) else rule
		if value == nil then
			if not optional then
				return false
			end
		elseif kind ~= "any" then
			if typeof(value) ~= kind then
				return false
			end
			if kind == "number" and (value ~= value or math.abs(value) == math.huge) then
				return false
			end
			if kind == "string" and #value > 1000 then
				return false
			end
		end
	end
	return true
end

------------------------------------------------------------------------
-- Token bucket: Rate tokens per second, up to Burst saved up.
------------------------------------------------------------------------
local buckets = {} -- [player][name] = { Tokens, Last }

local function allow(player, name, limits)
	local rate = limits and limits.Rate or 10
	local burst = limits and limits.Burst or rate * 2
	local perPlayer = buckets[player]
	if not perPlayer then
		perPlayer = {}
		buckets[player] = perPlayer
	end
	local bucket = perPlayer[name]
	local now = os.clock()
	if not bucket then
		bucket = { Tokens = burst, Last = now }
		perPlayer[name] = bucket
	end
	bucket.Tokens = math.min(burst, bucket.Tokens + (now - bucket.Last) * rate)
	bucket.Last = now
	if bucket.Tokens < 1 then
		return false
	end
	bucket.Tokens -= 1
	return true
end

if IS_SERVER then
	Players.PlayerRemoving:Connect(function(player)
		buckets[player] = nil
	end)
end

------------------------------------------------------------------------
-- Server API
------------------------------------------------------------------------

function Net.OnEvent(name, schema, handler, limits)
	assert(IS_SERVER, "Net.OnEvent is server only")
	getRemote(name, "RemoteEvent").OnServerEvent:Connect(function(player, ...)
		if not allow(player, name, limits) or not validate(schema, ...) then
			return
		end
		local ok, err = pcall(handler, player, ...)
		if not ok then
			warn(("[Net] %s handler error: %s"):format(name, tostring(err)))
		end
	end)
end

function Net.OnInvoke(name, schema, handler, limits)
	assert(IS_SERVER, "Net.OnInvoke is server only")
	getRemote(name, "RemoteFunction").OnServerInvoke = function(player, ...)
		if not allow(player, name, limits) then
			return false, "RateLimited"
		end
		if not validate(schema, ...) then
			return false, "BadArguments"
		end
		local result = table.pack(pcall(handler, player, ...))
		if not result[1] then
			warn(("[Net] %s handler error: %s"):format(name, tostring(result[2])))
			return false, "ServerError"
		end
		return true, table.unpack(result, 2, result.n)
	end
end

function Net.Fire(player, name, ...)
	getRemote(name, "RemoteEvent"):FireClient(player, ...)
end

function Net.FireAll(name, ...)
	getRemote(name, "RemoteEvent"):FireAllClients(...)
end

-- Create remotes up front so clients never wait for one that is only fired later.
function Net.Declare(names, className)
	assert(IS_SERVER, "Net.Declare is server only")
	for _, name in ipairs(names) do
		getRemote(name, className or "RemoteEvent")
	end
end

------------------------------------------------------------------------
-- Client API
------------------------------------------------------------------------

function Net.Send(name, ...)
	getRemote(name, "RemoteEvent"):FireServer(...)
end

-- Returns (ok, ...) - ok is false with a reason string when the server refused or errored.
function Net.Invoke(name, ...)
	return getRemote(name, "RemoteFunction"):InvokeServer(...)
end

function Net.On(name, callback)
	return getRemote(name, "RemoteEvent").OnClientEvent:Connect(callback)
end

return Net
