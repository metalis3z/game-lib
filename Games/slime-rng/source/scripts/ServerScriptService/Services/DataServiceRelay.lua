local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local DataServiceRelay = {}

function DataServiceRelay:init()
	local DataService = require(ReplicatedStorage.Packages.DataService).server

	local relay = ReplicatedStorage:FindFirstChild("DSRelay")
	if not relay then
		relay = Instance.new("RemoteEvent")
		relay.Name = "DSRelay"
		relay.Parent = ReplicatedStorage
		print("[DataServiceRelay] Created DSRelay RemoteEvent under ReplicatedStorage")
	else
		print("[DataServiceRelay] DSRelay already exists")
	end

	local originalSet = DataService.set
	DataService.set = function(self, player, path, value, silent)
		originalSet(self, player, path, value, silent)

		if not silent and typeof(player) == "Instance" and player:IsA("Player") then
			local ok, err = pcall(function()
				relay:FireClient(player, 1, path, value)
			end)
			if not ok then
				warn("[DataServiceRelay] FireClient error:", err)
			end
		end
	end

	local originalArrayInsert = DataService.arrayInsert
	DataService.arrayInsert = function(self, player, path, value, n, silent)
		originalArrayInsert(self, player, path, value, n, silent)
		if not silent and typeof(player) == "Instance" and player:IsA("Player") then
			pcall(function()
				relay:FireClient(player, 2, path, value, n)
			end)
		end
	end

	local originalArrayRemove = DataService.arrayRemove
	DataService.arrayRemove = function(self, player, path, n, silent)
		originalArrayRemove(self, player, path, n, silent)
		if not silent and typeof(player) == "Instance" and player:IsA("Player") then
			pcall(function()
				relay:FireClient(player, 3, path, n)
			end)
		end
	end

	local function sendInitSnapshot(player)
		local data = DataService:waitForData(player)
		if not data then return end
		task.wait(1)
		if player and player.Parent then
			local snapshot = data:get()
			pcall(function()
				relay:FireClient(player, 0, snapshot)
			end)
			print("[DataServiceRelay] Sent init snapshot to", player.Name)
		end
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(sendInitSnapshot, player)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(sendInitSnapshot, player)
	end

	print("[DataServiceRelay] Initialized — all DataService:set calls will relay via DSRelay")
end

return DataServiceRelay