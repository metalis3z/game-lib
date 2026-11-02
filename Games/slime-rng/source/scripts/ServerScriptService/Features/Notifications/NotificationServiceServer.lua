local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Networker = require(ReplicatedStorage.Packages.Networker)

local NotificationServiceServer = {}
NotificationServiceServer.__index = NotificationServiceServer

function NotificationServiceServer:init()
	-- Initialize the networker server for NotificationService
	self.networker = Networker.server.new("NotificationService", self)
	print("[NotificationServiceServer] Initialized")
end

-- Send a notification to a specific player
-- @param player Player - The player to send the notification to
-- @param imageId string - The image ID for the notification icon
-- @param amount number - The amount to display (e.g., x5, x100)
function NotificationServiceServer:sendNotification(player, imageId, amount)
	if not player or not player:IsA("Player") then
		warn("[NotificationServiceServer] Invalid player passed to sendNotification")
		return false
	end

	if not imageId or imageId == "" then
		warn("[NotificationServiceServer] Invalid imageId passed to sendNotification")
		return false
	end

	local notificationData = {
		Image = imageId,
		Amount = amount or 1,
	}

	-- Send to the specific player via networker
	if self.networker then
		self.networker:fireClient(player, "serverNotification", notificationData)
		return true
	else
		warn("[NotificationServiceServer] Networker not initialized")
		return false
	end
end

-- Send a notification to all players
-- @param imageId string - The image ID for the notification icon
-- @param amount number - The amount to display
function NotificationServiceServer:sendNotificationToAll(imageId, amount)
	local notificationData = {
		Image = imageId,
		Amount = amount or 1,
	}

	if self.networker then
		self.networker:fireAllClients("serverNotification", notificationData)
		return true
	else
		warn("[NotificationServiceServer] Networker not initialized")
		return false
	end
end

-- Send a text notification to a specific player (uses TextNotifications UI)
-- @param player Player - The player to send the notification to
-- @param message string - The message to display
-- @param options table - Optional: { Color, StrokeColor, Duration, Confetti }
function NotificationServiceServer:sendTextNotification(player, message, options)
	if not player or not player:IsA("Player") then
		warn("[NotificationServiceServer] Invalid player passed to sendTextNotification")
		return false
	end

	if not message or message == "" then
		warn("[NotificationServiceServer] Invalid message passed to sendTextNotification")
		return false
	end

	options = options or {}

	local notificationData = {
		message = message,
		Color = options.Color,
		StrokeColor = options.StrokeColor,
		Duration = options.Duration or 3,
		Confetti = options.Confetti,
	}

	if self.networker then
		self.networker:fireClient(player, "textNotification", notificationData)
		return true
	else
		warn("[NotificationServiceServer] Networker not initialized")
		return false
	end
end

-- Send an announcement to all players (uses AnnouncementMessages UI)
-- @param message string - The announcement message
-- @param options table - Optional: { Color, Position, Size, Duration, Sound, Confetti }
function NotificationServiceServer:sendAnnouncement(message, options)
	if not message or message == "" then
		warn("[NotificationServiceServer] Invalid message passed to sendAnnouncement")
		return false
	end

	options = options or {}

	local announcementData = {
		message = message,
		Color = options.Color,
		Position = options.Position,
		Size = options.Size,
		Duration = options.Duration or 7,
		Sound = options.Sound,
		Confetti = options.Confetti,
	}

	if self.networker then
		self.networker:fireAllClients("announcement", announcementData)
		return true
	else
		warn("[NotificationServiceServer] Networker not initialized")
		return false
	end
end

return NotificationServiceServer