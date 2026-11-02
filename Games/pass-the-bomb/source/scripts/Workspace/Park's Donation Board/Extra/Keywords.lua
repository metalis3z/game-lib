--[[
	
	THE KEYWORDS ARE NOT CASE SENSITIVE
	
	If you want any develper product to be detected,
	even if it doesn't have one of the keywords, add an empty string to the Keywords;
	This is an empty string: ""
	
]]--

local Keywords = {
	"Donation",
	"Dono",
	"Robux",
	"Bobux",
	"R$",
	"",
}

local Returning = {}

for _, String in ipairs(Keywords) do
	table.insert(Returning, string.lower(String))
end

return Returning