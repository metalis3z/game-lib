local function toCamelCase(text: string): string
	if text == nil or text == "" then
		return ""
	end

	-- Normalize separators to spaces (treat any non-alphanumeric as a separator)
	local norm = text:gsub("[^%w]", " ")

	-- Insert spaces for camel/Pascal/acronym boundaries:
	--  - lowerUpper -> "lower Upper" (split before an uppercase after a lowercase)
	--  - upperUpperLower -> "upper UpperLower" (split acronym from following mixed-case word)
	norm = norm
		:gsub("(%l)(%u)", "%1 %2")
		:gsub("(%u)(%u%l)", "%1 %2")

	-- Split into words
	local words = {}
	for word in norm:gmatch("%S+") do
		table.insert(words, word)
	end
	if #words == 0 then
		return ""
	end

	-- Build camelCase: first word all lower, subsequent words Capitalized
	local parts = {}
	parts[1] = string.lower(words[1])
	for index = 2, #words do
		local word = words[index]
		local first = word:sub(1, 1)
		local rest = word:sub(2)
		parts[index] = string.upper(first) .. string.lower(rest)
	end

	return table.concat(parts, "")
end

return toCamelCase