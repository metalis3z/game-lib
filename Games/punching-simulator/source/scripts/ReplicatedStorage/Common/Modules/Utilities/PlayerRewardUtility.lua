--> Variables
local _L = _G._L

local PlayerRewards
local TableUtility

--> Constants

---------->
local PlayerRewardUtility

PlayerRewardUtility = {
	getInfo = function(playerRewardName)
		local _, playerRewardInfo = TableUtility.match(PlayerRewards, function(i, v)
			return typeof(v) == "table" and  v.name == playerRewardName
		end)

		return playerRewardInfo
	end,

	give = function(client, pr, rewardUi)
		local t = {}
		
		for _, p in pairs(pr) do
			local playerRewardName = p.name
			local rewardProps = p.props
			
			local playerRewardInfo = PlayerRewardUtility.getInfo(playerRewardName)
			
			if playerRewardInfo then
				local success, reward = playerRewardInfo.callback(client, rewardProps)
				
				if success then
					if typeof(reward) == "table" then
						for _, a in pairs(reward) do
							table.insert(t, a)
						end
					else
						table.insert(t, reward)
					end
				end
			end
		end
		
		local rewardData = t
		
		if rewardUi and #pr == #t then
			Network.Remote.Fire("C_Reward_Open", client.player, rewardData)
			return true, rewardData
		end
		
		return false, rewardData
	end,

	_init = function()
		PlayerRewards = _L.Get {"Common", "Modules", "Databases", "PlayerRewards"}
		TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
		Network = _L.Get {"Common", "Library", "Network"}
	end
}

return PlayerRewardUtility