local module = {}

-- Created and Fixed by BUILDG Studios

function module:SetChanceDescript()
	
	local Chances = {
		{Room = "Common", Chance = 99};
		{Room = "Legendary", Chance = 1};
	}

	local function GetRandomRarity()
		local Sum = 0

		for _, Table in ipairs(Chances) do
			Sum += Table.Chance
		end

		local RNG = Random.new():NextInteger(1, Sum)

		local Weight = 0

		for _, Table in ipairs(Chances) do
			Weight += Table.Chance
			if Weight >= RNG then
				return Table.Room, Table.Chance
			end
		end
	end
	
	for i = 1, 10 do
		print(GetRandomRarity())
	end
end

task.wait(.1)
--module:SetChanceDescript()

return module
