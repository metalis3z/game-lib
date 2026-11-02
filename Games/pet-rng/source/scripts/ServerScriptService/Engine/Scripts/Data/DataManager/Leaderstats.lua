local ls = {}

function ls:CreateLeaderstats(plr:Player, profile)
	-- leaderstats
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	
	--wins
	local wins = Instance.new("StringValue", leaderstats)
	wins.Name = "Roll 🎲"
	wins.Value = profile.Data.Rolls
	
	--login times
	local loginTimes = Instance.new("IntValue", plr)
	loginTimes.Name = "logInTimes"
	loginTimes.Value = profile.Data.LogInTimes
end

return ls
