function saveScore(player, score)
	player:SaveString("Side", score)
end

function saveScore2(player, score)
	player:SaveNumber("Money", score)
end

function saveScore3(player, score)
	player:SaveNumber("Bounty", score)
end

function saveScore4(player, score)
	player:SaveString("MarineRank", score)
end

function saveScore5(player, score)
	player:SaveNumber("Reputation", score)
end

function saveScore6(player, score)
	player:SaveString("Weapon", score)
end

function saveScore7(player, score)
	player:SaveBoolean("Busoshoku", score)
end

function saveScore8(player, score)
	player:SaveBoolean("Kenbunshoku", score)
end

function saveScore9(player, score)
	player:SaveBoolean("Haoshoku", score)
end

function saveScore10(player, score)
	player:SaveBoolean("Imprisoned", score)
end

function saveScore11(player, score)
	player:SaveBoolean("Geppo", score)
end

function saveScore12(player, score)
	player:SaveBoolean("Tekkai", score)
end

function saveScore13(player, score)
	player:SaveBoolean("Shigan", score)
end

function saveScore14(player, score)
	player:SaveBoolean("Rankyaku", score)
end

function saveScore15(player, score)
	player:SaveBoolean("Soru", score)
end

function saveScore16(player, score)
	player:SaveBoolean("Kamie", score)
end

function saveScore17(player, score)
	player:SaveString("DevilFruit", score)
end

function saveScore18(player, score)
	player:SaveNumber("X", score)
end

function saveScore19(player, score)
	player:SaveNumber("Y", score)
end

function saveScore20(player, score)
	player:SaveNumber("Z", score)
end

function loadScore(player, clickCounter)
	local score = player:LoadString("Side")

	if score ~= "Pirate" then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore2(player, clickCounter)
	local score = player:LoadNumber("Money")

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore3(player, clickCounter)
	local score = player:LoadNumber("Bounty")

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore4(player, clickCounter)
	local score = player:LoadString("MarineRank")

	if score ~= "" then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore5(player, clickCounter)
	local score = player:LoadNumber("Reputation") 

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore6(player, clickCounter)
	local score = player:LoadString("Weapon")

	if score ~= "" then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore7(player, clickCounter)
	local score = player:LoadBoolean("Busoshoku")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore8(player, clickCounter)
	local score = player:LoadBoolean("Kenbunshoku")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore9(player, clickCounter)
	local score = player:LoadBoolean("Haoshoku")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore10(player, clickCounter)
	local score = player:LoadBoolean("Imprisoned")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore11(player, clickCounter)
	local score = player:LoadBoolean("Geppo")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore12(player, clickCounter)
	local score = player:LoadBoolean("Tekkai") 

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore13(player, clickCounter)
	local score = player:LoadBoolean("Shigan")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore14(player, clickCounter)
	local score = player:LoadBoolean("Rankyaku")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore15(player, clickCounter)
	local score = player:LoadBoolean("Soru")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore16(player, clickCounter)
	local score = player:LoadBoolean("Kamie")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore17(player, clickCounter)
	local score = player:LoadString("DevilFruit")

	if score ~= false then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore18(player, clickCounter)
	local score = player:LoadNumber("X")

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore19(player, clickCounter)
	local score = player:LoadNumber("Y")

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function loadScore20(player, clickCounter)
	local score = player:LoadNumber("Z")

	if score ~= 0 then
		clickCounter.Value = score
	else
		print("Nothing to load/score was 0")
	end

end

function onPlayerEntered(newPlayer)

		local stats = Instance.new("IntValue")
		stats.Name = "Data"

		local Side = Instance.new("StringValue")
		Side.Name = "Side"
		Side.Value = "Pirate"
		
		local Money = Instance.new("IntValue")
		Money.Name = "Money"
		Money.Value = 0
		
		local Bounty = Instance.new("IntValue")
		Bounty.Name = "Bounty"
		Bounty.Value = 0
		
		local MarineRank = Instance.new("StringValue")
		MarineRank.Name = "MarineRank"
		MarineRank.Value = ""
		
		local Reputation = Instance.new("IntValue")
		Reputation.Name = "Reputation"
		Reputation.Value = 0

		local Weapon = Instance.new("StringValue")
		Weapon.Name = "Weapon"
		Weapon.Value = ""
		
		local Busoshoku = Instance.new("BoolValue")
		Busoshoku.Name = "Busoshoku"
		Busoshoku.Value = false
		
		local Kenbunshoku = Instance.new("BoolValue")
		Kenbunshoku.Name = "Kenbunshoku"
		Kenbunshoku.Value = false
		
		local Haoshoku = Instance.new("BoolValue")
		Haoshoku.Name = "Haoshoku"
		Haoshoku.Value = false
		
		local Imprisoned = Instance.new("BoolValue")
		Imprisoned.Name = "Imprisoned"
		Imprisoned.Value = false
				
		local Geppo = Instance.new("BoolValue")
		Geppo.Name = "Geppo"
		Geppo.Value = false
		
		local Tekkai = Instance.new("BoolValue")
		Tekkai.Name = "Tekkai"
		Tekkai.Value = false
		
		local Shigan = Instance.new("BoolValue")
		Shigan.Name = "Shigan"
		Shigan.Value = false
				
		local Rankyaku = Instance.new("BoolValue")
		Rankyaku.Name = "Rankyaku"
		Rankyaku.Value = false
		
		local Soru = Instance.new("BoolValue")
		Soru.Name = "Soru"
		Soru.Value = false
		
		local Kamie = Instance.new("BoolValue")
		Kamie.Name = "Kamie"
		Kamie.Value = false
		
		local DevilFruit = Instance.new("StringValue")
		DevilFruit.Name = "DevilFruit"
		DevilFruit.Value = "None"
		
		local X = Instance.new("IntValue")
		X.Name = "X"
		X.Value = 0
		
		local Y = Instance.new("IntValue")
		Y.Name = "Y"
		Y.Value = 0
		
		local Z = Instance.new("IntValue")
		Z.Name = "Z"
		Z.Value = 0
		
		Side.Parent = stats
		Money.Parent = stats
		Bounty.Parent = stats
		MarineRank.Parent = stats
		Reputation.Parent = stats
		Weapon.Parent = stats
		Busoshoku.Parent = stats
		Kenbunshoku.Parent = stats
		Haoshoku.Parent = stats
		Imprisoned.Parent = stats
		Geppo.Parent = stats
		Tekkai.Parent = stats
		Shigan.Parent = stats
		Rankyaku.Parent = stats
		Soru.Parent = stats
		Kamie.Parent = stats
		DevilFruit.Parent = stats
		X.Parent = stats
		Y.Parent = stats
		Z.Parent = stats

		stats.Parent = newPlayer

		newPlayer:WaitForDataReady()

		
		loadScore(newPlayer, Side)
		loadScore2(newPlayer, Money)
		loadScore3(newPlayer, Bounty)
		loadScore4(newPlayer, MarineRank)
		loadScore5(newPlayer, Reputation)
		loadScore6(newPlayer, Weapon)
		loadScore7(newPlayer, Busoshoku)
		loadScore8(newPlayer, Kenbunshoku)
		loadScore9(newPlayer, Haoshoku)
		loadScore10(newPlayer, Imprisoned)
		loadScore11(newPlayer, Geppo)
		loadScore12(newPlayer, Tekkai)
		loadScore13(newPlayer, Shigan)
		loadScore14(newPlayer, Rankyaku)
		loadScore15(newPlayer, Soru)
		loadScore16(newPlayer, Kamie)
		loadScore17(newPlayer, DevilFruit)
		loadScore18(newPlayer, X)
		loadScore19(newPlayer, Y)
		loadScore20(newPlayer, Z)
end 

function onPlayerRespawned(player)
	print("Queso it works " .. player.Name)
	local stats = player:FindFirstChild("Data")
	if (stats ~= nil) then 
		local Side = stats:FindFirstChild("Side")
		local Money = stats:FindFirstChild("Money")
		local Bounty = stats:FindFirstChild("Bounty")
		local MarineRank = stats:FindFirstChild("MarineRank")
		local Reputation = stats:FindFirstChild("Reputation")
		local Weapon = stats:FindFirstChild("Weapon")
		local Busoshoku = stats:FindFirstChild("Busoshoku")
		local Kenbunshoku = stats:FindFirstChild("Kenbunshoku")
		local Haoshoku = stats:FindFirstChild("Haoshoku")
		local Imprisoned = stats:FindFirstChild("Imprisoned")
		local Geppo = stats:FindFirstChild("Geppo")
		local Tekkai = stats:FindFirstChild("Tekkai")
		local Shigan = stats:FindFirstChild("Shigan")
		local Rankyaku = stats:FindFirstChild("Rankyaku")
		local Soru = stats:FindFirstChild("Soru")
		local Kamie = stats:FindFirstChild("Kamie")
		local DevilFruit = stats:FindFirstChild("DevilFruit")
		local X = stats:FindFirstChild("X")
		local Y = stats:FindFirstChild("Y")
		local Z = stats:FindFirstChild("Z")
		if (Side ~= nil) and (Money ~= nil) and (Bounty ~= nil) and (MarineRank ~= nil) and (Reputation ~= nil) and (Weapon ~= nil) and (Busoshoku ~= nil) and (Kenbunshoku ~= nil) and (Haoshoku ~= nil) and (Imprisoned ~= nil) and (Geppo ~= nil) and (Tekkai ~= nil) and (Shigan ~= nil) and (Rankyaku ~= nil) and (Soru ~= nil) and (Kamie ~= nil) and (DevilFruit ~= nil) and (X ~= nil) and (Y ~= nil) and (Z ~= nil) then
			saveScore(player, Side.Value)
			saveScore2(player, Money.Value)
			saveScore3(player, Bounty.Value)
			saveScore4(player, MarineRank.Value)
			saveScore5(player, Reputation.Value)
			saveScore6(player, Weapon.Value)
			saveScore7(player, Busoshoku.Value)
			saveScore8(player, Kenbunshoku.Value)
			saveScore9(player, Haoshoku.Value)
			saveScore10(player, Imprisoned.Value)
			saveScore11(player, Geppo.Value)
			saveScore12(player, Tekkai.Value)
			saveScore13(player, Shigan.Value)
			saveScore14(player, Rankyaku.Value)
			saveScore15(player, Soru.Value)
			saveScore16(player, Kamie.Value)
			saveScore17(player, DevilFruit.Value)
			saveScore18(player, X.Value)
			saveScore19(player, Y.Value)
			saveScore20(player, Z.Value)
		end
	end
end

function onPlayerRemoving(player)
	print("Attempting to save score for " .. player.Name)
	local stats = player:FindFirstChild("Data")
	if stats ~= nil then 
		local Side = stats:FindFirstChild("Side")
		local Money = stats:FindFirstChild("Money")
		local Bounty = stats:FindFirstChild("Bounty")
		local MarineRank = stats:FindFirstChild("MarineRank")
		local Reputation = stats:FindFirstChild("Reputation")
		local Weapon = stats:FindFirstChild("Weapon")
		local Busoshoku = stats:FindFirstChild("Busoshoku")
		local Kenbunshoku = stats:FindFirstChild("Kenbunshoku")
		local Haoshoku = stats:FindFirstChild("Haoshoku")
		local Imprisoned = stats:FindFirstChild("Imprisoned")
		local Geppo = stats:FindFirstChild("Geppo")
		local Tekkai = stats:FindFirstChild("Tekkai")
		local Shigan = stats:FindFirstChild("Shigan")
		local Rankyaku = stats:FindFirstChild("Rankyaku")
		local Soru = stats:FindFirstChild("Soru")
		local Kamie = stats:FindFirstChild("Kamie")
		local DevilFruit = stats:FindFirstChild("DevilFruit")
		local X = stats:FindFirstChild("X")
		local Y = stats:FindFirstChild("Y")
		local Z = stats:FindFirstChild("Z")
		if (Side ~= nil) and (Money ~= nil) and (Bounty ~= nil) and (MarineRank ~= nil) and (Reputation ~= nil) and (Weapon ~= nil) and (Busoshoku ~= nil) and (Kenbunshoku ~= nil) and (Haoshoku ~= nil) and (Imprisoned ~= nil) and (Geppo ~= nil) and (Tekkai ~= nil) and (Shigan ~= nil) and (Rankyaku ~= nil) and (Soru ~= nil) and (Kamie ~= nil) and (DevilFruit ~= nil) and (X ~= nil) and (Y ~= nil) and (Z ~= nil) then
			saveScore(player, Side.Value)
			saveScore2(player, Money.Value)
			saveScore3(player, Bounty.Value)
			saveScore4(player, MarineRank.Value)
			saveScore5(player, Reputation.Value)
			saveScore6(player, Weapon.Value)
			saveScore7(player, Busoshoku.Value)
			saveScore8(player, Kenbunshoku.Value)
			saveScore9(player, Haoshoku.Value)
			saveScore10(player, Imprisoned.Value)
			saveScore11(player, Geppo.Value)
			saveScore12(player, Tekkai.Value)
			saveScore13(player, Shigan.Value)
			saveScore14(player, Rankyaku.Value)
			saveScore15(player, Soru.Value)
			saveScore16(player, Kamie.Value)
			saveScore17(player, DevilFruit.Value)
			saveScore18(player, X.Value)
			saveScore19(player, Y.Value)
			saveScore20(player, Z.Value)
		end
	end
end

game.Players.PlayerAdded:connect(onPlayerEntered)
game.Players.PlayerRemoving:connect(onPlayerRemoving)

while true do
	wait(150)
script.Disabled = true
wait()
script.Disabled = false
end
