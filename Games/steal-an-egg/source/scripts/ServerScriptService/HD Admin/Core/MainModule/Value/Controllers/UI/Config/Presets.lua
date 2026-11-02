--!strict


-- TYPES
export type UserPreset = {
	label: string,
	description: string?,
	icon: string?,
	resolveUserIds: () -> { number },
}

export type ProductPreset = {
	label: string,
	description: string?,
	icon: string?,
	id: number,
	infoType: Enum.InfoType,
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local ownerInfo = require(modules.References.ownerInfo)
local Presets = {}


-- PRESETS
------ Users ------
Presets.users = {
	["Creator"] = {
		label = "Creator",
		description = "Game/group owner",
		icon = "rbxassetid://107202584692517",
		resolveUserIds = function(): { number }
			-- We also give negative ids in studio the creator role as these are test clients
			local userIds = { ownerInfo.ownerId }
			local RunService = game:GetService("RunService")
			if RunService:IsStudio() then
				local Players = game:GetService("Players")
				for _, player in Players:GetPlayers() do
					if player.UserId < 0 then
						table.insert(userIds, player.UserId)
					end
				end
			end
			return userIds
		end,
	} :: UserPreset,
	["FriendsOfCreator"] = {
		label = "Friends of Creator",
		icon = "rbxassetid://107202584692517",
		resolveUserIds = function(): { number }
			local Players = game:GetService("Players")
			local friends: { number } = {}
			local ok, pages = pcall(function()
				return Players:GetFriendsAsync(ownerInfo.ownerId)
			end)
			if not ok or not pages then return friends end
			while true do
				for _, item in pages:GetCurrentPage() do
					if typeof(item) == "table" and typeof((item :: any).Id) == "number" then
						table.insert(friends, (item :: any).Id)
					end
				end
				if pages.IsFinished then break end
				pcall(function() pages:AdvanceToNextPageAsync() end)
			end
			return friends
		end,
	} :: UserPreset,
} :: { [string]: UserPreset }

------ Products ------
Presets.products = {} :: { [string]: ProductPreset }


return Presets
