local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local BanStore = DataStoreService:GetDataStore("GlobalBans")

local BannedUsers = {}

local function parseDuration(str)
	if not str or str == "" then return nil end
	local num, unit = str:match("(%d+)([smhdw]?)")
	num = tonumber(num)
	if not num then return nil end
	local mult = ({ s=1, m=60, h=3600, d=86400, w=604800 })[unit] or 86400
	return num * mult
end

local function getKickMessage(reason)
	reason = reason or "No reason provided"
	return ("You are banned from this game.\nReason: %s"):format(reason)
end

local function loadBan(userId)
	local success, data = pcall(function()
		return BanStore:GetAsync("ban_"..userId)
	end)
	if success and data then
		BannedUsers[userId] = data
		return data
	end
end

local function saveBan(userId, data)
	pcall(function()
		BanStore:SetAsync("ban_"..userId, data)
	end)
end

local function removeBan(userId)
	BannedUsers[userId] = nil
	pcall(function()
		BanStore:RemoveAsync("ban_"..userId)
	end)
end

local Admins = {
	[1381965313] = true
}

Players.PlayerAdded:Connect(function(player)
	local banData = BannedUsers[player.UserId] or loadBan(player.UserId)
	if banData then
		if banData.unbanTime and os.time() > banData.unbanTime then
			removeBan(player.UserId)
		else
			player:Kick(getKickMessage(banData.reason))
			return
		end
	end

	if Admins[player.UserId] then
		player.Chatted:Connect(function(msg)
			local cmd, targetName, durationStr, reason = msg:match("^/(%S+)%s+(%S+)%s*(%S*)%s*(.*)")
			if not cmd then return end
			cmd = cmd:lower()

			if cmd == "ban" then
				local success, userId = pcall(function()
					return Players:GetUserIdFromNameAsync(targetName)
				end)
				if not success or not userId then
					print("Player not found: "..targetName)
					return
				end

				if Admins[userId] then
					player:Kick("You can’t ban another admin!")
					return
				end

				local duration = parseDuration(durationStr)
				local unbanTime = duration and (os.time() + duration) or nil

				local banData = {reason = reason ~= "" and reason or "No reason provided", unbanTime = unbanTime}
				BannedUsers[userId] = banData
				saveBan(userId, banData)

				local target = Players:GetPlayerByUserId(userId)
				if target then
					target:Kick(getKickMessage(banData.reason))
				end

				print(("Admin %s banned %s for %s (%s)"):format(player.Name, targetName, durationStr ~= "" and durationStr or "permanent", banData.reason))

			elseif cmd == "unban" then
				local success, userId = pcall(function()
					return Players:GetUserIdFromNameAsync(targetName)
				end)
				if not success or not userId then
					warn("Unban failed: player not found.")
					return
				end

				removeBan(userId)
				print(("Admin %s unbanned %s"):format(player.Name, targetName))
			end
		end)
	end
end)