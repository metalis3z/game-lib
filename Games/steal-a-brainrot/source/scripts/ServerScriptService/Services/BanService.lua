local BanService = {}

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local BanStore = DataStoreService:GetDataStore("GlobalBans")

local Admins = {
	[1381965313] = true
}

local BannedUsers = {}
local ConnectedAdmins = {}

local function parseDuration(str)
	if not str or str == "" then return nil end
	local num, unit = str:match("(%d+)([smhdw])")
	num = tonumber(num)
	if not num or not unit then return nil end

	local mult = {
		s = 1,
		m = 60,
		h = 3600,
		d = 86400,
		w = 604800
	}

	return num * mult[unit]
end

local function getKickMessage(reason, unbanTime)
	reason = reason or "No reason provided"

	if unbanTime then
		local remaining = unbanTime - os.time()
		if remaining > 0 then
			local hours = math.ceil(remaining / 3600)
			return ("You are temporarily banned.\nReason: %s\nTime remaining: ~%d hour(s)")
				:format(reason, hours)
		end
	end

	return ("You are permanently banned.\nReason: %s"):format(reason)
end

local function loadBan(userId)
	local success, data = pcall(function()
		return BanStore:GetAsync("ban_" .. userId)
	end)

	if success and data then
		BannedUsers[userId] = data
		print("Loaded ban for UserId:", userId)
		return data
	end
end

local function saveBan(userId, data)
	pcall(function()
		BanStore:SetAsync("ban_" .. userId, data)
	end)
	print("Saved ban for UserId:", userId)
end

local function removeBan(userId)
	BannedUsers[userId] = nil
	pcall(function()
		BanStore:RemoveAsync("ban_" .. userId)
	end)
	print("Removed ban for UserId:", userId)
end

local function PlayerAdded(player: Player)
	local banData = BannedUsers[player.UserId] or loadBan(player.UserId)

	if banData then
		if banData.unbanTime and os.time() > banData.unbanTime then
			print("Ban expired for", player.Name)
			removeBan(player.UserId)
		else
			print("Kicking banned player:", player.Name)
			player:Kick(getKickMessage(banData.reason, banData.unbanTime))
			return
		end
	end

	if Admins[player.UserId] and not ConnectedAdmins[player.UserId] then
		ConnectedAdmins[player.UserId] = true

		player.Chatted:Connect(function(msg)
			local cmd, targetName, durationStr, reason =
				msg:match("^/(%S+)%s+(%S+)%s*(%S*)%s*(.*)")

			if not cmd then return end
			cmd = cmd:lower()

			if cmd == "ban" then
				local success, userId = pcall(function()
					return Players:GetUserIdFromNameAsync(targetName)
				end)

				if not success or not userId then
					print("Ban failed: player not found:", targetName)
					return
				end

				if Admins[userId] then
					print("Attempted admin ban blocked:", targetName)
					return
				end

				local duration = parseDuration(durationStr)
				local unbanTime = duration and (os.time() + duration) or nil

				local banData = {
					reason = reason ~= "" and reason or "No reason provided",
					unbanTime = unbanTime
				}

				BannedUsers[userId] = banData
				saveBan(userId, banData)

				local target = Players:GetPlayerByUserId(userId)
				if target then
					target:Kick(getKickMessage(banData.reason, banData.unbanTime))
				end

				print(("Admin %s banned %s for %s (%s)")
					:format(
						player.Name,
						targetName,
						durationStr ~= "" and durationStr or "permanent",
						banData.reason
					))

			elseif cmd == "unban" then
				local success, userId = pcall(function()
					return Players:GetUserIdFromNameAsync(targetName)
				end)

				if success and userId then
					removeBan(userId)
					print(("Admin %s unbanned %s")
						:format(player.Name, targetName))
				else
					print("Unban failed: player not found:", targetName)
				end
			end
		end)
	end
end

function BanService:BanUser(userId: number, durationStr: string?, reason: string?)
	if Admins[userId] then
		print("Ban blocked. Target is admin:", userId)
		return false
	end

	local duration = parseDuration(durationStr)
	local unbanTime = duration and (os.time() + duration) or nil

	local data = {
		reason = reason or "No reason provided",
		unbanTime = unbanTime
	}

	BannedUsers[userId] = data
	saveBan(userId, data)

	local player = Players:GetPlayerByUserId(userId)
	if player then
		player:Kick(getKickMessage(data.reason, data.unbanTime))
	end

	print("Manual ban applied to UserId:", userId)
	return true
end

function BanService:UnbanUser(userId: number)
	removeBan(userId)
	print("Manual unban for UserId:", userId)
end

function BanService:IsBanned(userId: number)
	return BannedUsers[userId] or loadBan(userId)
end

function BanService:Start()
	for _, player in ipairs(Players:GetPlayers()) do
		PlayerAdded(player)
	end

	Players.PlayerAdded:Connect(PlayerAdded)
end

return BanService