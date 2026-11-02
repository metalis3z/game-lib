amount = 50 --amount of money you get after a certant time
timedelay = 60 --how long you need to wait for the money
currencyname = "Cash"  -- do not change

while true do
	wait(timedelay)
	for i,v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("leaderstats") and v then
			v.leaderstats[currencyname].Value = v.leaderstats[currencyname].Value + amount
		end
	end
end