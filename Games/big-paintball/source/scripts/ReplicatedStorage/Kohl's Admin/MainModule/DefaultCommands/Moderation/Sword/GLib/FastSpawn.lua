--[[
	Spawns a new thread without waiting one step
	
	Args:
		Function callback,
		Vararg ...
--]]
local Instance_new = Instance.new
local BaseEvent = Instance_new'BindableEvent'
local Signal_connect = BaseEvent.Event.connect
local Event_Fire = BaseEvent.Fire
local Event_Destroy = BaseEvent.Destroy

return function(callback, ...)
	local event = Instance_new'BindableEvent'
	
	--event.Event:connect(callback)
	Signal_connect(event.Event, callback)
	
	--event:Fire(...)
	Event_Fire(event, ...)
	
	--event:Destroy()
	Event_Destroy(event)
end