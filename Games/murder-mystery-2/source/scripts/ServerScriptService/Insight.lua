-- Load existing event queue
_G.InsightEventQueue = _G.InsightEventQueue or {};
EventQueue = _G.InsightEventQueue;

-- Services
Support = require(script.SupportLibrary);
Support.ImportServices();

-- Settings
PushInterval = 5;
PushOnServerClose = true;
AccessKey = require(script.APIKey); 

function QueueEvent(EventData)
	table.insert(EventQueue, EventData);
end;

function UploadQueue()
	
	-- Ensure there are queued events
	if #EventQueue == 0 then
		return;
	end;

	-- Capture the current queue
	local Events = Support.CloneTable(EventQueue);

	-- Clear out the queue
	Support.ClearTable(EventQueue);

	-- Build the push payload
	local Payload = {
		serverId = game.JobId,
		placeId = tostring(game.PlaceId),
		events = Events
	};
 
	-- Send the request
	local Succeeded, Error = pcall(function ()
		HttpService:PostAsync(
			'http://api.f3xteam.com/insight/game-events',
			HttpService:JSONEncode(Payload),
			Enum.HttpContentType.ApplicationJson,
			true,
			{
				['X-Server-ID'] = (#game.JobId > 0) and game.JobId or
					('STUDIO' .. ((game.PlaceId ~= 0) and ('-' .. game.PlaceId) or '')),
				['X-Place-ID'] = tostring(game.PlaceId),
				['X-Access-Key'] = AccessKey
			}
		);
	end);

	-- If push failed, reload events into queue, log details 
	if not Succeeded then
		
		-- Log details


		-- Reload events into queue
		Support.ConcatTable(EventQueue, Events);

	end;

end;

-- Perform queue push every `PushInterval` seconds
Support.ScheduleRecurringTask(UploadQueue, PushInterval);

-- Push on server shutdown if enabled
if PushOnServerClose then
	game:BindToClose(UploadQueue);
end;

-- Export API
return {
	QueueEvent = QueueEvent
};