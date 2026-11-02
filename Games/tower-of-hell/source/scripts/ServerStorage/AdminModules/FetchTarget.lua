local playersService = game:GetService("Players")

return function(str, plr)
	if str == "me" then return {plr}
	elseif str == "all" then return playersService:GetPlayers()
	elseif str == "others" then
		local others = {}
		for _,player in pairs(playersService:GetPlayers()) do
			if player.UserId ~= plr.UserId then table.insert(others, player) end
		end
		return others
	elseif str == "random" then return {playersService:GetPlayers()[math.random(#playersService:GetPlayers())]}
	else
		for _,player in pairs(playersService:GetPlayers()) do
			if player.Name:lower() == str:lower() then return {player} end
		end
		for _,player in pairs(playersService:GetPlayers()) do
			if player.Name:lower():sub(1, #str) == str then return {player} end
		end
	end
end