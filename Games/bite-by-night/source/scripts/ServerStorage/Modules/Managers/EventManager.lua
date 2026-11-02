--[[
    Written by: Nextix (ne_tix)
    Date: 4/1/2026
    
    Method:
    Making a function is any other modules under ServerStorage and naming it:
    Event_EventName
    OR
    Event_EventName_SpecificRequest (SpecificRequest is the first argument of the call)
    
    To add a new listener, add a new dictionary in the Events table like this:
    EventName = Warp.Server('EventListner') (EventListner = The name the call will call aswell)
    
    Warning:
    Breaking this script will result in a lot of other scripts breaking aswell / yielding themself waiting for an call never returning anything.
]]

local EventManager = {}

-- <- Modules -> --
local Warp = require('@game/ReplicatedStorage/Modules/Warp');

-- <- Private Variables -> --
local Events = {
	Side = Warp.Server('Side');
}

local RegisteredEvents = {}
local RegisteredModule = {}

-- <- Private Functions -> --

-- // Handles the events calls. (Fire, Invoke)
local function EventHandler(EventName: string, MaybeRequest: string, Player: Player, ...): ()
	local InformationToReturn
	local PackedArguments = {...}
	
	warn(`{Player} is trying to call the event '{EventName}'. (Information, Request name (Innaccurate) {MaybeRequest}, Other arguments {...}`);
	
	for _, Modules in RegisteredModule do 
		local ModuleTable = Modules.ModuleReturn
		if not ModuleTable then
			continue
		end
		
		if typeof(ModuleTable) ~= 'table' then
			continue
		end
		
		-- // Checking if the EventName exist in the module functions + if the request name exist in the name aswell.
		local FunctionCallBackWithRequest = ModuleTable[`Event_{EventName}_{MaybeRequest}`]
		if FunctionCallBackWithRequest and typeof(FunctionCallBackWithRequest) == 'function' then
			warn(`Found a function with the request name + event name. Calling it.`);
			
			-- // Removes the first index of the arguments cause of it being the request name.
			PackedArguments[1] = nil
			
			-- // Try to call the function with the arguments Player, ... (With the first argument removed and ignoring it)
			InformationToReturn = FunctionCallBackWithRequest(Player, table.unpack(PackedArguments, 2));
			
			break
		end
		
		-- // Same as above but without the request and without removing the first argument.
		local FunctionCallBack = ModuleTable[`Event_{EventName}`]
		if FunctionCallBack and typeof(FunctionCallBack) == 'function' then
			warn(`Found a function with the event name. Calling it.`);

			InformationToReturn = FunctionCallBack(Player, ...);
			
			break
		end
	end
	
	warn(`Call success for {EventName} ! (Returned {InformationToReturn})`);
	
	-- // Return the informations from the function call.
	return InformationToReturn
end

-- <- Public Functions -> --

function EventManager.StartLoggingEvents(AllModules: {}): ()
	RegisteredModule = AllModules
		
	for EventName, EventCall: RemoteEvent in Events do		
		if not EventCall.IsConnected then
			RegisteredEvents[EventName] = EventCall:Connect(function(Player: Player, ...): ()
				-- // Event Name, First argument, Player, All the arguments
				local TableArgs = {...}
				return EventHandler(EventName, TableArgs[1], Player, ...);
			end)
		end
	end
end

-- <- Return -> --
return EventManager