-- AdminServiceClient (Client ModuleScript)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Networker = require(ReplicatedStorage.Packages.Networker)
local Vide = require(ReplicatedStorage.Packages.Vide)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)

local TEXT_FIELDS = {
	"text", "label", "message", "display",
	"timeText", "countdownText", "title", "subtitle",
	"description", "header", "body", "value", "time",
	"countdownLabel", "statusText", "timerText",
}

-- Every numeric field that AdminRoot might do arithmetic on
local NUMBER_FIELDS = {
	"duration", "remaining", "timeLeft", "elapsed",
	"startTime", "endTime", "expirationTime", "expires",
	"multiplier", "count", "total", "progress",
}

local BOOL_FIELDS = {
	"active", "visible", "enabled", "running", "paused",
}

local function sanitizeCountdownState(raw)
	local t = {}

	if type(raw) == "table" then
		for k, v in pairs(raw) do
			t[k] = v
		end
	end

	for _, field in ipairs(TEXT_FIELDS) do
		if t[field] == nil then t[field] = "" end
	end
	for _, field in ipairs(NUMBER_FIELDS) do
		if t[field] == nil then t[field] = 0 end
	end
	for _, field in ipairs(BOOL_FIELDS) do
		if t[field] == nil then t[field] = false end
	end

	return t
end

return {
	_bindHotkey = function(p1)
		if p1.hotkeyConn ~= nil then return end
		p1.hotkeyConn = UserInputService.InputBegan:Connect(function(input, b1: boolean)
			if b1 or UserInputService:GetFocusedTextBox() ~= nil then return end
			if input.KeyCode ~= Enum.KeyCode.F2 then return end
			p1:toggleMenu()
		end)
	end,

	init = function(p2)
		p2.networker = Networker.client.new("AdminService", p2)
		p2.adminEnabledSource = Vide.source(false)
		p2.countdownStateSource = Vide.source(sanitizeCountdownState(nil))
		p2.announcementSource = Vide.source(nil) -- Stores current announcement
		if not RunService:IsRunning() then return end
		task.spawn(function()
			local v18 = p2.networker:fetch("getClientState")
			p2.adminEnabledSource(v18.isAdmin == true)
			p2.countdownStateSource(sanitizeCountdownState(v18.countdownState))
			if p2.adminEnabledSource() then
				p2:_bindHotkey()
				-- Auto-open admin menu on join
				p2:toggleMenu()
			end
		end)
	end,

	isAdmin = function(p3)
		return p3.adminEnabledSource() == true
	end,

	getCountdownSource = function(p4)
		return p4.countdownStateSource
	end,

	toggleMenu = function(p5)
		if not p5:isAdmin() then return end
		if Menu.openedMenu() == "Admin" then
			Menu.setOpenedMenu(nil)
			return
		end
		Menu.setOpenedMenu("Admin")
		end,

	executeMiscAction = function(p6, p7)
		if not p6:isAdmin() then
			return false, "You are not authorized to use admin tools."
		end
		return p6.networker:fetch("executeMiscAction", p7)
	end,

	countdownUpdated = function(p8, t1)
		p8.countdownStateSource(sanitizeCountdownState(t1))
	end,

	globalAnnouncement = function(p9, message)
		p9.announcementSource(message)
		-- Display the announcement using the existing AnnouncementMessages system
		AnnouncementMessages.add(message, {
			Color = Color3.fromRGB(255, 200, 100),
			Duration = 8,
			Sound = "Announcement"
		})
		-- Auto-clear source after display
		task.delay(8, function()
			if p9.announcementSource() == message then
				p9.announcementSource(nil)
			end
		end)
	end,

	getAnnouncementSource = function(p10)
		return p10.announcementSource
	end,
}