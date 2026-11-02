-- Reference copy for study. Game: Punching Simulator (punching-simulator)
-- Original: StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Notifications.luau  (luau, 108 lines)
-- Categories: notifications 17.2
-- What it does: Framework notification service: respects a player "Notifications" setting, plays optional audio, spring-animates UIScale in/out (Spr), callable from server or client.

--> Variables
local _L = _G._L

local Services
local Signal
local Tracker
local Data
local TableUtility
local NumberUtility
local Spr
local Trove
local Audio
local Shared
local Timer
local FastTween
local cancellableDelay
local Constants
local AttributeUtility
local TrackerUtility

--> Constants

------------->
local Notifications = {
	name = script.Name
}

function Notifications:_init()
	Network = _L.Get {"Common", "Library", "Network"}
	Services = _L.Get {"Common", "Library", "Services"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Data = _L.Get {"Client", "Library", "Classes", "Data"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	TrackerUtility = _L.Get {"Common", "Library", "Utilities", "TrackerUtility"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Audio = _L.Get {"Common", "Library", "Audio"} 
	Shared = _L.Get {"Common", "Modules", "Shared"}
	FastTween = _L.Get {"Common", "Library", "Functions", "FastTween"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	Constants = _L.Get {"Common", "Modules", "Constants"}
	Pool = _L.Get {"Common", "Library", "Classes", "Pool"}
end

function Notifications:_start()
	self.object = _L.PlayerGui.Notifications
	
	Network.Remote.Fired("C_Notifications_Add", function(...)
		self:add(...)
	end)
	
	Network.Bindable.Fired("C_Notifications_Add", function(...)
		self:add(...)
	end)
	
	local data = Data.Await()

	if data then
		self._data = data
	end
end

function Notifications:add(props)
	if self._data and not self._data:Get({"settings", "Notifications"}) then
		return
	end
	
	local notificationColor = props.color or Color3.fromRGB(255, 255, 255)
	local notificationText = props.text
	local notificationAudio = props.audio
	local notificationDuration = props.duration or 3
	
	if notificationAudio then
		Audio.Play(notificationAudio)
	end
	
	local notificationInstance = _L.Assets.UI.Notification:Clone()
	
	notificationInstance.TextColor3 = notificationColor
	notificationInstance.Text = notificationText
	notificationInstance.UIScale.Scale = 1.1
	
	Spr.Target(notificationInstance.UIScale, 1, 4, {
		Scale = 1
	})
	
	task.delay(notificationDuration, function()
		Spr.Target(notificationInstance.UIScale, 1, 4, {
			Scale = 0
		})
		
		task.delay(1, function()
			notificationInstance.Parent = nil

			Spr.Stop(notificationInstance.UIScale)
			
			notificationInstance:Destroy()
		end)
	end)
	
	notificationInstance.Parent = self.object.Bottom.Notifications
end

return Notifications