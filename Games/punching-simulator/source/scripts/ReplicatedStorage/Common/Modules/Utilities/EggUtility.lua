--> Variables
local _L = _G._L

local Eggs
local TableUtility
local Services
local PlayerRewardUtility
local BoostUtility

--> Constants

---------->
local EggUtility

EggUtility = {
	getInfo = function(eggName)
		local _, eggInfo = TableUtility.match(Eggs, function(i, v)
			return v.name == eggName
		end)

		return eggInfo
	end,

	give = function(client, eggProps)
		local clientData = client.data
		local clientPlayerController = client.player_controller
		
		local eggName = eggProps.name
		local eggValue = eggProps.value or 1
		local eggInfo = EggUtility.getInfo(eggName)
		
		if clientPlayerController then
			local clan = clientPlayerController:get_clan()

			if clan then
				clan:increment("eggs_opened", eggValue)
			end
			clientPlayerController:_quests_progress("3", eggValue)
			clientPlayerController:_tutorial_quests_progress("1", eggValue)
		end
		
		if clientData and eggName and eggValue then
			local gen = {}
			
			for d = 1, eggValue do
				local bestLuckInfo = LuckPassUtility.getBestInfo(clientData)
				local n = RandomUtility.chance(TableUtility.map(eggInfo.pets, function(i, v)
					return v.name, v.chance + (if BoostUtility.has(client.data, "Lucky_Potion") then eggInfo.luck else 0)
				end))
				
				if not clientData:Get({"auto_delete", n}) then
					table.insert(gen, n)
				end
			end
			
			local rew = TableUtility.map(gen, function(i, v)
				return i, {name = "Pet", props = {name = v, value = 1, tier = if client.purchases:OwnsGamepass("Rainbow_Eggs") then "Rainbow" else nil}}
			end)
			
			PlayerRewardUtility.give(client, rew, true)
			
			local f = TableUtility.map(rew, function(i, v)
				return i, {
					reward_name = v.name,
					name = v.props.name,
					value = v.props.value,
					tier = v.props.tier
				}
			end)
			
			return true, f
		end

		return false
	end,

	_init = function()
		Eggs = _L.Get {"Common", "Modules", "Databases", "Eggs"}
		TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
		RandomUtility = _L.Get {"Common", "Library", "Utilities", "RandomUtility"}
		Services = _L.Get {"Common", "Library", "Services"}
		PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"} 
		BoostUtility = _L.Get {"Common", "Modules", "Utilities", "BoostUtility"}
		LuckPassUtility = _L.Get {"Common", "Modules", "Utilities", "LuckPassUtility"}
	end
}

return EggUtility