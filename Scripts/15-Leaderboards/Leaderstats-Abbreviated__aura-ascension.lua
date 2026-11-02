-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Services/PlayerService.lua  (588 lines)
-- What it does: Creates leaderstats with StringValue columns and fills them with FormatNumber text (1.2M) from the profile.
-- Excerpt of lines 300-338 (only the relevant part of a bigger script).

function PlayerService:_ensureLeaderstats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
	end

	local auraValue = leaderstats:FindFirstChild(LEADERSTAT_AURA_NAME)
	if not auraValue then
		auraValue = Instance.new("StringValue")
		auraValue.Name = LEADERSTAT_AURA_NAME
		auraValue.Parent = leaderstats
	end

	local rebirthValue = leaderstats:FindFirstChild(LEADERSTAT_REBIRTHS_NAME)
	if not rebirthValue then
		rebirthValue = Instance.new("StringValue")
		rebirthValue.Name = LEADERSTAT_REBIRTHS_NAME
		rebirthValue.Parent = leaderstats
	end

	self.Leaderstats[player] = leaderstats
	return leaderstats, auraValue, rebirthValue
end

function PlayerService:_destroyLeaderstats(player)
	self.Leaderstats[player] = nil
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		leaderstats:Destroy()
	end
end

function PlayerService:_syncLeaderstats(player, profile)
	local _, auraValue, rebirthValue = self:_ensureLeaderstats(player)
	auraValue.Value = MathUtility.FormatNumber(profile.Stats.Aura or 0)
	rebirthValue.Value = MathUtility.FormatNumber(profile.Stats.Rebirths or 0)
end
