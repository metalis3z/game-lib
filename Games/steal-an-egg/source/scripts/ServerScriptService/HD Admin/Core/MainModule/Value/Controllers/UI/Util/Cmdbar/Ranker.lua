--!strict

--[[

	This ranks candidate rows against the typed query
 
]]


-- LOCAL
local Ranker = {}


-- TYPES
export type Candidate = {
	keys: { string }?,
	text: string?, 
	recency: number?, 
	[string]: any,
}
type Options = {
	maxResults: number?,
}


-- LOCAL FUNCTIONS
local function scoreKey(query: string, key: string): (number, number)
	local loweredKey = key:lower()
	local keyLength = #loweredKey
	if keyLength == 0 then
		return 0, 0
	end
	if loweredKey == query then
		return 4, 1
	end
	local foundStart = loweredKey:find(query, 1, true)
	if foundStart then
		if foundStart == 1 then
			return 3, #query / keyLength -- starts-with, shorter key wins
		end
		return 2, (#query / keyLength) * (1 - (foundStart - 1) / keyLength) -- contains, earlier wins
	end
	local keyCursor = 1
	local firstPos: number? = nil
	local lastPos = 1
	for queryIndex = 1, #query do
		local char = query:sub(queryIndex, queryIndex)
		local foundAt = loweredKey:find(char, keyCursor, true)
		if not foundAt then
			return 0, 0
		end
		firstPos = firstPos or foundAt
		lastPos = foundAt
		keyCursor = foundAt + 1
	end
	local span = lastPos - (firstPos or 1) + 1
	local compactness = #query / span -- 1 = contiguous run
	return 1, compactness * (#query / keyLength) * 0.5
end

local function levenshtein(left: string, right: string): number
	local leftLength = #left
	local rightLength = #right
	if leftLength == 0 then return rightLength end
	if rightLength == 0 then return leftLength end
	local previous = {}
	for rightIndex = 0, rightLength do
		previous[rightIndex] = rightIndex
	end
	for leftIndex = 1, leftLength do
		local current = { [0] = leftIndex }
		local leftChar = left:sub(leftIndex, leftIndex)
		for rightIndex = 1, rightLength do
			local cost = if leftChar == right:sub(rightIndex, rightIndex) then 0 else 1
			current[rightIndex] = math.min(
				previous[rightIndex] + 1,
				current[rightIndex - 1] + 1,
				previous[rightIndex - 1] + cost
			)
		end
		previous = current
	end
	return previous[rightLength]
end

local function capList(list: { any }, maxResults: number?): { any }
	if maxResults and #list > maxResults then
		local trimmed = {}
		for index = 1, maxResults do
			trimmed[index] = list[index]
		end
		return trimmed
	end
	return list
end


-- FUNCTIONS
function Ranker.rank(query: string?, candidates: { Candidate }, options: Options?): { Candidate }
	local maxResults = options and options.maxResults
	local trimmed = (query or ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()

	if #trimmed == 0 then
		-- Wrap with the original index rather than stamping the shared candidate tables
		local wrapped = {}
		for index, candidate in candidates do
			table.insert(wrapped, { candidate = candidate, order = index })
		end
		table.sort(wrapped, function(left, right)
			-- The arg's default always leads before anything is typed, even over recents
			local leftDefault = left.candidate.isDefault == true
			local rightDefault = right.candidate.isDefault == true
			if leftDefault ~= rightDefault then
				return leftDefault
			end
			local leftRecency = left.candidate.recency or 0
			local rightRecency = right.candidate.recency or 0
			if leftRecency ~= rightRecency then
				return leftRecency > rightRecency
			end
			return left.order < right.order
		end)
		local out = {}
		for _, entry in wrapped do
			table.insert(out, entry.candidate)
		end
		return capList(out, maxResults)
	end

	local scored = {}
	for index, candidate in candidates do
		local keys = candidate.keys or { candidate.text }
		local bestTier, bestScore = 0, 0
		local nameMatched = false
		for keyIndex, key in keys do
			if typeof(key) == "string" then
				local tier, score = scoreKey(trimmed, key)
				if tier > bestTier or (tier == bestTier and score > bestScore) then
					bestTier, bestScore = tier, score
					nameMatched = keyIndex == 1 -- keys[1] is the command's own name, the rest are aliases
				end
			end
		end
		if bestTier > 0 then
			table.insert(scored, { candidate = candidate, tier = bestTier, score = bestScore, nameMatched = nameMatched, order = index })
		end
	end

	table.sort(scored, function(left, right)
		if left.tier ~= right.tier then
			return left.tier > right.tier
		end
		if left.score ~= right.score then
			return left.score > right.score
		end
		-- On an otherwise equal match, matching the real name beats matching an alias
		if left.nameMatched ~= right.nameMatched then
			return left.nameMatched
		end
		local leftRecency = left.candidate.recency or 0
		local rightRecency = right.candidate.recency or 0
		if leftRecency ~= rightRecency then
			return leftRecency > rightRecency
		end
		return left.order < right.order
	end)

	local out = {}
	for _, entry in scored do
		table.insert(out, entry.candidate)
	end
	return capList(out, maxResults)
end

-- Nearest name by edit distance for an unknown command, or nil when nothing's close
function Ranker.didYouMean(query: string?, names: { string }): string?
	local lowered = (query or ""):lower()
	if #lowered == 0 then
		return nil
	end
	local bestName: string? = nil
	local bestDistance = math.huge
	for _, name in names do
		local distance = levenshtein(lowered, name:lower())
		if distance < bestDistance then
			bestDistance = distance
			bestName = name
		end
	end
	-- Only suggest when it's a near miss, not a wild guess
	if bestName and bestDistance <= math.max(2, math.floor(#lowered / 2)) then
		return bestName
	end
	return nil
end

-- The alias a command matched on when its primary name (keys[1]) didn't match at
-- all, else nil. Lets the bar label a row "Speak (alias of Chat)" for a ;spe query
function Ranker.aliasHit(query: string?, keys: { string }?): string?
	if typeof(keys) ~= "table" or #keys == 0 then
		return nil
	end
	local trimmed = (query or ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()
	if #trimmed == 0 then
		return nil
	end
	if typeof(keys[1]) == "string" and (scoreKey(trimmed, keys[1])) > 0 then
		return nil
	end
	local bestKey: string? = nil
	local bestTier, bestScore = 0, 0
	for index = 2, #keys do
		local key = keys[index]
		if typeof(key) == "string" then
			local tier, score = scoreKey(trimmed, key)
			if tier > bestTier or (tier == bestTier and score > bestScore) then
				bestTier, bestScore = tier, score
				bestKey = key
			end
		end
	end
	if bestTier > 0 then
		return bestKey
	end
	return nil
end


return Ranker
