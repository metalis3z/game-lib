--!strict
--[[ To do: in the future:
		1. I can defer by 0.01 seconds, collect multiple requests
		   all at once, and handle them in batch with GetUserInfosByUserIdsAsync
]]


local Players = game:GetService("Players")
local UserService = game:GetService("UserService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local cachedInfo = {}

export type TopRole = {
	key: string,
	name: string,
	color: Color3,
}

export type UserInfo = {
	userId: number | string,
	userName: string,
	userImage: string,
	userDisplayName: string,
	userTopRole: TopRole?, -- highest-ranked role, only returned for a player in this server
}


-- LOCAL FUNCTIONS
-- The detail always completes against the local role config, so renames stay live
local function getTopRole(userId: number): TopRole?
	if not RunService:IsServer() then return nil end
	local Roles = require(modules.Parent.Services.Roles)
	local role: any = nil
	if Players:GetPlayerByUserId(userId) then
		local User = require(modules.Objects.User)
		local user = User.getUserByUserId(userId, true)
		role = if user then Roles.getTopRole(user) else nil
	else
		local RemoteCallerRoles = require(modules.References.remoteCallerRoles)
		local roleKey = RemoteCallerRoles.getKey(userId)
		role = if roleKey then Roles.getRole(roleKey) else nil
	end
	if typeof(role) ~= "table" then return nil end
	return {
		key = (role :: any).key,
		name = (role :: any).name,
		color = (role :: any).color,
	}
end

local function getUserInfoAsync(userId: number | string): (boolean, UserInfo | string)
	if typeof(userId) ~= "number" then
		return true, {
			userId = userId,
			userName = "System",
			userImage = "",
			userDisplayName = "System",
			userTopRole = nil,
		}
	end
	local image = `https://www.roblox.com/headshot-thumbnail/image?userId={userId}&width=420&height=420&format=png`
	local playerInServer = Players:GetPlayerByUserId(userId)
	if playerInServer then
		return true, {
			userId = userId,
			userName = playerInServer.Name,
			userImage = image,
			userDisplayName = playerInServer.DisplayName,
			userTopRole = getTopRole(userId),
		}
	end
	local success, userDetails = pcall(function()
		return UserService:GetUserInfosByUserIdsAsync({userId})
	end)
	if not success or not userDetails or #userDetails <= 0 then
		return false, tostring(userDetails)
	end
	local firstRecord = userDetails[1]
	if typeof(firstRecord) ~= "table" then
		return false, "Failed to find info"
	end
	return true, {
		userId = firstRecord.Id,
		userName = firstRecord.Username,
		userImage = image,
		userDisplayName = firstRecord.DisplayName,
		userTopRole = nil, -- offline user; roles aren't loaded here
	}
end

return function(userId: number | string): (boolean, UserInfo | string)
	local userInfo = cachedInfo[userId]
	if userInfo then
		-- A record cached before the caller's remote role key arrived has no role,
		-- so retry cheaply rather than pinning the gap for the cache lifetime
		if not userInfo.userTopRole and typeof(userId) == "number" then
			userInfo.userTopRole = getTopRole(userId)
		end
		return true, userInfo
	end
	local success, infoOrError = getUserInfoAsync(userId)
	if success then
		cachedInfo[userId] = infoOrError :: any
		task.delay(300, function()
			cachedInfo[userId] = nil
		end)
		return true, infoOrError
	end
	return false, infoOrError
end