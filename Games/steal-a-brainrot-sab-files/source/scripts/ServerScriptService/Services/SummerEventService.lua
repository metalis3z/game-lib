local SummerEventService = {}

local EventService = require(script.Parent.EventService)

function SummerEventService:Start()
	local replicatedStorage = game:GetService("ReplicatedStorage")

	while not replicatedStorage:GetAttribute("EventsLoaded") do
		replicatedStorage.AttributeChanged:Wait()
	end

	task.spawn(function()
		EventService:ExecuteEvent("Summer", math.huge)
	end)
end

return SummerEventService