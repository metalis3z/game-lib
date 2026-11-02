return {
	["MoneyGiver"] = function(Player : Player, CommandData)
		for _, plr in pairs(CommandData.Players) do
			local plrData = plr:FindFirstChild("PlayerData")
			local val = plrData and plrData:FindFirstChild("Stats") and plrData.Stats:FindFirstChild(CommandData.Type, true)
			if val then
				val.Value += CommandData.Amount
			end
		end
	end,
	["FlingPlayer"] = function(Player : Player, CommandData)
		for _, plr in pairs(CommandData.Players) do
			local bodyVelocity = Instance.new("BodyVelocity")
			game.Debris:AddItem(bodyVelocity, 0.1)
			bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			bodyVelocity.Velocity = CommandData.Vector
			bodyVelocity.Parent = plr.Character.PrimaryPart
		end
	end,
	["BanishPlayer"] = function(Player : Player, CommandData)
		local gameId = tonumber(CommandData.GameID)
		if not gameId then return end
		for _, plr in pairs(CommandData.Players) do
			game["Teleport Service"]:Teleport(gameId, plr)
		end
	end,
	["KillPlayer"] = function(Player : Player, CommandData)
		for _, plr in pairs(CommandData.Players) do
			if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
				plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
			end
		end
	end,
	["BanPlayer"] = function(Player : Player, CommandData)
		local UserIds = {}
		for _, plr in pairs(CommandData.Players) do
			table.insert(UserIds, plr.UserId)
		end
		local Config : BanConfigType = {
			UserIds = UserIds,
			Duration = CommandData.Length,
			DisplayReason = CommandData.Reason,
			PrivateReason = CommandData.InternalReason,
			ExcludeAltAccounts = false,
			ApplyToUniverse = true,
		}
		game.Players:BanAsync(Config)
	end,
}