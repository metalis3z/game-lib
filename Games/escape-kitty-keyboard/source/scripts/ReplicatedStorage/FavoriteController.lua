local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local AvatarEditorService = game:GetService("AvatarEditorService")
local GroupService = game:GetService("GroupService")
local SocialService = game:GetService("SocialService")

local Packages = ReplicatedStorage.Packages
local Synchronizer = require(Packages.Synchronizer)

local LocalPlayer = Players.LocalPlayer
local GROUP_ID = 286964047

local function promptGroupJoin()
	local success, isMember = pcall(function()
		return LocalPlayer:IsInGroup(GROUP_ID)
	end)

	if not success then
		warn("IsInGroup failed:", isMember)
		return
	end

	if isMember then
		return
	end

	task.wait(0.5)

	local promptSuccess, result = pcall(function()
		return GroupService:PromptJoinAsync(GROUP_ID)
	end)

	if not promptSuccess then
		warn("Group prompt failed:", result)
	end
end

local function promptFavorite()
	local promptSuccess, err = pcall(function()
		AvatarEditorService:PromptSetFavorite(
			game.PlaceId,
			Enum.AvatarItemType.Asset,
			true
		)
	end)

	if not promptSuccess then
		warn("Favorite prompt failed:", err)
	end
end

local function promptUpcomingEvents()
	local success, events = pcall(function()
		return SocialService:GetUpcomingExperienceEventsAsync()
	end)

	if not success then
		warn("Failed to get upcoming events:", events)
		return
	end

	if events and #events > 0 then
		for _, event in ipairs(events) do
			local eventId = tostring(event.Id)

			local rsvpSuccess, rsvpStatus = pcall(function()
				return SocialService:GetEventRsvpStatusAsync(eventId)
			end)

			if rsvpSuccess then
				if rsvpStatus == Enum.RsvpStatus.None or rsvpStatus == Enum.RsvpStatus.NotGoing then
					local promptSuccess = pcall(function()
						SocialService:PromptRsvpToEventAsync(eventId)
					end)

					if not promptSuccess then
						warn("Failed to prompt RSVP for event:", eventId)
					end

					task.wait(0.5)
				end
			else
				warn("Failed to get RSVP status for event:", eventId)
			end
		end
	end
end

return {
	Start = function()
		Synchronizer:WaitAndCall(LocalPlayer, function(playerData)
			local initialDelay = RunService:IsStudio() and 10 or 30

			task.delay(initialDelay, function()
				if playerData:Get("TimesJoined") <= 1 then
					promptFavorite()
					task.wait(0.5)
				end

				promptGroupJoin()
				task.wait(0.5)

				promptUpcomingEvents()
			end)
		end)
	end
}