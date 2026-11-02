-- Every remote the client can call, answered until a real service takes it over.
--
-- A RemoteFunction with no OnServerInvoke makes the client's InvokeServer wait forever,
-- silently, so each one gets a handler that returns nil straight away. This must start LAST,
-- after every real service: until a handler exists Roblox holds the invocation, which is
-- right for the ones a service is about to answer, and a nil sent early is not (the client's
-- CONSTANTS.INIT got nil for RequestConstants that way). Remotes marked handled are skipped.
-- RemoteEvents only get a logger. The first calls to each are printed with their arguments,
-- which is how the rest of the contract gets read off a live client.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LOG_CALLS = true
local LOG_PER_REMOTE = 3

local RemoteFallbacks = {}

local counts: { [Instance]: number } = {}
local handled: { [Instance]: boolean } = {}

local function describe(...): string
	local parts = {}
	for index = 1, select("#", ...) do
		local value = select(index, ...)
		local text = typeof(value) == "table" and "{table}" or tostring(value)
		table.insert(parts, typeof(value) .. ":" .. string.sub(text, 1, 60))
	end
	return table.concat(parts, ", ")
end

local function log(remote: Instance, player: Player, ...)
	if not LOG_CALLS or handled[remote] then
		return
	end
	counts[remote] = (counts[remote] or 0) + 1
	if counts[remote] <= LOG_PER_REMOTE then
		print(string.format("[Remote] %s <- %s (%s)", remote:GetFullName(), player.Name, describe(...)))
	end
end

-- Services call this for the remotes they own, so the log only shows what is still missing.
function RemoteFallbacks.MarkHandled(remote: Instance)
	handled[remote] = true
end

function RemoteFallbacks.Start()
	local root = ReplicatedStorage:WaitForChild("Remotes")

	for _, remote in root:GetDescendants() do
		if handled[remote] then
			continue
		end

		if remote:IsA("RemoteFunction") then
			remote.OnServerInvoke = function(player: Player, ...)
				log(remote, player, ...)
				return nil
			end
		elseif remote:IsA("RemoteEvent") or remote:IsA("UnreliableRemoteEvent") then
			remote.OnServerEvent:Connect(function(player: Player, ...)
				log(remote, player, ...)
			end)
		end
	end
end

return RemoteFallbacks
