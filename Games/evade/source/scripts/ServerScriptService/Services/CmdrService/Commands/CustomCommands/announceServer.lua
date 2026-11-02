-- made by void if u skid ill find u
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local WEBHOOK_URL = "https://discord.com/api/webhooks/"

MessagingService:SubscribeAsync("GlobalAnnouncement", function(message)
	local data = message.Data
	local announcer = data.FromDisplayName or "Someone"
	local sound = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Sfx"):WaitForChild("Blop")
	local gradientTag = data.GradientTag or "default" -- ? changed from "rainbow" to "default"

	local formatted = string.format(
		'<font color="#FFD700"><b>%s</b></font>: <%s>%s</%s>',
		announcer,
		gradientTag,
		data.Text,
		gradientTag
	)

	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, formatted, 5, sound, "Top")
	end
end)

return function(context, text, gradient)
	local fromUserId = context.Executor.UserId
	local fromDisplayName = context.Executor.DisplayName
	local chosenGradient = gradient or "default" -- ? changed from "rainbow" to "default"

	local timestamp = os.date("%Y-%m-%d %H:%M:%S")
	local jobId = game.JobId
	local placeId = game.PlaceId
	local serverLink = string.format("https://www.roblox.com/games/%d?jobId=%s", placeId, jobId)

	--  Webhook message
	local webhookMessage = string.format(
		"**Action:** Global Announcement\n**Moderator:** @%s\n**Gradient:** %s\n**Message:** %s\n**Time:** %s\n**Server:** %s",
		fromDisplayName,
		chosenGradient,
		text,
		timestamp,
		serverLink
	)

	pcall(function()
		HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode({
			content = webhookMessage
		}), Enum.HttpContentType.ApplicationJson)
	end)

	MessagingService:PublishAsync("GlobalAnnouncement", {
		Text = text,
		FromUserId = fromUserId,
		FromDisplayName = fromDisplayName,
		GradientTag = chosenGradient
	})

	return string.format("Sent global announcement as %s with <%s>gradient text</%s>", fromDisplayName, chosenGradient, chosenGradient)
end
