return {
	Speed = 16,
	Hp = function(Level: number)
		if Level == 1 then
			return 10
		elseif Level == 2 then
			return 25
		end
	end,
	Rewards = {},
}