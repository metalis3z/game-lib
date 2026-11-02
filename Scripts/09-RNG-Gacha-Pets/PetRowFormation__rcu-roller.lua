-- Game: rcu-roller
-- Original: StarterPlayer/StarterPlayerScripts/Client/Controllers/PetController/PetPosition.lua
-- What it does: Pure function that lays equipped pets out in up to 3 arcs behind the player (small pets front, big pets middle, huge pets back) and returns a CFrame offset per pet.

-- PetPosition: calculates CFrame offsets for pets arranged in rows around the owner
-- Row 1 (closest): up to 3 front/normal pets
-- Row 2 (middle):  up to 5 middle/big pets + overflow front
-- Row 3 (back):    all back/huge + remaining middle + remaining front

return function(petConfigs)
	local module = {}
	local front = {}
	local middle = {}
	local back = {}

	for i, v in ipairs(petConfigs) do
		if v.placement == "back" then
			table.insert(back, { index = i, pet = v })
		elseif v.placement == "middle" then
			table.insert(middle, { index = i, pet = v })
		else
			table.insert(front, { index = i, pet = v })
		end
	end

	local function sortByPriority(a, b)
		return (a.pet.priority or math.huge) < (b.pet.priority or math.huge)
	end
	table.sort(front, sortByPriority)
	table.sort(middle, sortByPriority)
	table.sort(back, sortByPriority)

	local function calculateRowPositions(pets, row)
		local result = {}
		local radius = row * 4
		local len = #pets
		if len == 0 then return result end
		local maxAngle = math.min(1.0471975511965976, 0.5235987755982988 * (len - 1))
		local step = maxAngle / math.max(len - 1, 1)
		for i, v in ipairs(pets) do
			local angle = (i - 1) * step - maxAngle / 2
			result[v.index] = CFrame.new(radius * 2 * math.sin(angle), 0, radius * math.cos(angle))
		end
		return result
	end

	-- Row 1: first 3 front pets
	local row1 = {}
	for _ = 1, math.min(3, #front) do
		table.insert(row1, table.remove(front, 1))
	end
	for i, v in pairs(calculateRowPositions(row1, 1)) do
		module[i] = { position = v, row = 1 }
	end

	-- Row 2: first 5 middle pets + remaining front to fill 5
	local row2 = {}
	for _ = 1, math.min(5, #middle) do
		table.insert(row2, table.remove(middle, 1))
	end
	for _ = 1, math.min(5 - #row2, #front) do
		table.insert(row2, table.remove(front, 1))
	end
	for i, v in pairs(calculateRowPositions(row2, 2)) do
		module[i] = { position = v, row = 2 }
	end

	-- Row 3: all remaining (back + leftover middle + leftover front)
	local row3 = {}
	for _, v in ipairs(back) do
		table.insert(row3, v)
	end
	for _, v in ipairs(middle) do
		table.insert(row3, v)
	end
	for _, v in ipairs(front) do
		table.insert(row3, v)
	end
	for i, v in pairs(calculateRowPositions(row3, 3)) do
		module[i] = { position = v, row = 3 }
	end

	return module
end
