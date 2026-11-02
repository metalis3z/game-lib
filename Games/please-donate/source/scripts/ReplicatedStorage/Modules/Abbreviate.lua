	
local Abbreviations = {
	K = 4, 
	M = 7,
	B = 10,
	T = 13,
}

local Abbreviate = {}

function Abbreviate.Number(Number, Decimals)
	--Getting Digits
	local String = tostring(Number)
	local NewString, Replaced = string.gsub(String, "-", "")
	local DigitsOfNewCoins = #NewString

	--Find Abbreviation
	local ChosenAbbreviation
	for Abbreviation, Digits in pairs(Abbreviations) do
		if DigitsOfNewCoins >= Digits and DigitsOfNewCoins < (Digits + 3) then
			ChosenAbbreviation = Abbreviation
			break
		end
	end

	--Rounding
	local Returning
	if ChosenAbbreviation then
		local a = Abbreviations[ChosenAbbreviation] - 1
		local b = Number / 10 ^ a
		local c = math.floor(b * (10 ^ (Decimals or 1)))
		local d = c / (10 ^ (Decimals or 1))
		local e = d..ChosenAbbreviation
		
		Returning = e
	else
		Returning = Number
	end

	return Returning
end

function Abbreviate.ReverseNumber(String)
	local Abbreviation = ""
	local DotReplaced
	Abbreviation = string.gsub(String, "%d", "")
	Abbreviation, DotReplaced = string.gsub(Abbreviation, "%.", "")
	
	if Abbreviation ~= "" and Abbreviations[Abbreviation] then
		local Number, Replaced = string.gsub(String, "%D", "")
		local HowMany0sToAdd = Abbreviations[Abbreviation] - 1
		
		local WithoutAbbreviation = string.gsub(String, Abbreviation, "")
		
		for i = 1, #WithoutAbbreviation do
			if string.sub(WithoutAbbreviation, i, i) == "." then
				local NumbersAfterDecimal = string.sub(WithoutAbbreviation, i + 1, -1)
				HowMany0sToAdd -= #NumbersAfterDecimal
			end
		end
	
		local UnAbbreviatedNumber = tonumber(Number*tonumber("1"..string.rep("0", HowMany0sToAdd)))
		return UnAbbreviatedNumber
	else
		return tonumber(String)
	end
	
end

function Abbreviate.AddComma(Number)
	
	local NumberString = tostring(Number)
	local Digits = #NumberString

	for i = Digits, 1, -1 do	
		if string.sub(NumberString, i, i) ~= "," and tonumber(string.sub(NumberString, i + 1, i + 3)) and #string.sub(NumberString, i + 1, i + 3) == 3 then		
			local BeforeComma = string.sub(NumberString, 1, i)
			local AfterComma = string.sub(NumberString, i + 1, -1)		
			NumberString = BeforeComma..","..AfterComma
		end
	end

	return NumberString
end

function Abbreviate.RemoveCommas(String)
	
	local WithoutCommas = string.gsub(String, ",", "")
	return tonumber(WithoutCommas)
	
end

function Format(Int)
	return string.format("%02i", Int)
end

function Abbreviate.ConvertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

return Abbreviate
