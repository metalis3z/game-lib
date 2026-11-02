local playerClass = {}
playerClass.__index = playerClass

local playerClasses = {}


local defaultData = {
	Moveset = 'Honored One',
	DidMonthlyReset = false,


	ButtonPositions = { ['Punch'] = UDim2.new(1, -95, 1, -165); ['Special'] = UDim2.new(1, -95, 1, -165); ['Dash'] = UDim2.new(1, -165,1, -220); ['Block'] = UDim2.new(1, -95, 1, -315); },


	KillsForEmote = 50,
	OwnedEmotes = { 'Crush' },
	Emotes = { ['1'] = 'Crush'; ['2'] = 'Crush'; ['3'] = 'Crush'; ['4'] = 'Crush'; ['5'] = 'Crush'; ['6'] = 'Crush'; ['7'] = 'Crush'; ['8'] = 'Crush'; },
	Emotes2 = { ['1'] = 'Crush'; ['2'] = 'Crush'; ['3'] = 'Crush'; ['4'] = 'Crush'; ['5'] = 'Crush'; ['6'] = 'Crush'; ['7'] = 'Crush'; ['8'] = 'Crush'; },
	Cosmetics = { Accessories = {}; Auras = {}; Titles = {}; },
	AwakeningOutfits = {},


	['Auto Run'] = true,
	['Auto Use'] = true,
	['Awakening Music'] = true,
	['Character Packages'] = true,
	['Shiftlock'] = false,
	['Blood'] = false,
	['Volume'] = 1,
	['Fast Mode'] = false
}


function playerClass.new(Player: Player, PlayerData)
	if PlayerData == nil then
		PlayerData = defaultData
	else
		for Index, Value in defaultData do
			if PlayerData[Index] == nil then
				PlayerData[Index] = Value
			end
		end

		for Index, _ in PlayerData do
			if defaultData[Index] == nil then
				PlayerData[Index] = nil
			end
		end
	end

	setmetatable(PlayerData, playerClass)
	playerClasses[Player.UserId] = PlayerData

	return PlayerData
end

function playerClass:GetClass(UserId: number)
	return playerClasses[UserId]
end

return playerClass