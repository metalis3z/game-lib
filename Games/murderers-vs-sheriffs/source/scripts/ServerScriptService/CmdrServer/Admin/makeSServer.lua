local ServerStorage = game:GetService("ServerStorage")

local function getForcedRoles()
	local folder = ServerStorage:FindFirstChild("ForcedRoles")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "ForcedRoles"
		folder.Parent = ServerStorage
	end

	local murderer = folder:FindFirstChild("Murderer")
	if not murderer then
		murderer = Instance.new("StringValue")
		murderer.Name = "Murderer"
		murderer.Parent = folder
	end

	local sheriff = folder:FindFirstChild("Sheriff")
	if not sheriff then
		sheriff = Instance.new("StringValue")
		sheriff.Name = "Sheriff"
		sheriff.Parent = folder
	end

	return murderer, sheriff
end

return function(_, targetPlayer)
	if not targetPlayer or not targetPlayer:IsA("Player") then
		return "Player not found."
	end

	local forcedMurderer, forcedSheriff = getForcedRoles()
	local currentMurderer = _G.CustomMurderer or (forcedMurderer.Value ~= "" and forcedMurderer.Value)
	local currentSheriff = _G.CustomSheriff or (forcedSheriff.Value ~= "" and forcedSheriff.Value)

	if currentMurderer == targetPlayer.Name then
		return targetPlayer.Name .. " is already set as Murderer. Clear/change Murderer first."
	end

	if currentSheriff and currentSheriff ~= targetPlayer.Name then
		return "Sheriff is already set to " .. currentSheriff .. "."
	end

	_G.CustomSheriff = targetPlayer.Name
	forcedSheriff.Value = targetPlayer.Name
	if _G.ResetChance then
		_G.ResetChance(targetPlayer.Name)
	end

	return targetPlayer.Name .. " will be Sheriff next round."
end