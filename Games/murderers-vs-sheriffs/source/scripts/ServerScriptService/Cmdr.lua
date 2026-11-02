local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedRoot = ReplicatedStorage:FindFirstChild("CmdrClient")
local Shared = script:FindFirstChild("Shared") or (ReplicatedRoot and ReplicatedRoot:FindFirstChild("Shared"))

if not Shared then
	error("Cmdr Shared folder is missing; Cmdr may not have initialized correctly.")
end

local Util = require(Shared:WaitForChild("Util"))

if RunService:IsServer() == false then
	error("Cmdr server module is somehow running on a client!")
end

local Cmdr do
	Cmdr = setmetatable({
		ReplicatedRoot = ReplicatedRoot;
		RemoteFunction = nil;
		RemoteEvent = nil;
		Util = Util;
		DefaultCommandsFolder = script:FindFirstChild("BuiltInCommands") or script:FindFirstChild("Server commands");
	}, {
		__index = function (self, k)
			local r = self.Registry[k]
			if r and type(r) == "function" then
				return function (_, ...)
					return r(self.Registry, ...)
				end
			end
		end
	})

	Cmdr.Registry = require(Shared.Registry)(Cmdr)
	Cmdr.Dispatcher = require(Shared.Dispatcher)(Cmdr)

	require(script.Initialize)(Cmdr)
end

-- Handle command invocations from the clients.
Cmdr.RemoteFunction.OnServerInvoke = function (player, text, options)
	if #text > 100_000 then
		return "Input too long"
	end

	return Cmdr.Dispatcher:EvaluateAndRun(text, player, options)
end

return Cmdr