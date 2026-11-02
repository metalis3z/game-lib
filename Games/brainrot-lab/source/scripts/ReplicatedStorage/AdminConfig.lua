-- Admin Configuration
-- Primary admin: 11157602774
-- Add more admin IDs by adding entries to the table below

local ADMIN_IDS = {
	[11157602774] = true,  -- Primary admin
	[10566406738] = true,
	[7227360264] = true,
	[10421875830] = true,
	[9498558190] = true,
	[9926507576] = true,
	[7840106493] = true,
	[4619352399] = true,
	[11177623015] = true,
	[10947324050] = true,  -- Conta atual (Studio)

	-- Add more admin IDs here:
	-- [123456789] = true,
	-- [987654321] = true,
}

return {
	IsAdmin = function(player)
		if not player then
			return false
		end
		return ADMIN_IDS[player.UserId] == true
	end,
	
	GetAdminIds = function()
		local ids = {}
		for id, _ in pairs(ADMIN_IDS) do
			table.insert(ids, id)
		end
		return ids
	end,
}