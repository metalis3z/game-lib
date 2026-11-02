local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local ANNOUNCEMENT_OWNERS = {
	["promisednothing"] = true,
	["24029404"] = true,
	["7652185711"] = true,
}
local function canSendAnnouncement(player)
	return player and (ANNOUNCEMENT_OWNERS[player.Name] == true or ANNOUNCEMENT_OWNERS[tostring(player.UserId)] == true)
end

local SendAnnouncement = ReplicatedStorage:FindFirstChild("SendAnnouncement")
if not SendAnnouncement then
	SendAnnouncement = Instance.new("RemoteEvent")
	SendAnnouncement.Name = "SendAnnouncement"
	SendAnnouncement.Parent = ReplicatedStorage
end

local AnnouncementEvent = ReplicatedStorage:FindFirstChild("AnnouncementEvent")
if not AnnouncementEvent then
	AnnouncementEvent = Instance.new("RemoteEvent")
	AnnouncementEvent.Name = "AnnouncementEvent"
	AnnouncementEvent.Parent = ReplicatedStorage
end

local ServerId = HttpService:GenerateGUID(false)
local CHANNEL = "GlobalAnnouncements"

local LogFolder = ServerStorage:FindFirstChild("AnnouncementLogs")
if not LogFolder then
	LogFolder = Instance.new("Folder")
	LogFolder.Name = "AnnouncementLogs"
	LogFolder.Parent = ServerStorage
end

local function logMessage(userId, name, text)
	local log = Instance.new("StringValue")
	log.Name = name .. " (" .. userId .. ")"
	log.Value = text
	log.Parent = LogFolder
end

local function broadcastAnnouncement(player, text)
	if not canSendAnnouncement(player) then
		return false, "You don't have permission to send announcements."
	end
	if typeof(text) ~= "string" or not text:match("%S") then
		return false, "Announcement cannot be empty."
	end

	text = text:match("^%s*(.-)%s*$")
	local msg = {
		userId = player.UserId,
		name = player.Name,
		text = text,
		server = ServerId
	}
	AnnouncementEvent:FireAllClients(msg.userId, msg.name .. ": " .. msg.text)
	pcall(function()
		MessagingService:PublishAsync(CHANNEL, msg)
	end)
	logMessage(msg.userId, msg.name, msg.text)
	return true, "Announcement sent."
end

local BroadcastAnnouncement = ServerStorage:FindFirstChild("BroadcastAnnouncement")
if not BroadcastAnnouncement then
	BroadcastAnnouncement = Instance.new("BindableFunction")
	BroadcastAnnouncement.Name = "BroadcastAnnouncement"
	BroadcastAnnouncement.Parent = ServerStorage
end
BroadcastAnnouncement.OnInvoke = broadcastAnnouncement

SendAnnouncement.OnServerEvent:Connect(function(player, text)
	broadcastAnnouncement(player, text)
end)

local subscribed, subscribeError = pcall(function()
	MessagingService:SubscribeAsync(CHANNEL, function(message)
		local data = message.Data
		if not data then return end
		if data.server == ServerId then return end
		AnnouncementEvent:FireAllClients(data.userId, data.name .. ": " .. data.text)
		logMessage(data.userId, data.name, data.text)
	end)
end)
if not subscribed then
	warn("Global announcements will only work in this server:", subscribeError)
end
