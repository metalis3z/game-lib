-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

return function(p1) --[[ observePlayer | Line: 21 | Upvalues: Players (copy) ]]
	local v1 = nil
	local t = {}

	local function OnPlayerAdded(p12) --[[ OnPlayerAdded | Line: 27 | Upvalues: v1 (ref), p1 (copy), t (copy) ]]
		if v1.Connected then
			task.spawn(function() --[[ Line: 32 | Upvalues: p1 (ref), p12 (copy), v1 (ref), t (ref) ]]
				local v12 = p1(p12)

				if typeof(v12) ~= "function" then
					return
				end

				if v1.Connected and p12.Parent then
					t[p12] = v12

					return
				end

				task.spawn(v12)
			end)
		end
	end

	local function OnPlayerRemoving(p1) --[[ OnPlayerRemoving | Line: 44 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		t[p1] = nil

		if typeof(v1) ~= "function" then
			return
		end

		task.spawn(v1)
	end

	v1 = Players.PlayerAdded:Connect(OnPlayerAdded)

	local v2 = Players.PlayerRemoving:Connect(OnPlayerRemoving)

	task.defer(function() --[[ Line: 57 | Upvalues: v1 (ref), Players (ref), OnPlayerAdded (copy) ]]
		if not v1.Connected then
			return
		end

		for v12, v2 in Players:GetPlayers() do
			task.spawn(OnPlayerAdded, v2)
		end
	end)

	return function() --[[ Line: 68 | Upvalues: v1 (ref), v2 (ref), t (copy) ]]
		v1:Disconnect()
		v2:Disconnect()

		local v12 = next(t)

		while v12 do
			local v22 = t[v12]

			t[v12] = nil

			if typeof(v22) == "function" then
				task.spawn(v22)
			end

			v12 = next(t)
		end
	end
end