game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)

	wait(2)

	while true do

	if player.Data.Side.Value == "Marine" then
		if player.Data.Bounty.Value <= 1000000 then
			player.Data.MarineRank.Value = "Chore Boy"
		end
	end
	
	if player.Data.Bounty.Value >= 1000001 and player.Data.Bounty.Value <= 3000000 then
		player.Data.MarineRank.Value = "Seaman Recruit"
	end
	
	if player.Data.Bounty.Value >= 3000001 and player.Data.Bounty.Value <= 5000000 then
		player.Data.MarineRank.Value = "Seaman Apprenctice"
	end
	
	if player.Data.Bounty.Value >= 5000001 and player.Data.Bounty.Value <= 8000000 then
		player.Data.MarineRank.Value = "Seaman First Class"
	end
	
	if player.Data.Bounty.Value >= 8000001 and player.Data.Bounty.Value <= 13000000 then
		player.Data.MarineRank.Value = "Petty Officer"
	end
	
	if player.Data.Bounty.Value >= 13000001 and player.Data.Bounty.Value <= 20000000 then
		player.Data.MarineRank.Value = "Chief Petty Officer"
	end
	
	if player.Data.Bounty.Value >= 20000001 and player.Data.Bounty.Value <= 30000000 then
		player.Data.MarineRank.Value = "Master Chief Petty Officer"
	end
	
	if player.Data.Bounty.Value >= 30000001 and player.Data.Bounty.Value <= 45000000 then
		player.Data.MarineRank.Value = "Lieutenant"
	end
	
	if player.Data.Bounty.Value >= 45000001 and player.Data.Bounty.Value <= 60000000 then
		player.Data.MarineRank.Value = "Commander"
	end
	
	if player.Data.Bounty.Value >= 60000001 and player.Data.Bounty.Value <= 80000000 then
		player.Data.MarineRank.Value = "Captain"
	end
	
	if player.Data.Bounty.Value >= 80000001 and player.Data.Bounty.Value <= 105000000 then
		player.Data.MarineRank.Value = "Commodore"
	end
	
	if player.Data.Bounty.Value >= 1050000001 and player.Data.Bounty.Value <= 200000000 then
		player.Data.MarineRank.Value = "Rear Admiral"
	end
	
	if player.Data.Bounty.Value >= 200000001 and player.Data.Bounty.Value <= 450000000 then
		player.Data.MarineRank.Value = "Vice Admiral"
	end
	
	if player.Data.Bounty.Value >= 450000001 then
		player.Data.MarineRank.Value = "Admiral"
	end
	
	wait()
	
end

wait()

	end)
end)