-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: serviceplayerdata, time of decompilation: Sun May  3 10:10:40 2026 ]]
local Players = game:GetService("Players")
local scriptParent = script.Parent
local Sift = require(scriptParent.Sift)
local Signal = require(scriptParent.Signal)

return {
	new = function(p1, p2) --[[ new ]] -- line: 16
		-- upvalues: Signal (copy), Sift (copy), Players (copy)
		local t1 = {
			onPlayerAdded = Signal.new(),
			onPlayerRemoving = Signal.new()
		}
		local t2 = {}
		local connection = Players.PlayerAdded:Connect(function(player) --[[ addPlayer ]] -- line: 24
			-- upvalues: t2 (copy), Sift (copy), p1 (copy), t1 (copy), p2 (copy)
			if t2[player] ~= nil then
				return
			end

			local v12 = Sift.Dictionary.copyDeep(p1)

			t2[player] = v12
			t1.onPlayerAdded:Fire(player, v12)

			if p2 and p2.playerAdded then
				p2:playerAdded(player, v12)
			end
		end)
		local connection2 = Players.PlayerRemoving:Connect(function(player) --[[ removePlayer ]] -- line: 38
			-- upvalues: t2 (copy), p2 (copy), t1 (copy)
			local v14 = t2[player]

			if p2 and p2.playerRemoving then
				p2:playerRemoving(player, v14)
			end

			if v14 then
				t2[player] = nil
				t1.onPlayerRemoving:Fire(player, v14)
			end
		end)

		function t1.destroy(_) -- line: 52
			-- upvalues: connection (copy), connection2 (copy), t1 (copy), Players (copy), t2 (copy), p2 (copy)
			connection:Disconnect()
			connection2:Disconnect()
			t1.onPlayerAdded:Destroy()
			t1.onPlayerRemoving:Destroy()

			for _, v17 in Players:GetPlayers() do
				local v18 = t2[v17]

				if p2 and p2.playerRemoving then
					p2:playerRemoving(v17, v18)
				end

				if v18 then
					t2[v17] = nil
					t1.onPlayerRemoving:Fire(v17, v18)
				end
			end
		end
		function t1.get(_, p5) -- line: 62
			-- upvalues: t2 (copy)
			local v21 = t2[p5]

			assert(v21 ~= nil, "Service player data not found for player: " .. p5.Name)

			return v21
		end

		return t1
	end
}
