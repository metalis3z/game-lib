game.Players.PlayerAdded:connect(function(player)

	wait(2)

local stats = Instance.new("StringValue", player)
stats.Name = "leaderstats"

local bounty = Instance.new("StringValue", stats)
bounty.Name = "Bounty/Rank"

wait(2)

while true do
	if player.Data.Side.Value == "Pirate" then
		bounty.Value = player.Data.Bounty.Value
	end

	if player.Data.Side.Value == "Marine" then
		bounty.Value = player.Data.MarineRank.Value
	end
	wait(0.1)
end
end)