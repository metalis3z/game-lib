--!strict
type Limiter = "Letters" | "LettersAndNumbers"

-- Safe letter set, no vowels and no risky consonants
local SAFE_LETTERS = {
	"g","h","j","l","m","n","q","r","v","w","x","y","z",
	"G","H","J","L","M","N","Q","R","V","W","X","Y","Z"
}

local NUMBERS = {"1","2","3","4","5","6","7","8","9","0"}

-- Combine safely if needed
local function getListForLimiter(limiter: Limiter?)
	if limiter == "Letters" then
		return SAFE_LETTERS
	elseif limiter == "LettersAndNumbers" then
		local combined = {}
		for _, letter in SAFE_LETTERS do
			table.insert(combined, letter)
		end
		for _, digit in NUMBERS do
			table.insert(combined, digit)
		end
		return combined
	elseif limiter ~= nil then
		error(`Limiter '{limiter}' does not exist!`)
	end

	-- Default: Letters + Numbers
	local combined = {}
	for _, letter in SAFE_LETTERS do
		table.insert(combined, letter)
	end
	for _, digit in NUMBERS do
		table.insert(combined, digit)
	end
	return combined
end

return function (length: number?, limiter: Limiter?): string
	length = length or 8
	
	local UID = {}
	
	local useStructured = (limiter ~= "Letters")
	
	for index = 1, length do
		if useStructured and index % 2 == 0 then
			-- Even positions = numbers
			local digit = NUMBERS[math.random(1, #NUMBERS)]
			table.insert(UID, digit)
		else
			local letter = SAFE_LETTERS[math.random(1, #SAFE_LETTERS)]
			table.insert(UID, letter)
		end
	end
	
	return table.concat(UID)
end