
local Players = game:GetService("Players")

local function observePlayer(p1: ((...any) -> ...any))
	local connection = nil
	local t1 = {}

	local function OnPlayerAdded(p2)
		if not connection.Connected then
			return
		end

		task.spawn(function()
			local v16 = p1(p2)

			if typeof(v16) == "function" then
				if connection.Connected and p2.Parent then
					t1[p2] = v16

					return
				end

				task.spawn(v16)
			end
		end)
	end
	local function OnPlayerRemoving(p3)
		local v11 = t1[p3]

		t1[p3] = nil

		if typeof(v11) == "function" then
			task.spawn(v11)
		end
	end

	connection = Players.PlayerAdded:Connect(OnPlayerAdded)

	local connection2 = Players.PlayerRemoving:Connect(OnPlayerRemoving)

	task.defer(function()
		if not connection.Connected then
			return
		end

		for _, player in Players:GetPlayers() do
			task.spawn(OnPlayerAdded, player)
		end
	end)

	return function()
		connection:Disconnect()
		connection2:Disconnect()

		local v14 = next(t1)

		while v14 do
			local v15 = t1[v14]

			t1[v14] = nil

			if typeof(v15) == "function" then
				task.spawn(v15)
			end

			v14 = next(t1)
		end
	end
end

return observePlayer
