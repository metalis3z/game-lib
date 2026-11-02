-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Services/LeaderboardService.lua  (1172 lines)
-- What it does: Clamps values (NaN/inf/negative/too big) before writing, publishes only changed values on an interval, formats durations and big numbers, and merges cached global entries with live players before sorting.
-- Excerpt of lines 288-554 (only the relevant part of a bigger script).

function LeaderboardService:_sanitizeOrderedValue(value)
	value = tonumber(value) or 0
	if value ~= value or value == math.huge or value == -math.huge then
		return 0
	end

	if value > MAX_SORTED_VALUE then
		value = MAX_SORTED_VALUE
	elseif value < 0 then
		value = 0
	end

	value = math.floor(value)
	return value
end

function LeaderboardService:_getValueType(definition)
	local sharedDefinition = definition and definition.Key and LeaderboardShared.Boards and LeaderboardShared.Boards[definition.Key]
	return sharedDefinition and sharedDefinition.valueType or definition.ValueFormat or "number"
end

function LeaderboardService:_extractStat(profile, statPath)
	local current = profile
	for _, key in ipairs(statPath) do
		if type(current) ~= "table" then
			return 0
		end
		current = current[key]
	end
	return self:_sanitizeOrderedValue(current)
end

function LeaderboardService:_extractStatEntry(profile, definition)
	local current = profile
	for _, key in ipairs(definition.StatPath) do
		if type(current) ~= "table" then
			return {
				EncodedValue = 0,
				DisplayValue = 0,
			}
		end
		current = current[key]
	end

	local valueType = self:_getValueType(definition)
	if valueType == "big" then
		local normalized = LeaderboardShared.NormalizeBig(current)
		return {
			EncodedValue = self:_sanitizeOrderedValue(LeaderboardShared.EncodeBig(normalized)),
			DisplayValue = normalized,
		}
	end

	local sanitized = self:_sanitizeOrderedValue(current)
	return {
		EncodedValue = sanitized,
		DisplayValue = sanitized,
	}
end
function LeaderboardService:_publishCurrentPlayers()
	if self.IsStudio then
		return
	end

	local now = os.time()
	for _, player in ipairs(Players:GetPlayers()) do
		local profile = self.DataService:GetProfile(player)
		if not profile then
			continue
		end

		local userId = player.UserId
		if userId <= 0 then
			continue
		end

		local lastPublishAt = self.LastPublishAtByUserId[userId]
		if lastPublishAt and (now - lastPublishAt) < LeaderboardConfig.PublishIntervalSeconds then
			continue
		end

		local publishedForUser = self.PublishedValues[userId] or {}
		self.PublishedValues[userId] = publishedForUser
		local attemptedWrite = false

		for boardKey, definition in pairs(LeaderboardConfig.Boards) do
			local store = self.OrderedStores[boardKey]
			if store then
				local statEntry = self:_extractStatEntry(profile, definition)
				local value = statEntry.EncodedValue
				if publishedForUser[boardKey] ~= value then
					local ok, err = pcall(function()
						store:SetAsync(tostring(userId), value)
					end)
					if ok then
						publishedForUser[boardKey] = value
						attemptedWrite = true
					else
						warn("[LeaderboardService] Failed to publish", boardKey, player.Name, err)
					end
				end
			end
		end

		if attemptedWrite then
			self.LastPublishAtByUserId[userId] = now
		end
	end
end

function LeaderboardService:_resolveName(userId, livePlayer)
	if livePlayer then
		self.NameCache[userId] = livePlayer.DisplayName
		return livePlayer.DisplayName
	end
	if self.NameCache[userId] then
		return self.NameCache[userId]
	end

	local success, result = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if success and type(result) == "string" and result ~= "" then
		self.NameCache[userId] = result
		return result
	end
	return "User " .. tostring(userId)
end

function LeaderboardService:_formatDuration(seconds)
	seconds = math.max(0, math.floor(tonumber(seconds) or 0))
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	if days > 0 then
		return string.format("%dd %dh %dm", days, hours, minutes)
	elseif hours > 0 then
		return string.format("%dh %dm", hours, minutes)
	elseif minutes > 0 then
		return string.format("%dm %ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

function LeaderboardService:_formatValue(definition, value, encodedValue)
	if definition.ValueFormat == "duration" then
		local durationValue = tonumber(value)
		if durationValue == nil then
			durationValue = tonumber(encodedValue) or 0
		end
		return self:_formatDuration(durationValue)
	end
	if self:_getValueType(definition) == "big" then
		local normalizedBig = nil
		if value ~= nil then
			normalizedBig = LeaderboardShared.NormalizeBig(value)
		end
		if normalizedBig and normalizedBig.mantissa and normalizedBig.mantissa > 0 then
			return LeaderboardShared.FormatBig(normalizedBig, true)
		end
		return LeaderboardShared.FormatBigFromScore(encodedValue or 0, true)
	end
	return MathUtility.FormatNumber(value)
end
function LeaderboardService:_readGlobalEntries(boardKey)
	if self.IsStudio then
		return {}
	end

	local store = self.OrderedStores[boardKey]
	if not store then
		return {}
	end

	local success, pages = pcall(function()
		return store:GetSortedAsync(false, LeaderboardConfig.MaxEntries)
	end)
	if not success then
		warn("[LeaderboardService] Failed to read ordered store", boardKey, pages)
		return nil
	end

	local entries = {}
	for _, item in ipairs(pages:GetCurrentPage()) do
		local userId = tonumber(item.key)
		if userId and userId > 0 then
			entries[userId] = {
				UserId = userId,
				EncodedValue = self:_sanitizeOrderedValue(item.value),
			}
		end
	end
	return entries
end

function LeaderboardService:_buildEntries(boardKey, definition)
	local merged = {}
	local cachedEntries = self.IsStudio and nil or self.CachedGlobalEntries[boardKey]
	if cachedEntries then
		for userId, entry in pairs(cachedEntries) do
			local encodedValue = self:_sanitizeOrderedValue(entry.EncodedValue or entry.Value)
			local displayValue = entry.DisplayValue
			if displayValue == nil then
				if definition.ValueFormat == "duration" then
					displayValue = encodedValue
				elseif self:_getValueType(definition) == "big" then
					displayValue = LeaderboardShared.DecodeBig(encodedValue)
				else
					displayValue = encodedValue
				end
			end
			merged[userId] = {
				UserId = entry.UserId,
				EncodedValue = encodedValue,
				DisplayValue = displayValue,
			}
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local profile = self.DataService:GetProfile(player)
		local statEntry = {
			EncodedValue = 0,
			DisplayValue = 0,
		}
		if profile then
			statEntry = self:_extractStatEntry(profile, definition)
		elseif not self.IsStudio then
			continue
		end

		local existing = merged[player.UserId]
		if self.IsStudio or not existing or statEntry.EncodedValue > existing.EncodedValue then
			merged[player.UserId] = {
				UserId = player.UserId,
				EncodedValue = statEntry.EncodedValue,
				DisplayValue = statEntry.DisplayValue,
				LivePlayer = player,
			}
		end
	end

	local entries = {}
	for _, entry in pairs(merged) do
		table.insert(entries, entry)
	end
	table.sort(entries, function(left, right)
		if left.EncodedValue == right.EncodedValue then
			return left.UserId < right.UserId
		end
		return left.EncodedValue > right.EncodedValue
	end)
	while #entries > LeaderboardConfig.MaxEntries do
		table.remove(entries)
	end

	for rank, entry in ipairs(entries) do
		entry.Rank = rank
		entry.DisplayName = self:_resolveName(entry.UserId, entry.LivePlayer)
		entry.FaceImage = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420", entry.UserId)
		entry.FormattedValue = self:_formatValue(definition, entry.DisplayValue, entry.EncodedValue)
	end
	return entries
end

