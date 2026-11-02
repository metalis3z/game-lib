return {
	countIndex = function(data)
		local seen = {}
		local count = 0
		for petName, _ in data.index or {} do
			local baseName = string.gsub(petName, ":s", "")
			if not seen[baseName] then
				seen[baseName] = true
				count += 1
			end
		end
		return count
	end,
}