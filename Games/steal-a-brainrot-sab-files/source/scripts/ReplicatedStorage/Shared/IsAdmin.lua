local ADMIN_IDS = {
	[1557378019] = true,
	[11465819882] = true, 
	[4549104887] = true,
}

local RunService = game:GetService("RunService")

local function IsAdmin(userId: number?): boolean
	if userId == nil then
		if RunService:IsClient() then
			userId = game:GetService("Players").LocalPlayer.UserId
		else
			error("IsAdmin requires a userId on the server")
		end
	end
	return ADMIN_IDS[userId] == true
end

return IsAdmin